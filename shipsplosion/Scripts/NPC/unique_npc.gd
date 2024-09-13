extends CharacterBody2D
class_name UniqueNPC

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("G_Player")

var isActive : bool = false

@export_group("DialogInfo")
@export var characterName : String

var daysSpokenTo : int = 1
var dailyDialog : int = 1
var isPanicked : bool = false

var currentDay : int = 1
var spokenToToday : bool = false

@export_group("CharacterInfo")
@export var sprite : Texture2D

func _ready() -> void:
	player.Interact.connect(OnSpokenTo)
	GameInformation.OnAdvanceDay.connect(AdvanceDay)

func _on_dialog_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("G_Player"):
		isActive = true

func _on_dialog_zone_area_exited(area: Area2D) -> void:
	if area.is_in_group("G_Player"):
		isActive = false

func runDialog(dialogString : String) -> void:
	Dialogic.start(dialogString)

func OnSpokenTo() -> void:
	if isActive && player.canTalk:
		spokenToToday = true
		
		PlayerInformation.addRep(characterName)
		
		runDialog(GetTimeLine())
		
		if dailyDialog != 3:
			dailyDialog = dailyDialog + 1

func GetTimeLine() -> String:
	var timelineString : String = "%s%s_%s" % [characterName, daysSpokenTo, dailyDialog]
	return timelineString

func AdvanceDay() -> void:
	if spokenToToday:
		dailyDialog = 1
		daysSpokenTo = daysSpokenTo + 1
		
	spokenToToday = false
