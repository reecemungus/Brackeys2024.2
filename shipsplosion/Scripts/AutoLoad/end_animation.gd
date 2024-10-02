extends Node

func Anim(input:String) -> void:
	var animationplayer = get_tree().get_first_node_in_group("g_endanimation")
	animationplayer.play(input)
