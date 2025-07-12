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
var lemon_picking = false
var returned_full_basket = false
var picked_up_star_basket = false
var mag_picked_up = false
