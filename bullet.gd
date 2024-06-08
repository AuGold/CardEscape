extends Area2D

var bulletOwner
var damage
var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	position += velocity * delta
	pass

func _on_area_2d_body_entered(body):
	if(body.name == "TileMap"):
		$CollisionPolygon2D.set_deferred("disabled", true)
		hide()
		self.queue_free()
	else:
		for group in body.get_groups():
			if(group == "Enemy"):
				$CollisionPolygon2D.set_deferred("disabled", true)
				body.changeHealth(-damage, bulletOwner)
				hide()
				self.queue_free()


func _on_body_entered(body):
	if(body.name == "FrontTileMap"):
		$CollisionShape2D.set_deferred("disabled", true)
		hide()
		self.queue_free()
	else:
		for group in body.get_groups():
			if(group == "Enemy"):
				$CollisionShape2D.set_deferred("disabled", true)
				body.changeHealth(-damage, bulletOwner)
				hide()
				self.queue_free()
	pass # Replace with function body.
