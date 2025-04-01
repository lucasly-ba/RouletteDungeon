extends Enemy

func _ready() -> void:
	health = 30
	speed = 20

func movement_anim(input):
	if !alive:
		return
	if current_direction == "right":
		play_anim(input,false,"","slime_side_walk","","")
	if current_direction == "left":
		play_anim(input,true,"","slime_side_walk","","")
	if current_direction == "up":
		play_anim(input,false,"","slime_up_walk","","")
	if current_direction == "down":
		play_anim(input,false,"","slime_down_walk","","")
		
func attack_anim(input):
	if(current_direction == "right"):
		play_anim(input,false,"","","slime_side_attack","")
	if( current_direction == "left"):
		play_anim(input,true,"","","slime_side_attack","")
	if(current_direction == "up"):
		play_anim(input,false,"","","slime_up_attack","")
	if(current_direction == "down"):
		play_anim(input,false,"","","slime_down_attack","")
		
func die_anim(input):
	play_anim(input,false,"","","","slime_die")
