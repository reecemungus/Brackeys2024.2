extends CharacterBody2D
class_name PlayerController

### INFO
## Player :)

var openContainer : Inventory

@export_group("Movement")
@export var speed : float = 7500.0

@export_group("Inventory")
@export var inventory : Inventory
var hasCrowbar : bool = false

@export_group("Dialog")
var canTalk : bool = true

@onready var audioManager : AudioManager = get_node("./AudioManager")

var weaponEquipped : InventoryItem

var bedLocation : Vector2 = Vector2(1735, -575)

func _ready() -> void:
	GameInformation.OnAdvanceDay.connect(AdvanceDay)
	
	Dialogic.timeline_started.connect(PreventDialog)
	Dialogic.timeline_ended.connect(AllowDialog)
	
	SignalBus.CloseContainer.connect(CloseContainer)

func _physics_process(delta: float) -> void:
	if !canTalk:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	var inputVector = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	
	velocity = inputVector * speed * delta
	move_and_slide()

func _input(event: InputEvent) -> void:
	if !canTalk:
		return
	
	if event.is_action_pressed("Interact"):
		SignalBus.OnPlayerInteract.emit()
	
	#if event.is_action_pressed("Attack"): # TODO Fix Crowbar
		#SignalBus.OnPlayerAttack.emit()
	
	if event.is_action_pressed("Trade"):
		SignalBus.OnPlayerTrade.emit()
	
	if event.is_action_pressed("Click"):
		SignalBus.OnPlayerClick.emit()

func PreventDialog() -> void:
	canTalk = false

func AllowDialog() -> void:
	canTalk = true

func _on_footstep_timer_timeout() -> void:
	if velocity.length() != 0:
		%MetalFootsteps.play()

func playAttackSound() -> void:
	%AttackSound.play()

func AdvanceDay() -> void:
	global_position = bedLocation

func Collect(item : InventoryItem) -> bool:
	if inventory.Insert(item):
		audioManager.playSound("Pickup")
		return true
	
	return false

func CloseContainer() -> void:
	openContainer = null
