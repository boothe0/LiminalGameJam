extends CanvasLayer
@onready var inventory: HBoxContainer = $Inventory
@onready var quests: VBoxContainer = $Quests

@onready var area_2d: Array[Area2D] = [$Inventory/Area2D, $Inventory/Area2D2, $Inventory/Area2D3]
@onready var label: Label = $Label


var post_it = preload("res://quest_props_tools/LO_post_it_note_tex.png")
var drill = preload("res://quest_props_tools/LO_drill_drill_tex.png")
var mirrorstick = preload("res://quest_props_tools/LO_mirrorstick_stick_tex.png")
var panel_opener = preload("res://quest_props_tools/LO_panel_opener_panel_opener_tex.png")
var tether_hook = preload("res://quest_props_tools/LO_tether_hook_tex.png")
var tether_rope = preload("res://quest_props_tools/LO_tether_rope_tex.png")

func _ready():
	Emitter.item_picked_up.connect(self.adding_to_inv)

func adding_to_inv():
	var item_key = Globals.most_recent_item_key
	if item_key == "WorkNote" || "PicnicNote" || "DateNode" || "LemonNote":
		make_asset(post_it)
		quest_trigger()
	match item_key:
		"PicnicNote":
			make_asset(post_it)
			quest_trigger()
		"drillasset":
			make_asset(drill)
		"mirrorstickasset":
			make_asset(mirrorstick)
		"panelopenerasset":
			make_asset(panel_opener)
		"tetherhookasset":
			make_asset(tether_hook)
		"tetherropeasset":
			make_asset(tether_rope)

func quest_trigger():
	var item_node = Globals.most_recent_node
	match item_node:
		"DateNote":
			date_night_quest()
		"WorkNote":
			tools_quest()
		"LemonNote":
			lemon_picking_quest()
		"PicnicNote":
			lemon_cake_quest()

func make_asset(texture):
	var texture_rect = TextureRect.new()
	texture_rect.texture = texture
	texture_rect.expand_mode = texture_rect.EXPAND_FIT_WIDTH
	texture_rect.name = Globals.most_recent_node
	inventory.add_child(texture_rect)
	# store the area
	var area = area_2d[Globals.number_items - 1]
	# store the collision
	var collision = area.get_child(0)
	area.remove_child(collision)
	# reparent to texture
	get_parent().remove_child(area)
	texture_rect.add_child(area)
	area.add_child(collision)

func date_night_quest():
	var v_box = VBoxContainer.new()
	var quest_title = Label.new()
	quest_title.text = "Romantic Date Night"
	quest_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	var quest_information = Label.new()
	quest_information.text = "Clean Up! \n OR \n Put out Candles!"
	quest_information.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	quests.add_child(v_box)
	v_box.add_child(quest_title)
	v_box.add_child(quest_information)

func tools_quest():
	var v_box = VBoxContainer.new()
	var quest_title = Label.new()
	quest_title.text = "Put back the tools, fools!"
	var quest_information = Label.new()
	quest_information.text = "Tether Hooks \n Pannel Opener \n Screwdriver \n Mirror on a stick"
	quest_information.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	quests.add_child(v_box)
	v_box.add_child(quest_title)
	v_box.add_child(quest_information)

func lemon_picking_quest():
	var v_box = VBoxContainer.new()
	var quest_title = Label.new()
	quest_title.text = "When life gives you lemons..."
	var quest_information = Label.new()
	quest_information.text = "Find Basket 1\nFind Basket 2\nFind Basket 3"
	quest_information.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	quests.add_child(v_box)
	v_box.add_child(quest_title)
	v_box.add_child(quest_information)

func lemon_cake_quest():
	var v_box = VBoxContainer.new()
	var quest_title = Label.new()
	quest_title.text = "Sorry I forgot the lemon cake"
	quest_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	var quest_information = Label.new()
	quest_information.text = "Bring to workstation! \n OR \n Near the lockers!"
	quest_information.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	quests.add_child(v_box)
	v_box.add_child(quest_title)
	v_box.add_child(quest_information)



func _on_area_2d_mouse_entered() -> void:
	# get the name of the texture rectangle to get corresponding text
	var node_name
	for child in inventory.get_children():
		if child is TextureRect:
			node_name = child.name
	print(node_name)
	match node_name:
		"PicnicNote":
			label.text = "Between the trees there is a picknick basket. \n Clearly the meal is over. There are small times \n that indicate several persons"
			label.visible = true
		"WorkNote":
			label.text = "You can collect four tools all \n over and bring them back here \n to result in ever more friendly behaviour \n between the foreman and the workers!"
			label.visible = true
		"LemonNote":
			label.text = "A will probably not pick a lot, and \n  when you find their almost empty basket you can fill \n it for them to improve their standing."
			label.visible = true

		"DateNote":
			label.text = "Surprise! Be at the three trees by 22:00 Dress up! :)"
			label.visible = true

	# otherwise it is an actual item
	
func _on_area_2d_2_mouse_entered() -> void:
	# get the name of the texture rectangle to get corresponding text
	var node_name
	var count = 0
	for child in inventory.get_children():
		if child is TextureRect:
			count += 1
		if child is TextureRect and count == 1:
			node_name = child.name
	print(node_name)
	match node_name:
		"PicnicNote":
			label.text = "Between the trees there is a picknick basket. \n Clearly the meal is over. There are small times \n that indicate several persons"
			label.visible = true
		"WorkNote":
			label.text = "You can collect four tools all \n over and bring them back here \n to result in ever more friendly behaviour \n between the foreman and the workers!"
			label.visible = true
		"LemonNote":
			label.text = "A will probably not pick a lot, and \n  when you find their almost empty basket you can fill \n it for them to improve their standing."
			label.visible = true
		"DateNote":
			label.text = "Surprise! Be at the three trees by 22:00 Dress up! :)"
			label.visible = true
	# otherwise it is an actual item	
func _on_area_2d_3_mouse_entered() -> void:
	# get the name of the texture rectangle to get corresponding text
	var node_name
	var count = 0
	for child in inventory.get_children():
		if child is TextureRect:
			count += 1
		if child is TextureRect and count == 2:
			node_name = child.name
	match node_name:
		"PicnicNote":
			label.text = "Between the trees there is a picknick basket. \n Clearly the meal is over. There are small times \n that indicate several persons"
			label.visible = true
		"WorkNote":
			label.text = "You can collect four tools all \n over and bring them back here \n to result in ever more friendly behaviour \n between the foreman and the workers!"
			label.visible = true
		"LemonNote":
			label.text = "A will probably not pick a lot, and \n  when you find their almost empty basket you can fill \n it for them to improve their standing."
			label.visible = true
		"DateNote":
			label.text = "Surprise! Be at the three trees by 22:00 Dress up! :)"
			label.visible = true
	# otherwise it is an actual item

func _on_area_2d_mouse_exited() -> void:
	label.visible = false
func _on_area_2d_2_mouse_exited() -> void:
	label.visible = false
func _on_area_2d_3_mouse_exited() -> void:
	label.visible = false
