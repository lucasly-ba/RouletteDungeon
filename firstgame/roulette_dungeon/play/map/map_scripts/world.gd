extends Node2D

var cliffside = false

func _process(delta: float) -> void:
	change_scene()
	
	
func _ready() -> void:

	if global.first_load:
		$player.position.x = global.player_start_posx
		$player.position.y = global.player_start_posy
	else:
		$player.position.x = global.player_exit_cliffside_posx
		$player.position.y = global.player_exit_cliffside_posy
		$player/AnimatedSprite2D.play("down")
		

func _on_cliffside_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("_is_player"):
		global.transition_scene = true
		cliffside = true
		

func _on_cliffside_transition_point_body_exited(body: Node2D) -> void:
	if body.has_method("_is_player"):
		global.transition_scene = false
		cliffside = false
		
func change_scene():
	if global.transition_scene == true:
		if cliffside:
			get_tree().change_scene_to_file("res://scenes/cliffside.tscn")
			global.finish_changescenes("cliffside")
			global.first_load = false
			
