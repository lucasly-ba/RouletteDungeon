extends Label


@export var weapon_number = 0
@export var max_weapon_number = 5

func _process(_delta: float) -> void:
	text = str(weapon_number) + "/" + str(max_weapon_number)
	
func upgrade(max_number):
	weapon_number -= max_number
	max_weapon_number = max_number
	
func add_number(number_to_add):
	weapon_number += number_to_add
