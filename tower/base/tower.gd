extends Node2D
class_name Tower

@export var area_scale: float; 

var level: int = 1;
var summary_price: int;

func play_upgrade_effect():
	var tween = create_tween()
	var shader_material: ShaderMaterial = %TowerSprite.material
	shader_material.set("shader_parameter/strength", 1.0)
	tween.tween_property(shader_material, "shader_parameter/strength", 0.0, 0.3).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func get_update_price():
	pass

func default_update():
	play_upgrade_effect()
	Global.gold -= get_update_price()
	summary_price += get_update_price()
	level += 1
	

func update_tower():
	pass

func find_enemy_in_area() -> Array:
	var enemies =  get_tree().get_nodes_in_group('Enemy');
	var ret = []
	
	for enemy in enemies:
		if $AttackArea.overlaps_body(enemy):
			ret.append(enemy)
	return ret
	


func _on_description_area_mouse_entered() -> void:
	$"AttackArea/Circle-svgrepo-com".visible = true




func _on_description_area_mouse_exited() -> void:
	$"AttackArea/Circle-svgrepo-com".visible = false
