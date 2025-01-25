extends RigidBody2D

var moving_up: bool = false
var speed: float = 1000.0  # Velocidad de movimiento
@onready var raycast: RayCast2D = $RayCast2D  # Asegúrate de tener un RayCast2D como hijo del nodo

func _ready() -> void:
	position *= 0
	hide()  # Oculta el nodo inicialmente

func _process(delta: float) -> void:
	if moving_up:
		#if not raycast.is_colliding():  # Si no choca con nada
		position.y -= speed * delta  # Mover hacia arriba

func ganchear() -> void:
	position *= 0
	moving_up = true
	show()  # Asegúrate de que el nodo sea visible al moverse

func _on_collision() -> void:
	moving_up = false
	raycast
	print("¡Gancho colisionó con ", raycast.get_collider())


func _on_area_entered(area: Area2D) -> void:
	moving_up = false
	raycast
	print("¡Gancho colisionó con ", raycast.get_collider())


func _on_body_entered(body: Node) -> void:
	moving_up = false
	print("¡Gancho colisionó con ", body)
