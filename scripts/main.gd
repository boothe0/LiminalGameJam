extends Node3D
var asset = preload("res://scenes/placeholder_asset.tscn")
func _ready():
	print(Globals.scene_counter)
	# TODO: Switch statement eventually for different loading situations
	if Globals.scene_counter == 0:
		# load the according assets
		var loaded_asset = asset.instantiate()
		add_child(loaded_asset)
