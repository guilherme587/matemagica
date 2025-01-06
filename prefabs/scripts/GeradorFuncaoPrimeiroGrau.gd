extends Node2D


export var intNivel: int = 1
export var intTempoParaResponder: int = 45
export var intTempoPenalidade: int = 5

onready var lblQuestao: Label = $UI/Questoes/ItemBox24X24/Questao
onready var lblTempo: Label = $UI/Questoes/ItemBox24X24/Tempo
onready var Respostas: Array = [
	$UI/Questoes/Resposta1/Label,
	$UI/Questoes/Resposta2/Label,
	$UI/Questoes/Resposta3/Label,
	$UI/Questoes/Resposta4/Label,
	$UI/Questoes/Resposta5/Label
]
onready var _Timer: Timer = $Timer
onready var Cronometro: Timer = $Cronometro


func _ready():
	Global.intGameDificuldade = intNivel
	Global.nodeAlgoritimoMatematico = self
	Global.nodeGameCena = self
	# Testar a geração de operações matemáticas em diferentes níveis de dificuldade
#	for nivel in range(1, 4):
#		print("Nível de dificuldade %d:" % nivel)
#		for i in range(5):
#			var resultado = gerar_operacao(nivel)
#			print("Operação: %s" % resultado.operacao)
#			print("Respostas: %s" % str(resultado.respostas))
#		print("")
	_Timer.start(0)

func gerar_operacao(nivel_dificuldade: int) -> Dictionary:
	# Define o intervalo para os números baseados no nível de dificuldade
	var intervalo = 0
	if nivel_dificuldade == 1: # Fácil
		intervalo = 10
	elif nivel_dificuldade == 2: # Médio
		intervalo = 20
	elif nivel_dificuldade == 3: # Difícil
		intervalo = 50
	else:
		push_error("Nível de dificuldade deve ser 1 (Fácil), 2 (Médio) ou 3 (Difícil).")
		return {}

	# Define o número de respostas possíveis
	var num_respostas = nivel_dificuldade + 2

	# Gera dois números aleatórios
	var a: int= Global.RNG.randi_range(1, intervalo)
	var b: int = Global.RNG.randi_range(1, intervalo)

	# Escolhe aleatoriamente uma operação
	var operacoes = ["+", "-", "*", "/"]
	var operacao = operacoes[Global.RNG.randi() % operacoes.size()]
	
	# Calcula o resultado correto
	var resultado = 0
	match operacao:
		"+":
			resultado = a + b
		"-":
			resultado = a - b
		"*":
			resultado = a * b
		"/":
			resultado = round((a / b) *100)/100 if b != 0 else 0  # Evita divisão por zero

	# Gera respostas aleatórias com uma resposta correta
	var respostas = []
	respostas.append(resultado)
	while respostas.size() < num_respostas:
		var resposta_falsa: int = Global.RNG.randi_range(resultado - intervalo, resultado + intervalo)
		if resposta_falsa != resultado and not respostas.has(resposta_falsa):
			respostas.append(resposta_falsa)

	# Embaralha as respostas
	respostas.shuffle()

	return {"operacao": "%d %s %d" % [a, operacao, b], "respostas": respostas}


func _on_Timer_timeout():
	Global.blnErrou = false
	
	var resultado: Dictionary = gerar_operacao(intNivel)
	
	var index: int = 0
	lblQuestao.text = str(resultado.operacao)
	for resposta in resultado.respostas:
		Respostas[index].text = str(resposta)
		index += 1
	
	lblTempo.text = str(intTempoParaResponder/intNivel)
	Cronometro.start(1)


func _on_Cronometro_timeout():
	lblTempo.text = str(int(lblTempo.text) -1)
	if int(lblTempo.text) <= 5 or Global.blnErrou:
		lblTempo.modulate = Color.red
	else:
		lblTempo.modulate = Color.white
	
	if not Global.blnErrou:
		if int(lblTempo.text) <= 0:
			_Timer.start(intTempoPenalidade*intNivel)
		else:
			Cronometro.start(1)
	elif Global.blnErrou:
			Cronometro.start(1)
