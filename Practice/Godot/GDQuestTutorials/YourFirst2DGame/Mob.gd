extends RigidBody2D

onready var MobSprite: AnimatedSprite = $AnimatedSprite

func _ready() -> void:
	MobSprite.playing = true
	var mob_types = MobSprite.frames.get_animation_names()
	MobSprite.animation = mob_types[randi() % mob_types.size()]
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
