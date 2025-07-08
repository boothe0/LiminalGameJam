extends StaticBody3D
@onready var continue_message: Label3D = $ContinueMessage

@onready var date_note: StaticBody3D = $"../LevelFloor/lockers/DateNote"
@onready var picnic_note: StaticBody3D = $"../LevelFloor/PicnicNote"
@onready var work_note: StaticBody3D = $"../LevelFloor/workbench tools/WorkNote"
@onready var lemon_note: StaticBody3D = $"../LevelFloor/cafe bar/LemonNote"

func _process(delta: float) -> void:
	# checking if the player is near the door
	if Input.is_action_just_pressed("interact") and continue_message.visible == true:
		Globals.scene_counter += 1
		get_tree().reload_current_scene()
func _on_detection_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		continue_message.visible = true
		print("player entered")

func _on_detection_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		continue_message.visible = false
		print("player exited")
