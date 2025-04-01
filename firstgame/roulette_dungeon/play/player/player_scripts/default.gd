extends Player

func _ready():
	health = 1000000
	speed = 100
	super._ready()

func movement_anim(input):
	if(attack_in_progress || !alive):
		return
	if current_direction == "right":
		play_anim(input,false,"default_side","default_side_walk","","")
	if current_direction == "left":
		play_anim(input,true,"default_side","default_side_walk","","")
	if current_direction == "up":
		play_anim(input,false,"default_up","default_up_walk","","")
	if current_direction == "down":
		play_anim(input,false,"default_down","default_down_walk","","")
		
func attack_anim(input):
	if(current_direction == "right"):
		play_anim(input,false,"","","default_side_attack","")
	if( current_direction == "left"):
		play_anim(input,true,"","","default_side_attack","")
	if(current_direction == "up"):
		play_anim(input,false,"","","default_up_attack","")
	if(current_direction == "down"):
		play_anim(input,false,"","","default_down_attack","")
		
func die_anim(input):
	play_anim(input,false,"","","","default_die")
