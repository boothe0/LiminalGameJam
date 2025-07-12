extends Node3D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


const LIMINAL_JAM_NIGHT_SHIFT_MUSIC = preload("res://audio/Liminal Jam - Night Shift Concept Music.ogg")
const LIMINAL_JAM_NIGHT_SHIFT_VARIATION = preload("res://audio/Liminal Jam - Night Shift Variation.ogg")
const LIMINAL_JAM_LAST_NIGHT_SHIFT = preload("res://audio/Liminal Jam - Last Night Shift.ogg")
func _ready():
	FadeEffectTransition.transition()
	await Emitter.on_transition_finished
	if Globals.scene_counter == 0:
		# load the according assets
		audio_stream_player.stream = LIMINAL_JAM_NIGHT_SHIFT_MUSIC
		audio_stream_player.play()
	elif Globals.scene_counter == 1:
		audio_stream_player.stream = LIMINAL_JAM_NIGHT_SHIFT_VARIATION
		audio_stream_player.play()
	elif Globals.scene_counter == 2:
		audio_stream_player.stream = LIMINAL_JAM_LAST_NIGHT_SHIFT
		audio_stream_player.play()
	# add another elif or else to direct to another function handling the end scene
	
	
	# reset globals for next rounds
	Globals.can_interact = true
	Globals.number_items = 0
