extends Node2D

func _ready() -> void:
	%MusicDay.playing = true
	
	GameInformation.OnAdvanceDay.connect(switchMusic)

func playSound(input : String) -> void:
	
	var children := get_children()
	
	for i in range(children.size()):
		if children[i].name == input:
			children[i].play()

func switchMusic() -> void:
	if GameInformation.DAY == 4:
		%MusicDay.playing = false
		%MusicRush.playing = true

func _on_music_day_finished() -> void:
	%MusicDay.playing = true

func _on_music_rush_finished() -> void:
	%MusicRush.playing = true
