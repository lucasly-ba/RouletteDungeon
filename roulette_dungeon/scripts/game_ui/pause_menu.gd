extends CanvasLayer


func _process(_delta):
	pause()

func pause():
	if global.pause:
		get_tree().paused = true
		show()
		global.pause = false



func _on_leave_game_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://roulette_dungeon/scenes/user_interface/play.tscn")



func _on_continue_pressed() -> void:
	get_tree().paused = false
	hide()
