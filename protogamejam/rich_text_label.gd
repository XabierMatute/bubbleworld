extends Node

var start = true
var audio

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio = $RichTextLabel/AudioStreamPlayer
	set_text_menu()
	await get_tree().create_timer(0.4).timeout
	audio.play(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_text_menu():
	var Menu = $RichTextLabel
	var label = $RichTextLabel/Label
	var text = " INMATE ID: 997836

 CRIME:	 MURDER

 SENTENCE: BUBBLE WORLD

 YEARS LEFT TO LIVE: 1.90259e-6

 60 seconds"

	var text2 = "\n\n[center][color=green]IN BUBBLE WORLD[/color][/center]"
	var text3 = "[center][color=red]\n\nYOU DROWN\n[/color][/center]"
	var i = 13
	var tmp
	Menu.text = "[color=green]_"
	tmp = "[color=green]_"
	var n = 0
	while (n < 20):
		Menu.text = ""
		await get_tree().create_timer(0.01).timeout
		Menu.text = tmp
		await get_tree().create_timer(0.01).timeout
		n += 1
	while i - 13 < text.length():
		Menu.text[i] = text[i - 13]
		tmp[i] = text[i - 13]
		Menu.text += "_"
		tmp += "_"
		await get_tree().create_timer(0.1).timeout
		Menu.text = ""
		await get_tree().create_timer(0.01).timeout
		Menu.text = tmp
		i += 1
	await get_tree().create_timer(0.05).timeout
	Menu.text = text2
	tmp = text2
	i = 0
	n = 0
	while (n < 10):
		Menu.text = ""
		await get_tree().create_timer(0.01).timeout
		Menu.text = tmp
		await get_tree().create_timer(0.01).timeout
		n += 1
	while(i < 3):
		Menu.text += '[color=green].[/color]'
		tmp += '[color=green].[/color]'
		Menu.text = ""
		await get_tree().create_timer(0.02).timeout
		Menu.text = tmp
		await get_tree().create_timer(0.02).timeout
		Menu.text = ""
		await get_tree().create_timer(0.1).timeout
		i += 1
	Menu.add_theme_font_size_override("normal_font_size", 80)
	Menu.text = text3
	await get_tree().create_timer(3).timeout
	label.show()
	start = true

func _input(event):
	if event is InputEventKey and event.pressed:
		if start == true:
			get_tree().change_scene_to_file("res://testchamber_5.tscn")
