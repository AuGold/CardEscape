extends Node

var isActive
var currentHealth
var punchesObtained
var enemiesKilled
var bulletsFired
var ability

func changeScenes(tempIsActive, tempHealth, tempPunches, tempKills, tempBullets, tempAbility):
	isActive = tempIsActive
	currentHealth = tempHealth
	punchesObtained = tempPunches
	enemiesKilled = tempKills
	bulletsFired = tempBullets
	ability = tempAbility
	pass

func getVars(node):
	node.isActive = isActive
	node.currentHealth = currentHealth
	node.punchesObtained = punchesObtained
	node.enemiesKilled = enemiesKilled
	node.bulletsFired = bulletsFired
	node.ability = ability
