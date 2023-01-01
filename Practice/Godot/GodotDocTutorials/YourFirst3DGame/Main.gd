extends Node

export(PackedScene) var MobScene: PackedScene

func _ready() -> void:
	randomize()
	$UserInterface/Retry.hide()


func _on_MobTimer_timeout() -> void:
	var mob: KinematicBody = MobScene.instance()
	var mob_spawn_location = $SpawnPath/SpawnLocation
	mob_spawn_location.unit_offset = randf()
	var player_pos: Vector3 = $Player.transform.origin
	mob.initialize(mob_spawn_location.translation, player_pos)
	add_child(mob)
	mob.connect("squashed", $UserInterface/Score, "_on_Mob_squashed")


func _on_Player_hit() -> void:
	$MobTimer.stop()
	$UserInterface/Retry.show()
	
func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()
