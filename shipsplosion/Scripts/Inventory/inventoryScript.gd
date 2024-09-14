extends Resource
class_name Inventory

signal UpdateInventory # update UI
signal GiveKeycard(keycardGroup : String)
signal GiveCrowbar

@export var slots : Array[InventorySlot]
var shouldDestroy : bool = false

func Insert(item : InventoryItem) -> void:
	var hasItemAlready = false
	var inc = 0
	
	for i in range(slots.size()):
		if slots[i].slotItem != null: # is not null
			if slots[i].slotItem == item:
				slots[i].slotAmount += 1
				hasItemAlready = true
			
			inc = inc + 1
	
	if !hasItemAlready && inc < slots.size():
		slots[inc].slotItem = item
		slots[inc].slotAmount += 1
	
	UpdateInventory.emit()
	
	if item.ItemName.contains("keycard"):
		GiveKeycard.emit(item.ItemName)
		
	if item.ItemName.contains("Crowbar"):
		GiveCrowbar.emit()
