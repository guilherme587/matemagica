extends Node

var RNG: RandomNumberGenerator = RandomNumberGenerator.new()
var nodeAlgoritimoMatematico: Node2D = null
var nodeGameCena: Node2D = null
var intGameDificuldade: int = 1
var blnErrou: bool = false
var UIDeck: CanvasLayer = null
var arrayTorresInimigas: Array
var intTorresInimigasDerrubadas: int = 0
var intTorresAliadasDerrubadas: int = 0
var arrayTorresAliadas: Array
var intAcertos: int = 0
var intErros: int = 0
var intTempoInicial: int = 0
var intTempo: int = 0
var intInimigosMortos: int = 0


func _ready():
	self.pause_mode = Node.PAUSE_MODE_PROCESS
	RNG.randomize()


func reiniciar():
	RNG = RandomNumberGenerator.new()
	nodeAlgoritimoMatematico = null
	nodeGameCena = null
	intGameDificuldade = 1
	blnErrou = false
	UIDeck = null
	arrayTorresInimigas = []
	intTorresInimigasDerrubadas = 0
	intTorresAliadasDerrubadas = 0
	arrayTorresAliadas = []
	intAcertos = 0
	intErros = 0
	intTempoInicial = 0
	intTempo = 0
	intInimigosMortos = 0


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
