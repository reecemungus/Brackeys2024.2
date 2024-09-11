extends Resource
class_name Inventory

signal UpdateInventory

@export var slots : Array[InventorySlot]

func Insert(item : InventoryItem) -> void:
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	
	if itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
			
	UpdateInventory.emit()
