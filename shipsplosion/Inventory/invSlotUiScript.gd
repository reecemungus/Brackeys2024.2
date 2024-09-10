extends Panel

@onready var itemVisual : Sprite2D = %ItemDisplay

func UpdateInv(item : InventoryItem) -> void:	
	if !item:
		itemVisual.visible = false
	else:
		itemVisual.visible = true
		itemVisual.texture = item.ItemTexture
