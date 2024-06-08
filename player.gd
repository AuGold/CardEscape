extends CharacterBody2D

signal hit

@export var speedValue = 200
@export var jumpSpeed = 0
@export var maxHealth = 0
@export var attackDamage = 0

var speed
var screenSize
var currentHealth = 0
var facing = "right"
var didFire = false
var fireTime = 50
var punchesObtained = 0
var enemiesKilled = 0
var bulletsFired = 1
var gameOverFired = false
var frozen = false
var frozenTimer = 0
var ability = "bullet"
var addX = 60
var whipActive = false
var currentWhip

var bullet = preload("res://bullet.tscn")
var deathScreen = preload("res://game_over.tscn")
var whip = preload("res://whip.tscn")
const GRAVITY = 400.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	screenSize = get_viewport().get_visible_rect().size
	$CanvasLayer/HPBar.max_value = maxHealth
	$CanvasLayer/HPBar.value = currentHealth
	speed = speedValue
	$AnimatedSprite2D.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	velocity.y += delta * GRAVITY
	
	if Input.is_action_pressed("goRight"):
		velocity.x = speed
		facing = "right"
		$AnimatedSprite2D.flip_h = false
		addX = 60
		$AnimatedSprite2D.play("default")
	elif Input.is_action_pressed("goLeft"):
		velocity.x = -speed
		facing = "left"
		$AnimatedSprite2D.flip_h = true
		addX = -60
		$AnimatedSprite2D.play("default")
	else:
		velocity.x = 0
		$AnimatedSprite2D.stop()
		
	#if is_on_floor() and Input.is_action_pressed("jump"):
		#velocity.y -= jumpSpeed
		
	#if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
		#$AnimatedSprite2D.play()
	#else:
		#null
		#$AnimatedSprite2D.stop()
		
	move_and_slide()
	var w = whip.instantiate()
	
	if Input.is_action_pressed("fire") and didFire == false and ability == "bullet":
		var rotated = 0
		if(facing == "left"):
			rotated = PI
		for n in bulletsFired:
			var b = bullet.instantiate()
			b.position = Vector2(self.position.x + addX, self.position.y)
			b.rotation = rotated
			b.visible = true
			b.velocity = Vector2(speedValue+50, 0).rotated(b.rotation)
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
	
	if Input.is_action_pressed("fire") and whipActive == false and ability == "whip":
		whipActive = true
		var rotated = 0
		if(facing == "left"):
			rotated = PI
		w.position = Vector2(self.position.x + addX, self.position.y)
		w.rotation = rotated
		w.visible = true
		w.bulletOwner = self
		w.damage = attackDamage
		w.addX = addX
		get_tree().root.add_child(w)
		whipActive = true
		currentWhip = w
		await get_tree().create_timer(2.0).timeout
		w.queue_free()
		whipActive = false
	
	if(whipActive):
		currentWhip.addX = addX
			
	if(frozen):
		frozenTimer -= 1
		if(fmod(frozenTimer, 60) == 0):
			changeHealth(-1)
		if(frozenTimer == 0):
			frozen = false
			speed = speedValue
	pass

func changeHealth(changeValue):
	currentHealth += changeValue
	self.modulate = Color8(255,0,0)
	if(currentHealth <=0 && gameOverFired == false):
		gameOver()
		gameOverFired = true
	$CanvasLayer/HPBar.value = currentHealth
	await get_tree().create_timer(0.5).timeout
	self.modulate = Color8(255,255,255,255)
	

func killedBoss():
	punchesObtained += 1
	if(punchesObtained == 1):
		bulletsFired += 1

func freezeMove(number):
	if(frozen == false):
		frozen = true
		frozenTimer = 60*number
		speed = 0

func gameOver():
	hide()
	#$CollisionShape2D.set_deferred("disabled", true)
	#self.queue_free()
	var done = deathScreen.instantiate()
	done.find_child("CardPunched").text = "You got your card punched " + str(punchesObtained) + " times!"
	done.find_child("EnemiesKilled").text = "You killed " + str(enemiesKilled) + " enemies!"
	done.playerNode = self
	get_tree().root.add_child(done)
	pass
