extends CharacterBody2D

signal hit

@export var speedValue = 200
@export var jumpSpeed = 0
@export var maxHealth = 0
@export var attackDamage = 0

var isActive = false

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
var addX = 25
var infrontValue = addX
var bulletSpeed = speedValue

var bullet = preload("res://bullet.tscn")
var deathScreen = preload("res://game_over.tscn")
const GRAVITY = 400.0

# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport().get_visible_rect().size
	$CanvasLayer/HPBar.max_value = maxHealth
	$CanvasLayer/HPBar.value = currentHealth
	speed = speedValue
	$AnimatedSprite2D.play("landing")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	velocity.y += delta * GRAVITY
	
	if(isActive):
		
		if Input.is_action_pressed("goRight"):
			velocity.x = speed
			facing = "right"
			$AnimatedSprite2D.flip_h = false
			addX = infrontValue
			$AnimatedSprite2D.play("default")
		elif Input.is_action_pressed("goLeft"):
			velocity.x = -speed
			facing = "left"
			$AnimatedSprite2D.flip_h = true
			addX = -infrontValue
			$AnimatedSprite2D.play("default")
		else:
			velocity.x = 0
			$AnimatedSprite2D.pause()
		
		if Input.is_action_pressed("fire") and didFire == false and ability == "bullet":
			var rotated = 0
			if(facing == "left"):
				rotated = PI
			for n in bulletsFired:
				var b = bullet.instantiate()
				b.position = Vector2(self.position.x + addX, self.position.y)
				b.rotation = rotated
				b.visible = true
				b.velocity = Vector2(bulletSpeed+50, 0).rotated(b.rotation)
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
				
		if(frozen):
			frozenTimer -= 1
			if(fmod(frozenTimer, 60) == 0):
				changeHealth(-1)
			if(frozenTimer == 0):
				frozen = false
				speed = speedValue
	
	move_and_slide()
	
	pass
	

func changeHealth(changeValue):
	currentHealth += changeValue
	if(currentHealth > 0):
		self.modulate = Color8(255,0,0)
	if(currentHealth <=0 && gameOverFired == false):
		gameOver()
		gameOverFired = true
	$CanvasLayer/HPBar.value = currentHealth
	await get_tree().create_timer(0.5).timeout
	self.modulate = Color8(255,255,255,255)

func killedBoss():
	isActive = false
	velocity.x = 0
	$AudioStreamPlayer2D.stop()
	
	punchesObtained += 1
	if(punchesObtained == 1):
		$PunchCard.texture = load("res://assests/Punch1.png")
		bulletsFired += 1
		await TextBoxes.popUpText("Rover-" + str(TextBoxes.roverNumber) + "! If you can hear this, your current location is perfect to plant the first sapling. Activate planting protocol!")
		$AnimatedSprite2D.play("plantTree")
		$AudioStreamPlayer2D.stream = load("res://sounds/plantTree.mp3")
		$AudioStreamPlayer2D.play()
		await TextBoxes.popUpText("Excellent job Rover-" + str(TextBoxes.roverNumber) + "! It looks like you planted your first sapling.")
		$PunchCard.visible = true
		await TextBoxes.popUpText("Your Sapling Punch Card should have filled out the first slot. This should augment your rover for the rest of the mission.")
		await TextBoxes.popUpText("Keep going Rover-" +str(TextBoxes.roverNumber) + ". We're all counting on you.")
		$PunchCard.visible = false
		
		get_tree().current_scene.showTree()
		
		await get_tree().create_timer(3).timeout
		
		ChangeScenes.changeScenes(isActive, currentHealth, punchesObtained, enemiesKilled, bulletsFired, ability, bulletSpeed, attackDamage)
		get_tree().change_scene_to_file("res://levels/level_2.tscn")
	if(punchesObtained == 2):
		$PunchCard.texture = load("res://assests/Punch2.png")
		bulletSpeed += 200
		await TextBoxes.popUpText("Rover-" + str(TextBoxes.roverNumber) + "! If you can hear this, your current location is perfect to plant the second sapling. Activate planting protocol!")
		$AnimatedSprite2D.play("plantTree")
		$AudioStreamPlayer2D.stream = load("res://sounds/plantTree.mp3")
		$AudioStreamPlayer2D.play()
		await TextBoxes.popUpText("Excellent job Rover-" + str(TextBoxes.roverNumber) + "! It looks like you planted your second sapling.")
		$PunchCard.visible = true
		await TextBoxes.popUpText("Your Sapling Punch Card should have filled out the second slot. This should augment your rover for the rest of the mission.")
		await TextBoxes.popUpText("Keep going Rover-" +str(TextBoxes.roverNumber) + ". We're all counting on you.")
		$PunchCard.visible = false
		get_tree().current_scene.showTree()
		
		await get_tree().create_timer(3).timeout
		
		ChangeScenes.changeScenes(isActive, currentHealth, punchesObtained, enemiesKilled, bulletsFired, ability, bulletSpeed, attackDamage)
		get_tree().change_scene_to_file("res://levels/level_3.tscn")
	if(punchesObtained == 3):
		$PunchCard.texture = load("res://assests/Punch3.png")
		attackDamage += 10
		await TextBoxes.popUpText("Rover-" + str(TextBoxes.roverNumber) + "! If you can hear this, your current location is perfect to plant the third sapling. Activate planting protocol!")
		$AnimatedSprite2D.play("plantTree")
		$AudioStreamPlayer2D.stream = load("res://sounds/plantTree.mp3")
		$AudioStreamPlayer2D.play()
		await TextBoxes.popUpText("Excellent job Rover-" + str(TextBoxes.roverNumber) + "! It looks like you planted your third sapling.")
		$PunchCard.visible = true
		await TextBoxes.popUpText("Your Sapling Punch Card should have filled out the third slot. This should augment your rover for the rest of the mission.")
		await TextBoxes.popUpText("Keep going Rover-" +str(TextBoxes.roverNumber) + ". We're all counting on you.")
		$PunchCard.visible = false
		get_tree().current_scene.showTree()
		
		await get_tree().create_timer(3).timeout
		ChangeScenes.changeScenes(isActive, currentHealth, punchesObtained, enemiesKilled, bulletsFired, ability, bulletSpeed, attackDamage)
		get_tree().change_scene_to_file("res://levels/level_4.tscn")
	if(punchesObtained == 4):
		$PunchCard.texture = load("res://assests/Punch4.png")
		await TextBoxes.popUpText("Rover-" + str(TextBoxes.roverNumber) + "! If you can hear this, your current location is perfect to plant the last sapling. Activate planting protocol!")
		$AnimatedSprite2D.play("plantTree")
		$AudioStreamPlayer2D.stream = load("res://sounds/plantTree.mp3")
		$AudioStreamPlayer2D.play()
		await TextBoxes.popUpText("Excellent job Rover-" + str(TextBoxes.roverNumber) + "! It looks like you planted every sapling!")
		$PunchCard.visible = true
		#do something else
		TextBoxes.pressedMouse
		$PunchCard.visible = false
		get_tree().current_scene.showTree()
		
		await get_tree().create_timer(3).timeout

func freezeMove(number):
	if(frozen == false):
		frozen = true
		frozenTimer = 60*number
		speed = 0

func gameOver():
	$AnimatedSprite2D.visible = false
	#$CollisionShape2D.set_deferred("disabled", true)
	#self.queue_free()
	var done = deathScreen.instantiate()
	
	TextBoxes.roverNumber += 1
	isActive = false
	velocity.x = 0
	
	$PunchCard.visible = true
	done.find_child("EnemiesKilled").text = "You killed " + str(enemiesKilled) + " enemies!"
	done.playerNode = self
	get_tree().root.add_child(done)
	pass
