extends Area2D


var knbPai: KinematicBody2D = null
var fltTempoPassado: float = 0

func _ready():
	knbPai = self.get_parent()


func _physics_process(delta):
	if fltTempoPassado >= 1000:
		print(fltTempoPassado)
		print($CollisionShape2D.shape.radius)
		self.set_deferred("monitoring", false)
		self.set_deferred("monitoring", true)
		fltTempoPassado = 0
		
		if self.global_position.distance_to(knbPai.knbAlvo.global_position) > $CollisionShape2D.shape.radius:
			knbPai.knbAlvo = null
	
	fltTempoPassado += delta


func _on_Visao_body_entered(body):
	if body != self.get_parent() and \
	(knbPai.knbAlvo == null or not is_instance_valid(knbPai.knbAlvo)):
		knbPai.knbAlvo = body


func _on_Visao_body_exited(body):
	if knbPai.knbAlvo == body and self.monitoring:
		self.set_deferred("monitoring", false)
		self.set_deferred("monitoring", true)
