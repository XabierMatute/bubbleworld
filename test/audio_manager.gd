extends Node

var Audio1

func _ready() -> void:
	get_tree().set_pause(true)
	
	set_text_menu()
	await get_tree().create_timer(25).timeout
	
	#check imput
	get_tree().set_pause(false)
	
	await get_tree().create_timer(2).timeout
	Audio1 = $Audio/AudioStreamPlayer
	Audio1.play(0)
	Audio1.set_volume_db(-10)

	var grid_container = $ESC/CenterContainer/GridContainer
	var id = -1
	for button in grid_container.get_children():
		if button is Button:
			id += 1
			if (id == 0):
				button.pressed.connect(self._return)
			elif (id == 1):
				button.pressed.connect(self._exit)
	pass

func _input(_id):
	if (Input.is_key_pressed(KEY_ESCAPE)):
		var Menu = $ESC/CenterContainer
		if (!Menu.is_visible()):
			Menu.show()
			get_tree().set_pause(true)
		else:
			Menu.hide()
			get_tree().set_pause(false)

func _return():
	var Menu = $ESC/CenterContainer
	Menu.hide()
	get_tree().set_pause(false)

func _exit():
	get_tree().quit()

func set_text_menu():
	var Menu = $RichTextLabel
	var text = "INMATE ID:	997836

CRIME:		MURDER

SENTENCE:	BUBBLE WORLD

YEARS LEFT TO LIVE:	1.90259e-6

60 seconds"

	var text2 = "\n\n[center][color=green]IN BUBBLE WORLD[/color][/center]"
	var text3 = "[center][color=red]\n\n\nYOU DROWN\n[/color][/center]"
	var i = 13
	Menu.text = "[color=green]_"
	while i - 13 < text.length():
		await get_tree().create_timer(0.1).timeout
		Menu.text[i] = text[i - 13]
		Menu.text += "_"
		i += 1
	await get_tree().create_timer(1).timeout
	Menu.text = text2
	i = 0
	while(i < 3):
		Menu.text += '[color=green].[/color]'
		await get_tree().create_timer(1).timeout
		i += 1
	Menu.text = text3


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_bullet_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
