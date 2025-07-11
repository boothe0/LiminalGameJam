extends CanvasLayer
@onready var play: Button = $VBoxContainer/Play

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_stream_player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	audio_stream_player.stop()
	get_tree().change_scene_to_file("res://scenes/non_quest/intro.tscn")

func _on_head_bob_pressed() -> void:
	if Globals.motion_sickness_flag == true:
		Globals.motion_sickness_flag = false
	else:
		Globals.motion_sickness_flag = true


func _on_quit_pressed() -> void:
	get_tree().quit()
