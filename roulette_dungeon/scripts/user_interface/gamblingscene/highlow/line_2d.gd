extends Line2D

signal time_up

func _decrease():
	points[1].x -= 1
	
func time_is_up():
	return points[1].x == 0

func _on_timer_timeout() -> void:
	if !time_is_up():
		_decrease()
	if time_is_up():
		emit_signal("time_up")
