extends Node2D
const CAMERA_MOVEMENT_SPEED : float = 20
const CAMERA_ZOOM_SPEED : Vector2 = Vector2(0.2, 0.2)
const CAMERA_ZOOM_DEFAULT : Vector2 = Vector2(1.0, 1.0)
const CAMERA_ZOOM_MIN : Vector2 = Vector2(0.6, 0.6)
const CAMERA_ZOOM_MAX : Vector2 = Vector2(3.0, 3.0)
const CAMERA_TWEEN_DURATION : float = 0.3
const CAMERA_SPEED = 400
var MAX_RATIO = 16 / 9
var MIN_RATIO = 16 / 9

@onready var viewport_size = get_viewport().size
@export var camera: Camera2D; 

var wave = 0
var enemy_count = 0
var hp:
	set(value):
		%HpInput.text = str(value)
		hp = value

var camera_tween: Tween = null 
func _ready() -> void:
	get_viewport().size_changed.connect(center_field)
	Global.gold_changed.connect(update_gold_label)
	%GoldInput.text = str(Global.gold)
	hp = 30


func center_field():
	var screen_size = get_viewport().get_visible_rect().size
	print(screen_size)
	camera.limit_right = 1920 + (screen_size.x - 1920) / 2
	camera.limit_bottom = 1080 + (screen_size.y - 1080) / 2
	var aspect = screen_size.x / screen_size.y
	var viewport := get_viewport()
	if aspect > MAX_RATIO:
		ProjectSettings.set_setting("display/window/stretch/aspect", "keep")
	elif aspect < MIN_RATIO:
		ProjectSettings.set_setting("display/window/stretch/aspect", "keep")
	

var waves = [
	[Global.Enemies.SLIME, Global.Enemies.SLIME],
	[Global.Enemies.SLIME, Global.Enemies.SLIME, Global.Enemies.SLIME, Global.Enemies.SLIME, Global.Enemies.SLIME, Global.Enemies.SLIME, Global.Enemies.SLIME, Global.Enemies.SLIME, Global.Enemies.SLIME ]
]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("zoom_in"):
		if (camera.zoom < CAMERA_ZOOM_MAX):
			if (camera_tween == null or not camera_tween.is_running()):
				camera_tween = create_tween()
				camera_tween.tween_property(camera, "zoom", camera.zoom * (CAMERA_ZOOM_DEFAULT + CAMERA_ZOOM_SPEED),CAMERA_TWEEN_DURATION)
	elif Input.is_action_just_pressed("zoom_out"):
		if (camera.zoom > CAMERA_ZOOM_MIN):
			if (camera_tween == null or not camera_tween.is_running()):
				camera_tween = create_tween()
				camera_tween.tween_property(camera, "zoom", camera.zoom / (CAMERA_ZOOM_DEFAULT + CAMERA_ZOOM_SPEED),CAMERA_TWEEN_DURATION)
	var mouse_pos := camera.get_local_mouse_position()
	#print(mouse_pos)
	if mouse_pos[0] < -(viewport_size.x / camera.zoom.x) / 2 + 10:
		camera.position.x -= CAMERA_SPEED * delta / camera.zoom.x
	if mouse_pos[1] < -(viewport_size.y / camera.zoom.y) / 2 + 10:
		camera.position.y -= CAMERA_SPEED * delta / camera.zoom.y
	if mouse_pos[0] > (viewport_size.x / camera.zoom.x) / 2 - 10:
		camera.position.x += CAMERA_SPEED * delta / camera.zoom.x
	if mouse_pos[1] > (viewport_size.y / camera.zoom.y) / 2 - 10:
		camera.position.y += CAMERA_SPEED * delta / camera.zoom.y
		
		

func update_gold_label():
	%GoldInput.text = str(Global.gold)

func start_wave():
	enemy_count = 0
	%Control/StartWave.visible = false
	%Wave_generator.start_wave()
	

func next_enemy():
	var enemy = Global.enemy_properties[waves[wave][enemy_count]].scene.instantiate()
	%Path2D.add_child(enemy)
	enemy_count += 1
	if enemy_count == waves[wave].size():
		%Control/StartWave.visible = true
		$EnemyTimer.stop()
		wave += 1
			


func _on_button_pressed() -> void:
	get_tree().paused = !get_tree().paused


func _on_home_area_entered(area: Area2D) -> void:
	hp -= 1
	area.remove()




func _on_wave_generator_add_enemy(enemy: Enemy) -> void:
	enemy.offset = randi_range(-30, 30)
	%Path2D.add_child(enemy)


func _on_wave_generator_wave_ended() -> void:
	%Control/StartWave.visible = true
