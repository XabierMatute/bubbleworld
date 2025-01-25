extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

signal popped

@export var initial_air := 100.0
@export var air_decrement = 1
@export var base_jump_air_cosumption = 20
@export var dash_air_cosumption = 20
@export var jump_air_cosumption_increment = 5
var jump_air_cosumption = base_jump_air_cosumption
@export var dash_velocity = 1000

var num_of_stage = 3

var air := initial_air

var alive = true

var looking_left = false

var dashing = false

func _ready() -> void:
	alive = true
	air = initial_air
	$Bubble.scale *= num_of_stage
	$AnimatedSprite2D.animation = "walk"

func get_bubble_percentage():
	return float(air) / initial_air

func get_bubble_stage():
	return int(num_of_stage * get_bubble_percentage() + 1)

func handle_animation():
	$AnimatedSprite2D.flip_v = false
	# See the note below about the following boolean assignment.
	$AnimatedSprite2D.flip_h = looking_left
	if dashing:
		$AnimatedSprite2D.play("dash")
		return
	if hitted:
		$AnimatedSprite2D.play("hit")
		return
	if velocity.x < 0:
		looking_left = true
	elif velocity.x > 0:
		looking_left = false
	if velocity.y < 0:
		$AnimatedSprite2D.play("walk")
		#$AnimatedSprite2D.play("swim")
	elif velocity.x != 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

var hitted = false

func get_hit(damage):
	print("hothit")
	if hitted:
		return
	if dashing:
		return
	$HitTimer.start()
	air -= damage
	hitted = true
	
func get_heal(heal):
	air += heal

func _process(delta: float) -> void:
	handle_animation()
	air -= air_decrement  * delta
	if air < 0:
		air = 0
		emit_signal("popped")
		#get_hit()
		#$AnimatedSprite2D.play("hit")
		# debug
		air = 0
	#print(air)
	$Bubble.scale = Vector2(1 , 1) * get_bubble_stage()
	#print($Bubble.scale)

@export var gravity_scale = 0.42

func get_player_gavity():
	return get_gravity() / get_bubble_stage() * gravity_scale

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity +=  delta * get_player_gavity()
	
	# ir para abajo en plan tetris
	if Input.is_action_just_pressed("ui_down"):
		velocity.y = 0 - JUMP_VELOCITY

	## Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_air_cosumption = base_jump_air_cosumption
		air -= jump_air_cosumption

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# Handdle dash
	if Input.is_action_just_pressed("dash"):
		dashing = true
		$DashTimer.start()
		air -= dash_air_cosumption
	
	if dashing:
		#print("dashing")
		velocity.y = 0
		if looking_left:
			velocity.x = -dash_velocity
		else:
			velocity.x = dash_velocity
	
	if Input.is_action_just_pressed("gancho"):
		trow_gancho()

	move_and_slide()

func trow_gancho():
	print("gancheo")
	$Gancho.show()
	$Gancho.ganchear()
	pass

func _on_dash_timer_timeout() -> void:
	print("ya no dashing")
	dashing = false
	$AnimatedSprite2D.animation = "idle"


func _on_hit_timer_timeout() -> void:
	print("ya no hit")
	hitted = false
	$AnimatedSprite2D.animation = "idle"


func _on_animated_sprite_2d_animation_finished() -> void:
	print("hola")
	if not dashing:
		return
	_on_dash_timer_timeout()
