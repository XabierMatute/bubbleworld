extends RigidBody2D

# Variables de movimiento
var speed: float = 20  # Velocidad de movimiento
var direction: int = 1  # Dirección del movimiento, 1 hacia la derecha, -1 hacia la izquierda

# Límites de movimiento
var left_limit: float = -20  # Límite izquierdo
var right_limit: float = 20  # Límite derecho

# Se llama cuando el nodo entra en la escena
func _ready() -> void:
	$AnimatedSprite2D.play("default")

# Se llama cada frame
func _process(delta: float) -> void:
	# Mover horizontalmente
	position.x += direction * speed * delta

	# Cambiar dirección si se alcanzan los límites
	if position.x >= right_limit:
		direction = -1
	elif position.x <= left_limit:
		direction = 1
