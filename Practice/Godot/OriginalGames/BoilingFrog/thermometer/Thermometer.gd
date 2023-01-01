extends PanelContainer

var _player: Player
onready var Display: TextureProgress = $Thermometer


func _physics_process(_delta: float) -> void:
	Display.value = _player.temp
	if Display.value >= 100:
		explode()
		
func explode() -> void:
	set_physics_process(false)
	$Explode.emitting = true
	$Explosion.play()
