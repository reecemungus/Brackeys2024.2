extends Control

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/intro_cutscene.tscn") 
	

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu/options_menu_level.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
