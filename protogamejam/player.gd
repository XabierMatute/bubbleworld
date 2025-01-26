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

var SoftMusic
var HardMusic
var SoundHit
var SoundKill

func _ready() -> void:
	SoftMusic = $"../SoftMusic"
	HardMusic = $"../HadMusic"
	SoundHit = $"../Hit"
	SoundKill = $"../Kill"
	SoundHit.play(0)
	init_music()
	alive = true
	air = initial_air
	$Bubble.scale *= num_of_stage
	$AnimatedSprite2D.animation = "walk"
	var anim = $Bubble/AnimatedSprite2D
	anim.play()
	
	var grid_container = $"../ESC/CenterContainer/GridContainer"
	var id = -1
	for button in grid_container.get_children():
		if button is Button:
			id += 1
			if (id == 0):
				button.pressed.connect(self._return)
			elif (id == 1):
				button.pressed.connect(self._exit)

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
	set_soft_m()
	SoundHit.play(0)
	
	
func get_heal(heal):
	air += heal
	set_hard_m()
	SoundKill.play(0)

func _process(delta: float) -> void:
	handle_animation()
	air -= air_decrement  * delta
	if air > 60:
		air = 60
	if air < 0:
		air = 0
		emit_signal("popped")
		#################
		#################
		while dashing == true:
			await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://testchamber_5.tscn")
		#################
		#################
		#get_hit()
		#$AnimatedSprite2D.play("hit")
		# debug
		air = 0
	#print(air)
	$Bubble.scale = Vector2(1 , 1) * (get_bubble_stage() / 2)
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

	if (Input.is_key_pressed(KEY_ESCAPE)):
		var Menu = $"../ESC/CenterContainer"
		if (!Menu.is_visible()):
			Menu.show()
			get_tree().set_pause(true)
		else:
			Menu.hide()
			get_tree().set_pause(false)

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


func _on_anemonadown_body_entered(body: Node) -> void:
	pass # Replace with function body.


func _on_ballon_fish_body_entered(body: Node) -> void:
	pass # Replace with function body.

func init_music():
	SoftMusic.play(0)
	HardMusic.play(0)
	HardMusic.set_volume_db(-100)

func set_soft_m():
	SoftMusic.set_volume_db(0)
	HardMusic.set_volume_db(-100)
	
func set_hard_m():
	HardMusic.set_volume_db(0)
	SoftMusic.set_volume_db(-100)

func _return():
	var Menu = $"../ESC/CenterContainer"
	Menu.hide()
	get_tree().set_pause(false)

func _exit():
	get_tree().quit()
