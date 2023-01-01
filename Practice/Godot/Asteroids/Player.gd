extends KinematicBody2D

export(int) var speed: int = 300
export(PackedScene) var Missile
onready var MissileTimer = $MissileTimer
var ammo: bool = true

func _ready() -> void:
	MissileTimer.connect("timeout", self, "_on_Missile_Timer_timeout")

func _on_Missile_Timer_timeout() -> void:
	MissileTimer.stop()
	ammo = true

func _physics_process(delta: float) -> void:
	var velocity: Vector2 = Vector2.ZERO
	look_at(get_global_mouse_position())
	if Input.is_key_pressed(KEY_W):
		velocity = Vector2.RIGHT.rotated(rotation)
	if Input.is_key_pressed(KEY_D):
		velocity = Vector2.LEFT.rotated(rotation)
	move_and_collide(velocity * speed * delta)
	position.x = wrapf(position.x, 0, get_viewport_rect().size.x - 32)
	position.y = wrapf(position.y, 0, get_viewport_rect().size.y)
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and ammo:
		ammo = false
		var instance = Missile.instance()
		get_parent().add_child(instance)
		instance.position = $Missiles.get_global_transform().origin
		instance.rotation = rotation
		MissileTimer.start()
		$Shoot.play()
