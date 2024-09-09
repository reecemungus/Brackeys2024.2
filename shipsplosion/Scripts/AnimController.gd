extends AnimatedSprite2D

@onready var parent : CharacterBody2D = $"../.."

func _ready() -> void:
	if !parent:
		push_error("No Parent : %s" % [name])

func _physics_process(_delta: float) -> void:
	if parent.velocity != Vector2.ZERO:
		play("Moving")
	else:
		play("Idle")
