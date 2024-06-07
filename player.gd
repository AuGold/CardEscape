extends CharacterBody2D

signal hit

@export var speed = 0
@export var jumpSpeed = 0
@export var maxHealth = 0
@export var attackDamage = 0
var screenSize
var currentHealth = 0
var facing = "right"
var didFire = false
var fireTime = 50
var punchesObtained = 0
var enemiesKilled = 0
var bulletsFired = 1

var bullet = preload("res://bullet.tscn")
var deathScreen = preload("res://game_over.tscn")
const GRAVITY = 400.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	screenSize = get_viewport().get_visible_rect().size
	$CanvasLayer/HPBar.max_value = maxHealth
	$CanvasLayer/HPBar.value = currentHealth
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	velocity.y += delta * GRAVITY
	
	if Input.is_action_pressed("goRight"):
		velocity.x = speed
		facing = "right"
	elif Input.is_action_pressed("goLeft"):
		velocity.x = -speed
		facing = "left"
	else:
		velocity.x = 0
		
	#if is_on_floor() and Input.is_action_pressed("jump"):
		#velocity.y -= jumpSpeed
		
	#if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
		#$AnimatedSprite2D.play()
	#else:
		#null
		#$AnimatedSprite2D.stop()
		
	move_and_slide()
	
	if Input.is_action_pressed("fire") and didFire == false:
		var addX
		var rotated = 0
		if(facing == "right"):
			addX = 60
		if(facing == "left"):
			addX = -60
			rotated = PI
		for n in bulletsFired:
			var b = bullet.instantiate()
			b.position = Vector2(self.position.x + addX, self.position.y)
			b.rotation = rotated
			b.visible = true
			b.velocity = Vector2(speed+50, 0).rotated(b.rotation)
			b.bulletOwner = self
			b.damage = attackDamage
			get_tree().root.add_child(b)
			didFire = true
			await get_tree().create_timer(0.1).timeout
		
	if(didFire == true):
		fireTime -= 1
		if(fireTime == 0):
			didFire = false
			fireTime = 50
	pass

func changeHealth(changeValue):
	currentHealth += changeValue
	if(currentHealth <=0):
		gameOver()
	$CanvasLayer/HPBar.value = currentHealth
	

func killedBoss():
	punchesObtained += 1
	if(punchesObtained == 1):
		bulletsFired += 1

func gameOver():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	self.queue_free()
	var done = deathScreen.instantiate()
	done.find_child("CardPunched").text = "You got your card punched " + str(punchesObtained) + " times!"
	done.find_child("EnemiesKilled").text = "You killed " + str(enemiesKilled) + " enemies!"
	get_tree().root.add_child(done)
	pass
