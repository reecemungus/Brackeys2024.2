extends Control

@onready var pause_menu = $"."
var paused = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused

func _on_resume_pressed() -> void:
	pauseMenu()

func _on_quit_pressed() -> void:
	get_tree().quit()
