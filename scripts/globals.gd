extends Node


var motion_sickness_flag = true

# empty dictionary to store item pickups to load on each scene reload
# syntax is key:value
# to assign item[key] = value
# the value will be the scene of the item for each item/asset make it a separate scene to load
var most_recent_item_key = "placeholder"
var most_recent_node = "holder"
var item = {
}
var number_items = 0
var scene_counter = 0
var notes_picked_up = []
var can_interact = true
var did_player_interact = false

# Lemon count general
var lemon_count = 0

# Lemon Quest Flags
var lemon_quest_triggered = false
var lemon_picking = false
var returned_full_basket = false
var picked_up_star_basket = false
var mag_picked_up = false
# for bee food 
var left_lemons = false
var clean_up_food = false
var put_lemons_away = false
var choice_picked = false


# Picnic Quest flags
var picnic_quest_triggered = false
var dropped_off_workbench = false
var dropped_off_lockers = false

# Date quest variables
var lantern_count = 0
var lanterns_up = false
var lanterns_were_up = false
var lantern_choice_made = false
var date_quest_triggered = false

# tools quest variables
var mirrorstick_returned = false
var drill_returned = false
var tools_quest_triggered = false
