extends AnimationPlayer

@onready var parent : CharacterBody2D = get_node("..")
@onready var feet : AnimatedSprite2D = %Feet

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if parent.velocity != Vector2.ZERO:
		feet.play("Moving")
		play("Movement")
	else:
		feet.play("Idle")
		play("Idle")
