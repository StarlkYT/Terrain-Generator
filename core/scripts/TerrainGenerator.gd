extends Node2D

# TODO: Make terrain generates in both directions

var random: RandomNumberGenerator = RandomNumberGenerator.new()
var block_scene: PackedScene = load("res://core/scenes/utils/Block.tscn")
var distance_position_x: int
var body_node: Node

onready var player_raycast_right: RayCast2D = $Player/Right
onready var cursor: Node2D = $Cursor

func _on_Area2D2_body_entered(body: Node) -> void:
	body_node = body

func _ready() -> void:
	generate_chunk()
	random.randomize()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left_click"):
		if body_node is StaticBody2D:
			if not body_node == null:
				body_node.queue_free()

func _process(_delta: float) -> void:
	cursor.position.x = get_global_mouse_position().x
	cursor.position.y = get_global_mouse_position().y
	if not player_raycast_right == null:
		if (player_raycast_right.enabled) and not (player_raycast_right.is_colliding()):
			generate_chunk()

func place_block(position_x: int, position_y: int) -> void:
	var block_instance: Node2D = block_scene.instance()
	add_child(block_instance)
	block_instance.global_position.x = position_x
	block_instance.global_position.y = position_y

func generate_chunk() -> void:
	for _bar in range(4):
		var random_position_y: int = random.randi_range(352, 480)
		for _depth in range(8):
			place_block(distance_position_x, (random_position_y + 64 * _depth))
		distance_position_x += 64
