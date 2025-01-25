extends Area2D

var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	speed = speed * -1

func _on_enemy_3_boddy_entered(body):
	if (body.is_in_group("wall")):
		speed = speed * -1
