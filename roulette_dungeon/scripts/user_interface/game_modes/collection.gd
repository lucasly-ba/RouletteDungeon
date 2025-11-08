extends Control

@onready var gamblers_button := $gamblers_button
@onready var weapons_button := $weapons_button
@onready var gamblers := $Gamblers
@onready var sortlabel := $Possessed/sort_button
@onready var  weapons = $Weapons/GridContainer
@onready var  weapons_scroll_container = $Weapons
@onready var ascending_image = $Possessed/ascending_button/TextureRect


var uparrow = preload("res://roulette_dungeon/assets/user_interface/weaponsscene/arrow.png")
var downarrow = preload("res://roulette_dungeon/assets/user_interface/weaponsscene/downarrow.png")
var cleartheme = preload("res://roulette_dungeon/assets/tres/buttons_theme/collection_buttons.tres")

var darktheme = preload("res://roulette_dungeon/assets/tres/buttons_theme/collection_buttons2.tres")
var nbsortpressed = 0
var nbascendingpressed = 0

var weapons_scroll_vertical = 0
var gamblers_scroll_vertical = 0




func _on_gamblers_button_toggled(toggled_on: bool) -> void:
	if toggled_on and global_user_interface.collection_gamblers_button_activated == false:
		global_user_interface.collection_gamblers_button_activated = true
		global_user_interface.collection_weapons_button_activated = false
		weapons_button.set_pressed(false)
		gamblers_button.add_theme_stylebox_override("pressed", cleartheme)
		weapons_button.add_theme_stylebox_override("pressed", darktheme)
		gamblers_button.add_theme_stylebox_override("normal", cleartheme)
		weapons_button.add_theme_stylebox_override("normal", darktheme)
		gamblers_button.add_theme_stylebox_override("hover", cleartheme)
		weapons_button.add_theme_stylebox_override("hover", darktheme)
		
		
		gamblers.visible = true
		await get_tree().process_frame
		await get_tree().process_frame
		$Gamblers.scroll_vertical = gamblers_scroll_vertical
		weapons_scroll_vertical = $Weapons.scroll_vertical
		weapons.visible = false
		
	else:
		gamblers_button.set_pressed(global_user_interface.collection_gamblers_button_activated)


func _on_weapons_button_toggled(toggled_on: bool) -> void:
	if toggled_on and global_user_interface.collection_weapons_button_activated == false:
		global_user_interface.collection_gamblers_button_activated = false
		global_user_interface.collection_weapons_button_activated = true
		gamblers_button.set_pressed(false)
		gamblers_button.add_theme_stylebox_override("pressed", darktheme)
		weapons_button.add_theme_stylebox_override("pressed", cleartheme)
		gamblers_button.add_theme_stylebox_override("normal", darktheme)
		weapons_button.add_theme_stylebox_override("normal", cleartheme)
		gamblers_button.add_theme_stylebox_override("hover", darktheme)
		weapons_button.add_theme_stylebox_override("hover", cleartheme)
		weapons.visible = true
		await get_tree().process_frame
		await get_tree().process_frame
		$Weapons.scroll_vertical = weapons_scroll_vertical
		gamblers_scroll_vertical = $Gamblers.scroll_vertical
		gamblers.visible = false
	else:
		weapons_button.set_pressed(global_user_interface.collection_weapons_button_activated)


func _on_sort_button_pressed() -> void:
	nbsortpressed +=1
	if nbsortpressed == 0:
		sortlabel.text = "Par rarete"
		sort_by_rarity_sort_button()

	else:
		sortlabel.text = "Par level"
		nbsortpressed = -1
		sort_by_level_sort_button()



func _on_ascending_button_pressed() -> void:
	nbascendingpressed +=1
	if nbascendingpressed == 0:
		ascending_image.texture = uparrow
		sort_ascending_button()
	else:
		ascending_image.texture = downarrow
		nbascendingpressed = -1
		sort_descending_button()
		
		
func sort_by_rarity_sort_button():
	var weps = weapons.get_children()
	if nbascendingpressed == 0:
		weps.sort_custom(sort_rare_ascending)
	else:
		weps.sort_custom(sort_rare_descending)
		weps = move_last_four_to_front(weps)
	for i in range (0,weps.size()):
		weapons.move_child(weps[i],i)

func sort_by_level_sort_button():
	var weps = weapons.get_children()
	if nbascendingpressed == 0:
		weps.sort_custom(sort_level_ascending)
	else:
		weps.sort_custom(sort_level_descending)
		weps = move_last_four_to_front(weps)
	for i in range (0,weps.size()):
		weapons.move_child(weps[i],i)
				
func sort_ascending_button():
	var weps = weapons.get_children()
	if nbsortpressed == 0:
		weps.sort_custom(sort_rare_ascending)
	else:
		weps.sort_custom(sort_level_ascending)
	for i in range (0,weps.size()):
		weapons.move_child(weps[i],i)

				
				
func sort_descending_button():
	var weps = weapons.get_children()
	if nbsortpressed == 0:
		weps.sort_custom(sort_rare_descending)
	else:
		weps.sort_custom(sort_level_descending)
	weps = move_last_four_to_front(weps)
	for i in range (0,weps.size()):
		weapons.move_child(weps[i],i)


func sort_rare_ascending(a,b):
	if a.index < b.index:
		return true
	return false
	
func sort_rare_descending(a,b):
	if a.index > b.index:
		return true
	return false
				
func sort_level_ascending(a, b):
	if a.get_level() < b.get_level():
		return true
	if a.get_level() == b.get_level() and a.index < b.index:
		return true
	return false

func sort_level_descending(a, b):
	if a.get_level() > b.get_level():
		return true
	if a.get_level() == b.get_level() and a.index > b.index:
		return true
	return false
	

func move_last_four_to_front(arr):
	
	var last_four = arr.slice(arr.size() - 4, arr.size())
	var res = arr.slice(0, arr.size() - 4)
	
	res.append(res.pop_at(0))
	return last_four + res


	
