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

@export_group("NavInfo")
@onready var nav_updater: Timer = %NavUpdater
@onready var wonder_timer: Timer = %WonderTimer
@onready var wait_timer: Timer = %WaitTimer
@onready var navAgent: NavigationAgent2D = %NavigationAgent2D

@export var speed : float = 7500.0
@export var acceptableRadius : float = 25
@export var wanderRadius : float = 500.0
var dir : Vector2 

var targetLocation : Vector2 

var initialLocation : Vector2

func _ready() -> void:
	%Sprite.texture = sprite
	
	initialLocation = global_position
	
	player.Interact.connect(OnSpokenTo)
	GameInformation.OnAdvanceDay.connect(AdvanceDay)
	
	wonder_timer.wait_time = %WonderTimer.wait_time + randf_range(-2, 2)
	wait_timer.wait_time = randf_range(0, 5)
	
	wait_timer.start()

func _physics_process(delta: float) -> void:
	if isActive:
		velocity = Vector2.ZERO
	elif navAgent.distance_to_target() > acceptableRadius:
		dir = (navAgent.get_next_path_position() - global_position).normalized()
		velocity = (dir * speed) * delta 
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _on_dialog_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("G_Player"):
		isActive = true

func _on_dialog_zone_area_exited(area: Area2D) -> void:
	if area.is_in_group("G_Player"):
		isActive = false

func runDialog(dialogString : String) -> void:
	Dialogic.start(dialogString)

func OnSpokenTo() -> void:
	if !isPanicked:
		if isActive && player.canTalk:
			spokenToToday = true
			
			PlayerInformation.addRep(characterName)
			
			runDialog(GetTimeLine())
			
			if dailyDialog != 3:
				dailyDialog = dailyDialog + 1
	
	elif isPanicked:
		if isActive && player.canTalk:
			spokenToToday = true
			
			PlayerInformation.addRep(characterName)
			
			runDialog(GetTimeLinePanicked())
			
			if dailyDialog != 2:
				dailyDialog = dailyDialog + 1

func GetTimeLine() -> String:
	var timelineString : String = "%s%s_%s" % [characterName, daysSpokenTo, dailyDialog]
	return timelineString

func GetTimeLinePanicked() -> String:
	var timelineString : String = "%s%s_%sPanic" % [characterName, daysSpokenTo, dailyDialog]
	return timelineString

func AdvanceDay() -> void:
	if spokenToToday:
		dailyDialog = 1
		daysSpokenTo = daysSpokenTo + 1
		
	spokenToToday = false
	
	global_position = initialLocation
	
	if GameInformation.DAY == 4:
		queue_free()

func _on_nav_updater_timeout() -> void:
	navAgent.target_position = targetLocation

func _on_wonder_timer_timeout() -> void:
	targetLocation = getRandomReachablePointInRadius(global_position, wanderRadius)

func _on_wait_timer_timeout() -> void:
	targetLocation = getRandomReachablePointInRadius(global_position, wanderRadius)

func getRandomReachablePointInRadius(origin : Vector2, radius : float) -> Vector2:
	var vec : Vector2 = (Vector2.RIGHT * randf_range(radius / 2,radius)).rotated(randf_range(-PI, PI))
	vec = vec + origin
	
	return vec

func OnTraded() -> void:
	pass

func OnPanicked() -> void:
	isPanicked = true
	dailyDialog = 1
	
	spokenToToday = false
	
	print("AAAAAhhh")
