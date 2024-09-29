extends Resource
class_name Inventory

### INFO
## Class defining an Inventory, a collection of Items belonging to a container
## An inventory stores "Slots", which is an Item and an Int, allowing for stacking of items

@export var slots : Array[InventorySlot] # Conatained Items
@export var playerInventory : bool = false

func Insert(item : InventoryItem) -> bool:	
	for i in range(slots.size()):
		if slots[i].slotItem == null:
			slots[i].slotItem = item
			slots[i].slotAmount = 1
			return true
		
		if slots[i].slotItem == item:
			slots[i].slotAmount += 1
			return true
	
	return false

func Remove(item : InventoryItem) -> bool:
	for i in range(slots.size()):
		if slots[i].slotItem == item:
			if slots[i].slotAmount > 1:
				slots[i].slotAmount -= 1
				return true
			
			if slots[i].slotAmount == 1:
				slots[i].slotAmount = 0
				slots[i].slotItem = null
				return true
	
	return false
