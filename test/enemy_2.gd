extends Area2D

var Bullet = preload("res://bullet.tscn")
var last_shot = 0
var shot = 100

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
		var n = 0
		var bullet_array: Array = []
		var rot = 0
		var rot2 = 2 *PI /10
		while (n < 10):
			rot += rot2
			var bullet_instance
			bullet_instance = Bullet.instantiate()
			bullet_instance.speed = 50
			bullet_instance.rotation = rot
			bullet_instance.position = position
			bullet_array.append(bullet_instance)
			get_parent().add_child(bullet_array[n])
			n += 1
