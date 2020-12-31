extends Label

func _process(_delta: float) -> void:
	var _FPS: int = int(Engine.get_frames_per_second())
	print(OS.get_dynamic_memory_usage())
	self.text = "FPS: " + str(_FPS)
	if _FPS > 45:
		self.set("custom_colors/font_color", Color8(0, 240, 0 , 255))
	elif _FPS < 45:
		self.set("custom_colors/font_color", Color8(100, 125, 0 , 255))
	elif _FPS < 25:
		self.set("custom_colors/font_color", Color8(255, 0, 0 , 255))
	
