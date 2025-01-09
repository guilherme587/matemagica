extends Node2D

export(float) var amplitude_x: float = 50.0
export(float) var frequency_x: float = 1.0

export(float) var amplitude_y: float = 30.0
export(float) var frequency_y: float = 2.0

var pckdGame: PackedScene = preload("res://cenas/game.tscn")
var initial_position: Vector2
var intDificuldade: int = 1

func _ready():
	initial_position = global_position

func _physics_process(delta):
	if ("TelaInicial" in self.name) and $CanvasLayer/btnReiniciar != null and \
	self.get_tree().root.has_node("game"):
		$CanvasLayer/btnReiniciar.visible = true
	
	var offset_x = amplitude_x * sin(2 * PI * frequency_x * OS.get_ticks_msec() / 1000.0)
	var offset_y = amplitude_y * sin(2 * PI * frequency_y * OS.get_ticks_msec() / 1000.0)
	
	global_position = initial_position + Vector2(offset_x, offset_y)


func _on_btnStart_gui_input(event):
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
	if Input.is_action_just_released("mouse_esquerdo"):
		$CanvasLayer/Control.visible = false
		$CanvasLayer/Control2.visible = true


func _on_btnConfiguracoes_gui_input(event):
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
	if Input.is_action_just_released("mouse_esquerdo"):
		$CanvasLayer/Control.visible = false
		$CanvasLayer/Control2.visible = false
		$CanvasLayer/Control3.visible = true


func _on_btnSair_gui_input(event):
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
	if Input.is_action_just_released("mouse_esquerdo"):
		self.get_tree().quit()


func _on_btnProximo_gui_input(event):
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
	if Input.is_action_just_released("mouse_esquerdo"):
		intDificuldade += 1
		if intDificuldade > 3:
			intDificuldade = 1
		$CanvasLayer/Control2/lblDificuldade/Label.text = "nivel " + str(intDificuldade)
		
		Global.intGameDificuldade = intDificuldade


func _on_btnAnterior_gui_input(event):
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
	if Input.is_action_just_released("mouse_esquerdo"):
		intDificuldade -= 1
		if intDificuldade < 1:
			intDificuldade = 3
		$CanvasLayer/Control2/lblDificuldade/Label.text = "nivel " + str(intDificuldade)
		
		Global.intGameDificuldade = intDificuldade


func _on_btnVoltar_gui_input(event):
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
	if Input.is_action_just_released("mouse_esquerdo"):
		$CanvasLayer/Control2.visible = false
		$CanvasLayer/Control.visible = true


func _on_btnStartGame_gui_input(event):
	if Input.is_action_just_released("mouse_esquerdo"):
		if self.get_tree().root.has_node("game"):
			self.get_tree().paused = false
		else:
			var game = pckdGame.instance()
			game.name = "game"
			get_tree().root.add_child(game)
			self.get_tree().paused = false
		
		$CanvasLayer/bg.visible = true
		visivel(false)


func _on_btnConfiguracoesTelaCheia_gui_input(event):
	if Input.is_action_just_released("mouse_esquerdo"):
		OS.window_fullscreen = !OS.window_fullscreen


func _on_btnConfiguracoesComoJogar_gui_input(event):
	if Input.is_action_just_released("mouse_esquerdo"):
		pass


func _on_btnConfiguracoesVoltar_gui_input(event):
	if Input.is_action_just_released("mouse_esquerdo"):
		$CanvasLayer/Control3.visible = false
		$CanvasLayer/Control2.visible = false
		$CanvasLayer/Control.visible = true


func _on_btnReiniciar_gui_input(event):
	if Input.is_action_just_released("mouse_esquerdo"):
		Global.nodeGameCena.queue_free()
		var current_scene_path = get_tree().current_scene.filename
		
		get_tree().change_scene(current_scene_path)
		
		Global.reiniciar()


func visivel(bln: bool) -> void:
	if bln:
		$Musica.play()
	else:
		$Musica.stop()
		
	$CanvasLayer.visible = bln
	self.visible = bln


