extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var bubble_speed = 1.0 / 4

var air = 1

func _process(delta: float) -> void:
	if velocity.x != 0:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.stop()
	
	$Bubble.scale -= Vector2(delta * bubble_speed, delta * bubble_speed)
	if $Bubble.scale.x < 0 or $Bubble.scale.y < 0:
		$Bubble.scale = Vector2(0,0)
		emit_signal("popped")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
