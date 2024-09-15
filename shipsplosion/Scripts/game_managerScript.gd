extends Node2D

func _on_hour_timer_timeout() -> void:
	GameInformation.AdvanceTime()

func _on_enemy_spawner_timeout() -> void:
	pass # Replace with function body.
