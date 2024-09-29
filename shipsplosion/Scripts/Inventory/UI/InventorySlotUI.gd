extends Control
class_name InventorySlotUI

### INFO
## Class representing an InventorySlot in UI

var inventory : Inventory
var inventorySlot : InventorySlot

var isHovered : bool = false

@export_group("MouseOverAnim")
@onready var originalScale : Vector2 = scale
@export var hoverScale : float = 2
@export var lerpVal : float = 0.1
@onready var targetScale : Vector2 = scale

func _ready() -> void:
	SignalBus.UpdateInventorySlots.connect(UpdateSlot)
	SignalBus.OnPlayerClick.connect(OnClicked)
	
	UpdateSlot()

func _physics_process(_delta: float) -> void:
	scale = lerp(scale, targetScale, lerpVal)

func UpdateSlot() -> void:
	if inventorySlot.slotItem:
		%ItemDisplay.texture = inventorySlot.slotItem.ItemTexture
		%AmountDisplay.text = str(inventorySlot.slotAmount)
	else:
		%ItemDisplay.texture = null
		%AmountDisplay.text = "0"

func _on_mouse_entered() -> void:
	targetScale = Vector2(hoverScale, hoverScale)
	isHovered = true

func _on_mouse_exited() -> void:
	targetScale = originalScale
	isHovered = false

func OnClicked() -> void:
	if isHovered && inventorySlot.slotItem:
		var player : PlayerController = get_tree().get_first_node_in_group("G_Player")
		
		if inventory.playerInventory:
			SignalBus.TransferItem.emit(inventorySlot.slotItem, inventory, player.openContainer)
		if !inventory.playerInventory:
			SignalBus.TransferItem.emit(inventorySlot.slotItem, player.openContainer, player.inventory)
		
		SignalBus.UpdateInventorySlots.emit()
