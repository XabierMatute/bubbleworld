extends StaticBody2D

@export var speed = 1.0 / 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale *= 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scale -= Vector2(delta * speed, delta * speed)
	if scale.x < 0 or scale.y < 0:
		scale = Vector2(0,0)
		emit_signal("popped")
