extends Area2D

onready var player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
#	visible = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		player.play("fade_in")
		
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		global_position = get_global_mouse_position()
	
func _on_body_entered(body: PhysicsBody2D) -> void:
	player.play("fade_out")
