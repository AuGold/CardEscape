extends CanvasLayer

signal pressedMouse

var roverNumber = 1

func popUpText(newText):
	self.find_child("Label").text = newText
	self.find_child("TextLayer").visible = true
	await pressedMouse
	pass

func _input(_event):
	if Input.is_action_just_released("click"):
		pressedMouse.emit()
