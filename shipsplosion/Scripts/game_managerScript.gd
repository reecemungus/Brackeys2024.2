extends Node2D

func _on_hour_timer_timeout() -> void:
	GameInformation.TIME = GameInformation.TIME + 100
	print(GameInformation.TIME)
