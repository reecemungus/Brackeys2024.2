extends CanvasLayer

@onready var inventory : Inventory = preload("res://Inventory/playerInventory.tres")
@onready var slots: Array = %HotBar.get_children()

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("G_Player") # player ref
var isOpen : bool = false

func _ready() -> void:
	UpdateSlots()
	close()
	
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
	for i in range(min(inventory.Items.size(), slots.size())):
		slots[i].UpdateInv(inventory.Items[i])
