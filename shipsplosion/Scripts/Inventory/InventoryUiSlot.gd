extends AspectRatioContainer
class_name InventoryUISlot

###INFO - Script to show sprites in UI slots
##

@onready var itemVisual : TextureRect = %ItemDisplay
@onready var amountText : Label = %AmountDisplay

func UpdateInv(slot : InventorySlot) -> void: # Display Slots in InventoryUI 
	if !slot: # If slot is empty
		itemVisual.visible = false
		amountText.visible = false
	else:
		if slot.slotItem != null:
			itemVisual.visible = true
			itemVisual.texture = slot.slotItem.ItemTexture
		
		if slot.slotAmount != 0:
			amountText.visible = true
			amountText.text = str(slot.slotAmount)
