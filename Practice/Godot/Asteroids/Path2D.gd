extends Path2D

export(PackedScene) var UFO: PackedScene

#func _process(delta):
#	$PathFollow2D.offset += 100 * delta
#
func _on_SpawnTimer_timeout():
	pass
#	var a = UFO.instance()
#	a.position.x = $PathFollow2D.offset
#	add_child(a)
#	a.look_at(get_parent().get_node("Player").position)
#	a.velocity = a.position.rotated(a.rotation)
