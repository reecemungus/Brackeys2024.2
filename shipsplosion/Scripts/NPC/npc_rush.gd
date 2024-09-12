extends CharacterBody2D
class_name NPCRush

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("G_Player")
@onready var navAgent : NavigationAgent2D = %NavigationAgent2D

@onready var hitDelayer : Timer = %HitDelayer
var isStunned : bool = false

@export var speed : float = 5000

var health : float = 100.0

func _physics_process(delta: float) -> void:
	if !isStunned:
		var dir = (navAgent.get_next_path_position() - global_position).normalized()
		velocity = (dir * speed) * delta 
	
	move_and_slide()

func onHit(damage : float) -> void:
	isStunned = true
	hitDelayer.start()
	
	health = health - damage
	checkHealth()
	
	var hitPunch = (player.global_position - global_position).normalized()
	velocity = velocity + (-hitPunch * 500)

func checkHealth() -> void:
	if health <= 0:
		onDeath()

func onDeath() -> void:
	queue_free()

func _on_nav_updater_timeout() -> void:
	navAgent.target_position = player.global_position

func _on_hit_delayer_timeout() -> void:
	isStunned = false
