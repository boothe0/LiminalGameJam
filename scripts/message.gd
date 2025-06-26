extends CanvasLayer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func _on_button_pressed() -> void:
	self.queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print(Globals.item)
