extends Node2D

export var fltVida: float = 5

var pckdTorreDestruida: PackedScene = preload("res://prefabs/torres/TorreDestruida.tscn")

func _ready():
	pass
	
	
func hitted(dano: float) -> void:
	if $MorteTorre.is_playing() or $MorteTropa.is_playing():
		return
	
	fltVida -= dano
	
	if fltVida <= 0:
		if "Torre" in self.get_parent().name:
			for i in range(1):
				$MorteTorre.play()
				yield($MorteTorre, "finished")
			
			var aux = pckdTorreDestruida.instance()
			Global.nodeGameCena.add_child(aux)
			aux.global_position = self.get_parent().global_position
			
			if self.get_parent().blnInimigo:
				Global.intTorresInimigasDerrubadas += 1
				Global.arrayTorresInimigas.erase(self.get_parent())
			else:
				Global.intTorresAliadasDerrubadas += 1
				Global.arrayTorresAliadas.erase(self.get_parent())
		else:
			if self.get_parent().blnInimigo:
				Global.intInimigosMortos += self.get_parent().intScore
			
			for i in range(1):
				$MorteTropa.play()
				yield($MorteTropa, "finished")
#
		self.get_parent().call_deferred("queue_free")
