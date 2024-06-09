extends Node

var isActive
var currentHealth
var punchesObtained
var enemiesKilled
var bulletsFired
var ability
var bulletSpeed
var attackDamage
var cardTexture
var bulletTexture

func changeScenes(tempIsActive, tempHealth, tempPunches, tempKills, tempBullets, tempAbility, tempBSpeed, tempDamage, tempCard, tempBullet):
	isActive = tempIsActive
	currentHealth = tempHealth
	punchesObtained = tempPunches
	enemiesKilled = tempKills
	bulletsFired = tempBullets
	ability = tempAbility
	bulletSpeed = tempBSpeed
	attackDamage = tempDamage
	cardTexture = tempCard
	bulletTexture = tempBullet
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
	node.cardTexture = cardTexture
	node.bulletTexture = bulletTexture
