extends Panel


@onready var music_volume_slider := $Panel/Panel/VBoxContainer/music_volume/music_volume_slider
@onready var sfx_volume_slider := $Panel/Panel/VBoxContainer/sfx_volume/sfx_volume_slider
@onready var vibration_check := $Panel/Panel/VBoxContainer/joystick/joystick_button
@onready var joystick_check := $Panel/Panel/VBoxContainer/vibration/vibration_button
func _ready() -> void:
	var audio_settings = config_file_handler.load_audio_setings()
	music_volume_slider.value = min(audio_settings.music_volume,1.0) * 100
	sfx_volume_slider.value = min(audio_settings.sfx_volume,1.0) * 100
	
	var gameplay_settings = config_file_handler.load_gameplay_setings()
	vibration_check.button_pressed = gameplay_settings.vibration
	joystick_check.button_pressed = gameplay_settings.joystick


func _on_music_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		config_file_handler.save_audio_settings("music_volume",music_volume_slider.value/100)
		

func _on_sfx_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		config_file_handler.save_audio_settings("sfx_volume",sfx_volume_slider.value/100)


func _on_vibration_button_toggled(toggled_on: bool) -> void:
	config_file_handler.save_gameplay_settings("vibration",toggled_on)


func _on_joystick_button_toggled(toggled_on: bool) -> void:
	config_file_handler.save_gameplay_settings("joystick",toggled_on)
