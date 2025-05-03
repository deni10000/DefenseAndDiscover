extends Node2D

var mouse_in_control : bool
var mouse_in_area : bool 
var current_tower : Tower
var tower_cashback := 0.5

func  _ready() -> void:
	%ArcherTowerCard.price = Global.archer_tower_price
	%ArtTowerCard.price = Global.art_tower_price
	%TreeTowerCard.price = Global.tree_tower_price
	%ElectricTowerCard.price = Global.electric_tower_price

	
	

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index <= 2 and event.is_pressed():
		if current_tower == null:
			%MenuPanel.visible = not %MenuPanel.visible
		else:
			%UpdatePanel.visible = not %UpdatePanel.visible


	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and not mouse_in_control and not mouse_in_area:
		%MenuPanel.visible = false
		%UpdatePanel.visible = false
	
	
	#if event is InputEventMouseButton:
		#var pos = event.position - %Control.global_position
		#if  (not %MenuPanel.visible or not %MenuPanel.get_rect().has_point(pos)) and (not %UpdatePanel.visible or not %UpdatePanel.get_rect().has_point(pos)) and not mouse_in_area:
			#%MenuPanel.visible = false
			#%UpdatePanel.visible = false
		

func _on_control_mouse_entered() -> void:
	mouse_in_control = true


func _on_control_mouse_exited() -> void:
	mouse_in_control = false


func _on_area_2d_mouse_entered() -> void:
	mouse_in_area = true


func _on_area_2d_mouse_exited() -> void:
	mouse_in_area = false


func _on_archer_tower_card_card_pressed() -> void:
	create_tower(Global.archer_tower, Global.archer_tower_price)

func _on_art_tower_card_card_pressed() -> void:
	create_tower(Global.art_tower, Global.art_tower_price)

func _on_tree_tower_card_card_pressed() -> void:
	create_tower(Global.tree_tower, Global.tree_tower_price)

func _on_electric_tower_card_card_pressed() -> void:
	create_tower(Global.electric_tower, Global.electric_tower_price)

func update_prices():
	%UpdateCard.price = current_tower.get_update_price()
	%RemoveCard.price = -int(current_tower.summary_price * tower_cashback)

func create_tower(tower: PackedScene, tower_price):
	if tower_price <= Global.gold:
		Global.gold -= tower_price
		current_tower = tower.instantiate()
		add_child(current_tower)
		%MenuPanel.visible = false
		%PlaceTexture.visible = false
		update_prices()
	


func _on_update_card_card_pressed() -> void:
	current_tower.update_tower()
	%UpdatePanel.visible = false
	update_prices()


func _on_remove_card_card_pressed() -> void:
	Global.gold += int(current_tower.summary_price * tower_cashback)
	%UpdatePanel.visible = false
	current_tower.queue_free()
	current_tower = null
	%PlaceTexture.visible = true
	
