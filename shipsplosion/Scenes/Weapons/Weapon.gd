extends Area2D
class_name Weapon

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("G_Player") 
@export var Damage : float = 10

var canSwing : bool = true

func _ready() -> void:
	SignalBus.OnPlayerAttack.connect(Swing)

func _physics_process(_delta: float) -> void:
	var mousePos = get_global_mouse_position()
	
	look_at(mousePos)

func Swing() -> void:
	if canSwing:
		canSwing = false
		%Delay.start()
		%SwingParticle.emitting = true
		player.playAttackSound()
		
		var bodies : Array[Area2D] = get_overlapping_areas()
		
		for i in range(bodies.size()):
			if bodies[i].is_in_group("G_Attackable"):
				var parent = bodies[i].get_node("..")
				parent.onHit(Damage)

func _on_delay_timeout() -> void:
	canSwing = true
