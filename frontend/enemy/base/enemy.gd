extends PathFollow2D
class_name Enemy
@export var texture: AnimatedSprite2D
@export var lightning: AnimatedSprite2D

@export var speed = 80
var slow_time: float
var slowing := 0.7
var prev_pos := Vector2.ZERO
var offset : int;
@export var award : int = 8; #было 10

@export var max_hp: float:
	set(value):
		$HpBar.max_value = value
		hp = value
		max_hp = value

var hp: float:
	set(value):
		if hp <= 0 and value <= 0:
			return
		$HpBar.value = value
		if value <= 0 and hp > 0:
			Global.gold += award
			hp = 0
			$Body.queue_free()
			if texture.sprite_frames and texture.sprite_frames.has_animation("death"):
				texture.play("death")
				await texture.animation_finished
			queue_free()
		else:
			hp = value

func on_art_tower_hit():
	slow_time = 0.17 #было 20

func on_electric_tower_hit():
	if lightning.sprite_frames:
		lightning.play("default")

func hit(damage, type):
	match type:
		Global.Types.ELECTRIC:
			on_electric_tower_hit()
		Global.Types.ART:
			on_art_tower_hit()
	hp -= damage
	
			
		

func calculate_offset_vector():
	var path := get_parent() as Path2D
	var curve := path.curve

	var pos := curve.sample_baked(progress)
	var next_pos := curve.sample_baked(progress + 1.0)

	var tangent := (next_pos - pos).normalized()
	var normal := Vector2(-tangent.y, tangent.x) 
	h_offset = offset * normal.x
	v_offset = offset * normal.y

func mooving(delta):
	slow_time = max(0, slow_time - delta)
	var ds =  delta * speed
	if slow_time > 0:
		progress += ds * slowing
	else:
		progress += ds
	calculate_offset_vector()
	
	if (prev_pos - global_position).x > 0:
		$Texture.flip_h = true
	else:
		$Texture.flip_h = false
	
	prev_pos = global_position


func _physics_process(delta: float) -> void:
	mooving(delta)
	
	

	
	
