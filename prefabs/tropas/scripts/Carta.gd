extends Node2D


onready var onrdColorRect: ColorRect = $ColorRect

var animSrtTropa: AnimatedSprite
var blnEmFoco: bool = false
var blnGerar: bool = false
var vctPontoGeracao: Vector2 = Vector2.ZERO

var arrayImgTropas: Array = [
	preload("res://prefabs/tropas/sprites/sprtAbelha.tscn"),
	preload("res://prefabs/tropas/sprites/sprtCao.tscn"),
	preload("res://prefabs/tropas/sprites/sprtCavaleiro.tscn"),
	preload("res://prefabs/tropas/sprites/sprtLobisomen.tscn"),
	preload("res://prefabs/tropas/sprites/sprtMago.tscn"),
	preload("res://prefabs/tropas/sprites/sprtMedusaBranca.tscn"),
	preload("res://prefabs/tropas/sprites/sprtOrc.tscn"),
	preload("res://prefabs/tropas/sprites/sprtRatazana.tscn"),
	preload("res://prefabs/tropas/sprites/sprtSlime.tscn")
]
var arrayTropas: Array = [
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
var arrayCusto: Array = [
	1,
	3,
	5,
	7,
	5,
	9,
	4,
	5,
	3
]
var intNumero: int = 0

func _ready():
	intNumero = Global.RNG.randi_range(0, arrayCusto.size()-1)
	animSrtTropa = arrayImgTropas[intNumero].instance()
	
	self.get_parent().call_deferred("add_child", animSrtTropa)
	self.get_parent().call_deferred("remove_child", animSrtTropa)
	self.call_deferred("add_child", animSrtTropa)
	animSrtTropa.position = $Position2D.position
	animSrtTropa.stop()
	$Label2.text = str(arrayCusto[intNumero])
	
	vctPontoGeracao = self.global_position


func _physics_process(delta):
	if self.scale != Vector2(0.5, 0.5):
		if blnEmFoco and Input.is_action_just_released("mouse_direito"):
			blnEmFoco = false
			onrdColorRect.visible = false
			self.global_position = vctPontoGeracao
			$Cancelar.play()
			onrdColorRect.call_deferred("set_visible", true)
		elif blnEmFoco and Input.is_action_pressed("mouse_esquerdo"):
			if not blnGerar:
				self.modulate.a8 = 125
			self.global_position = get_global_mouse_position() + Vector2(-48, -48)
		elif Global.UIDeck.vlrPontosDeEnergia >= arrayCusto[intNumero] and blnGerar and \
		blnEmFoco and Input.is_action_just_released("mouse_esquerdo"):
			var auxTropa = arrayTropas[intNumero].instance()
			Global.UIDeck.vlrPontosDeEnergia -= arrayCusto[intNumero]
			Global.UIDeck.MostrarPontos(Global.UIDeck.vlrPontosDeEnergia)
			Global.nodeGameCena.call_deferred("add_child", auxTropa)
			auxTropa.global_position = get_global_mouse_position()
			$AudioStreamPlayer.play()
			
			Global.UIDeck.gerarCartas(vctPontoGeracao)
			
			self.global_position = Vector2(5000, 5000)
			yield($AudioStreamPlayer, "finished")
			
			animSrtTropa.call_deferred("queue_free")
			self.call_deferred("queue_free")
		else:
			self.global_position = vctPontoGeracao
			self.modulate.a8 = 255


func _on_ColorRect_mouse_entered():
	if self.scale != Vector2(0.5, 0.5):
		$Selecionado.play()
		blnEmFoco = true
		onrdColorRect.modulate.a8 = 125
		animSrtTropa.play("default")


func _on_ColorRect_mouse_exited():
	blnEmFoco = false
	onrdColorRect.modulate.a8 = 0
	animSrtTropa.stop()


func _on_Area2D_area_entered(area):
	blnGerar = true
	self.modulate.a8 = 255


func _on_Area2D_area_exited(area):
	blnGerar = false
	self.modulate.a8 = 125
