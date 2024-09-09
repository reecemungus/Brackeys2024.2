class_name Bed extends StaticBody2D

@onready var player : CharacterBody2D = get_node("/root/ShipLevel/PlayerCharacter") # get ref to player
@onready var fade : AnimationPlayer = get_node("/root/ShipLevel/Fade/AnimationPlayer")
var isActive : bool = false

func _ready() -> void:
	
	if player: # attempt to connect to signal on player
		player.Interact.connect(AdvanceDay)
	else:
		push_error("Player not found")

func _on_interact_area_area_entered(area: Area2D) -> void:
	
	if area.name == "InteractArea": # only move forward if player is in the area
		isActive = true

func _on_interact_area_area_exited(area: Area2D) -> void:
	
	if area.name == "InteractArea": # only move forward if player is in the area
		isActive = false

func AdvanceDay() -> void:
	if isActive: # advance day if player is within range of bed
		GameInformation.AdvanceDay()
		fade.play("FadeOut&In")
