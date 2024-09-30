extends CharacterBody2D
class_name UniqueNPC

@onready var player : PlayerController = get_tree().get_first_node_in_group("G_Player")

var isActive : bool = false

@export_group("DialogInfo")
@export var characterName : String

var daysSpokenTo : int = 1
var dailyDialog : int = 1
var isPanicked : bool = false

var currentDay : int = 1
var spokenToToday : bool = false

@export_group("Trading")

@export var itemWanted : InventoryItem
@export var itemToGive : InventoryItem
var tradeInc : int = 1
var hasTradedOnce : bool = false

@export_group("CharacterInfo")
@export var sprite : Texture2D

func _ready() -> void:
	%Sprite.texture = sprite
	
	SignalBus.OnPlayerInteract.connect(OnSpokenTo)
	SignalBus.OnPlayerTrade.connect(OnTraded)
	
	GameInformation.OnAdvanceDay.connect(AdvanceDay)

func _on_dialog_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("G_Player"):
		isActive = true

func _on_dialog_zone_area_exited(area: Area2D) -> void:
	if area.is_in_group("G_Player"):
		isActive = false

func runDialog(dialogString : String) -> void:
	Dialogic.start(dialogString)

func OnSpokenTo() -> void:
	if !isPanicked:
		if isActive && player.canTalk:
			spokenToToday = true
			
			PlayerInformation.addRep(characterName)
			
			runDialog(GetTimeLine())
			
			if dailyDialog != 3:
				dailyDialog = dailyDialog + 1
	
	elif isPanicked:
		if isActive && player.canTalk:
			spokenToToday = true
			
			PlayerInformation.addRep(characterName)
			
			runDialog(GetTimeLinePanicked())
			
			if dailyDialog != 2:
				dailyDialog = dailyDialog + 1

func GetTimeLine() -> String:
	var timelineString : String = "%s%s_%s" % [characterName, daysSpokenTo, dailyDialog]
	return timelineString

func GetTimeLinePanicked() -> String:
	var timelineString : String = "%s%s_%sPanic" % [characterName, daysSpokenTo, dailyDialog]
	return timelineString

func GetTimeLineTrading() -> String:
	var timelineString : String = "%sTrade_%s" % [characterName, tradeInc]
	return timelineString

func AdvanceDay() -> void:
	if spokenToToday:
		dailyDialog = 1
		daysSpokenTo = daysSpokenTo + 1
		
	spokenToToday = false
	
	if GameInformation.DAY == 4:
		queue_free()

func OnTraded() -> void:
	if isActive:
		
		if !hasTradedOnce:
			hasTradedOnce = true
			runDialog(GetTimeLineTrading())
			return
		
		var playerInv : Inventory = player.inventory
		var playerHasItem : bool = false
		
		for i in range(playerInv.slots.size()):
			if playerInv.slots[i].slotItem == itemWanted:
				playerHasItem = true
		
		if !playerHasItem:
			runDialog(GetTimeLineTrading())
		else:
			tradeInc += 1
			
			playerInv.Remove(itemWanted)
			playerInv.Insert(itemToGive)
			
			SignalBus.UpdateInventorySlots.emit()
			runDialog(GetTimeLineTrading())

func OnPanicked() -> void:
	isPanicked = true
	dailyDialog = 1
	
	spokenToToday = false

func DropItem() -> void:
	var pickup : PickUp = preload("res://Scenes/Inventory/Items/PickUp/PickUp.tscn").instantiate()
	pickup.item = itemToGive
	add_child(pickup)
	
	pickup.global_position = lerp(global_position, player.global_position, 0.5)
