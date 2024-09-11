extends Area2D

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("G_Player") # player ref
@onready var inventory : Inventory = preload("res://Scenes/Inventory/Inventories/playerInventory.tres")
@export var item : InventoryItem

var isActive : bool = false

func _ready() -> void:
	player.Interact.connect(OnPickup)
	%PickupSprite.texture = item.ItemTexture

func _on_area_entered(area: Area2D) -> void:
	if area.name == "InteractArea": # only move forward if player is in the area
		isActive = true

func _on_area_exited(area: Area2D) -> void:
	if area.name == "InteractArea": # only move forward if player is in the area
		isActive = true

func OnPickup() -> void:
	if isActive:
		player.Collect(item)
		queue_free()
