extends CharacterBody2D
class_name Enemy

var speed
var health
var attack_in_progress = false
var can_attack = false
var current_direction = "none"
var cur_player = null
var alive = true



func _physics_process(_delta):
	if !alive:
		return
	health_bar()
	chase()
	attack()
	die()


####MOVE

func chase():
	if(attack_in_progress):
		return
	var direction = (global.player_position - position).normalized()
	velocity = direction * speed
	move_and_slide()
	var posx = position.x - global.player_position.x
	var posy = position.y - global.player_position.y
	if posx >= 0 && abs(posx) >= abs(posy):
		current_direction = "left"
	elif posx < 0 && abs(posx) > abs(posy):
		current_direction = "right"
	elif posy < 0 && abs(posy) > abs(posx):
		current_direction = "down"
	elif posy > 0 && abs(posy) > abs(posx):
		current_direction = "up"
	movement_anim(1)
	
####ATTACK

func attack():
	if can_attack && !attack_in_progress:
		attack_in_progress = true
		attack_anim(2)
		$enemy_attack_cooldown.start()
		
	

func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("is_player"):
		can_attack = true
		cur_player = body
		
func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("is_player"):
		can_attack = false


func _on_enemy_attack_cooldown_timeout() -> void:
	$enemy_attack_cooldown.stop()
	cur_player.health -= 10
	attack_in_progress = false


##ANIMATION
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


###METHOD
func is_enemy():
	pass

###DIE

func die():
	if health <= 0:
		die_anim(3)
		$death.start()
		alive = false
		#self.queue_free()
		

func _on_death_timeout() -> void:
	$death.stop()
	self.visible = false

###HEALTHBAR

func health_bar():
	$health.value = health
