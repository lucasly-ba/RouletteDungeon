extends HSlider

var texture1 := preload("res://roulette_dungeon/assets/user_interface/fightscene/pokercoinslider.png")
var texture2 := preload("res://roulette_dungeon/assets/user_interface/fightscene/pokercoinsliderfocused.png")



func _gui_input(event):
	if event is InputEventMouseButton or event is InputEventScreenDrag or event is InputEventScreenTouch:
		if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
			add_theme_icon_override("grabber",texture2)
		elif (event is InputEventMouseButton or event is InputEventScreenTouch ) and not event.pressed:
			var sb := StyleBoxTexture.new()
			add_theme_icon_override("grabber", texture1)
