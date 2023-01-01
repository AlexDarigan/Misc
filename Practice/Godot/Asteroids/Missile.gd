extends KinematicBody2D

export var speed: int = 50

#func _ready() -> void:
#	if get_parent().name != "Player":
#		look_at(get_global_mouse_position())


func _process(delta: float) -> void:
	var velocity = Vector2.RIGHT.rotated(rotation)
	move_and_collide(velocity * speed * delta)


#	var velocity: Vector2 = Vector2.ZERO
#	look_at(get_global_mouse_position())
#	if Input.is_key_pressed(KEY_W):
#		velocity = Vector2.RIGHT.rotated(rotation)
#	if Input.is_key_pressed(KEY_D):
#		velocity = Vector2.LEFT.rotated(rotation)
#	move_and_collide(velocity * speed * delta)
#
#	if Input.is_mouse_button_pressed(BUTTON_LEFT):
#		var m = $Missile.duplicate()
#		var g = $Missile.get_global_transform().get_origin()
##		remove_child(m)
#		get_parent().add_child(m)
#		m.position = velocity #Vector2.UP.rotated(velocity)
##		m.position = g
#		m.set_process(true)
##		$Missile.set_process(true)
#		print("shoot")
