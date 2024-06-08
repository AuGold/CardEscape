extends Node2D


func _ready():
	ChangeScenes.getVars($Player)
	$Player.find_child("HPBar").value = $Player.currentHealth
	$Player.isActive = true
