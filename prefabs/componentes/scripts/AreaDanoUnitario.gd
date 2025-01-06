extends Area2D

export var strGrupoAlvo: String = "Inimigo"
export var fltDanoPorSegundo: float = 1.0

onready var onrdTimer: Timer = $Timer
onready var onrdSprite: AnimatedSprite = $"../sprite"
onready var onrdAudioAtaque: AudioStreamPlayer2D = $"../Ataque"

var blnPodeAtacar: bool = true
var knbAlvo = null

func _ready():
	self.set_deferred("monitoring", false)
	self.set_deferred("monitoring", true)


func _physics_process(delta):
#	print(knbAlvo)
	if blnPodeAtacar and knbAlvo != null and is_instance_valid(knbAlvo):
		if onrdAudioAtaque != null:
			onrdAudioAtaque.play()
			onrdAudioAtaque.set_volume_db(-5)
		if onrdSprite != null:
			onrdSprite.stop()
			onrdSprite.play("ataque")
			onrdSprite.frame = 0
		else:
			onrdSprite = $"../sprite"
		
		blnPodeAtacar = false
		knbAlvo.get_node("Vida").hitted(self.get_parent().intDano)
		onrdTimer.start(fltDanoPorSegundo)


func _on_AreaDanoUnitario_body_entered(body):
#	if body.is_in_group(strGrupoAlvo) and \
#	(knbAlvo == null or not is_instance_valid(knbAlvo)):
#		knbAlvo = body

	self.set_deferred("monitoring", false)
	
	if (knbAlvo == null or not is_instance_valid(knbAlvo)):
		knbAlvo = body
	
	self.set_deferred("monitoring", true)


func _on_AreaDanoUnitario_body_exited(body):
	if body.is_in_group(strGrupoAlvo) and knbAlvo == body:
		knbAlvo = null


func _on_Timer_timeout():
	blnPodeAtacar = true
