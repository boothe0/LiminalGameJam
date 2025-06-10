extends Node3D
var asset = preload("res://scenes/placeholder_asset.tscn")
func _ready():
	FadeEffectTransition.transition()
	await Emitter.on_transition_finished
	# TODO: Switch statement eventually for different loading situations
	if Globals.scene_counter == 0:
		# load the according assets
		print(Globals.scene_counter)
		var loaded_asset = asset.instantiate()
		add_child(loaded_asset)
