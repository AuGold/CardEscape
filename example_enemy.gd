extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	if(body.name == "Player"):
		body.changeHealth(-5)
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		self.queue_free()
	pass # Replace with function body.
