extends Enemy

func _ready() -> void:
	health = 30
	speed = 3

func movement_anim(input):
	if !alive:
		return
	if current_direction == "right":
		play_anim(input,false,"","skeleton_side_walk","","")
	if current_direction == "left":
		play_anim(input,true,"","skeleton_side_walk","","")
	if current_direction == "up":
		play_anim(input,false,"","skeleton_up_walk","","")
	if current_direction == "down":
		play_anim(input,false,"","skeleton_down_walk","","")
		
func attack_anim(input):
	if(current_direction == "right"):
		play_anim(input,false,"","","skeleton_side_attack","")
	if( current_direction == "left"):
		play_anim(input,true,"","","skeleton_side_attack","")
	if(current_direction == "up"):
		play_anim(input,false,"","","skeleton_up_attack","")
	if(current_direction == "down"):
		play_anim(input,false,"","","skeleton_down_attack","")
		
func die_anim(input):
	play_anim(input,false,"","","","skeleton_die")
