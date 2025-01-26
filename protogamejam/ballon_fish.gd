extends RigidBody2D

# Variables configurables
@export var bullet_scene: PackedScene  # Escena de la bala
@export var shoot_interval: float = 1.0  # Intervalo entre disparos en segundos
@export var bullet_speed: float = 500.0  # Velocidad de las balas
# Temporizador para controlar el disparo
@onready var shoot_timer: Timer = $ShootTimer

func _ready() -> void:
	# Inicia el temporizador para disparar
	shoot_timer.wait_time = shoot_interval
	shoot_timer.start()
	var animation = $AnimatedSprite2D
	animation.play()
	print("_ready")

func shoot_bullet() -> void:
	print("shoot_bullet")
	if bullet_scene == null:
		print("¡No se asignó una escena de bala!")
		return
	
	# Instancia la bala
	var Bullet = bullet_scene
	if (Bullet):
		var n = 0
		var bullet_array: Array = []
		
		var rot = 0
		var rot2 = 2 *PI /10
		while (n < 10):
			rot += rot2
			var bullet_instance
			bullet_instance = Bullet.instantiate()
			bullet_instance.speed = 50
			bullet_instance.rotation = rot
			bullet_instance.position = position
			bullet_array.append(bullet_instance)
			get_parent().add_child(bullet_array[n])
			n += 1


func _on_shoot_timer_timeout() -> void:
	shoot_bullet()


#func _on_body_entered(body: Node) -> void:
func _on_area_2d_body_entered(body: Node2D) -> void:
	#print(body)
	#print(body.has_method("dashing"))
	player = body
	
var player = null

func _process(delta: float) -> void:
	if not player:
		return
	if player.dashing:  # Verifica si tiene el método 'dashing' y que sea true
		player.get_heal(20)
		die()
		
func die():
	queue_free()


func _on_body_entered(body: Node) -> void:
	pass # Replace with function body.
