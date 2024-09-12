extends Area2D

var bodies : Array[Area2D]

var shouldOpen : bool = false
var anims : Array

func _ready() -> void:
	anims = %AnimationPlayer.get_animation_list()
	
	%AnimationPlayer.play("DoorClose")

func _on_area_entered(_area: Area2D) -> void:
	CheckAreas()

func _on_area_exited(_area: Area2D) -> void:
	CheckAreas()

func CheckAreas() -> void:
	bodies = get_overlapping_areas()
	
	var groupedBodies : Array[Area2D]
	
	for i in range(bodies.size()):
		if bodies[i].is_in_group("G_Character"):
			groupedBodies.insert(0, bodies[i])
	
	if groupedBodies.size() > 0:
		%AnimationPlayer.current_animation = anims[1]
	else:
		%AnimationPlayer.current_animation = anims[0]
