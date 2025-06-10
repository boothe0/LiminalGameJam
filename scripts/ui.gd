extends CanvasLayer
@onready var play: Button = $VBoxContainer/Play


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")



func _on_head_bob_pressed() -> void:
	if Globals.motion_sickness_flag == true:
		Globals.motion_sickness_flag = false
	else:
		Globals.motion_sickness_flag = true


func _on_quit_pressed() -> void:
	get_tree().quit()
