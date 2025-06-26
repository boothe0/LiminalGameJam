extends StaticBody3D

@onready var label_3d_2: Label3D = $MeshInstance3D/Label3D2
@onready var label_3d: Label3D = $MeshInstance3D/Label3D
func _process(delta: float) -> void:
	# making sure the player is near the interactable by checking the label
	if Input.is_action_just_pressed("interact") and label_3d_2.visible == true:
		# debug statement
		# free the object
		Globals.most_recent_node = self.name
		self.queue_free()
		if Globals.number_items == 0:
			Emitter.emit_signal("first_item_pickup")
		Globals.number_items += 1
		# call the regex function
		Globals.most_recent_item_key = key_retrieval()
		Emitter.emit_signal("item_picked_up")


# IMPORTANT
# Gets the key straight from the scene path so I can look it up later to add to the next scene change
# use the following syntax to name your scene paths for assets: name_name
# will combine to namename for more descriptive assets
func key_retrieval():
	var key = ""
	# regex stuff
	var regex = RegEx.new()
	regex.compile("res://scenes/([A-Za-z]+)_([A-Za-z]+)\\.tscn")
	var scene = self.get_scene_file_path()
	var word = regex.search(scene)
	# combine the two words to get the key to add to the global dictionary
	key += word.get_string(1) + "" + word.get_string(2)
	# set the item dictionary
	Globals.item[key] = scene
	return key

# handles label visibility
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		label_3d_2.visible = true
func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		label_3d_2.visible = false
