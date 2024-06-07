extends CharacterBody2D

signal hit

@export var speed = 0
@export var jumpSpeed = 0
@export var maxHealth = 0
var screenSize
var currentHealth = 0

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
	elif Input.is_action_pressed("goLeft"):
		velocity.x = -speed
	else:
		velocity.x = 0
		
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y -= jumpSpeed
		
	#if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
		#$AnimatedSprite2D.play()
	#else:
		#null
		#$AnimatedSprite2D.stop()
		
	move_and_slide()
	
	pass

func changeHealth(changeValue):
	currentHealth += changeValue
	$CanvasLayer/HPBar.value = currentHealth