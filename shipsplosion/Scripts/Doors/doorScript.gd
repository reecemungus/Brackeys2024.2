extends Area2D

var bodies : Array[Area2D]

var shouldOpen : bool = false
var anims : Array

var blendValue : float = 0
var targetBlendValue : float = 0
@export var doorSpeed : float = 0.1

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	blendValue = lerpf(blendValue, targetBlendValue, doorSpeed)
	%AnimationTree.set("parameters/BlendSpace1D/blend_position", blendValue)

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
		targetBlendValue = 1
		
	else:
		targetBlendValue = 0
