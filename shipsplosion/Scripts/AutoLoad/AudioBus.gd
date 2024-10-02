extends Node

var musicTrack : AudioStreamPlayer

func _ready() -> void:
	musicTrack = AudioStreamPlayer.new()
	musicTrack.volume_db = -24
	musicTrack.bus = "Music"
	
	add_child(musicTrack)

func setMusic(musicPath : String) -> void:
	musicTrack.stream = load(musicPath)
	musicTrack.playing = true

func playSoundAtLocation(globalLocation : Vector2, sound : String, pitchVariation : float = 0.2) -> void:
	var newSound : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	newSound.bus = "SFX"
	newSound.stream = load(sound)
	
	add_child(newSound)
	newSound.global_position = globalLocation
	
	newSound.pitch_scale = randf_range((1 - pitchVariation), (1 + pitchVariation))
	
	newSound.playing = true
	newSound.finished.connect(newSound.queue_free)
