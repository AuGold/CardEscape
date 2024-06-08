extends CharacterBody2D

@export var speed = 100
@export var jumpSpeed = 250
@export var maxHealth = 10

var currentHealth
var isMoving = false
var changeMove = 100
var playerTookDamage = false
var playerDamageTimer = 120

const GRAVITY = 400.0
@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	currentHealth = maxHealth
	$Area2D/BossHealth.max_value = maxHealth
	$Area2D/BossHealth.value = currentHealth
	pass # Replace with function body.

func _process(delta):
	
	playerDamageTimer -= 1
	if($Area2D.has_overlapping_bodies() == true && playerDamageTimer == 0):
		playerTookDamage = false
		for body in $Area2D.get_overlapping_bodies():
			_on_area_2d_body_entered(body)
	
	velocity.y += delta * GRAVITY
	
	
	if(isMoving == false):
		changeMove = 100
		
		var randomDirection = randf_range(1,30)
		if(randomDirection >= 1 and randomDirection <= 10):
			var directionToMove = player.position.x - self.position.x
			if(directionToMove < 0):
				velocity.x = -speed
				isMoving = true
				$AnimatedSprite2D.play("default")
			elif(directionToMove > 0):
				velocity.x = speed
				isMoving = true
				$AnimatedSprite2D.play("default")
		elif(randomDirection >= 11 and randomDirection <= 15):
			velocity.x = 0
			isMoving = true
			$AnimatedSprite2D.stop()
		else:
			velocity.y = -jumpSpeed
			$AnimatedSprite2D.stop()
	
		move_and_slide()
	else:
		move_and_slide()
		changeMove -= 1
		if(changeMove == 0):
			isMoving = false

func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		body.changeHealth(-5)
		playerTookDamage = true
		playerDamageTimer = 120
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
		
