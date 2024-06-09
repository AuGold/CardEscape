extends CharacterBody2D

@export var speed = 100
@export var jumpSpeed = 250
@export var maxHealth = 10

var currentHealth
var isMoving = false
var changeMove = 100
var isBurrowed = false
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
	
	stayBurrowed -= 1
	if(isBurrowed == false):
		velocity.y += delta * GRAVITY
	
	if(isMoving == false):
		changeMove = 100
		
		
		var randomDirection = randf_range(1,50)
		if(randomDirection >= 1 and randomDirection <= 10 and canGoLeft):
			velocity.x = -speed
			isMoving = true
			$AnimatedSprite2D.play("default")
			$AnimatedSprite2D.flip_h = false
			facing = "left"
			canGoRight = true
		elif(randomDirection >= 11 and randomDirection <= 20 and canGoRight):
			velocity.x = speed
			isMoving = true
			$AnimatedSprite2D.play("default")
			$AnimatedSprite2D.flip_h = true
			facing = "right"
			canGoLeft = true
		elif(randomDirection >= 21 and randomDirection <= 30):
			velocity.x = 0
			isMoving = true
			$AnimatedSprite2D.stop()
		elif(randomDirection >= 31 && randomDirection <= 40 && isBurrowed == false):
			velocity.y = -jumpSpeed
			$AnimatedSprite2D.play("default")
		else:
			if(isBurrowed == false):
				velocity.x = 0
				#position.y += 200
				speed = 300
				isBurrowed = true
				$AnimatedSprite2D.stop()
				$AnimatedSprite2D.visible = false
				$Area2D/CollisionShape2D.set_deferred("disabled", true)
				$CollisionShape2D.set_deferred("disabled", true)
				$Sprite2D.visible = true
				stayBurrowed = 120
			elif(stayBurrowed < 0):
				velocity.x = 0
				#position.y -= 200
				isBurrowed = false
				speed = 100
				$AnimatedSprite2D.stop()
				isMoving = true
				$AnimatedSprite2D.visible = true
				$Area2D/CollisionShape2D.set_deferred("disabled", false)
				$CollisionShape2D.set_deferred("disabled", false)
				$Sprite2D.visible = false
	
		move_and_slide()
	else:
		move_and_slide()
		changeMove -= 1
		if(changeMove == 0):
			isMoving = false

func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		body.changeHealth(-8)
		body.freezeMove(3)
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
		

func _on_burrowed_area_body_entered(body):
	velocity.x = 0
	if(facing == "right"):
		canGoRight = false
	if(facing == "left"):
		canGoLeft = false
	pass # Replace with function body.
