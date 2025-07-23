extends StaticBody3D
@onready var continue_message: Label3D = $ContinueMessage

func _process(_delta: float) -> void:
	# checking if the player is near the door
	if Input.is_action_just_pressed("interact") and continue_message.visible == true:
		Globals.scene_counter += 1
		for item in Globals.item:
			if item == "LO_mag":
				Globals.mag_picked_up = true
		Globals.item.clear()
	
		if Globals.put_lemons_away == true or Globals.dropped_off_workbench == true or Globals.dropped_off_lockers == true or Globals.mag_picked_up == true:
			get_tree().change_scene_to_file("res://scenes/quest_endings.tscn")
		else:
			get_tree().reload_current_scene()

func _on_detection_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		continue_message.visible = true
		print("player entered")

func _on_detection_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		continue_message.visible = false
		print("player exited")
