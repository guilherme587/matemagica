extends Node2D


export(float) var amplitude = 0.2
export(float) var frequency = 2.0
var original_scale = Vector2.ONE
var fltTempoPassado: float = 0

func _ready():
	original_scale = self.scale

func _process(delta):
	fltTempoPassado += delta
	var pulse = sin(2.0 * PI * frequency * fltTempoPassado) * amplitude
	self.scale = original_scale * (1.0 + pulse)
