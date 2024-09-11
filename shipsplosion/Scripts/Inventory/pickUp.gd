extends Area2D

@export var item : InventoryItem

func _ready() -> void:
	%PickupSprite.texture = item.ItemTexture
