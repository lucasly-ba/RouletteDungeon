extends Area2D

var speed = 300

func _ready():
	set_as_top_level(true)
	
	
func _process(delta: float) -> void:
	position+= (Vector2.RIGHT*speed).rotated(rotation) * delta
	
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		queue_free()
		body.health -=10
		show_damage.display_number(10,body.damage_numbers_origin.global_position,false)
		body.hitflash.play("hitflash")
