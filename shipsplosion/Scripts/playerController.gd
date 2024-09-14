extends CharacterBody2D

@onready var playerWalkingAudioStream = $MetalFootsteps
@onready var playingAttackAudioStream = $AttackSound

signal Interact
signal OnAttack
signal InventoryToggle

@export_group("Movement")
@export var speed : float = 7500.0

@export_group("Inventory")
@export var inventory : Inventory

@export_group("Dialog")
var canTalk : bool = true

func _ready() -> void:
	Dialogic.timeline_started.connect(PreventDialog)
	Dialogic.timeline_ended.connect(AllowDialog)
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
		
	if event.is_action_pressed("Attack"):
		OnAttack.emit()
		playingAttackAudioStream.play()
		

func Collect(item : InventoryItem) -> void:
	inventory.Insert(item)

func PreventDialog() -> void:
	canTalk = false

func AllowDialog() -> void:
	canTalk = true

func _on_footstep_timer_timeout() -> void:
	if velocity.length() > 0:
		playerWalkingAudioStream.play()
