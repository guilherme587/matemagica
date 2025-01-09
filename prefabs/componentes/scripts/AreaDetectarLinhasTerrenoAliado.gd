extends Area2D


func _on_AreaDetectarLinhasTerrenoAliado_area_entered(area):
	if not self.get_parent().blnInimigo:
		var aux: Vector2 = self.get_parent().global_position
		yield(get_tree(), "idle_frame")
		self.get_parent().get_parent().remove_child(self.get_parent())
		area.get_parent().add_child(self.get_parent())
		self.get_parent().global_position = aux



func _on_AreaDetectarLinhasTerrenoInimigo_area_entered(area):
	if self.get_parent().blnInimigo:
		var aux: Vector2 = self.get_parent().global_position
		yield(get_tree(), "idle_frame")
		self.get_parent().get_parent().remove_child(self.get_parent())
		area.get_parent().add_child(self.get_parent())
		self.get_parent().global_position = aux
