extends KinematicBody2D

# Keyboard controlling from Input Map
export (String) var move_right_key = "ui_right"
export (String) var move_left_key = "ui_left"
export (String) var jump_key = "ui_up"

# Player movement settings
export (int) var speed = 150
export (int) var max_speed = 256
export (int) var gravity = 375
export (int) var jump_power = 256
export (int) var snap_length = 32
export (int) var max_floor_degree = 45
export (bool) var double_jump_ability = true

# Smoothing-related variables for player movement
export (int) var ground_friction = 7
export (int) var air_friction = 13

onready var player_sprite: Sprite = $CollisionShape2D/Sprite
onready var player_on_floor: RayCast2D = $OnFloor

# Terrain generation related
onready var player_terrain_right: RayCast2D = $Right


var double_jump: bool = false
var friction: int = ground_friction
var snap_direction: Vector2 = Vector2.DOWN
var snap_vector: Vector2 = snap_direction * snap_length
var motion: Vector2 = Vector2()

func get_horizontal_input() -> float:
	return (Input.get_action_strength(move_right_key) - Input.get_action_strength(move_left_key))
func _physics_process(delta: float) -> void:
	if is_on_floor():
		friction = ground_friction
	else:
		friction = air_friction
	apply_jump()
	apply_gravity(delta)
	apply_movement(delta)
	motion.y = move_and_slide_with_snap(motion, snap_vector, Vector2.UP, deg2rad(max_floor_degree)).y
	
func apply_movement(delta: float) -> void:
	if get_horizontal_input() != 0:
		player_terrain_right.enabled = get_horizontal_input() >= 1
		motion.x = lerp(motion.x, get_horizontal_input() * speed, friction * delta)
	else:
		motion.x = lerp(motion.x, 0, friction * delta)

func apply_jump() -> void:
	if Input.is_action_just_pressed(jump_key):
		if player_on_floor.is_colliding():
			snap_vector = Vector2.UP
			motion.y = -jump_power
			double_jump = true
		else:
			if double_jump_ability == true:
				if double_jump == true:
					motion.y = -jump_power
					double_jump = false
	else:
		snap_vector = snap_direction * snap_length

func apply_gravity(delta: float) -> void:
	motion.y += gravity * delta
	if motion.y > 500:
		motion.y = 500
