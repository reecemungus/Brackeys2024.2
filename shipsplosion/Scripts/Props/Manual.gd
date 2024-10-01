extends Area2D
class_name Manual

var isActive : bool = false

func _ready() -> void:
	SignalBus.OnPlayerInteract.connect(OnInteract)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("G_Player"):
		isActive = true

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("G_Player"):
		isActive = false

func OnInteract() -> void:
	if isActive:
		SignalBus.OpenManual.emit()
