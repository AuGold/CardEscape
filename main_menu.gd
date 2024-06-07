extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://tutorial.tscn")
	
	pass # Replace with function body.



func _on_exit_pressed():
	get_tree().quit()
	pass # Replace with function body.
