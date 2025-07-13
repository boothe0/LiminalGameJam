extends CanvasLayer
@onready var lemons_leave: Button = $LemonsLeave
@onready var clean_up: Button = $CleanUP
@onready var clean_up_2: Button = $CleanUP2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func _on_button_pressed() -> void:
	if lemons_leave.visible == true:
		lemons_leave.visible = false
		clean_up.visible = false
		clean_up_2.visible = false
	self.queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



func _on_lemons_leave_pressed() -> void:
	Globals.left_lemons = true
	Globals.choice_picked = true
	print("Left Lemons")
func _on_clean_up_pressed() -> void:
	Globals.clean_up_food = true
	Globals.choice_picked = true
	print("Cleaned up food")
func _on_clean_up_2_pressed() -> void:
	Globals.put_lemons_away = true
	Globals.choice_picked = true
	print("Put away lemons")
