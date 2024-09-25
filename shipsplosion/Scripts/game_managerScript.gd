extends Node2D

func _on_hour_timer_timeout() -> void:
	GameInformation.AdvanceTime()

func _on_enemy_spawner_timeout() -> void:
	if GameInformation.DAY == 4:
		var enemy = preload("res://Scenes/Character/NPCRush.tscn").instantiate()
		add_child(enemy)
		
		#var children = get_children()
