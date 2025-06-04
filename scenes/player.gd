extends CharacterBody3D
@onready var neck: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D
var speed
const SPRINT_SPEED = 8.0
const WALK_SPEED = 5.0
const JUMP_VELOCITY = 4.5

# fov change based on speed
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

# head bob
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
# how far along sin wave player is 
var sin_bob = 0.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# handle sprint
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			# base the velocity off the speed since you can sprint or walk
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			# if not sprinting slow down slowly to a minimum speed
			# increasing the float increases the speed that the lerp function slows down to the minimum value
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)

	else:
		# slows velocity down slowly with lerp 
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.5)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.5)

	# this is multiplied by is_on_floor because we do not want head bob in the air lol
	sin_bob += delta * velocity.length() * float(is_on_floor())
	# call the headbob function to handle the camera going vertical and horizonal using sin and cos wave functions.
	camera.transform.origin = _headbob(sin_bob) 
	
	# FOV
	# need to clamp the fov so it does not zoom in too much
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	# ramps up with the lerp function to be calculated every frame
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	# attaches mouse 
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# ui_cancel is the esc key
	# frees the mouse so the window can be closed
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# rotating the neck
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			# 3 would be a full rotation smaller = less sensitivity
			neck.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			# could lower the -30 degrees if you want the player to look down more
			# to look at items etc
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50), deg_to_rad(60))
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	# vertical bob
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	# horizontal bob
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
	
	
	
	
	
