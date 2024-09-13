extends Control



func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)


func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu/main_menu_level.tscn")
