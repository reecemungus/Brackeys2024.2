extends Area2D

var isLastDay : bool = false
var shouldSwitch : bool = false
var willSwitch : bool = true

func _on_area_entered(area: Area2D) -> void:
	if GameInformation.DAY == 4:
		isLastDay = true
	
	if area.is_in_group("G_Player") && isLastDay:
		shouldSwitch = true

func _process(_delta: float) -> void:	
	if shouldSwitch && willSwitch:
		willSwitch = false
		
		%FadeDelay.start()
		
		var fade = get_tree().get_first_node_in_group("G_Fade")
		fade.play("FadeOut&In")

func _on_fade_delay_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/final_set_piece.tscn")
