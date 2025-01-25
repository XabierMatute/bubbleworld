extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	#print(body)
	#print(body.has_method("dashing"))
	if body.dashing:  # Verifica si tiene el método 'dashing' y que sea true
		break_wall()
		
func break_wall():
	$entera.hide()
	collision_layer = 0
	collision_mask = 0
