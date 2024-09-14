extends Node

signal OnAdvanceDay

var DAY : int = 0
var TIME : String = "08:00"

var Hours : int = 8
var Minutes : int = 0

var GameManager : Node2D 

func _ready() -> void:
	pass

func FindGM() -> void:
	GameManager = get_node("/root/ShipLevel/GameManager")
	
	if !GameManager:
		push_error("GM Not Found")

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
	
	OnAdvanceDay.emit()

func _physics_process(_delta: float) -> void:
	if TIME == "24:00":
		var bed = get_tree().get_first_node_in_group("G_Bed")
		bed.AdvanceDay(true)
