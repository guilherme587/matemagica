extends CanvasLayer


onready var onrdArrayPontosDeEnergia: Array = [
	$Cartas/BarraDeEnergia/Energia1,
	$Cartas/BarraDeEnergia/Energia2,
	$Cartas/BarraDeEnergia/Energia3,
	$Cartas/BarraDeEnergia/Energia4,
	$Cartas/BarraDeEnergia/Energia5,
	$Cartas/BarraDeEnergia/Energia6,
	$Cartas/BarraDeEnergia/Energia7,
	$Cartas/BarraDeEnergia/Energia8,
	$Cartas/BarraDeEnergia/Energia9,
	$Cartas/BarraDeEnergia/Energia10
]
onready var onrdArrayPosicaoCartas: Array = [
	$Cartas/Carta1/Position2D,
	$Cartas/Carta2/Position2D,
	$Cartas/Carta3/Position2D,
	$Cartas/Carta4/Position2D,
	$Cartas/Carta5/Position2D,
	$Cartas/Position2D
]
onready var lblQuestao: Label = $Questoes/ItemBox24X24/Questao

var pckdCarta: PackedScene = preload("res://prefabs/tropas/Carta.tscn")
var nodeProximaCarta: Node2D = null
var vlrPontosDeEnergia: int = 300


func _ready():
	Global.UIDeck = self
	MostrarPontos(vlrPontosDeEnergia)
	gerarCartas()


func gerarCartas(posicao: Vector2 = Vector2.ZERO) -> void:
	if posicao == Vector2.ZERO:
		for gerarCarta in 6:
			var carta = pckdCarta.instance()
			self.get_parent().call_deferred("add_child", carta)
			self.get_parent().call_deferred("remove_child", carta)
			self.get_node("Cartas").call_deferred("add_child", carta)
			carta.global_position = onrdArrayPosicaoCartas[gerarCarta].global_position - Vector2(36, 36)
			
			if gerarCarta == 5:
				carta.scale = Vector2(0.5, 0.5)
				carta.global_position = onrdArrayPosicaoCartas[gerarCarta].global_position - Vector2(18, 18)
				nodeProximaCarta = carta
	else:
		nodeProximaCarta.vctPontoGeracao = posicao
		nodeProximaCarta.scale = Vector2(0.75, 0.75)
		nodeProximaCarta.global_position = posicao
		
		var carta = pckdCarta.instance()
		self.get_parent().call_deferred("add_child", carta)
		self.get_parent().call_deferred("remove_child", carta)
		self.get_node("Cartas").call_deferred("add_child", carta)
		carta.scale = Vector2(0.5, 0.5)
		carta.global_position = onrdArrayPosicaoCartas[5].global_position - Vector2(18, 18)
		nodeProximaCarta = carta


func MostrarPontos(quantidade: int) -> void:
	for ponto in onrdArrayPontosDeEnergia:
		if quantidade > 0:
			ponto.visible = true
		else:
			ponto.visible = false
		
		quantidade -= 1
