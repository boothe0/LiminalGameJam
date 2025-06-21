extends Node3D
func _ready():
	FadeEffectTransition.transition()
	await Emitter.on_transition_finished
	# TODO: Switch statement eventually for different loading situations
	if Globals.scene_counter == 0:
		# load the according assets
		print(Globals.scene_counter)
