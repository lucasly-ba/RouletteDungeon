extends Control

@onready var current_game_mode = $current_game_mode

@onready var shop := $game_mode/Shop
@onready var gambling:= $game_mode/Gamble
@onready var fight := $game_mode/Fight
@onready var collection := $game_mode/Collection
@onready var event := $game_mode/Events

@onready var scrollhorizontal := $ScrollContainer
@onready var hbox := $ScrollContainer/HBoxContainer
@onready var sep := $ScrollContainer/HBoxContainer/sep1
@onready var sep4 := $ScrollContainer/HBoxContainer/sep4
@onready var wholepanel:= $game_mode_panel
@onready var firstscene := $ScrollContainer/HBoxContainer/collection/Bar

var tween : Tween

var initial_game_mode_size : float
var initial_scene_size: float
var precedent_scene

func _ready() -> void:
	
	$ScrollContainer/HBoxContainer/shop.custom_minimum_size = Vector2(get_viewport_rect().size.x,get_viewport_rect().size.y)
	$ScrollContainer/HBoxContainer/gambling.custom_minimum_size = Vector2(get_viewport_rect().size.x,get_viewport_rect().size.y)
	$ScrollContainer/HBoxContainer/fight.custom_minimum_size = Vector2(get_viewport_rect().size.x,get_viewport_rect().size.y)
	$ScrollContainer/HBoxContainer/collection.custom_minimum_size = Vector2(get_viewport_rect().size.x,get_viewport_rect().size.y)
	fight.custom_minimum_size.x = current_game_mode.size.x
	await get_tree().process_frame

	
	initial_scene_size = firstscene.size.x + sep.size.x
	initial_game_mode_size = shop.size.x
	current_game_mode.position.x = initial_game_mode_size
	precedent_scene = fight
	
	fight.custom_minimum_size.x = current_game_mode.size.x
	fight.get_node("Button/Label").visible = true
	fight.get_node("Button/TextureRect").scale = Vector2(1.3,1.3)
	fight.get_node("Button/TextureRect").position.y -=10





func _process(_delta: float) -> void:

	game_mode_scroll()



func game_mode_scroll():
	current_game_mode.position.x = ((scrollhorizontal.scroll_horizontal - sep4.size.x)* initial_game_mode_size)/initial_scene_size
	if global_user_interface.scene_changed == true:
		reset_tween(precedent_scene)
		if global_user_interface.i == 0:
			tween_activate(shop)
			precedent_scene = shop
		elif global_user_interface.i == 1:
			tween_activate(gambling)
			precedent_scene = gambling
		elif global_user_interface.i == 2:
			tween_activate(fight)
			precedent_scene = fight
		elif global_user_interface.i == 3:
			tween_activate(collection)
			precedent_scene = collection
		global_user_interface.scene_changed = false
		
func tween_activate(node):
	node.get_node("Button/Label").visible = true
	tween.tween_property(node,"custom_minimum_size:x",current_game_mode.size.x,0.4)
	tween.tween_property(node.get_node("Button/Label"),"scale",Vector2(1,1),0.4)
	tween.tween_property(node.get_node("Button/TextureRect"),"position:y",node.get_node("Button/TextureRect").position.y -10,0.4)
	tween.tween_property(node.get_node("Button/TextureRect"),"scale",Vector2(1.3,1.3),0.4)

func reset_tween(node):
	new_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.set_parallel()
	tween.tween_property(node,"custom_minimum_size:x",initial_game_mode_size,0.4)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(node.get_node("Button/Label"),"scale",Vector2(0,0),0.4)
	tween.tween_property(node.get_node("Button/TextureRect"),"position:y",node.get_node("Button/TextureRect").position.y +10,0.4)
	tween.tween_property(node.get_node("Button/TextureRect"),"scale",Vector2(1,1),0.4)

func new_tween():
	if tween:
		tween.kill()
	tween = create_tween()





	
