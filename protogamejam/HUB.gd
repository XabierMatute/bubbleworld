extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var container = $CenterContainer/GridContainer
	var id = -1
	for button in container.get_children():
		if button is Button:
			id += 1
			if id == 0:
				button.pressed.connect(self._start)
			elif id == 1:
				button.pressed.connect(self._exit)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _start():
	get_tree().change_scene_to_file("res://text_menu.tscn")

func _exit():
	get_tree().quit()
