extends Control

@onready var bet_slider = $bet_slider
@onready var money = $money
@onready var coin = $TextureRect

var init_pos = 0
var font
var font_size
var char_size
func _ready() -> void:
	init_pos = coin.position.x
	font = money.get_theme_font("font")
	font_size = money.get_theme_font_size("font")
	char_size = font.get_char_size("0".unicode_at(0), font_size)

	
func _on_bet_slider_value_changed(value: float) -> void:
	money.text = str(int(value))
	if(money.text.length() == 3):
		coin.position.x = init_pos
	else:
		coin.position.x = init_pos + char_size.x * (money.text.length())
