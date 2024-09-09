extends CharacterBody2D

signal Interact

@export var SPEED : float = 5000.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var inputVector = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	
	velocity = inputVector * SPEED * delta
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact"):
		Interact.emit()
