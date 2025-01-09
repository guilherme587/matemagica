extends Sprite

var blnEmFoco: bool = false


func _ready():
	pass


func _physics_process(delta):
	if blnEmFoco and not Global.blnErrou and Input.is_action_just_pressed("mouse_esquerdo"):
		ChecarResposta()
	if Global.blnErrou:
		self.modulate.a8 = 125
	elif not Global.blnErrou:
		self.modulate.a8 = 255


func ChecarResposta():
	if $Label.text == "":
		return
	
	var questao: PoolStringArray = Global.UIDeck.lblQuestao.text.split(" ")
	var resultado: float = 0
	var a: int = int(questao[0])
	var b: int = int(questao[2])
	
	match questao[1]:
		"+":
			resultado = a + b
		"-":
			resultado = a - b
		"*":
			resultado = a * b
		"/":
			resultado = round((a / b) *100)/100 if b != 0 else 0  # Evita divisão por zero
	
	if resultado == float($Label.text):
		$Acerto.play()
		Global.blnErrou = true
		Global.UIDeck.vlrPontosDeEnergia += Global.intGameDificuldade
		if Global.UIDeck.vlrPontosDeEnergia > 10:
			Global.UIDeck.vlrPontosDeEnergia = 10
		Global.UIDeck.MostrarPontos(Global.UIDeck.vlrPontosDeEnergia)
		Global.nodeAlgoritimoMatematico.lblTempo.text = str(1)
		Global.nodeAlgoritimoMatematico._Timer.start(1)
		Global.intAcertos += 1
	else:
		$Erro.play()
		Global.blnErrou = true
		Global.nodeAlgoritimoMatematico.lblTempo.text = str(Global.nodeAlgoritimoMatematico.intTempoPenalidade * Global.nodeAlgoritimoMatematico.intNivel)
		Global.nodeAlgoritimoMatematico._Timer.start(Global.nodeAlgoritimoMatematico.intTempoPenalidade * Global.nodeAlgoritimoMatematico.intNivel)
		Global.intErros += 1


func _on_ColorRect_mouse_entered():
	blnEmFoco = true


func _on_ColorRect_mouse_exited():
	blnEmFoco = false
