@tool
extends HBoxContainer
signal name_ready()
signal value_ready()


@export var property: String:
	set(value):
		if $Name == null:
			await name_ready
		$Name.text = value
	get():
		return $Name.text
		
@export var value: String:
	set(value):
		if $Value == null:
			await value_ready
		$Value.text = value
	get():
		return $Value.text


func _on_name_ready() -> void:
	name_ready.emit()


func _on_value_ready() -> void:
	value_ready.emit()
