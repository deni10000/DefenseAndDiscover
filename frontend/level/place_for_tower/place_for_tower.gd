extends Node2D

var current_tower : Tower
var place_for_tower_control = Global.place_for_tower_control_scene.instantiate()

func  _ready() -> void:
	#place_for_tower_control.visible = false
	place_for_tower_control.global_position = global_position
	place_for_tower_control.tower_created.connect(on_tower_created)
	place_for_tower_control.tower_deleted.connect(on_tower_delted)

	
func on_tower_delted():
	%PlaceTexture.visible = true
	current_tower.queue_free()

func on_tower_created(tower):
	%PlaceTexture.visible = false
	current_tower = tower
	add_child(tower)
	

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index <= 2 and event.is_pressed():
		if current_tower == null:
			place_for_tower_control.menu_panel.visible = not place_for_tower_control.menu_panel.visible
		else:
			place_for_tower_control.update_panel.visible = not place_for_tower_control.update_panel.visible


func _on_area_2d_mouse_entered() -> void:
	place_for_tower_control.mouse_in_area = true


func _on_area_2d_mouse_exited() -> void:
	place_for_tower_control.mouse_in_area = false

	
	
