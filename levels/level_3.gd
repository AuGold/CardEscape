extends Node2D

@export var basicEnemiesToSpawn = 5
@export var freezeEnemiesToSpawn = 5
@export var burrowEnemiesToSpawn = 10
var enemiesCreated = 1

func _ready():
	
	ChangeScenes.getVars($Player)
	$Player.find_child("HPBar").value = $Player.currentHealth
	
	await TextBoxes.popUpText("Keep going Rover-" + str(TextBoxes.roverNumber) + "!")
	await TextBoxes.popUpText("Now that you've made it to this plateau, we are reading new life forms present. They seem to burrow underground, so keep an eye out!")
	await TextBoxes.popUpText("Good luck Rover-" + str(TextBoxes.roverNumber) + ". We're all counting on you.")
	TextBoxes.find_child("TextLayer").visible = false
	
	$Player.isActive = true
	$Player.find_child("AudioStreamPlayer2D").stream = load("res://sounds/Game_Background.wav")
	$Player.find_child("AudioStreamPlayer2D").play()
	spawnEnemies()
	$BlockingTile.queue_free()

func spawnEnemies():
	for n in basicEnemiesToSpawn:
		var enemyNode = $ExampleEnemy.duplicate()
		enemyNode.position = Vector2($ExampleEnemy.position.x + (30* enemiesCreated), $ExampleEnemy.position.y)
		add_child(enemyNode)
		enemiesCreated += 1
	
	enemiesCreated = 1
	for n in freezeEnemiesToSpawn:
		var enemyNode = $FreezeEnemy.duplicate()
		enemyNode.position = Vector2($FreezeEnemy.position.x + (30* enemiesCreated), $FreezeEnemy.position.y)
		add_child(enemyNode)
		enemiesCreated += 1
	
	enemiesCreated = 1
	for n in burrowEnemiesToSpawn:
		var enemyNode = $BurrowEnemy.duplicate()
		enemyNode.position = Vector2($BurrowEnemy.position.x + (30* enemiesCreated), $BurrowEnemy.position.y)
		add_child(enemyNode)
		enemiesCreated += 1

func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		$Player.isActive = false
		ChangeScenes.changeScenes($Player.isActive, $Player.currentHealth, $Player.punchesObtained, $Player.enemiesKilled, $Player.bulletsFired, $Player.ability, $Player.bulletSpeed, $Player.attackDamage, $Player.cardTexture, $Player.bulletTexture)
		get_tree().change_scene_to_file("res://levels/third_boss_stage.tscn")
		
		pass # Replace with function body.
