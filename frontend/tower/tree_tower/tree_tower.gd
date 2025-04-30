extends Tower

var damage := 60
var planned_attack := false
var additional_price_to_up := 60

func get_update_price():
	return Global.electric_tower_price + additional_price_to_up * (level - 1)

func update_tower():
	default_update()
	level += 1
	damage += 15

func _ready() -> void:
	summary_price = Global.tree_tower_price
	
func _process(delta: float) -> void:
	if planned_attack:		
		for enemy_area: Area2D in %Attack.get_overlapping_areas():
			enemy_area.hit(damage, Global.Types.TREE)
		planned_attack = false
	if  $AttackTimer.time_left != 0:
		return
	var enemies = $AttackArea.get_overlapping_areas()
	var mx = 0
	var max_enemy: Enemy = null
	for enemy_area: Area2D in enemies:
		var enemy = enemy_area.get_parent()
		if enemy.progress_ratio > mx:
			mx = enemy.progress_ratio
			max_enemy = enemy
	if max_enemy != null:
		$AttackTimer.start()
		%Attack.global_position = max_enemy.global_position
		planned_attack = true
