extends StaticBody2D
class_name Bed 

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("G_Player") # player ref
@onready var fade : AnimationPlayer = get_tree().get_first_node_in_group("G_Fade")
var isActive : bool = false

var lastDay : bool = false

func _ready() -> void:	
	if player: # attempt to connect to signal on player
		SignalBus.OnPlayerInteract.connect(AdvanceDay) # connect advance day to player interact
	else:
		push_error("Player not found")

func _on_interact_area_area_entered(area: Area2D) -> void:
	if area.name == "InteractArea": # only move forward if player is in the area
		isActive = true

func _on_interact_area_area_exited(area: Area2D) -> void:
	
	if area.name == "InteractArea": # only move forward if player is in the area
		isActive = false

func AdvanceDay(override : bool = false) -> void:
	if !lastDay:
		if override:
			%DelayTimer.start()
			fade.play("FadeOut&In")
		else:
			if isActive: # advance day if player is within range of bed
				%DelayTimer.start()
				fade.play("FadeOut&In")

func _on_delay_timer_timeout() -> void:
	GameInformation.AdvanceDay()
	
	if GameInformation.DAY == 4:
		lastDay = true
