extends Control

func _ready() -> void:
	SignalBus.OpenManual.connect(OpenManual)

func OpenManual() -> void:
	visible = true

func _on_close_book_pressed() -> void:
	visible = false
