extends AnimatedSprite2D

@onready var parent : CharacterBody2D = $"../.."

func _ready() -> void:
	if !parent:
		push_error("No Parent : %s" % [name])

func _physics_process(_delta: float) -> void:
	if parent.velocity.length() > 5:
		play("Moving")
	else:
		play("Idle")
