extends Label

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "visible_ratio", 1, 5.0)
	tween.set_trans(Tween.TRANS_CUBIC)
