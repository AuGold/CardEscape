extends CharacterBody2D

signal hit

@export var speed = 0
@export var jumpSpeed = 0
@export var maxHealth = 0
var screenSize
var currentHealth = 0
var facing = "right"
var didFire = false
var fireTime = 100

var bullet = preload("res://bullet.tscn")
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
		var b = bullet.instantiate()
		var addX
		if(facing == "right"):
			addX = 60
		if(facing == "left"):
			addX = -60
			b.rotation = PI
		b.position = Vector2(self.position.x + addX, self.position.y)
		b.visible = true
		b.velocity = Vector2(speed+50, 0).rotated(b.rotation)
		get_tree().root.add_child(b)
		didFire = true
		
	if(didFire == true):
		fireTime -= 1
		if(fireTime == 0):
			didFire = false
			fireTime = 100
	pass

func changeHealth(changeValue):
	currentHealth += changeValue
	$CanvasLayer/HPBar.value = currentHealth
