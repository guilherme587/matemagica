extends Node

var RNG: RandomNumberGenerator = RandomNumberGenerator.new()
var nodeAlgoritimoMatematico: Node2D = null
var nodeGameCena: Node2D = null
var intGameDificuldade: int = 1
var blnErrou: bool = false
var UIDeck: CanvasLayer = null
var arrayTorresInimigas: Array
var intTorresInimigasDerrubadas: int = 0
var arrayTorresAliadas: Array


func _ready():
	self.pause_mode = Node.PAUSE_MODE_PROCESS
	RNG.randomize()


func _physics_process(delta):
	if intTorresInimigasDerrubadas >= 3:
		get_tree().paused = true


func distancia_para(vec1: Vector2, vec2: Vector2) -> int:
	var resultado: int = 0
	
	resultado = sqrt(
		pow(
			vec1.x - vec2.x, 2
		) +
		pow(
			vec1.y - vec2.y, 2
		)
	)
	
	return resultado
