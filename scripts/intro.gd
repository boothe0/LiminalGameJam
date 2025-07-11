extends CanvasLayer
@onready var button: Button = $VBoxContainer/Button


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/non_quest/main.tscn")
