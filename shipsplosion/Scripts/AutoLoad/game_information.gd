extends Node

#signal AdvanceDay

var DAY : int = 0
var TIME : int = 0800

var GameManager : Node2D 

func _ready() -> void:
	pass

func FindGM() -> void:
	GameManager = get_node("/root/ShipLevel/GameManager")
	
	if GameManager:
		print("GM Found") 
	else:
		print("GM Not Found")

func AdvanceDay() -> void:
	TIME = 0800
	DAY = DAY + 1
	
	print("Day - %s" % [DAY])
