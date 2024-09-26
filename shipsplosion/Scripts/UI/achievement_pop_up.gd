extends Control

var texttoshow = "this is a popup"
var show_time = 3
var texture = "texture"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NinePatchRect/Label.text=texttoshow
	$Timer.start(show_time)
	$NinePatchRect/TextureRect.texture = load(texture)


func _on_timer_timeout() -> void:
	queue_free()
