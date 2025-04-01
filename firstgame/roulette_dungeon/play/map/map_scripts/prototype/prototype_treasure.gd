extends Node2D

var next_scene = false

func _process(delta: float) -> void:
	change_scene()
	
func _ready() -> void:
	$default/AnimatedSprite2D.play("default_up")
		
		

func change_scene():
	if next_scene:
		var rd = randi_range(1,3)
		if rd == 1:
			get_tree().change_scene_to_file("res://roulette_dungeon/play/map/map_scenes/prototype_treasure.tscn")
		elif rd == 2:
			get_tree().change_scene_to_file("res://roulette_dungeon/play/map/map_scenes/prototype/prototype_map.tscn")
		elif rd == 3:
			get_tree().change_scene_to_file("res://roulette_dungeon/play/map/map_scenes/prototype_treasure.tscn")


func _on_first_door_body_entered(body: Node2D) -> void:
	if body.has_method("is_player"):
		next_scene = true
		

func _on_second_door_body_entered(body: Node2D) -> void:
	if body.has_method("is_player"):
		next_scene = true


func _on_third_door_body_entered(body: Node2D) -> void:
	if body.has_method("is_player") && body.finished_scene:
		next_scene = true
