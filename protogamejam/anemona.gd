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
	print("_ready")

func shoot_bullet() -> void:
	print("shoot_bullet")
	if bullet_scene == null:
		print("¡No se asignó una escena de bala!")
		return
	
	# Instancia la bala
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)  # Añade la bala al nodo padre
	bullet.position =  position  # Coloca la bala en la posición del objeto
	bullet.rotation = rotation  # Ajusta la dirección de disparo
	# Aplica una fuerza inicial a la bala
	if bullet.has_method("set_speed"):
		bullet.set_speed(bullet_speed)


func _on_shoot_timer_timeout() -> void:
	shoot_bullet()


#func _on_body_entered(body: Node) -> void:
func _on_area_2d_body_entered(body: Node2D) -> void:
	#print(body)
	#print(body.has_method("dashing"))
	if body.dashing:  # Verifica si tiene el método 'dashing' y que sea true
		body.get_heal(20)
		die()
		
func die():
	queue_free()
