extends Node2D


func _ready():
	ChangeScenes.getVars($Player)
	$Player.find_child("HPBar").value = $Player.currentHealth
	$Player.isActive = true
	$Player.find_child("AudioStreamPlayer2D").stream = load("res://sounds/Boss.wav")
	$Player.find_child("AudioStreamPlayer2D").play()
