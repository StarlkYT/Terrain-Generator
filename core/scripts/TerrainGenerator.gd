extends Node2D

# TODO: Make terrain generates in both directions

var block_scene: PackedScene = load("res://core/scenes/utils/Block.tscn")
var random: RandomNumberGenerator = RandomNumberGenerator.new()
var distance_position_x: int = 0

onready var player_raycast_right: RayCast2D = $Player/Right
onready var inside_camera_view: Area2D = $Player/Area2D

func place_block(position_x: int, position_y: int) -> void:
	var block_instance: Node2D = block_scene.instance()
	add_child(block_instance)
	block_instance.global_position.x = position_x
	block_instance.global_position.y = position_y

func generate_chunk() -> void:
	for _bar in range(4):
		var random_position_y = random.randi_range(352, 480)
		for _depth in range(8):
			place_block(distance_position_x, random_position_y + (64 * _depth))
		distance_position_x += 64

func _process(_delta: float) -> void:
	if (player_raycast_right.enabled) and not (player_raycast_right.is_colliding()):
		print("Chunk generated")
		generate_chunk()

func _ready() -> void:
	random.randomize()
	generate_chunk()

func _on_Area2D_body_entered(body: Node) -> void:
	body.visible = true

func _on_Area2D_body_exited(body: Node) -> void:
	body.visible = false
