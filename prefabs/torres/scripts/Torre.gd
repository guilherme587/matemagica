extends StaticBody2D

export var blnInimigo: bool = false
export var blnCenario: bool = true

func _ready():
	if not blnCenario:
		if blnInimigo:
			self.collision_layer = 8192
			Global.arrayTorresInimigas.append(self)
		else:
			self.collision_layer = 1
			Global.arrayTorresAliadas.append(self)
