extends Node2D

onready var timerTimer: Timer = $Timer

var fltIntervaloGerar: float = 8
var blnPodeAtacar: bool = false

var arrayTropasNivel_1: Array = [
	preload("res://prefabs/tropas/Abelha.tscn"),
	preload("res://prefabs/tropas/Cao.tscn"),
	preload("res://prefabs/tropas/Cavaleiro.tscn"),
	preload("res://prefabs/tropas/Lobisomen.tscn"),
	preload("res://prefabs/tropas/Mago.tscn"),
	preload("res://prefabs/tropas/MedusaBranca.tscn"),
	preload("res://prefabs/tropas/Orc.tscn"),
	preload("res://prefabs/tropas/Ratazana.tscn"),
	preload("res://prefabs/tropas/Slime.tscn")
]
var arrayTropasNivel_2: Array = [
	preload("res://prefabs/tropas/Cavaleiro.tscn"),
	preload("res://prefabs/tropas/Lobisomen.tscn"),
	preload("res://prefabs/tropas/Mago.tscn"),
	preload("res://prefabs/tropas/MedusaBranca.tscn"),
	preload("res://prefabs/tropas/Orc.tscn"),
	preload("res://prefabs/tropas/Ratazana.tscn"),
	preload("res://prefabs/tropas/Slime.tscn")
]
var arrayTropasNivel_3: Array = [
	preload("res://prefabs/tropas/Cavaleiro.tscn"),
	preload("res://prefabs/tropas/Lobisomen.tscn"),
	preload("res://prefabs/tropas/Mago.tscn"),
	preload("res://prefabs/tropas/MedusaBranca.tscn"),
	preload("res://prefabs/tropas/Ratazana.tscn"),
]
var arrayTropas: Array = [
	arrayTropasNivel_1,
	arrayTropasNivel_2,
	arrayTropasNivel_3
]

func _ready():
	timerTimer.start(fltIntervaloGerar * (Global.intGameDificuldade +2))


func _on_Timer_timeout():
	var torresPerdidas: int = Global.intTorresInimigasDerrubadas if Global.intTorresInimigasDerrubadas > 0 else 1
	var tempo: float = (fltIntervaloGerar / Global.intGameDificuldade) / torresPerdidas
	
	var index: int = Global.RNG.randi_range(0, arrayTropas[Global.intTorresInimigasDerrubadas].size()-1)
	var auxTropa = arrayTropas[Global.intTorresInimigasDerrubadas][index].instance()
	auxTropa.blnInimigo = true
	Global.nodeGameCena.call_deferred("add_child", auxTropa)
	var x: int = Global.RNG.randi_range(600, 920)
	var y: int = Global.RNG.randi_range(190, 420)
	auxTropa.global_position = Vector2(x, y)
	
	timerTimer.start(tempo)
