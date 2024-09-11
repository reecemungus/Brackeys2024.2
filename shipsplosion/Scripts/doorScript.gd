extends Area2D

var bodies : Array[Area2D]

var shouldOpen : bool = false

var shouldAnimate : bool = true

func _on_area_entered(area: Area2D) -> void:
	CheckAreas()

func _on_area_exited(area: Area2D) -> void:
	CheckAreas()

func CheckAreas() -> void:
	bodies = get_overlapping_areas()
	
	var groupedBodies : Array[Area2D]
	
	for i in range(bodies.size()):
		if bodies[i].is_in_group("G_Character"):
			groupedBodies.insert(0, bodies[i])
			
	
