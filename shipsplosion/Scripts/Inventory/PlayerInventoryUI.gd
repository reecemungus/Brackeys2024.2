extends CanvasLayer
class_name PlayerInventoryUI

@onready var inventory : Inventory = preload("res://Scenes/Inventory/Inventories/playerInventory.tres")
@onready var slots: Array #= %HotBar.get_children()

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("G_Player") # player ref
var isOpen : bool = false

func CreateUISlots() -> void:
	for i in range(inventory.slots.size()):
		var uiSlotScene = preload("res://Scenes/Inventory/InvSlotUi.tscn").instantiate()
		%HotBar.add_child(uiSlotScene)
	
	slots = %HotBar.get_children()

func _ready() -> void:
	CreateUISlots()
	
	inventory.UpdateInventory.connect(UpdateSlots)
	
	UpdateSlots()
	open()
	
	if player: # attempt to connect to signal on player
		player.InventoryToggle.connect(OnToggle) # connect advance day to player interact
	else:
		push_error("Player not found")

func OnToggle() -> void:
	if isOpen:
		close()
	else:
		open()

func close() -> void:
	isOpen = false
	visible = false

func open() -> void:
	isOpen = true
	visible = true

func UpdateSlots() -> void:
	for i in range(0, slots.size()):
		if slots[i] != null:
			slots[i].UpdateInv(inventory.slots[i])
