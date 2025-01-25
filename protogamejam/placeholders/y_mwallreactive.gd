extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D/AnimatedSprite2D.play("paloma")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("_on_area_2d_area_entered", area)
	#$Area2D/AnimatedSprite2D.play("cepillos")


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("_on_area_2d_body_entered", body)
	
		
	$Area2D/AnimatedSprite2D.play("cepillos")
	if body.dashing:
		body.air += 50
		$Area2D/AnimatedSprite2D.play("dinosaurio")
	else:
		#body.air -= 50
		body.get_hit(50)
		
	
# Cuando un cuerpo sale, revisa si no quedan más cuerpos y pausa la animación.
func _on_area_2d_body_exited(body: Node2D) -> void:
	print("_on_area_2d_body_exited", body)

	# Comprueba si no hay cuerpos en el área
	if $Area2D.get_overlapping_bodies().size() == 0:
		$Area2D/AnimatedSprite2D.stop()
