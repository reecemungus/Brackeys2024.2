extends Resource
class_name Inventory

### INFO
## Class defining an Inventory, a collection of Items belonging to a container
## An inventory stores "Slots", which is an Item and an Int, allowing for stacking of items

signal UpdateInventory # Update UI
signal GiveKeycard(keycardGroup : String)
signal GiveCrowbar

@export var slots : Array[InventorySlot] # Conatained Items
var shouldDestroy : bool = false # TODO - What is this

func Insert(item : InventoryItem) -> bool: # Add an item to the Inventory, in the leftmost slot
	var hasPickedUp : bool = false # Prevents player from 
	
	var hasItemAlready = false
	var inc = 0
	
	for i in range(slots.size()): # Attempt to find empty Slot
		if slots[i].slotItem != null: # is not null
			if slots[i].slotItem == item:
				slots[i].slotAmount += 1
				hasItemAlready = true
				hasPickedUp = true
			
			inc = inc + 1
	
	if !hasItemAlready && inc < slots.size(): # Increase stack number of item already in inventory
		slots[inc].slotItem = item
		slots[inc].slotAmount += 1
		hasPickedUp = true
	
	else: # If item cannot be picked up, return false
		hasPickedUp = false
	
	if item.ItemName.contains("keycard") && hasPickedUp:
		GiveKeycard.emit(item.ItemName)
	
	if item.ItemName.contains("Crowbar") && hasPickedUp:
		GiveCrowbar.emit()
	
	UpdateInventory.emit() # Update Inventory
	
	return hasPickedUp
