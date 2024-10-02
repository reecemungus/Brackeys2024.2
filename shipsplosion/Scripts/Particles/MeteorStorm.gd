extends Node2D

@export var scaleDeviation : float = 0
@export var rotationDeviation : float = 0
@export var meteorSpread : float = 250

func _on_timer_timeout() -> void:
	SpawnMeteor()

func SpawnMeteor() -> void:
	var meteor : Node2D = load("res://Scenes/Particles/BrowserSafe/meteor.tscn").instantiate()
	
	var tempScale = 1 + randf_range(-scaleDeviation, scaleDeviation)
	meteor.scale = Vector2(tempScale, tempScale)
	
	var tempRot = randf_range(-rotationDeviation, rotationDeviation)
	meteor.global_rotation = meteor.global_rotation + tempRot
	
	meteor.position = Vector2(0, randf_range(-meteorSpread, meteorSpread))
	
	add_child(meteor)
