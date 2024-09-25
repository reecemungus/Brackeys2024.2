extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameInformation.OnAdvanceDay.connect(Reveal)
	visible = false

func Reveal() -> void:
	if GameInformation.DAY == 4:
		visible = true
