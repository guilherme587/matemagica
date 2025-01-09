extends Area2D


export var intDano: int = 1
export var intVelocidade: int = 350
var vctDirecao: Vector2 = Vector2.ZERO
var blnInimigo: bool = false

func _ready():
	if blnInimigo:
		self.collision_mask = 2
	else:
		self.collision_mask = 4


func _physics_process(delta):
	self.translate(vctDirecao * delta * intVelocidade)
	self.rotation = vctDirecao.angle()


func _on_Flecha_body_entered(body):
	self.set_deferred("monitoring", false)
	if body != null and is_instance_valid(body):
		body.get_node("Vida").hitted(intDano)
	self.call_deferred("queue_free")


func _on_VisibilityNotifier2D_screen_exited():
	self.call_deferred("queue_free")
