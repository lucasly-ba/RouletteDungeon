extends Node
class_name Weapon

@onready var label = $Button/Level/Label
@onready var bar = $Button/LevelBar/Panel/Panel/TextureRect
@onready var weapon_number = $Button/LevelBar/Panel/Panel/WeaponNumber
@onready var color_change = $Button/LevelBar/Panel
@onready var arrow = $Button/LevelBar/AnimatedSprite2D

var can_upgrade_bar = load("res://roulette_dungeon/assets/user_interface/weaponsscene/barfin.png")


var purple_panel = load("res://roulette_dungeon/assets/tres/weaponsLevelBarPurple.tres")
var yellow_panel = load("res://roulette_dungeon/assets/tres/weaponsLevelBarYellow.tres")


var bar_dict = {
	0: load("res://roulette_dungeon/assets/user_interface/weaponsscene/bar0.png"),
	1: load("res://roulette_dungeon/assets/user_interface/weaponsscene/bar1.png"),
	2: load("res://roulette_dungeon/assets/user_interface/weaponsscene/bar2.png"),
	3: load("res://roulette_dungeon/assets/user_interface/weaponsscene/bar3.png"),
	4: load("res://roulette_dungeon/assets/user_interface/weaponsscene/bar4.png"),
	5: load("res://roulette_dungeon/assets/user_interface/weaponsscene/bar5.png"),
	6: load("res://roulette_dungeon/assets/user_interface/weaponsscene/bar6.png"),
	7: load("res://roulette_dungeon/assets/user_interface/weaponsscene/bar7.png"),
	8: load("res://roulette_dungeon/assets/user_interface/weaponsscene/bar8.png"),
	9: load("res://roulette_dungeon/assets/user_interface/weaponsscene/bar9.png"),
	10: load("res://roulette_dungeon/assets/user_interface/weaponsscene/bar10.png"),
	11: load("res://roulette_dungeon/assets/user_interface/weaponsscene/bar10.png"),
}
var can_upgrade = false

func get_level():
	return int(label.text.replace("Level ",label.text))

func _process(_delta: float) -> void:
	if weapon_number.weapon_number == 0:
		bar.texture = bar_dict[0]
		color_change.add_theme_stylebox_override("panel", purple_panel)
		arrow.visible = false
	elif weapon_number.weapon_number >= weapon_number.max_weapon_number:
		bar.texture = can_upgrade_bar
		color_change.add_theme_stylebox_override("panel", yellow_panel)
		arrow.visible=true
		arrow.play()
	else:
		arrow.visible = false
		color_change.add_theme_stylebox_override("panel", purple_panel)
		var index = int(round(float(weapon_number.weapon_number) * 11 / float(weapon_number.max_weapon_number)))
		if index == 0:
			bar.texture = bar_dict[1]
		elif index == 11:
			bar.texture = bar_dict[10]
		else:
			bar.texture = bar_dict[index]
		
		
		
	
