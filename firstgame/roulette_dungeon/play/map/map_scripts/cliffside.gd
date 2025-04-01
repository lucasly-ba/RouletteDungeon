extends Node2D

var world = false

func _process(delta: float) -> void:
	change_scene()
	

	
func change_scene():
	if global.transition_scene == true:
		if world:
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			global.finish_changescenes("world")
			


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("_is_player"):
		global.transition_scene = true
		world = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("_is_player"):
		global.transition_scene = false
		world = false
		
