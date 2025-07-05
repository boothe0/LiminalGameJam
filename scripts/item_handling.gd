extends StaticBody3D

@onready var label_3d_2: Label3D = $MeshInstance3D/Label3D2
@onready var label_3d: Label3D = $MeshInstance3D/Label3D
func _process(delta: float) -> void:
	# making sure the player is near the interactable by checking the label
	if Input.is_action_just_pressed("interact") and label_3d_2.visible == true:
		# debug statement
		# free the object
		Globals.most_recent_node = self.name
		var scene = self.get_scene_file_path()
		Globals.item[str(self.name)] = scene
		self.queue_free()
		if Globals.number_items == 0:
			Emitter.emit_signal("first_item_pickup")
		Globals.number_items += 1
		Emitter.emit_signal("item_picked_up")

# handles label visibility
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		label_3d_2.visible = true
func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		label_3d_2.visible = false
