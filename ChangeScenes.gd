extends Node

var isActive
var currentHealth
var punchesObtained
var enemiesKilled
var bulletsFired
var ability
var bulletSpeed
var attackDamage

func changeScenes(tempIsActive, tempHealth, tempPunches, tempKills, tempBullets, tempAbility, tempBSpeed, tempDamage):
	isActive = tempIsActive
	currentHealth = tempHealth
	punchesObtained = tempPunches
	enemiesKilled = tempKills
	bulletsFired = tempBullets
	ability = tempAbility
	bulletSpeed = tempBSpeed
	attackDamage = tempDamage
	pass

func getVars(node):
	node.isActive = isActive
	node.currentHealth = currentHealth
	node.punchesObtained = punchesObtained
	node.enemiesKilled = enemiesKilled
	node.bulletsFired = bulletsFired
	node.ability = ability
	node.bulletSpeed = bulletSpeed
	node.attackDamage = attackDamage
