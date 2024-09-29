extends Node2D

func _ready() -> void:
	#var fade : AnimationPlayer = get_tree().get_first_node_in_group("G_Fade")
	#fade.play("FadeIn")
	var Angela = PlayerInformation.angelaRep
	var Avi = PlayerInformation.aviRep
	var Charlotte = PlayerInformation.charlotteRep
	var Jeremy = PlayerInformation.jeremyRep
	var Harry = PlayerInformation.harryRep
	var Patrick = PlayerInformation.patrickRep
	
	var maxrep = [Angela, Avi, Charlotte, Jeremy, Harry, Patrick]
	var largest = max(Angela, Avi, Charlotte, Jeremy, Harry, Patrick)
	
	var chars : Array[String] = ["Angela", "Avi", "Charlotte", "Jeremy", "Harry", "Patrick"]
	
	var chosenChar 
	
	for i in range(chars.size()):
		if maxrep[i] == largest:
			chosenChar = chars[i]
	
	Dialogic.start(chosenChar+"Finale")
	%Character.texture = load ("res://Dialog/Sprites/%s.png" % [chosenChar])
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Stay":
		get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu/Day Transitions/EndOfGame.tscn")
	if anim_name == "Leave":
		get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu/Day Transitions/EndOfGame.tscn")
