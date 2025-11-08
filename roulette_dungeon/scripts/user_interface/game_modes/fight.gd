extends Control

@onready var umenu := $show_user_menu
@onready var play_button := $play_button
@onready var user_menu_button := $user_menu_button

@onready var parameters := $show_user_menu/parameters



func _process(_delta: float) -> void:

	others_activate()


	

func others_activate():
	if global_user_interface.play_button_can_activate:
		get_tree().change_scene_to_file("res://roulette_dungeon/scenes/game/map/prototype/map.tscn")
		global_user_interface.play_button_can_activate = false
	


	#if global_user_interface.profile_button_can_activate:

	#if global_user_interface.success_button_can_activate:
		
	if global_user_interface.user_menu_button_can_activate:
		umenu.show_popup()
		global_user_interface.user_menu_button_can_activate = false
	
	if global_user_interface.settings_button_can_activate:
		umenu.show_parameters()
		global_user_interface.settings_button_can_activate = false
		
	if global_user_interface.mail_button_can_activate:
		umenu.show_mail()
		global_user_interface.mail_button_can_activate = false
		
	if global_user_interface.news_button_can_activate:
		umenu.show_news()
		global_user_interface.news_button_can_activate = false
		
	if global_user_interface.history_button_can_activate:
		umenu.show_history()
		global_user_interface.history_button_can_activate = false
		
	global_user_interface.history_button_can_activate = false
	global_user_interface.news_button_can_activate = false
	global_user_interface.mail_button_can_activate = false
	global_user_interface.settings_button_can_activate = false
	global_user_interface.user_menu_button_can_activate = false
	global_user_interface.play_button_can_activate = false
	#if global_user_interface.mail_button_can_activate:
		



	
