extends CPUParticles2D


func _ready():
	pass


func _physics_process(delta):
	self.visible = false
	if self.get_parent().Alvo != null and \
	Global.distancia_para(self.global_position, self.get_parent().Alvo.global_position) < \
	120:
		self.visible = true
		self.rotation = self.global_position.direction_to(self.get_parent().Alvo.global_position).angle()
