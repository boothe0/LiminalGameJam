extends CanvasLayer
@onready var inventory: HBoxContainer = $Inventory
@onready var quests: VBoxContainer = $Quests

@onready var area_2d: Array[Area2D] = [$Inventory/Area2D, $Inventory/Area2D2, $Inventory/Area2D3, $Inventory/Area2D4, $Inventory/Area2D5, $Inventory/Area2D6, $Inventory/Area2D7, $Inventory/Area2D8, $Inventory/Area2D9 ]
@onready var label: Label = $Label

var area_texture_dictionary = {}

var post_it = preload("res://quest_props_tools/LO_post_it_note_tex.png")
var drill = preload("res://quest_props_tools/LO_drill_drill_tex.png")
var mirrorstick = preload("res://quest_props_tools/LO_mirrorstick_stick_tex.png")
var panel_opener = preload("res://quest_props_tools/LO_panel_opener_panel_opener_tex.png")
var tether_hook = preload("res://quest_props_tools/LO_tether_hook_tex.png")
var tether_rope = preload("res://quest_props_tools/LO_tether_rope_tex.png")
var lemon_basket = preload("res://set_dressing_props/LO_cafe_main_shutter_tex.png")
var mag = preload("res://quest_props_lemonade/LO_mag_mag_tex.png")
var lemon = preload("res://quest_props_lemonade/LO_Lemon1_lemon_tex.png")

var font = preload("res://fonts/Summerti.ttf")

func _ready():
	for area in area_2d:
		area.mouse_entered.connect(_on_area_2d_mouse_entered.bind(area))
		area.mouse_exited.connect(_on_area_2d_mouse_exited.bind(area))
	Emitter.item_picked_up.connect(self.adding_to_inv)
	Emitter.remove_inv_assets.connect(self.remove_asset.bind("lemon_basket_2"))

func adding_to_inv():
	var item_key = Globals.most_recent_node
	if item_key in ["WorkNote", "PicnicNote", "DateNote", "LemonNote"]:
		make_asset(post_it)
		quest_trigger()
		Emitter.emit_signal("note_picked_up") 
	match item_key:
		"LO_drill2":
			make_asset(drill)
		"LO_mirrorstick":
			make_asset(mirrorstick)
		"panelopenerasset":
			make_asset(panel_opener)
		"tetherhookasset":
			make_asset(tether_hook)
		"tetherropeasset":
			make_asset(tether_rope)
		"LO_basket_filled_star2":
			Globals.picked_up_star_basket = true
			make_asset(lemon_basket)
		"LO_mag":
			make_asset(mag)
		"LO_Lemon1":
			Globals.lemon_count += 1
			make_asset(lemon)
		"LO_Lemon2":
			Globals.lemon_count += 1
			make_asset(lemon)
		"LO_Lemon3":
			Globals.lemon_count += 1
			make_asset(lemon)
func quest_trigger():
	Globals.lemon_quest_triggered = true
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
	
	var area = area_2d[Globals.number_items - 1]
	area_texture_dictionary[area] = texture_rect

func remove_asset(type_of_asset):
	if type_of_asset == "lemon_basket_2":
		var lemons_to_remove = []
		for area in area_texture_dictionary:
			var texture = area_texture_dictionary[area]
			if texture.name in ["LO_Lemon1", "LO_Lemon2", "LO_Lemon3"]:
				texture.queue_free()
				lemons_to_remove.append(area)
				Globals.lemon_count -= 1
			if texture.name == "LO_basket_filled_star2":
				texture.queue_free()
				lemons_to_remove.append(area)
		for lemon in lemons_to_remove:
			area_texture_dictionary.erase(lemon)
		print(Globals.lemon_count)
		
	
func date_night_quest():
	var v_box = VBoxContainer.new()
	var quest_title = Label.new()
	quest_title.text = "Romantic Date Night"
	quest_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	var quest_information = Label.new()
	quest_information.text = "Clean Up! \n OR \n Put out Candles!"
	quest_information.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	quest_information.add_theme_font_override("font", font)
	quests.add_child(v_box)
	v_box.add_child(quest_title)
	v_box.add_child(quest_information)
	quest_information.label_settings = LabelSettings.new()
	quest_information.label_settings.font_size = 30
	quest_information.label_settings.font = font
	
	quest_title.label_settings = LabelSettings.new()
	quest_title.label_settings.font_size = 40
	quest_title.label_settings.font = font
func tools_quest():
	var v_box = VBoxContainer.new()
	var quest_title = Label.new()
	quest_title.text = "Put back the tools, fools!"
	var quest_information = Label.new()
	quest_information.text = "Tether Hooks \n Pannel Opener \n Screwdriver \n Mirror on a stick"
	quest_information.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	quest_information.add_theme_font_override("font", font)
	quests.add_child(v_box)
	v_box.add_child(quest_title)
	v_box.add_child(quest_information)
	
	quest_information.label_settings = LabelSettings.new()
	quest_information.label_settings.font_size = 30
	quest_information.label_settings.font = font
	
	quest_title.label_settings = LabelSettings.new()
	quest_title.label_settings.font_size = 40
	quest_title.label_settings.font = font
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
	
	quest_information.label_settings = LabelSettings.new()
	quest_information.label_settings.font_size = 30
	quest_information.label_settings.font = font
	
	quest_title.label_settings = LabelSettings.new()
	quest_title.label_settings.font_size = 40
	quest_title.label_settings.font = font

	# trigger global boolean
	Globals.lemon_picking = true

func lemon_cake_quest():
	var v_box = VBoxContainer.new()
	var quest_title = Label.new()
	quest_title.text = "Sorry I forgot the lemon cake"
	quest_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	var quest_information = Label.new()
	quest_information.text = "Bring to workstation! \n OR \n Near the lockers!"
	quest_information.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	quest_information.add_theme_font_override("font", font)
	quests.add_child(v_box)
	v_box.add_child(quest_title)
	v_box.add_child(quest_information)
	
	quest_information.label_settings = LabelSettings.new()
	quest_information.label_settings.font_size = 30
	quest_information.label_settings.font = font
	
	quest_title.label_settings = LabelSettings.new()
	quest_title.label_settings.font_size = 40
	quest_title.label_settings.font = font
func _on_area_2d_mouse_entered(area):
	var texture_rect = area_texture_dictionary.get(area)
	if texture_rect:
		handle_label_inv(texture_rect.name)

func _on_area_2d_mouse_exited(area):
	label.visible = false


func handle_label_inv(node_name):
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
		"LO_mirrorstick":
			label.text = "Mirrorstick"
			label.visible = true
		"LO_basket_filled_star2":
			label.text = "Lemon Basket (rembember to bring with 3 lemons!)"
			label.visible = true
		"LO_drill2":
			label.text = "Drill"
			label.visible = true
		"LO_mag":
			label.text = "Mag"
			label.visible = true
		"LO_Lemon1":
			label.text = "Lemon"
			label.visible = true
		"LO_Lemon2":
			label.text = "Lemon"
			label.visible = true
		"LO_Lemon3":
			label.text = "Lemon"
			label.visible = true
