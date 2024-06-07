extends CharacterBody2D

@export var speed = 100
@export var jumpSpeed = 250
@export var maxHealth = 10

var currentHealth
var isMoving = false
var changeMove = 100

const GRAVITY = 400.0

# Called when the node enters the scene tree for the first time.
func _ready():
	currentHealth = maxHealth
	pass # Replace with function body.

func _process(delta):
	
	velocity.y += delta * GRAVITY
	
	if(isMoving == false):
		changeMove = 100
		
		var randomDirection = randf_range(1,30)
		if(randomDirection >= 1 and randomDirection <= 5):
			velocity.x = -speed
			isMoving = true
		elif(randomDirection >= 6 and randomDirection <= 10):
			velocity.x = speed
			isMoving = true
		elif(randomDirection >= 11 and randomDirection <= 20):
			velocity.x = 0
			isMoving = true
		else:
			velocity.y = -jumpSpeed
	
		move_and_slide()
	else:
		move_and_slide()
		changeMove -= 1
		if(changeMove == 0):
			isMoving = false

func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		body.changeHealth(-5)
	pass # Replace with function body.

func changeHealth(changeValue):
	currentHealth += changeValue
	if(currentHealth <= 0):
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		self.queue_free()
