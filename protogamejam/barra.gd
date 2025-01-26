extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$medio.scale.y = get_parent().get_parent().get_bubble_percentage()
	$medio.position.y = (760.0 - 760 * $medio.scale.y) / 2
	
