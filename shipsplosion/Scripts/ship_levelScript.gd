extends Node2D

func _ready() -> void:
	AudioBus.setMusic("res://Assets/Audio/Music/WeatherWarningNewMainTheme.wav")
	
	GameInformation.FindGM() 
	
	var fade : AnimationPlayer = get_tree().get_first_node_in_group("G_Fade")
	fade.play("FadeIn")
