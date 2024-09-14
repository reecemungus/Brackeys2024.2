extends CharacterBody2D

signal Interact
signal InventoryToggle
signal OnAttack
signal OnTrade

@export_group("Movement")
@export var speed : float = 7500.0

@export_group("Inventory")
@export var inventory : Inventory
var hasCrowbar : bool = false

@export_group("Dialog")
var canTalk : bool = true

var weaponEquipped : InventoryItem

var bedLocation : Vector2 = Vector2(1735, -575)

func _ready() -> void:	
	GameInformation.OnAdvanceDay.connect(AdvanceDay)
	
	Dialogic.timeline_started.connect(PreventDialog)
	Dialogic.timeline_ended.connect(AllowDialog)
	
	inventory.GiveKeycard.connect(GetKeycard)
	inventory.GiveCrowbar.connect(GetCrowbar)

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
		if hasCrowbar:
			OnAttack.emit()
		
	if event.is_action_pressed("Trade"):
		OnTrade.emit()

func Collect(item : InventoryItem) -> void:
	inventory.Insert(item)

func PreventDialog() -> void:
	canTalk = false

func AllowDialog() -> void:
	canTalk = true

func GetKeycard(keycardGroup : String) -> void:
	print("Get")
	%HitBox.add_to_group("G_%s" % [keycardGroup])

func _on_footstep_timer_timeout() -> void:
	%MetalFootsteps.play()

func playAttackSound() -> void:
	%AttackSound.play()

func AdvanceDay() -> void:
	global_position = bedLocation

func GetCrowbar() -> void:
	hasCrowbar = true
