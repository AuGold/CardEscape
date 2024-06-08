extends Node2D

@export var enemiesToSpawn = 10
var enemiesCreated = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.currentHealth = $Player.maxHealth
	$Player.find_child("HPBar").value = $Player.currentHealth
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(enemiesToSpawn > 0):
		enemiesToSpawn -= 1
		var enemyNode = $ExampleEnemy.duplicate()
		enemyNode.position = Vector2($ExampleEnemy.position.x + (70* enemiesCreated), $ExampleEnemy.position.y)
		add_child(enemyNode)
		enemiesCreated += 1
	
	pass


func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		get_tree().change_scene_to_file("res://level_2.tscn")
		
		pass # Replace with function body.
