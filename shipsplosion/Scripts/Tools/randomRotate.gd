extends Sprite2D

var targetAngle : float

func _ready() -> void:
	targetAngle = randf_range(-360, 360)

func _on_timer_timeout() -> void:
	targetAngle = randf_range(-360, 360)

func _physics_process(delta: float) -> void:
	global_rotation = lerp_angle(global_rotation, targetAngle, 0.01)
