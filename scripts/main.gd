extends Node3D
@onready var table_label: Label3D = $"LevelFloor/cafe bar/LO_cafe_main/cafe seating/LO_cafe_table2/TableLabel"
@onready var mag_label: Label3D = $"Dome/garden furniture/LO_bench2/MagLabel"
@onready var bee_label: Label3D = $LevelFloor/quest_items/LO_basket_filled2/BeeLabel
@onready var pie_label: Label3D = $"LevelFloor/workbench tools/LO_workbench/Pie_Work_Bench/PieLabel"
@onready var secondary_pie_label: Label3D = $LevelFloor/lockers/SecondaryPieLabel


@onready var lo_lantern_1: Node3D = $LevelFloor/quest_items/LO_picnic/LO_lantern1
@onready var lo_lantern_2: Node3D = $LevelFloor/quest_items/LO_picnic/LO_lantern2
@onready var lo_lantern_3: Node3D = $LevelFloor/quest_items/LO_picnic/LO_lantern3
@onready var lo_lantern_4: Node3D = $LevelFloor/quest_items/LO_picnic/LO_lantern4
@onready var invisible_lanterns: Node3D = $LevelFloor/quest_items/LO_picnic/InvisibleLanterns



@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var lemon_1_quest: Label3D = $LevelFloor/quest_items/LO_basket_filled_star2/Lemon1Quest

@onready var workbench_label: Label3D = $LevelFloor/LO_workbench_Quest/WorkbenchLabel

# Tablet pictures
@onready var foreman_fixNPC: MeshInstance3D = $LevelFloor/quest_items/LO_tablet/foreman_fix
@onready var tetherNPC: MeshInstance3D = $LevelFloor/quest_items/LO_tablet/tether
@onready var mirrorstickNPC: MeshInstance3D = $LevelFloor/quest_items/LO_tablet/mirrorstick
@onready var drillNPC: MeshInstance3D = $LevelFloor/quest_items/LO_tablet/drill
@onready var panel_openerNPC: MeshInstance3D = $"LevelFloor/quest_items/LO_tablet/panel opener"



var near_basket = false
var near_table = false
var near_lockers = false
var near_workbench = false

# TOOLS QUEST
var near_quest_workbench = false

var message = preload("res://scripts/message.gd")
const LIMINAL_JAM_NIGHT_SHIFT_MUSIC = preload("res://audio/Liminal Jam - Night Shift Concept Music.ogg")
const LIMINAL_JAM_NIGHT_SHIFT_VARIATION = preload("res://audio/Liminal Jam - Night Shift Variation.ogg")
const LIMINAL_JAM_LAST_NIGHT_SHIFT = preload("res://audio/Liminal Jam - Last Night Shift.ogg")
func _ready():
	print(Globals.item)
	FadeEffectTransition.transition()
	await Emitter.on_transition_finished
	audio_stream_player.volume_db = -20
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
	var tween = get_tree().create_tween()
	tween.tween_property(audio_stream_player, "volume_db", 0, 2.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

	# add another elif or else to direct to another function handling the end scene
	
	# reset globals for next rounds
	Globals.can_interact = true
	Globals.number_items = 0
	
	# emitters
	Emitter.date_quest_start.connect(self.lantern_monitoring)
	Emitter.lanterns_up.connect(self.show_lanterns)
	
	# reloading scene pictures
	if Globals.scene_counter >= 1:
		
		if Globals.tether_returned and Globals.drill_returned and Globals.mirrorstick_returned and Globals.panel_opener_returned:
			foreman_fixNPC.visible = true
			tetherNPC.visible = true
			drillNPC.visible = true
			mirrorstickNPC.visible = true
			panel_openerNPC.visible = true
		else:
			if Globals.tether_returned:
				tetherNPC.visible = true
			if Globals.drill_returned:
				drillNPC.visible = true
			if Globals.mirrorstick_returned:
				mirrorstickNPC.visible = true
			if Globals.panel_opener_returned:
				panel_openerNPC.visible = true
	
func _process(float) -> void:
	if lemon_1_quest and Globals.lemon_quest_triggered == true:
		lemon_1_quest.visible = true
	
	if Globals.lanterns_up == true:
		Emitter.emit_signal("lanterns_up")
	# LEMON QUEST
	if Globals.lemon_picking:
		mag_label.visible = true
		table_label.visible = true
		bee_label.visible = true
	# DATE QUEST
	if Globals.picnic_quest_triggered and "LO_pie_slice" in Globals.item:
		pie_label.visible = true
		secondary_pie_label.visible = true
		if Input.is_action_just_pressed("interact") and near_lockers:
			Emitter.emit_signal("remove_inv_lemon_pie")
			Globals.dropped_off_lockers = true
			Globals.picnic_quest_triggered = false
			pie_label.visible = false
			secondary_pie_label.visible = false
		if Input.is_action_just_pressed("interact") and near_workbench:
			Emitter.emit_signal("remove_inv_lemon_pie")
			Globals.dropped_off_workbench = true
			Globals.picnic_quest_triggered = false
			pie_label.visible = false
			secondary_pie_label.visible = false
	# TOOLS QUEST
	if Input.is_action_just_pressed("interact") and Globals.tools_quest_triggered and near_quest_workbench:
		if "LO_drill2" in Globals.item:
			Emitter.emit_signal("remove_drill")
		if "LO_mirrorstick" in Globals.item:
			Emitter.emit_signal("remove_mirrorstick")
		if "LO_tether" in Globals.item:
			Emitter.emit_signal("remove_tether")
		if "LO_panel_opener" in Globals.item:
			Emitter.emit_signal("remove_panel_opener")
	if Input.is_action_just_pressed("interact") and near_basket and Globals.lemon_picking:
		# so user knows to bring back 3 lemons
		Emitter.emit_signal("display_warning")
	# many conditions so they dont accidently turn in this part without actually doing it
	if Input.is_action_just_pressed("interact") and near_table and Globals.lemon_picking and Globals.picked_up_star_basket:
		Emitter.emit_signal("remove_inv_asset_lemons")
		Globals.lemon_picking = false
		if Globals.lemon_count >= 3:
			Globals.returned_full_basket = true
			table_label.text = "Nice job on the lemon picking! Now find those other baskets."
		else:
			table_label.text = "Well Done! Now Find the other baskets or exit!"
		Globals.lemon_count = 0

		
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		near_basket = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		near_basket = false


func _on_table_area_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		near_table = true


func _on_table_area_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		near_table = false

func _on_locker_pie_deliver_body_entered(body: Node3D) -> void:
	if body.name == "Player" and "LO_pie_slice" in Globals.item:
		near_lockers = true


func _on_work_bench_area_body_entered(body: Node3D) -> void:
	if body.name == "Player" and "LO_pie_slice" in Globals.item:
		near_workbench = true
func lantern_monitoring():
	var area1 = lo_lantern_1.get_child(1)
	area1.monitoring = true
		
	var area2 = lo_lantern_2.get_child(1)
	area2.monitoring = true
			
	var area3 = lo_lantern_3.get_child(1)
	area3.monitoring = true
			
	var area4 = lo_lantern_4.get_child(1)
	area4.monitoring = true
	
func show_lanterns():
	for lantern in invisible_lanterns.get_children():
		lantern.visible = true
	Globals.lanterns_up = false
	Globals.lanterns_were_up = true

func _on_work_area_body_entered(body: Node3D) -> void:
	if body.name == "Player" and "LO_drill2" in Globals.item:
		workbench_label.visible = true
		near_quest_workbench = true

	if body.name == "Player" and "LO_mirrorstick" in Globals.item:
		workbench_label.visible = true
		near_quest_workbench = true
	if body.name == "Player" and "LO_tether" in Globals.item:
		workbench_label.visible = true
		near_quest_workbench = true
	if body.name == "Player" and "LO_panel_opener" in Globals.item:
		workbench_label.visible = true
		near_quest_workbench = true
func _on_work_area_body_exited(body: Node3D) -> void:
	if workbench_label.visible == true:
		workbench_label.visible = false
	near_quest_workbench = false
