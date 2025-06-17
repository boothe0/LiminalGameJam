extends Node

var motion_sickness_flag = true

# empty dictionary to store item pickups to load on each scene reload
# syntax is key:value
# to assign item[key] = value
# the value will be the scene of the item for each item/asset make it a separate scene to load
var item = {
}
var number_items = 0
var scene_counter = 0
