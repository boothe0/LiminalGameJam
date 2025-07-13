extends Node

@export var audio_path: NodePath
@onready var audio = get_node(audio_path)
@export var area_path: NodePath
@onready var area = get_node(area_path)
@export var label_3d_2_path: NodePath
@onready var label_3d_2: Label3D = get_node(label_3d_2_path)
@export var label_3d_path: NodePath
@onready var label_3d: Label3D = get_node(label_3d_path)
var message = preload("res://scenes/non_quest/message.tscn")
func _ready() -> void:
	area.body_entered.connect(_on_area_3d_body_entered)
	area.body_exited.connect(_on_area_3d_body_exited)
func _process(delta: float) -> void:

	# making sure the player is near the interactable by checking the label
	if Input.is_action_just_pressed("interact") and label_3d_2.visible == true and Globals.can_interact:
		# debug statement
		# if there is an audio stream

		
		if self.name != "LO_basket_filled2":
			if audio:
				audio.play()
			# might be too long of a delay 
			await get_tree().create_timer(0.2).timeout
			Globals.most_recent_node = self.name
			var scene = self.get_scene_file_path()
			Globals.item[str(self.name)] = scene
			self.queue_free()
			if Globals.did_player_interact == false:
				Emitter.emit_signal("first_item_pickup")
				Globals.did_player_interact = true
			Globals.number_items += 1
			if Globals.number_items > 8 :
				Emitter.emit_signal("too_many_items")
				Globals.can_interact = false
				
			# for bee food part of lemon quest
			# Debug for later if it goes to 9 and not trigger too many items
			print("Number ITEMS: ", Globals.number_items)
			Emitter.emit_signal("item_picked_up")

# handles label visibility
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		label_3d_2.visible = true
	if self.name == "LO_basket_filled2" and Globals.choice_picked == false and Globals.lemon_quest_triggered == true:
		Emitter.emit_signal("bee_basket_choice")

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		label_3d_2.visible = false
