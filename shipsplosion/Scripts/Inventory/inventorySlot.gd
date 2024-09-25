extends Resource
class_name InventorySlot

### INFO
## Class defining a slot that contains an InventoryItem, an Inventory contains an Array of these 
## (Rather than InventoryItems, as these cannot be stacked)

@export var slotItem : InventoryItem
@export var slotAmount : int
