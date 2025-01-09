extends KinematicBody2D

export var intVelocidade: int = 2000
export var intDano: int = 1
export var areaDano: NodePath
export var intDistanciaMinAlvo: int = 5
export var blnInimigo: bool = false
export var intScore: int = 3

onready var onrdSprite: AnimatedSprite = $sprite
onready var onrdVisao: Area2D = $Visao

var vctDirecao: Vector2 = Vector2.ZERO
var knbAlvo = null
var stbAlvo: StaticBody2D = null
var Alvo = null
var blnAtacando: bool = false


func _ready():
	$Spaw.play()
	if not blnInimigo:
		self.collision_layer = 2
		onrdVisao.collision_mask = 4
		get_node(areaDano).collision_mask = 8196
		get_torreAtaque()
	else:
		self.modulate = Color8(255, 155, 155)
		self.collision_layer = 4
		onrdVisao.collision_mask = 2
		get_node(areaDano).collision_mask = 3
		get_torreAtaque()


func _physics_process(delta):
	Alvo = null
	
	if (knbAlvo == null or not is_instance_valid(knbAlvo)) and \
	stbAlvo != null and is_instance_valid(stbAlvo):
		Alvo = stbAlvo
		vctDirecao = self.global_position.direction_to(stbAlvo.global_position)
	elif knbAlvo != null and is_instance_valid(knbAlvo):
		Alvo = knbAlvo
		vctDirecao = self.global_position.direction_to(knbAlvo.global_position)
	else:
		get_torreAtaque()
		vctDirecao = Vector2.ZERO
	
	if Alvo != null and Global.distancia_para(self.global_position, Alvo.global_position) > intDistanciaMinAlvo:
		self.move_and_slide(vctDirecao * delta * intVelocidade)
	else:
		self.global_position = self.global_position


func get_torreAtaque():
	var distancia: float = 0
	var index: int = 0
	if not blnInimigo and Global.arrayTorresInimigas.size() > 0:
		for torre in Global.arrayTorresInimigas:
			if is_instance_valid(torre):
				if distancia == 0:
					distancia = self.global_position.distance_to(torre.global_position)
				elif distancia > self.global_position.distance_to(torre.global_position):
					distancia = self.global_position.distance_to(torre.global_position)
					index = Global.arrayTorresInimigas.find(torre)
		
		stbAlvo = Global.arrayTorresInimigas[index]
	elif Global.arrayTorresAliadas.size() > 0:
		for torre in Global.arrayTorresAliadas:
			if is_instance_valid(torre):
				if distancia == 0:
					distancia = self.global_position.distance_to(torre.global_position)
				elif distancia > self.global_position.distance_to(torre.global_position):
					distancia = self.global_position.distance_to(torre.global_position)
					index = Global.arrayTorresAliadas.find(torre)
		
		stbAlvo = Global.arrayTorresAliadas[index]


func _on_sprite_animation_finished():
	if vctDirecao == Vector2.ZERO:
		onrdSprite.stop()
		onrdSprite.play("default")
		onrdSprite.frame = 0
	else:
		if blnInimigo:
			onrdSprite.flip_h = true if vctDirecao.x > 0 else false
		else:
			onrdSprite.flip_h = false if vctDirecao.x > 0 else true
		
		onrdSprite.play("default")
		onrdSprite.frame = 0
