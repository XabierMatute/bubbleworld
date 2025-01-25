extends Area2D

var Bullet = preload("res://bullet.tscn")
var last_shot = 0
var shot = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	last_shot += 1
	if (last_shot >= shot):
		shot_bullet()
		last_shot = 0
	pass

func shot_bullet():
	if (Bullet):
		var bullet_instance = Bullet.instantiate()
		bullet_instance.speed = 3000
		bullet_instance.rotation = 0
		bullet_instance.position = position
		bullet_instance.position.x += 30
		get_parent().add_child(bullet_instance)
