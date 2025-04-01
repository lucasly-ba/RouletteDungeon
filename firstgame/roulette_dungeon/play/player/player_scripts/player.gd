extends CharacterBody2D
class_name Player

var speed
var health


var current_direction = "none"
var attack_in_progress = false
var can_attack = true
var alive = true
var finished_scene = true
var enemy_list = []
	
func _ready():
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	Input.action_release("ui_up")
	Input.action_release("ui_down")
	global.player_position = position
	
func _physics_process(_delta):
	if(!alive):
		return
	movement()
	attack()
	health_bar()
	current_camera()
	game_over()
	


		
#MOVEMENT
func movement():
	var dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	if dir.x > 0 && abs(dir.x) >= abs(dir.y): 
		_movement("right",dir)
	elif dir.x < 0 && abs(dir.x) >= abs(dir.y):
		_movement("left",dir)
	elif  dir.y < 0 && abs(dir.y) >= abs(dir.x):
		_movement("up",dir)
	elif dir.y > 0 && abs(dir.y) >= abs(dir.x):
		_movement("down",dir)
	else:
		velocity.x = move_toward(velocity.x, 0,speed)
		velocity.y = move_toward(velocity.y, 0,speed)
		movement_anim(0)
	move_and_slide()
	global.player_position = position

func _movement(dir, dirspeed):
	current_direction = dir
	velocity = dirspeed * speed
	movement_anim(1)
	

		
#ATTACK

func attack():
	if can_attack and !attack_in_progress:
		can_attack = false
		attack_in_progress = true
		attack_anim(2)
		$animation_cooldown.start()
		$attack_cooldown.start()

		
func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_list.append(body)
	
func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_list.erase(body)

func _on_attack_cooldown_timeout() -> void:
	$attack_cooldown.stop()
	can_attack = true
	

func _on_animation_cooldown_timeout() -> void:
	$animation_cooldown.stop()
	for enemy in enemy_list:
		enemy.health -=10
	attack_in_progress = false
	

###ANIMATION

func play_anim(input,flipped,idle,walk_idle,attack_idle,die_idle):
	var anim = $AnimatedSprite2D
	anim.flip_h = flipped
	if input == 0: 
		anim.play(idle)
	elif input == 1:
		anim.play(walk_idle)
	elif input == 2:
		anim.play(attack_idle)
	elif input == 3:
		anim.play(die_idle)
			
func movement_anim(_input):
	pass
		
func attack_anim(_input):
	pass
	
func die_anim(_input):
	pass

### CAMERA	
	
func current_camera():
	#if global.current_scene == "world":
	#	$world_camera.enabled = true
	#	$cliffside_camera.enabled = false
	#if global.current_scene == "cliffside":
	#	$cliffside_camera.enabled = true
	#	$world_camera.enabled = false
	pass
	
#### METHOD
func is_player():
	pass

###GAME OVER
func game_over():
	if health <= 0:
		die_anim(3)
		$death.start()
		alive = false
		
func _on_death_timeout() -> void:
	$death.stop()
	self.visible = false

###HEALTHBAR

func health_bar():
	$health.value = health
