extends Node2D

@export var enemiesToSpawn = 10
var enemiesCreated = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	$Player.currentHealth = $Player.maxHealth
	$Player.find_child("HPBar").value = $Player.currentHealth
	
	await TextBoxes.popUpText("Hello Rover-" + str(TextBoxes.roverNumber) + " are you reading this? If so, click your mouse to send a message back to us.")
	await TextBoxes.popUpText("Glad to hear from you Rover-" + str(TextBoxes.roverNumber) + ". Are you prepared to start your mission on Mars?")
	await TextBoxes.popUpText("Great! Here at Cosmic Mana-Team we are hoping you can plant those saplings we placed within your cargo hold. To better facilitate your mission we sent with you a Sapling Punch Card.")
	await TextBoxes.popUpText("!!!!!!!Show the punch card here before release!!!!!!!")
	await TextBoxes.popUpText("As you progress around the surface of Mars and plant each sapling, your Sapling Punch Card will help you adapt to whatever you may find on your mission.")
	await TextBoxes.popUpText("Currently, we are reading in front of you signs of life, Rover-" + str(TextBoxes.roverNumber) + ". They appear to be tiny creatures who jump around. Be careful, if your hull becomes compromised prior to planting each sapling, your mission will result in a failure.")
	await TextBoxes.popUpText("If you must defend yourself, we provided you with tools to do so. Press the Spacebar on your rover and you'll be sure to take care of those creatures.")
	await TextBoxes.popUpText("Good luck, Rover-" + str(TextBoxes.roverNumber) + ". All of us here at Cosmic Mana-Team are counting on you!")
	TextBoxes.find_child("TextLayer").visible = false
	
	$Player.isActive = true
	spawnEnemies()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	
	pass

func spawnEnemies():
	for n in enemiesToSpawn:
		var enemyNode = $ExampleEnemy.duplicate()
		enemyNode.position = Vector2($ExampleEnemy.position.x + (30* enemiesCreated), $ExampleEnemy.position.y)
		add_child(enemyNode)
		enemiesCreated += 1

func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		$Player.isActive = false
		ChangeScenes.changeScenes($Player.isActive, $Player.currentHealth, $Player.punchesObtained, $Player.enemiesKilled, $Player.bulletsFired, $Player.ability)
		get_tree().change_scene_to_file("res://level_2.tscn")
		
		pass # Replace with function body.
