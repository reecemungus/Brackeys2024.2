extends Node2D

@onready var npc_head: Sprite2D = $NPCHead
@onready var npc_torso: Sprite2D = $NPCTorso
@onready var npc_legs: Sprite2D = $NPCLegs
@onready var npc_feet: AnimatedSprite2D = $NPCFeet

@export_group("Colors")
@export var ClothingColors : Gradient
@export var skinColors : Gradient

func _ready() -> void:
	npc_head.modulate = skinColors.sample(randf_range(0, 1))
	
	npc_torso.modulate = ClothingColors.sample(randf_range(0, 1))
	npc_legs.modulate = ClothingColors.sample(randf_range(0, 1))
	npc_feet.modulate = ClothingColors.sample(randf_range(0, 1))
