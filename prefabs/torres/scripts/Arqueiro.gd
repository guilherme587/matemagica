extends KinematicBody2D

export var fltTempoEsfriar: float = 1.2
export var intDano: float = 1
export var blnInimigo: bool = false

onready var onrdVisao: Area2D = $Visao

var pckdFlecha: PackedScene = preload("res://prefabs/torres/Flecha.tscn")
var knbAlvo: KinematicBody2D = null
var blnPodeAtacar: bool = true
var fltTempoPassado: float = 0


func _ready():
	if blnInimigo:
		onrdVisao.collision_mask = 2
	else:
		onrdVisao.collision_mask = 4


func _physics_process(delta):
	if fltTempoPassado >= fltTempoEsfriar:
		fltTempoPassado = 0
		blnPodeAtacar = true
	if blnPodeAtacar and knbAlvo != null and is_instance_valid(knbAlvo):
		blnPodeAtacar = false
		ataque()
	
	fltTempoPassado += delta



func ataque():
	var aux = pckdFlecha.instance()
	aux.blnInimigo = blnInimigo
	aux.intDano = intDano
	Global.nodeGameCena.add_child(aux)
	aux.global_position = self.global_position
	aux.vctDirecao = self.global_position.direction_to(knbAlvo.global_position)
