extends Button
class_name UIButton

var just_pressed = false
var is_inside = false
var button_name
var is_game_mode

var tween : Tween


	
func _gui_input(event):
	_gui_input_aux(event)
			
func _gui_input_aux(event):
	if event is InputEventMouseButton or event is InputEventScreenDrag:
		var local_pos = event.position
		if event is InputEventMouseButton and event.pressed:
			change_size()
		elif event is InputEventMouseButton  and event.is_released():
			if is_pressed and is_inside:
				set_global_to_true()
			reset_sizes()
		elif event is InputEventScreenDrag :
			is_inside = get_rect().has_point(local_pos)
			
			
func change_size():
	just_pressed = true
	is_inside = true
	reset_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.set_parallel(true)
	if is_game_mode == true:
		z_index = 2
		if (global_user_interface.i == 0 and button_name == "shop" )||( global_user_interface.i == 1 and button_name == "gamble")||( global_user_interface.i == 2 and button_name == "fight")||( global_user_interface.i == 3 and button_name == "collection"):
			tween.tween_property(get_node("TextureRect"),"scale",Vector2(1.4,1.4),0.4)
			tween.tween_property(get_node("Label"),"scale",Vector2(1.1,1.1),0.4)
		else:
			tween.tween_property(get_node("TextureRect"),"scale",Vector2(1.15,1.15),0.4)
	else:
		tween.tween_property(self,"scale",Vector2(0.90,0.90),0.4)

func reset_sizes():
	just_pressed = false
	is_inside = false
	reset_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.set_parallel(true)
	if is_game_mode == true:
		z_index = 0
		if (global_user_interface.i == 0 and button_name == "shop" )||( global_user_interface.i == 1 and button_name == "gamble")||( global_user_interface.i == 2 and button_name == "fight")||( global_user_interface.i == 3 and button_name == "collection"):
			tween.tween_property(get_node("TextureRect"),"scale",Vector2(1.3,1.3),0.4)
			tween.tween_property(get_node("Label"),"scale",Vector2(1,1),0.4)
		else:
			tween.tween_property(get_node("TextureRect"),"scale",Vector2(1,1),0.4)
	else:
		tween.tween_property(self,"scale",Vector2(1,1),0.4)
			

func set_global_to_true():
	if button_name == "play":
		global_user_interface.play_button_can_activate = true
	elif button_name == "user_menu":
		global_user_interface.user_menu_button_can_activate = true
	elif button_name == "profile":
		global_user_interface.profile_button_can_activate = true
	elif button_name == "fight":
		global_user_interface.fight_button_can_activate = true
	elif button_name == "shop":
		global_user_interface.shop_button_can_activate = true
	elif button_name == "collection":
		global_user_interface.collection_button_can_activate = true
	elif button_name == "event":
		global_user_interface.event_button_can_activate = true
	elif button_name == "gamble":
		global_user_interface.gamble_button_can_activate = true
	elif button_name == "energy":
		global_user_interface.energy_button_can_activate = true
	elif button_name == "gold":
		global_user_interface.gold_button_can_activate = true
	elif button_name == "poker_coin":
		global_user_interface.poker_coin_button_can_activate = true
	elif button_name == "success":
		global_user_interface.success_button_can_activate = true
	elif button_name == "mail":
		global_user_interface.mail_button_can_activate = true
	elif button_name == "settings":
		global_user_interface.settings_button_can_activate = true
	elif button_name == "collection_gamblers":
		global_user_interface.collection_gamblers_button_can_activate = true
	elif button_name == "collection_weapons":
		global_user_interface.collection_weapons_button_can_activate = true
	elif button_name == "collection_sort":
		global_user_interface.collection_sort_button_can_activate = true
	elif button_name == "news":
		global_user_interface.news_button_can_activate = true
	elif button_name == "history":
		global_user_interface.history_button_can_activate = true
	elif button_name == "exit":
		global_user_interface.exit_button_can_activate = true


func reset_tween():
	if tween:
		tween.kill()
	tween = create_tween()
