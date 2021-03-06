extends Node2D

onready var terrain_raycast: RayCast2D = $StaticBody2D/RayCast2D
onready var terrain_sprite: Sprite = $StaticBody2D/Sprite
onready var visibility_enabler: VisibilityEnabler2D = $VisibilityEnabler2D

var dirt_sprite: Texture = load("res://assets/tiles/dirt_sprite.png")
var grass_sprite: Texture = load("res://assets/tiles/grass_sprite.png")

func _process(_delta: float) -> void:
	if not terrain_raycast == null:
		if terrain_raycast.is_colliding():
			if not terrain_raycast.get_collider() is KinematicBody2D:
#				terrain_raycast.queue_free()
				terrain_sprite.texture = dirt_sprite
		else:
			terrain_raycast.queue_free()
			terrain_sprite.texture = grass_sprite

func _on_VisibilityEnabler2D_screen_entered() -> void:
	self.show()

func _on_VisibilityEnabler2D_screen_exited() -> void:
	self.hide()
