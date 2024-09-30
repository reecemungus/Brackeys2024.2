extends Control
class_name ChestUI

@export var inventory : Inventory 
var slotUIScene := preload("res://Scenes/Inventory/InventorySlotUI.tscn")

func _ready() -> void:
	CreateSlots()
	
	SignalBus.OpenChest.connect(OpenChest)

func CreateSlots() -> void:
	for i in range(inventory.slots.size()):
		var slotInst : InventorySlotUI = slotUIScene.instantiate()
		slotInst.inventory = inventory
		slotInst.inventorySlot = inventory.slots[i]
		%GridContainer.add_child(slotInst)

func _on_close_button_pressed() -> void:
	visible = false
	SignalBus.CloseContainer.emit()

func OpenChest() -> void:
	visible = true
