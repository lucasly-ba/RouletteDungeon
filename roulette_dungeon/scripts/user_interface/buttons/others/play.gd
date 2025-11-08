extends UIButton


func _ready() -> void:
	button_name = "play"
	is_game_mode = false
	await get_tree().process_frame
	reset_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.set_loops()
	tween.tween_property(self,"position:y",position.y - 3,0.4)
	tween.tween_property(self,"position:y",position.y + 3,0.4)
	


func reset_tween():
	if tween:
		tween.kill()
	tween = create_tween()
	
