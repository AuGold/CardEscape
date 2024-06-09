extends CharacterBody2D

@export var speed = 100
@export var jumpSpeed = 250
@export var maxHealth = 10

var currentHealth
var isMoving = false
var changeMove = 100
var isBurrowed = false
var isBurrowing = false
var stayBurrowed = 0
var canGoRight = true
var canGoLeft = true
var facing = "right"

const GRAVITY = 400.0
@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	currentHealth = maxHealth
	$Area2D/BossHealth.max_value = maxHealth
	$Area2D/BossHealth.value = currentHealth
	pass # Replace with function body.

func _process(delta):
	
	if(isBurrowed == false):
		velocity.y += delta * GRAVITY
	
	stayBurrowed -= 1
	if(isMoving == false && isBurrowing == false):
		changeMove = 100
		
		var randomDirection = randf_range(1,30)
		if(randomDirection >= 1 and randomDirection <= 10):
			var directionToMove = player.position.x - self.position.x
			if(directionToMove < 0 and canGoLeft):
				velocity.x = -speed
				isMoving = true
				$AnimatedSprite2D.play("default")
				$AnimatedSprite2D.flip_h = true
				facing = "left"
				canGoRight = true
			elif(directionToMove > 0 and canGoRight):
				velocity.x = speed
				isMoving = true
				$AnimatedSprite2D.play("default")
				$AnimatedSprite2D.flip_h = false
				facing = "right"
				canGoLeft = true
		elif(randomDirection >= 11 and randomDirection <= 14):
			velocity.x = 0
			isMoving = true
			$AnimatedSprite2D.stop()
		else:
			print(stayBurrowed)
			if(isBurrowed == false):
				isBurrowing = true
				stayBurrowed = 120
				velocity.x = 0
				isBurrowed = true
				$BurrowArea/BurrowCollision.set_deferred("disabled", false)
				$AnimatedSprite2D.play("burrow")
				await get_tree().create_timer(1.6).timeout
				#position.y += 200
				$AnimatedSprite2D.visible = false
				$Area2D/CollisionShape2D.set_deferred("disabled", true)
				$CollisionShape2D.set_deferred("disabled", true)
				speed = 300
				isBurrowing = false
				$AnimatedSprite2D.stop()
				$BurrowArea/BurrowCollision.set_deferred("disabled", true)
				$BurrowSprite.visible = true
			elif(stayBurrowed < 0):
				velocity.x = 0
				#position.y -= 200
				speed = 100
				$AnimatedSprite2D.stop()
				isMoving = true
				$AnimatedSprite2D.visible = true
				$Area2D/CollisionShape2D.set_deferred("disabled", false)
				$CollisionShape2D.set_deferred("disabled", false)
				$BurrowSprite.visible = false
				isBurrowed = false
	
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
	$Area2D/BossHealth.visible = true
	currentHealth += changeValue
	$Area2D/BossHealth.value = currentHealth
	self.modulate = Color8(255,0,0)
	if(currentHealth <= 0):
		hide()
		node.killedBoss()
		$CollisionShape2D.set_deferred("disabled", true)
		self.queue_free()
	await get_tree().create_timer(0.5).timeout 
	self.modulate = Color8(255,255,255,255)
	

func _on_burrowed_area_body_entered(_body):
	velocity.x = 0
	if(facing == "right"):
		canGoRight = false
	if(facing == "left"):
		canGoLeft = false
	pass # Replace with function body.
