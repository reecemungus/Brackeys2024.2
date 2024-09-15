extends Node

@export_category("CharacterTracker")
var angelaRep : int = 0
var aviRep : int = 0
var charlotteRep : int = 0
var harryRep : int = 0
var jeremyRep : int = 0
var patrickRep : int = 0

func addRep(character : String) -> void:
	match character:
		"Angela":
			angelaRep += 1
		"Avi":
			aviRep += 1
		"Charlotte":
			charlotteRep += 1
		"Harry":
			harryRep += 1
		"Jeremy":
			jeremyRep += 1
		"Patrick":
			patrickRep += 1
		_:
			angelaRep += 1

func PanickCharacter(character : String) -> void:
	var targetChar = get_tree().get_first_node_in_group("C_%s" % [character])
	targetChar.OnPanicked()
