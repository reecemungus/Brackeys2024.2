extends CharacterBody2D

@export_group("Movement")
@export var speed : float = 7500.0
@export var acceptableRadius : float = 25
@export var wanderRadius : float = 500.0
var dir : Vector2 

@onready var navAgent : NavigationAgent2D = %NavigationAgent2D

var targetLocation : Vector2 

var initialLocation : Vector2 

func _ready() -> void:
	%WonderTimer.wait_time = %WonderTimer.wait_time + randf_range(-2, 2)
	%WaitTimer.wait_time = randf_range(0, 5)
	
	%WaitTimer.start()
	
	GameInformation.OnAdvanceDay.connect(AdvanceDay)
	initialLocation = global_position

func _physics_process(delta: float) -> void:
	if navAgent.distance_to_target() > acceptableRadius:
		dir = (navAgent.get_next_path_position() - global_position).normalized()
		velocity = (dir * speed) * delta 
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	
func _on_nav_updater_timeout() -> void:
	navAgent.target_position = targetLocation

func _on_wonder_timer_timeout() -> void:
	targetLocation = getRandomReachablePointInRadius(global_position, wanderRadius)
	
func _on_wait_timer_timeout() -> void:
	targetLocation = getRandomReachablePointInRadius(global_position, wanderRadius)

func getRandomReachablePointInRadius(origin : Vector2, radius : float) -> Vector2:
	var vec : Vector2 = (Vector2.RIGHT * randf_range(radius / 2,radius)).rotated(randf_range(-PI, PI))
	vec = vec + origin
	
	return vec

func AdvanceDay() -> void:
	global_position = initialLocation
