extends ScrollContainer

var tween : Tween
@onready var weapons = $GridContainer

@onready var startpoint = $GridContainer/daggers
@onready var endpoint = $GridContainer/daggers2

var velocity := 0.0
var last_scroll := 0.0
var last_time := 0.0
var is_dragging = false

func _ready():
	await get_tree().process_frame
	scroll_vertical = startpoint.position.y


func _gui_input(event):
	if global_user_interface.active_scroll_id != "" and global_user_interface.active_scroll_id != "weapon":
		return

	if event is InputEventMouseButton:
		if event.is_released():
			global_user_interface.active_scroll_id = ""
			is_dragging = false
			var inertia_duration = 0.5
			var inertia_distance = velocity * inertia_duration * 0.5
			var target_scroll = clamp(scroll_vertical + inertia_distance, startpoint.position.y, endpoint.position.y + 2300 - get_viewport_rect().size.y)
			reset_tween()
			tween.tween_property(self, "scroll_vertical", target_scroll, inertia_duration).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)

			is_dragging = false
			

	elif event is InputEventScreenDrag:
		if !is_dragging and abs(event.relative.x) > abs(event.relative.y):
			scroll_vertical = scroll_vertical
		else:
			if tween:
				tween.kill()
			is_dragging = true
			global_user_interface.active_scroll_id = "weapon"
			scroll_vertical -= event.relative.y

func _physics_process(delta):
	change_points()
	if is_dragging:
		velocity = (scroll_vertical - last_scroll) / delta
		last_scroll = scroll_vertical
		last_time = Time.get_ticks_msec() / 1000.0

func change_points():
	startpoint = weapons.get_child(4)
	endpoint = weapons.get_child(12)

func tween_activate(target):
	reset_tween()
	tween.tween_property(self, "scroll_vertical", target, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		
func reset_tween():
	if tween:
		tween.kill()
	tween = create_tween()
