extends Sprite


export var start_time: int = 300
var current_time = 0


onready var timer = $Timer
onready var label = $lblTempo

func _ready():
	if Global.intGameDificuldade == 1:
		start_time = 150
	elif Global.intGameDificuldade == 2:
		start_time = 210
	elif Global.intGameDificuldade == 3:
		start_time = 300
	
	current_time = start_time  
	Global.intTempoInicial = start_time
	update_label()  
	timer.wait_time = 1
	timer.start() 


func update_label():
	var minutes = current_time / 60
	var seconds = current_time % 60
	label.text = "%02d:%02d" % [minutes, seconds]
	Global.intTempo = current_time


func _on_Timer_timeout():
	if current_time > 0:
		current_time -= 1  
		update_label()  
	else:
		timer.stop()
