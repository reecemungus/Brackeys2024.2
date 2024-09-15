extends Node2D

func _ready() -> void:
	var fade : AnimationPlayer = get_tree().get_first_node_in_group("G_Fade")
	fade.play("FadeIn")

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/ship_level.tscn")
