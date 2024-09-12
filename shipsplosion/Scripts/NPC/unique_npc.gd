extends CharacterBody2D
class_name UniqueNPC

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("G_Player")

var isActive : bool = false

@export var characterName : String
@export var dialog : String

func _ready() -> void:
	player.Interact.connect(OnSpokenTo)

func _on_dialogue_sphere_area_entered(area: Area2D) -> void:
	if area.is_in_group("G_Player"):
		isActive = true

func _on_dialogue_sphere_area_exited(area: Area2D) -> void:
	if area.is_in_group("G_Player"):
		isActive = false

func runDialog(dialogString : String) -> void:
	Dialogic.start(dialogString)

func OnSpokenTo() -> void:
	if isActive:
		runDialog(dialog)
