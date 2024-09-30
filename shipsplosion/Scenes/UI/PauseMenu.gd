extends Control

@onready var pause_menu = $"."
@onready var pausebuttons = $MarginContainer/PauseButtons
@onready var optionsbuttons = $MarginContainer/OptionsButtons
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


func _on_options_pressed() -> void:
	pausebuttons.hide()
	optionsbuttons.show()

func _on_back_button_pressed() -> void:
	optionsbuttons.hide()
	pausebuttons.show()

func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)
