extends Area2D

var bodies : Array[Area2D]

var anims : Array

var blendValue : float = 0
var targetBlendValue : float = 0
@export var doorSpeed : float = 0.1

@export var keycardNeeded : InventoryItem 
@export var modulateColor : Color

var isOpen : bool = false
var hasOpened : bool = false

func _ready() -> void:
	%DoorRight.modulate = modulateColor
	%DoorLeft.modulate = modulateColor

func _physics_process(_delta: float) -> void:
	blendValue = lerpf(blendValue, targetBlendValue, doorSpeed)
	%AnimationTree.set("parameters/BlendSpace1D/blend_position", blendValue)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("G_Player"):
		CheckAreas(area)

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("G_Player"):
		targetBlendValue = 0
		%CollisionBlocker.set_collision_layer_value(1, true)
		%CollisionBlocker.set_collision_mask_value(1, true)

func CheckAreas(area : Area2D) -> void:
	var shouldOpen : bool = false
	var playerInv : Inventory = area.get_node("..").inventory
	
	for i in range(playerInv.slots.size()):
		if playerInv.slots[i].slotItem == keycardNeeded:
			shouldOpen = true
	
	if shouldOpen:
		targetBlendValue = 1
		%CollisionBlocker.set_collision_layer_value(1, false)
		%CollisionBlocker.set_collision_mask_value(1, false)
