extends CanvasLayer

var playerNode

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
	playerNode.queue_free()
	self.queue_free()
	pass # Replace with function body.
