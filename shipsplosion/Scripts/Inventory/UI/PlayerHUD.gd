extends CanvasLayer
class_name PlayerHUD

@onready var inventory : Inventory = get_node("..").inventory
var inventorySlot = preload("res://Scenes/Inventory/InventorySlotUI.tscn")

func _ready() -> void:
	for i in range(inventory.slots.size()):
		var slot : InventorySlotUI = inventorySlot.instantiate()
		slot.inventory = inventory
		slot.inventorySlot = inventory.slots[i]
		%InventoryHotBar.add_child(slot)

func _physics_process(_delta: float) -> void:
	%Time.text = "%s" % [GameInformation.TIME]
