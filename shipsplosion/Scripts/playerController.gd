extends CharacterBody2D

signal Interact
signal InventoryToggle

@export_group("Movement")
@export var speed : float = 7500.0

@export_group("Inventory")
@export var inventory : Inventory

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var inputVector = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	
	velocity = inputVector * speed * delta
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact"):
		Interact.emit()
		
	if event.is_action_pressed("Inventory"):
		InventoryToggle.emit()

func Collect(item : InventoryItem) -> void:
	inventory.Insert(item)
