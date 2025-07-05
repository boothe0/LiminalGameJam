extends CanvasLayer

var post_it = preload("res://quest_props_tools/LO_post_it_note_tex.png")
@onready var panel: Panel = $Background/GridContainer/Panel
@onready var texture_rect: TextureRect = $Background/GridContainer/TextureRect
@onready var grid_container: GridContainer = $Background/GridContainer
func _ready():
	var index = Globals.note_count
	while index != 0:
		texture_rect = grid_container.get_child(Globals.inventory_indexing)
		texture_rect.texture = post_it
		Globals.inventory_indexing += 1
		index -= 1
