extends CanvasLayer

func _physics_process(_delta: float) -> void:
	%Time.text = "%s" % [GameInformation.TIME]
