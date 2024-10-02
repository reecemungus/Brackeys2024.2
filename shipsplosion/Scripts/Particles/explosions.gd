extends Node2D

@export var distance : float

var explScene = preload("res://Scenes/Particles/BrowserSafe/explosion.tscn")

func _on_timer_timeout() -> void:
	if GameInformation.DAY != 4:
		return
	
	var player = get_tree().get_first_node_in_group("G_Player")
	
	var explosion : Node2D = explScene.instantiate()
	add_child(explosion)
	
	explosion.global_position = randomLocationInRadius(player.global_position)

func randomLocationInRadius(origin : Vector2) -> Vector2:
	var point : Vector2 = origin + ((Vector2.RIGHT * randf_range(100, distance)).rotated(randf_range(0, PI)))
	return point
