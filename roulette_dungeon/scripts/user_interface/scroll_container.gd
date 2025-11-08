extends ScrollContainer

@onready var shop:= $HBoxContainer/shop
@onready var gambling:= $HBoxContainer/gambling
@onready var fight:= $HBoxContainer/fight
@onready var collection:= $HBoxContainer/collection

var tween : Tween

var i:= 2
var list = []


var is_dragging := false
var drag_start_x := 0.0
var drag_speed := 0.0
var drag_time := 0.0
var cur_scroll = 0


func _ready() -> void:
	await get_tree().process_frame
	list.append(shop)
	list.append(gambling)
	list.append(fight)
	list.append(collection)
	scroll_horizontal = fight.position.x
	cur_scroll = fight.position.x




func _gui_input(event):

	if global_user_interface.active_scroll_id != "" and global_user_interface.active_scroll_id != "main":
		scroll_horizontal = collection.position.x
		return

		
	if event is InputEventScreenDrag:
		if not is_dragging:
			is_dragging = true
			global_user_interface.active_scroll_id = "main"
			drag_start_x = event.position.x
			drag_time = Time.get_ticks_msec() / 1000.0 
	
		tween_activate2(scroll_horizontal -event.relative.x)
	elif event is InputEventMouseButton and event.is_released():
		is_dragging = false
		global_user_interface.active_scroll_id = ""
		var drag_end_x = event.position.x
		var drag_duration = (Time.get_ticks_msec() / 1000.0) - drag_time
		drag_speed = (drag_end_x - drag_start_x) / drag_duration
		
		handle_release()
	

func handle_release():
	var threshold_speed = 3000
	
	if drag_speed > threshold_speed and i > 0:
		i -= 1
		global_user_interface.scene_changed = true		
		global_user_interface.i = i
	elif drag_speed < -threshold_speed and i < list.size() - 1:		
		i+=1
		global_user_interface.scene_changed = true		
		global_user_interface.i = i
	else:
		var closest_index := 0
		var min_distance := INF
		for j in list.size():
			var dist = abs(scroll_horizontal - list[j].position.x)
			if dist < min_distance:
				min_distance = dist
				closest_index = j
		if closest_index != i:
			global_user_interface.scene_changed = true
			global_user_interface.i = closest_index
		i = closest_index
	
	tween_activate(list[i].position.x)

		

func _process(_delta):
	goods_activate()
	game_modes_activate()

	
func goods_activate():
	if i != 0 and( global_user_interface.energy_button_can_activate || global_user_interface.gold_button_can_activate || global_user_interface.poker_coin_button_can_activate):
		global_user_interface.scene_changed = true
		global_user_interface.i = 0
		i = 0
		tween_activate3(list[0].position.x)
		
	global_user_interface.energy_button_can_activate = false
	
	global_user_interface.gold_button_can_activate = false
	global_user_interface.poker_coin_button_can_activate = false

func game_modes_activate():
	
	var changed = false
	
	if global_user_interface.shop_button_can_activate and i != 0:
		i =0 
		changed = true

	if global_user_interface.gamble_button_can_activate and i != 1:
		i = 1
		changed = true
		
			
	if global_user_interface.fight_button_can_activate and i != 2:
		i = 2
		changed = true


	if global_user_interface.collection_button_can_activate and i != 3:
		i = 3
		changed = true
		
	if changed:
		global_user_interface.i = i
		global_user_interface.scene_changed = true
		tween_activate3(list[i].position.x)
		
	global_user_interface.shop_button_can_activate = false
	global_user_interface.gamble_button_can_activate = false
	global_user_interface.fight_button_can_activate = false
	global_user_interface.collection_button_can_activate = false
		
		
		
func tween_activate(target):
	reset_tween()
	tween.tween_property(self, "scroll_horizontal", target, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

func tween_activate3(target):
	reset_tween()
	tween.tween_property(self, "scroll_horizontal", target, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
func tween_activate2(target):
	reset_tween()
	tween.tween_property(self, "scroll_horizontal", target, 0.008).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)



func reset_tween():
	if tween:
		tween.kill()
	tween = create_tween()
	
