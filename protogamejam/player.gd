extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

signal popped

@export var initial_air = 100
@export var air_decrement = 1
@export var base_jump_air_cosumption = 20
@export var jump_air_cosumption_increment = 5
var jump_air_cosumption = base_jump_air_cosumption

var air

var alive = true

func _ready() -> void:
	alive = true
	air = initial_air

func get_bubble_percentage():
	return float(air) / initial_air


func _process(delta: float) -> void:
	if velocity.y < 0:
		$AnimatedSprite2D.play("swim")
	elif velocity.x != 0:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.stop()
	

	
	air -= air_decrement  * delta
	if air < 0:
		air = 0
		emit_signal("popped")
		# debug
		air = 111
	$Bubble.scale = Vector2(1 ,1) * (get_bubble_percentage())

@export var dash = 400

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * (1 - get_bubble_percentage()) * 2
		
	#if Input.is_action_just_pressed("ui_up"):
		#velocity -= velocity / 2
	#if Input.is_action_just_pressed("ui_down"):
		#velocity += velocity / 2
		

	## Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_air_cosumption = base_jump_air_cosumption
		air -= jump_air_cosumption
	#
	## Handle double jump??	
	#if Input.is_action_just_pressed("ui_accept") and not is_on_floor():
		#velocity.y = JUMP_VELOCITY
		#jump_air_cosumption += jump_air_cosumption_increment
		#air -= jump_air_cosumption
		

	
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#direction = Input.get_axis("ui_up", "ui_down")
	#if direction:
		#velocity.y += direction * SPEED/100
	#else:
		#velocity.y += move_toward(velocity.y, 0, SPEED)

		# Handdle dash
	#if Input.is_action_just_pressed("ui_accept") and not is_on_floor():
		#var xdirection := Input.get_axis("ui_left", "ui_right") #TODO: mirar controles de joystick
		#var ydirection := Input.get_axis("ui_left", "ui_right")
		#print("dash", velocity)
		#velocity += Vector2(xdirection, ydirection).normalized() * dash
		#print(velocity)
	if Input.is_action_just_pressed("ui_accept") and not is_on_floor():
		var xdirection := Input.get_axis("ui_left", "ui_right")  # Movimiento en eje X
		var ydirection := Input.get_axis("ui_up", "ui_down")    # Movimiento en eje Y (joystick o teclado)

		if xdirection != 0 or ydirection != 0:  # Solo aplica dash si hay entrada de movimiento
			var dash_vector = Vector2(xdirection, ydirection).normalized() * dash
			velocity = dash_vector # Añade el dash a la velocidad actual
			print("Dash vector:", dash_vector, "New velocity:", velocity)
			
			# Activar partículas
			$DashParticles.global_position = global_position  # Posiciona las partículas en el personaje
			$DashParticles.emitting = true

			print("Dash vector:", dash_vector, "New velocity:", velocity)

	move_and_slide()
