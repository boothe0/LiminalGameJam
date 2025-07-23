extends CanvasLayer

@onready var timer: Timer = $Timer
@onready var texture_rect: TextureRect = $TextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play("fade")
	
	if Globals.put_lemons_away == true:
		texture_rect.texture = load("res://assets/LO_endings_beelover.jpg")
	elif Globals.dropped_off_workbench == true:
		texture_rect.texture = load("res://assets/LO_endings_cake_buddies.jpg")
	elif Globals.dropped_off_lockers == true:
		texture_rect.texture = load("res://assets/LO_endings_cake_couple.jpg")
	elif Globals.mag_picked_up == true:
		texture_rect.texture = load("res://assets/LO_endings_magclub.jpg")
	else:
		pass
	timer.start()



#if Globals.put_lemons_away == true or Globals.dropped_off_workbench == true or Globals.dropped_off_lockers == true or Globals.mag_picked_up == true:

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/non_quest/main.tscn")
