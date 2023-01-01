extends Node2D

const BRICK_HEIGHT: int = 32
const BRICK_WITDH: int = 16
export(PackedScene) var BrickScene: PackedScene
export(Array) var colors: Array = []
const BRICK_SIZE: Vector2 = Vector2(16, 32)
export(int) var brick_count_per_rows: int = 1
export(int) var rows: int = 1
var bricks: Array = []

func _ready() -> void:
	spawn_bricks()
	
func spawn_bricks() -> void:
	var brick_position = Vector2(0, -BRICK_HEIGHT)
	for row in rows:
		brick_position.x -= BRICK_WITDH
		brick_position.y = 0
		for pos in brick_count_per_rows:
			var brick: Brick  = BrickScene.instance()
			randomize()
			brick.color = colors[randi() % colors.size()]
			add_child(brick)
			brick.position = brick_position
			brick_position.y += BRICK_HEIGHT
			
