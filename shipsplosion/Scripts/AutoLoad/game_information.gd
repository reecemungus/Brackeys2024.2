extends Node

#signal AdvanceDay

var DAY : int = 0
var TIME : String = "08:00"

var Hours : int = 8
var Minutes : int = 0

var GameManager : Node2D 

func _ready() -> void:
	pass

func FindGM() -> void:
	GameManager = get_node("/root/ShipLevel/GameManager")
	
	if GameManager:
		print("GM Found") 
	else:
		print("GM Not Found")

func AdvanceTime() -> void:
	# Increment Clock
	if Minutes == 30:
		Minutes = 0
		Hours = Hours + 1
	
	elif Minutes == 0:
		Minutes = 30
	
	var minString : String = str(Minutes)
	var hourString : String = str(Hours)
	
	if minString.length() == 1:
		minString = minString + "0"
	
	if hourString.length() == 1:
		hourString = "0" + hourString 
	
	TIME = "%s:%s" % [hourString, minString]

func AdvanceDay() -> void:
	TIME = "08:00"
	Hours = 8
	Minutes = 0
	
	DAY = DAY + 1
	
	print("Day - %s" % [DAY])
