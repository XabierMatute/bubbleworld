extends Area2D

@export var speed: float = 500.0  # Velocidad inicial
@export var damage: int = 30  # Daño que inflige la bala

signal shooted  # Señal para disparo (opcional, puedes eliminarla si no la usas)

# Variable para manejar la velocidad de la bala
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Establece la velocidad inicial de la bala en función de su rotación
	velocity = Vector2(sin(rotation), -cos(rotation)) * speed
	
	# Autodestrucción tras 3 segundos
	await get_tree().create_timer(3).timeout
	queue_free()

func _process(delta: float) -> void:
	# Actualiza la posición de la bala según su velocidad
	position += velocity * delta

func set_speed(initial_speed: float) -> void:
	# Ajusta la velocidad en función de la rotación y el nuevo valor de velocidad
	velocity = Vector2(sin(rotation), -cos(rotation)) * initial_speed

func _on_area_entered(area: Area2D) -> void:
	# Lógica cuando la bala entra en otra área
	_on_collision(area)

func _on_body_entered(body: Node) -> void:
	# Lógica cuando la bala choca con un cuerpo
	_on_collision(body)

func _on_collision(target: Node) -> void:
	if target and target.has_method("get_hit"):  # Verifica si el objetivo tiene un método 'get_hit'
		target.get_hit(damage)  # Llama al método con el daño
	queue_free()  # Destruye la bala después de colisionar
