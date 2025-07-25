extends CanvasLayer
@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void:
	if Globals.lemon_quest_triggered or Globals.picnic_quest_triggered or Globals.date_quest_triggered or Globals.tools_quest_triggered:
		texture_rect.texture = load("res://assets/LO_endings_together.jpg")
	else:
		texture_rect.texture = load("res://assets/LO_endings_alone.jpg")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func _on_button_pressed() -> void:
	get_tree().quit()
