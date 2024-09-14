extends CanvasLayer
@onready var canvas_layer: CanvasLayer = $"."
@onready var label: Label = $Control/CenterContainer/Label


func _ready() -> void:
	var Day = GameInformation.DAY
	
	if Day == 1:
		label.text="Day One. \nThree days until the meteor strike."
		
	if Day == 2:
		label.text="Day Two. \nTwo days until the meteor strike."
		
	if Day == 3:
		label.text="Day Three. \nOne day until the meteor strike."
		
	else:
		label.text="Day Four. \nMeteor strike imminent."
