extends Node2D

export(float) var amplitude_x: float = 50.0
export(float) var frequency_x: float = 1.0

export(float) var amplitude_y: float = 30.0
export(float) var frequency_y: float = 2.0


var initial_position: Vector2

func _ready():
	initial_position = global_position

func _physics_process(delta):
	var offset_x = amplitude_x * sin(2 * PI * frequency_x * OS.get_ticks_msec() / 1000.0)
	var offset_y = amplitude_y * sin(2 * PI * frequency_y * OS.get_ticks_msec() / 1000.0)
	
	global_position = initial_position + Vector2(offset_x, offset_y)
