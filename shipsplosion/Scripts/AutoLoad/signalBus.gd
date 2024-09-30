extends Node

signal OnPlayerClick
signal OnPlayerInteract
signal OnPlayerAttack
signal OnPlayerTrade

signal UpdateInventorySlots

signal OpenChest # Unhide Chest UI
signal CloseContainer

signal TransferItem(item : InventoryItem, fromInventory : Inventory, toInventory : Inventory)

func _ready() -> void:
	TransferItem.connect(OnTransferItem)

func OnTransferItem(item : InventoryItem, fromInventory : Inventory, toInventory : Inventory) -> bool:
	if !toInventory or !fromInventory:
		SignalBus.UpdateInventorySlots.emit()
		return false 
	
	if toInventory.Insert(item):
		fromInventory.Remove(item)
		SignalBus.UpdateInventorySlots.emit()
		return true
	
	return false
