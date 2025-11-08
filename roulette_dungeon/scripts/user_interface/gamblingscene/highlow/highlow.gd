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
@onready var high_low_panel = $high_low_panel
@onready var high_low_card = $high_low_panel/high_low
@onready var high_low_choice = $high_low_choice

@onready var which_color_panel = $which_color_panel
@onready var which_color_card = $which_color_panel/which_color
@onready var which_color_choice = $which_color_choice

@onready var inside_outside_panel = $inside_outside_panel
@onready var inside_outside_card = $inside_outside_panel/inside_outside
@onready var inside_outside_choice = $inside_outside_choice

@onready var which_sign_panel = $which_sign_panel
@onready var which_sign_card = $which_sign_panel/which_sign
@onready var which_sign_choice = $which_sign_choice

@onready var init_pos_coin_add = $goods/Gold/Panel.position
@onready var init_pos_card = $which_color_panel.position
@onready var init_pos_coin = $TotalBet/TextureRect.position
@onready var init_pos_coin_pop = $TotalBet/Panel.position

var initmoney = 100

var card1 = -1
var card2 = -1
var card3 = -1
var card4 = -1
var multiplier = 2

var tween : Tween
var tween_exit : Tween

var which_color = false
var higher_lower = false
var inside_outside = false
var which_sign = false


var red = false
var black = false

var high = false
var low = false

var inside = false
var outside = false

var coeur = false
var pique = false
var carreau = false
var trefle = false


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
	which_color = true
	bets.visible = false
	reset_tween()
	tween_center(which_color_panel,which_color_choice,which_color_card)
	totalbets.text = str(int(bet_slider.value))
	bet_slider.value = bet_slider.min_value
	
	$card_sound.play()

	


######WHICHCOLOR####
func _on_red_pressed() -> void:
	if which_color:
		$button.play()
		red = true
		tween_zoom()
		var t = get_tree().create_tween()
		t.tween_property(which_color_choice, "modulate:a", 0.0, 0.5)
		t.tween_callback(Callable(which_color_choice, "hide"))
		$which_color_choice/Panel/Line2D/Timer.stop()

func _on_black_pressed() -> void:
	if which_color:
		$button.play()
		black = true
		tween_zoom()
		var t = get_tree().create_tween()
		t.tween_property(which_color_choice, "modulate:a", 0.0, 0.5)
		t.tween_callback(Callable(which_color_choice, "hide"))
		$which_color_choice/Panel/Line2D/Timer.stop()
	


	
	
####HIGHLOW

func _on_higher_pressed() -> void:
	if higher_lower:
		$button.play()
		high = true
		tween_zoom()
		var t = get_tree().create_tween()
		t.tween_property(high_low_choice, "modulate:a",0.0, 0.5)
		t.tween_callback(Callable(high_low_choice, "hide"))
		$high_low_choice/Panel/Line2D/Timer.stop()


func _on_lower_pressed() -> void:
	if higher_lower:
		$button.play()
		low = true
		tween_zoom()
		var t = get_tree().create_tween()
		t.tween_property(high_low_choice, "modulate:a",0.0, 0.5)
		t.tween_callback(Callable(high_low_choice, "hide"))
		$high_low_choice/Panel/Line2D/Timer.stop()
	
	
###INSIDEOUTSIDE
func _on_inside_pressed() -> void:
	if inside_outside:
		$button.play()
		inside = true
		tween_zoom()
		var t = get_tree().create_tween()
		t.tween_property(inside_outside_choice, "modulate:a",0.0, 0.5)
		t.tween_callback(Callable(inside_outside_choice, "hide"))
		$inside_outside_choice/Panel/Line2D/Timer.stop()

func _on_outside_pressed() -> void:
	if inside_outside:
		$button.play()
		outside = true
		tween_zoom()
		var t = get_tree().create_tween()
		t.tween_property(inside_outside_choice, "modulate:a",0.0, 0.5)
		t.tween_callback(Callable(inside_outside_choice, "hide"))
		$inside_outside_choice/Panel/Line2D/Timer.stop()
	
###
func which_sign_pressed():
	if which_sign:
		$button.play()
		tween_zoom()
		var t = get_tree().create_tween()
		t.tween_property(which_sign_choice, "modulate:a",0.0, 0.5)
		t.tween_callback(Callable(which_sign_choice, "hide"))
		$which_sign_choice/Panel/Line2D/Timer.stop()

func _on_coeur_pressed() -> void:
	coeur = true
	which_sign_pressed()

func _on_pique_pressed() -> void:	
	pique = true
	which_sign_pressed()

func _on_trefle_pressed() -> void:
	trefle = true
	which_sign_pressed()

func _on_carreau_pressed() -> void:
	carreau = true
	which_sign_pressed()

###
func tween_center(panel,choice,card):
	print(panel)
	var where = $HIGHLOW.position + Vector2($HIGHLOW.size.x/2 - panel.size.x/2,0) + Vector2(0,$HIGHLOW.size.y /2 - (card.sprite_frames.get_frame_texture("2coeur", 0).get_size() * card.scale).y/2)
	reset_tween()
	tween.tween_property(panel, "position",where, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.finished.connect(func():on_tween_center_finished(choice))


	
func on_tween_center_finished(choice):
	reset_tween()
	choice.visible = true
	choice.modulate.a = 0.0
	tween.tween_property(choice,"modulate:a",1.0,0.5)
	tween.connect("finished",on_tween_center_modulate_finished)
	

func on_tween_center_modulate_finished():
	if which_color:
		$which_color_choice/Panel/Line2D/Timer.start(0)
	elif higher_lower:
		$high_low_choice/Panel/Line2D/Timer.start(0)
	elif inside_outside:
		$inside_outside_choice/Panel/Line2D/Timer.start(0)
	elif which_sign_choice:
		$which_sign_choice/Panel/Line2D/Timer.start(0)
		

func tween_zoom():
	reset_tween()
	tween.tween_property(self,"scale",Vector2(1.4,1.4),0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.connect("finished", on_zoom_finished)
	
func on_zoom_finished():
	if card1 == -1:
		card1 = get_random_card()
		which_color_card.play(anim_dict[card1])
	elif card2 == -1:
		card2 = get_random_card()
		high_low_card.play(anim_dict[card2])
	elif card3 == -1:
		card3 = get_random_card()
		inside_outside_card.play(anim_dict[card3])
	else:
		card4 = get_random_card()
		which_sign_card.play(anim_dict[card4])
	$card_flip.play()
	await get_tree().create_timer(1.0).timeout
	tween_dezoom()
	
	
func tween_dezoom():
	reset_tween()
	tween.tween_property(self,"scale",Vector2(1,1),0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if which_color and (red and card1 <= 25 || black and card1 > 25):
		which_color = false
		tween_win_lose_activate($WIN)
		play_money_bounce($"TotalBet/+",int(totalbets.text),true)
		totalbets.text = str(initmoney * multiplier)
		multiplier = 3
		tween.tween_property($WIN, "modulate:a", 0.0, 0.5)
		$coin.play()
		tween.tween_property(which_color_panel,"position",$card_pos1.position,0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		higher_lower = true
		
		tween.finished.connect(func(): 
			$card_sound.play()
			tween_center(high_low_panel,high_low_choice,high_low_card))
	elif higher_lower and (high and card2 % 13 >= card1 % 13 || low and card2 % 13 <= card1 % 13):
		higher_lower = false
		tween_win_lose_activate($WIN)
		play_money_bounce($"TotalBet/+",initmoney,true)
		totalbets.text = str(initmoney * multiplier)
		multiplier = 4
		$coin.play()
		tween.tween_property($WIN, "modulate:a", 0.0, 0.5)
		tween.tween_property(high_low_panel,"position",$card_pos2.position,0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		inside_outside = true
		
		tween.finished.connect(func(): 
			$card_sound.play()
			tween_center(inside_outside_panel,inside_outside_choice,inside_outside_card))
		
	elif inside_outside and (inside and ((card1 % 13 <= card3 % 13 and card3%13 <= card2 % 13)||(card2%13 <= card3%13 and card3%13 <= card1%13))|| (outside 
	and ((card3%13 <= card1%13 and card1%13 <= card2%13) || (card3%13<=card2%13 and card2 %13<=card1%13) ||(card3%13 >= card1%13 and card1 %13>= card2%13) || (card3%13>=card2%13 and card2%13>=card1%13))) ):

		inside_outside = false
		tween_win_lose_activate($WIN)
		play_money_bounce($"TotalBet/+",initmoney,true)
		totalbets.text = str(initmoney * multiplier)
		multiplier = 10
		$coin.play()
		tween.tween_property($WIN, "modulate:a", 0.0, 0.5)
		tween.tween_property(inside_outside_panel,"position",$card_pos3.position,0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		which_sign = true
		tween.finished.connect(func(): 
			$card_sound.play()
			tween_center(which_sign_panel,which_sign_choice,which_sign_card))
		
	elif which_sign and (coeur and card4 <= 12 || carreau and card4 > 12 and card4<= 25 || trefle and card4 > 25 and card4 <= 38 || pique and card4 > 38):
		which_sign = false
		tween_win_lose_activate($WIN)
		totalbets.text = str(initmoney * multiplier)
		multiplier = 2
		tween.tween_property($WIN, "modulate:a", 0.0, 0.5)
		tween.tween_property(which_sign_panel,"position",$card_pos4.position,0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.set_parallel(true)
		$coin.play()
		$win.play()
		tween.tween_property(which_color_panel, "modulate:a",0.0, 1)
		tween.tween_property(high_low_panel, "modulate:a",0.0, 1)
		tween.tween_property(inside_outside_panel,"modulate:a",0.0,1)
		tween.tween_property(which_sign_panel,"modulate:a",0.0,1)
		tween.tween_property(which_sign_panel,"modulate:a",0.0,1)
		add_money()
		tween.connect("finished", set_back)
	else:
		tween_win_lose_activate($LOSE)
		play_money_bounce($"TotalBet/-",int(totalbets.text),false)
		energy.text = str(int(energy.text[0]) - 1)+"/"+"3"
		totalbets.text = "0"
		var tween2 = get_tree().create_tween()
		tween2.set_parallel(true)
		tween2.tween_property(which_color_panel, "modulate:a",0.0, 1)
		tween2.tween_property(high_low_panel, "modulate:a",0.0, 1)
		tween2.tween_property(inside_outside_panel,"modulate:a",0.0,1)
		tween2.tween_property(which_sign_panel,"modulate:a",0.0,1)
		tween.tween_property($LOSE, "modulate:a", 0.0, 0.5)
		tween.connect("finished", set_back)
		$lose.play()
		
func set_back():
	multiplier = 2
	which_color = false
	red = false
	black = false
	card1 = -1
	which_color_panel.position = init_pos_card
	which_color_panel.modulate.a = 1.0
	which_color_card.frame = 0
	which_color_card.stop()

	
	higher_lower = false
	high = false
	low = false
	card2 = -1
	high_low_panel.position = init_pos_card
	high_low_panel.modulate.a = 1.0
	high_low_card.frame = 0
	high_low_card.stop()

	
	inside_outside = false
	inside = false
	outside = false
	card3 = -1
	inside_outside_panel.position = init_pos_card
	inside_outside_panel.modulate.a = 1.0
	inside_outside_card.frame = 0
	inside_outside_card.stop()

	
	which_sign = false
	coeur = false
	pique = false
	carreau = false
	trefle = false
	card4 = -1
	which_sign_panel.position = init_pos_card
	which_sign_panel.modulate.a = 1.0
	which_sign_card.frame = 0
	which_sign_card.stop()
	$which_color_choice/Panel/Line2D.points[1].x = 500
	$which_color_choice/Panel/Line2D/Timer.stop()
	$high_low_choice/Panel/Line2D.points[1].x = 500
	$high_low_choice/Panel/Line2D/Timer.stop()
	$inside_outside_choice/Panel/Line2D.points[1].x = 500
	$inside_outside_choice/Panel/Line2D/Timer.stop()
	$which_sign_choice/Panel/Line2D.points[1].x = 500
	$which_sign_choice/Panel/Line2D/Timer.stop()
	
	
	$which_sign_choice/Carreau.disabled = false
	$which_sign_choice/Coeur.disabled = false
	$which_sign_choice/Pique.disabled = false
	$which_sign_choice/Trefle.disabled = false
	$high_low_choice/Higher.disabled = false
	$high_low_choice/Lower.disabled = false
	$inside_outside_choice/Inside.disabled = false
	$inside_outside_choice/Outside.disabled = false
	$which_color_choice/Black.disabled = false
	$which_color_choice/Red.disabled = false
	bets.visible = true
	


	
	

func tween_win_lose_activate(object):
	object.visible = true
	object.modulate.a = 0.0
	tween.tween_property(object,"modulate:a",1.0,0.7).set_ease(Tween.EASE_OUT)
	
	

	
func play_money_bounce(label: Label, amount: int,won) -> void:
	var coinflip = $TotalBet/Panel/coin_flip
	var minusone = $"goods/Energy/-"
	
	if won:
		label.text = "+%d" % amount
	else:
		label.text = "-%d" % amount
	label.visible = true
	label.modulate.a = 1.0
	label.scale = Vector2(0,0)
	minusone.scale = Vector2(0,0)
	coinflip.scale = Vector2(0,0)
	var t = create_tween()
	var t2 = create_tween()
	var t3 = create_tween()
	if won:
		var char_size = label.get_theme_font("font").get_char_size("0".unicode_at(0), label.get_theme_font_size("font"))
		if(label.text.length() > 4):
			$TotalBet/Panel.position.x = init_pos_coin_pop.x + char_size.x * (label.text.length() - 4) + 40
		else:
			$TotalBet/Panel.position.x = init_pos_coin_pop.x
		coinflip.visible=true
		coinflip.modulate.a = 1.0
		coinflip.play()
	else:
		minusone.visible = true
		minusone.modulate.a = 1.0
		

		
	t.tween_property(label, "scale", Vector2(1.4, 1.4), 0.6)\
		.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	t.tween_property(label, "modulate:a", 0.0, 0.5)\
		.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	t.tween_callback(Callable(label, "hide"))
	
	t2.tween_property(coinflip, "scale", Vector2(0.1, 0.1), 0.6)\
		.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	t2.tween_property(coinflip, "modulate:a", 0.0, 0.5)\
		.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	t2.tween_callback(Callable(coinflip, "hide"))

	t3.tween_property(minusone, "scale", Vector2(1.4, 1.4), 0.6)\
		.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	t3.tween_property(minusone, "modulate:a", 0.0, 0.5)\
		.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	t3.tween_callback(Callable(minusone, "hide"))
	

func _on_line_2d_time_up() -> void:
	var t= create_tween()
	var t2= create_tween()
	t.set_parallel(true)
	t.tween_property(which_color_panel, "modulate:a", 0.0, 0.5)
	t.tween_property(high_low_panel, "modulate:a",0.0, 0.5)
	t.tween_property(inside_outside_panel, "modulate:a",0.0, 0.5)
	t.tween_property(which_sign_panel, "modulate:a",0.0, 0.5)
	if which_color:
		t2.tween_property(which_color_choice, "modulate:a", 0.0, 0.5)
		t2.tween_callback(Callable(which_color_choice,"hide"))
		$which_color_choice/Panel/Line2D/Timer.stop()
		$which_color_choice/Panel/Line2D.points[1].x = 500
		$which_color_choice/Black.disabled = true
		$which_color_choice/Red.disabled = true
	elif higher_lower:
		t2.tween_property(high_low_choice, "modulate:a", 0.0, 0.5)
		t2.tween_callback(Callable(high_low_choice,"hide"))
		$high_low_choice/Panel/Line2D.points[1].x = 500
		$high_low_choice/Panel/Line2D/Timer.stop()
		$high_low_choice/Higher.disabled = true
		$high_low_choice/Lower.disabled = true

	elif inside_outside:
		t2.tween_property(inside_outside_choice, "modulate:a", 0.0, 0.5)
		t2.tween_callback(Callable(inside_outside_choice,"hide"))
		$inside_outside_choice/Panel/Line2D.points[1].x = 500
		$inside_outside_choice/Panel/Line2D/Timer.stop()
		$inside_outside_choice/Inside.disabled = true
		$inside_outside_choice/Outside.disabled = true
	elif which_sign:
		t2.tween_property(which_sign_choice, "modulate:a", 0.0, 0.5)
		t2.tween_callback(Callable(which_sign_choice,"hide"))
		$which_sign_choice/Panel/Line2D.points[1].x = 500
		$which_sign_choice/Panel/Line2D/Timer.stop()
		$which_sign_choice/Carreau.disabled = true
		$which_sign_choice/Coeur.disabled = true
		$which_sign_choice/Pique.disabled = true
		$which_sign_choice/Trefle.disabled = true

	
	t.connect("finished", set_back)

	add_money()

	gold.text = str(int(totalbets.text) + int(gold.text))

func add_money() -> void:
	$coin.play()
	$goods/Gold/Button/Label.text = str(int(totalbets.text) + int($goods/Gold/Button/Label.text))

	var coinflip = $goods/Gold/Panel/coin_flip
	var label = $"goods/Gold/+"
	label.text = "+"+totalbets.text
	label.visible = true
	label.modulate.a = 1.0
	label.scale = Vector2(0,0)
	coinflip.modulate.a = 1.0
	coinflip.scale = Vector2(0,0)
	var t = create_tween()
	var t2 = create_tween()
	var char_size = label.get_theme_font("font").get_char_size("0".unicode_at(0), label.get_theme_font_size("font"))
	if label.text.length() > 4:
		$goods/Gold/Panel.position.x = init_pos_coin_add.x + char_size.x * (label.text.length() - 4) + 40
	else:
		$goods/Gold/Panel.position.x = init_pos_coin_add.x
	coinflip.visible=true

	t.tween_property(label, "scale", Vector2(1, 1), 0.6)\
		.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	t.tween_property(label, "modulate:a", 0.0, 0.5)\
		.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	t.tween_callback(Callable(label, "hide"))

	
	t2.tween_property(coinflip, "scale", Vector2(0.08, 0.08), 0.6)\
		.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	
	coinflip.play()
	t2.tween_property(coinflip, "modulate:a", 0.0, 0.5)\
		.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	t2.tween_callback(Callable(coinflip, "hide"))
	$TotalBet/TotalBet.text = "0"
	$TotalBet/TextureRect.position = init_pos_coin

	
func _on_exit_button_pressed() -> void:
	if which_color || higher_lower || inside_outside || which_sign:
		$cant_exit.play()
		$CANTEXIT.visible = true
		$CANTEXIT.scale = Vector2(0,0)
		$CANTEXIT.modulate.a = 1.0
		if tween_exit:
			tween_exit.kill()
		tween_exit = create_tween()
		tween_exit.tween_property($CANTEXIT, "scale", Vector2(1, 1), 0.6)\
		.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
		tween_exit.tween_property($CANTEXIT, "modulate:a", 0.0, 1)\
		.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
		tween_exit.tween_callback(Callable($CANTEXIT,"hide"))
	else:
		visible = false
		
func get_random_card():
	randomize()
	var keys = anim_dict.keys()
	return keys[randi() % keys.size()]
	
func reset_tween():
	if tween:
		tween.kill()
	tween = create_tween()
