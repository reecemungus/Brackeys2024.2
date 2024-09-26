extends Node

signal achievementget(msg)

@export var display_time : float = 5
@export var texttoshow : String = "text"
@export var texture : String = "text"
@onready var pop_up_scene = preload("res://Scenes/UI/AchievementPopUp.tscn")
var player

var newlargest
var once : bool = false

func _ready():
	achievementget.connect(_on_achievementget)
	player = %PlayerCharacter

func _process(_float) -> void:
	var Angela = PlayerInformation.angelaRep
	var Avi = PlayerInformation.aviRep
	var Charlotte = PlayerInformation.charlotteRep
	var Jeremy = PlayerInformation.jeremyRep
	var Harry = PlayerInformation.harryRep
	var Patrick = PlayerInformation.patrickRep
	
	var largest = max(Angela, Avi, Charlotte, Jeremy, Harry, Patrick)
	print (largest)
	
	if largest == 2 and not once:
		once = true
		print(once)
		achievementget.emit("affinity")

func _on_achievementget(msg):
	if msg == "affinity":
		texttoshow = "Reach max affinity with a character!"
		var new_pop_up = pop_up_scene.instantiate()
		new_pop_up.show_time = display_time
		new_pop_up.texttoshow = texttoshow
		new_pop_up.texture = "res://Dialog/Sprites/Avi.png"
		new_pop_up.set_z_index(100)
		player.add_child(new_pop_up)
