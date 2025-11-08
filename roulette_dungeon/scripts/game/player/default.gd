extends Player

@export var Health = 1000
@export var Speed = 100
@export var Ability: PackedScene

func _ready():
	health = Health
	speed = Speed
	ability = Ability
	super._ready()

func movement_anim(input):
	if(!alive):
		return
	if current_direction == "right":
		play_anim(input,false,"default_side","default_side_walk","","")
	if current_direction == "left":
		play_anim(input,true,"default_side","default_side_walk","","")
	if current_direction == "up":
		play_anim(input,false,"default_up","default_up_walk","","")
	if current_direction == "down":
		play_anim(input,false,"default_down","default_down_walk","","")
		
func attack_anim(_input):
	#if(current_direction == "right"):
		#play_anim(input,false,"","","default_side_attack","")
	#if( current_direction == "left"):
		#play_anim(input,true,"","","default_side_attack","")
	#if(current_direction == "up"):
	#	play_anim(input,false,"","","default_up_attack","")
	#if(current_direction == "down"):
		#play_anim(input,false,"","","default_down_attack","")
	pass
		
func die_anim(input):
	play_anim(input,false,"","","","default_die")
