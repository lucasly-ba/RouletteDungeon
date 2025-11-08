extends Control
var anim_dict = {
	0: "2coeur",
	1: "3coeur",
	2: "4coeur",
	3: "5coeur",
	4: "6coeur",
	5: "7coeur",
	6: "8coeur",
	7: "9coeur",
	8: "10coeur",
	9: "jcoeur",
	10: "dcoeur",
	11: "rcoeur",
	12: "acoeur",

	13: "2carreau",
	14: "3carreau",
	15: "4carreau",
	16: "5carreau",
	17: "6carreau",
	18: "7carreau",
	19: "8carreau",
	20: "9carreau",
	21: "10carreau",
	22: "jcarreau",
	23: "dcarreau",
	24: "rcarreau",
	25: "acarreau",

	26: "2trefle",
	27: "3trefle",
	28: "4trefle",
	29: "5trefle",
	30: "6trefle",
	31: "7trefle",
	32: "8trefle",
	33: "9trefle",
	34: "10trefle",
	35: "jtrefle",
	36: "dtrefle",
	37: "rtrefle",
	38: "atrefle",

	39: "2pique",
	40: "3pique",
	41: "4pique",
	42: "5pique",
	43: "6pique",
	44: "7pique",
	45: "8pique",
	46: "9pique",
	47: "10pique",
	48: "jpique",
	49: "dpique",
	50: "rpique",
	51: "apique"
}


@onready var totalbets = $TotalBet/TotalBet
@onready var coin = $TotalBet/TextureRect
@onready var bets = $Bets
@onready var bet_slider = $Bets/bet_slider
@onready var energy = $goods/Energy/Button/Label
@onready var gold = $goods/Gold/Button/Label
@onready var pokercoin = $goods/PokerCoin/Button/Label

#ANIM
@onready var dealer_first_card_panel = $dealer_first_card
@onready var dealer_first_card = $dealer_first_card/dealer_first_card

@onready var dealer_second_card_panel = $dealer_second_card
@onready var dealer_second_card = $dealer_second_card/dealer_second_card


@onready var our_first_card_panel = $our_first_card
@onready var our_first_card = $our_first_card/our_first_card

@onready var our_second_card_panel = $our_second_card
@onready var our_second_card = $our_second_card/our_second_card


@onready var hit_or_stand = $hit_or_stand


@onready var init_pos_coin_add = $goods/Gold/Panel.position
@onready var init_pos_card = $our_first_card.position
@onready var init_pos_coin = $TotalBet/TextureRect.position
@onready var init_pos_coin_pop = $TotalBet/Panel.position

var initmoney = 100

var our_card1 = -1
var our_card2 = -1
var dealer_card1 = -1
var dealer_card2 = -1

var tween : Tween
var tween_exit : Tween

var hit = false
var stand = false

func _ready() -> void:
	bet_slider.max_value = int(gold.text) / 10 * 10

	
func _process(_delta: float) -> void:
	var char_size = totalbets.get_theme_font("font").get_char_size("0".unicode_at(0), totalbets.get_theme_font_size("font"))
	if totalbets.text.length() == 1:
		coin.position.x = init_pos_coin.x + char_size.x * (totalbets.text.length() - 1)
	else:
		coin.position.x = init_pos_coin.x + char_size.x * (totalbets.text.length() - 1) + 10
	bet_slider.max_value = int(gold.text) / 10 * 10
	
func _on_play_button_pressed() -> void:
	$button.play()
	var money = int(gold.text) - int(bet_slider.value)
	var inimtoney = money
	if (money < 0):
		gold.text = "0"
	else:
		gold.text = str(money)
	bets.visible = false
	totalbets.text = str(int(bet_slider.value))
	bet_slider.value = bet_slider.min_value
	$card_sound.play()
	reset_tween()
	distribute_cards()
	
	
func distribute_cards():
	tween.tween_property(our_first_card_panel, "position",$our_card_pos1.position, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	our_card1 = get_random_card()
	our_first_card.play(anim_dict[our_card1])
	tween.finished.connect(func():
		var t=create_tween()
		t.tween_property(our_second_card_panel, "position",$our_card_pos2.position, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		our_card2 = get_random_card()
		our_second_card.play(anim_dict[our_card2])
		t.finished.connect(func():
			var t2=create_tween()
			t2.tween_property(dealer_first_card_panel, "position",$dealer_card_pos1.position, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
			dealer_card1 = get_random_card()
			dealer_first_card.play(anim_dict[dealer_card1])
			t2.finished.connect(func():
				var t3=create_tween()
				t3.tween_property(dealer_second_card_panel, "position",$dealer_card_pos2.position, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
			)
		)
	)


	

func _on_hit_pressed() -> void:
	$button.play()
	hit = true
	#tween_zoom()
	var t = get_tree().create_tween()
	#t.tween_property(which_color_choice, "modulate:a", 0.0, 0.5)
	#t.tween_callback(Callable(which_color_choice, "hide"))
	#$which_color_choice/Panel/Line2D/Timer.stop()
	

func _on_stand_pressed() -> void:
	$button.play()
	stand = true
	#tween_zoom()
	var t = get_tree().create_tween()



func get_random_card():
	randomize()
	var keys = anim_dict.keys()
	return keys[randi() % keys.size()]
	
func reset_tween():
	if tween:
		tween.kill()
	tween = create_tween()
