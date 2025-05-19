extends Control


func _on_settings_cross_button_pressed() -> void:
	visible = false
	
func _ready() -> void:
	%VolumeSlider.value_changed.connect(Music.set_master_volume)
	%VolumeSlider.value = db_to_linear(Music.master_volume_db)
