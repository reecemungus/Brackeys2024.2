extends Panel

@onready var itemVisual : Sprite2D = %ItemDisplay

func UpdateInv(item : InventoryItem) -> void:
	print("item = %s" % [item])
	print("itemVisual = %s" % [itemVisual])
	
	if !item:
		itemVisual.visible = false
	else:
		itemVisual.visible = true
		itemVisual.texture = item.ItemTexture
