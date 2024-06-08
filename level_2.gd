extends Node2D

@export var basicEnemiesToSpawn = 15
@export var freezeEnemiesToSpawn = 10
var enemiesCreated = 1

func _ready():
	
	ChangeScenes.getVars($Player)
	$Player.find_child("HPBar").value = $Player.currentHealth
	
	await TextBoxes.popUpText("Hello Rover-" + str(TextBoxes.roverNumber) + " it looks like you planted one of the saplings. We're proud of you!")
	await TextBoxes.popUpText("Something happened to you while you were underground, we're reading higher than usual energy output. Give yourself a scan when you can, just to verify our readings.")
	await TextBoxes.popUpText("Now that you've made it to this plateau, we are reading new enemies present. Their body temperature is massively low, so be on the lookout for them!")
	await TextBoxes.popUpText("Good luck Rover-" + str(TextBoxes.roverNumber) + ". We're all counting on you.")
	TextBoxes.find_child("TextLayer").visible = false
	
	$Player.isActive = true
	spawnEnemies()

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
