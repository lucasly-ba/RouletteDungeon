extends Control


@onready var popup := $user_menu
@onready var parameters := $parameters
@onready var history := $historique
@onready var news := $news
@onready var mail := $mail

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP

func show_popup():
	visible = true
	global_user_interface.user_menu_button_activated = true
	popup.visible = true
	popup.scale = Vector2(0,0)
	var tween := create_tween()
	tween.tween_property(popup, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func show_parameters():
	parameters.visible = true
	popup.visible = false
	parameters.scale = Vector2(0.8,0.8)
	var tween := create_tween()
	tween.tween_property(parameters, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
func show_history():
	history.visible = true
	popup.visible = false
	history.scale = Vector2(0.8,0.8)
	var tween := create_tween()
	tween.tween_property(history, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
func show_news():
	news.visible = true
	popup.visible = false
	news.scale = Vector2(0.8,0.8)
	var tween := create_tween()
	tween.tween_property(news, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func show_mail():
	mail.visible = true
	popup.visible = false
	mail.scale = Vector2(0.8,0.8)
	var tween := create_tween()
	tween.tween_property(mail, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if not popup.get_global_rect().has_point(event.position):
			visible = false
			popup.visible = false
			parameters.visible = false
			history.visible = false
			news.visible = false
			mail.visible = false
			global_user_interface.user_menu_button_activated = false



	
func _on_exit_parameters_pressed() -> void:
	parameters.visible = false
	popup.visible = false
	visible = false
	

func _on_exit_history_pressed() -> void:
	history.visible = false
	popup.visible = false
	visible = false



func _on_exit_news_pressed() -> void:
	news.visible = false
	popup.visible = false
	visible = false



func _on_exit_mail_pressed() -> void:
	mail.visible = false
	popup.visible = false
	visible = false
