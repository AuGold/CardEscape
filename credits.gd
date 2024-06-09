extends CanvasLayer

func _ready():
	$AudioStreamPlayer2D.stream = load("res://sounds/Credits_Background.wav")
	$AudioStreamPlayer2D.play()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
	pass # Replace with function body.
