extends NinePatchRect

@onready var itemVisual : Sprite2D = %ItemDisplay

func UpdateInv(slot : InventorySlot) -> void:	
	if !slot:
		itemVisual.visible = false
	else:
		itemVisual.visible = true
		itemVisual.texture = slot.item.ItemTexture
