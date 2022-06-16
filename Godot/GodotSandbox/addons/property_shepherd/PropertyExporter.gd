tool
extends VBoxContainer

func _ready() -> void:
	$Button.connect("pressed", self, "_on_button_pressed")
	
func _on_button_pressed():
	if $Grid.visible:
		$Grid.visible = false
		$ExportProperty.visible = false
		$Button.text = "Unfold Property Exporter"
	else:
		$Grid.visible = true
		$ExportProperty.visible = false
		$Button.text = "Fold Property Exporter"
