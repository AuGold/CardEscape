extends CharacterBody2D

@export var speed = 100
@export var jumpSpeed = 250
@export var maxHealth = 10

var currentHealth
var isMoving = false
var changeMove = 100
var isBurrowed = false

signal finishedAnimation

const GRAVITY = 400.0

# Called when the node enters the scene tree for the first time.
func _ready():
	currentHealth = maxHealth
	$AnimatedSprite2D.stop()
	pass # Replace with function body.

func _process(_delta):
	
	#velocity.y += delta * GRAVITY
	
	if(isMoving == false):
		changeMove = 100
		
		var randomDirection = randf_range(1,30)
		if(randomDirection >= 1 and randomDirection <= 8):
			velocity.x = -speed
			isMoving = true
			$AnimatedSprite2D.play("default")
			$AnimatedSprite2D.flip_h = true
		elif(randomDirection >= 9 and randomDirection <= 16):
			velocity.x = speed
			isMoving = true
			$AnimatedSprite2D.play("default")
			$AnimatedSprite2D.flip_h = false
		elif(randomDirection >= 17 and randomDirection <= 24):
			velocity.x = 0
			isMoving = true
			$AnimatedSprite2D.stop()
		else:
			if(isBurrowed == false):
				velocity.x = 0
				$AnimatedSprite2D.stop()
				#position.y += 200
				$AnimatedSprite2D.visible = false
				$Area2D/CollisionShape2D.set_deferred("disabled", true)
				$CollisionShape2D.set_deferred("disabled", true)
				$BurrowSprite.visible = true
				speed = 300
				isBurrowed = true
			else:
				velocity.x = 0
				#position.y -= 200
				$AnimatedSprite2D.visible = true
				$Area2D/CollisionShape2D.set_deferred("disabled", false)
				$CollisionShape2D.set_deferred("disabled", false)
				$BurrowSprite.visible = false
				isBurrowed = false
				speed = 100
				$AnimatedSprite2D.stop()
				isMoving = true
	
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

func changeHealth(changeValue, node):
	currentHealth += changeValue
	self.modulate = Color8(255,0,0)
	if(currentHealth <= 0):
		hide()
		node.enemiesKilled += 1
		$CollisionShape2D.set_deferred("disabled", true)
		self.queue_free()
	await get_tree().create_timer(0.5).timeout 
	self.modulate = Color8(255,255,255,255)
