extends UIButton


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	button_name = "map"
	sprite.play("default")
	
