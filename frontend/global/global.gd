extends Node

enum Types {ELECTRIC, ARCHER, ART, TREE}

signal gold_changed
signal start_question(type: Types)
signal question_completed(is_successful: bool)

var gold : int:
	set(v):
		gold = v
		gold_changed.emit()
var archer_tower_price : int = 140 #было 100
var electric_tower_price : int = 150
var art_tower_price : int = 160 #было 150
var tree_tower_price : int = 170
var archer_tower := preload("uid://dblmp648wldnf")
var electric_tower := preload("uid://sqp3gbqgta6a")
var art_tower := preload("uid://bdth5uwj86qyt")
var arrow := preload("uid://d2bj3yntbkiuu")
var tree_tower := preload("uid://6a7dry2en0la")
var level_scene := preload("uid://mahg2nbldblf")
var main_menu_scene := preload("uid://dgd30hd5wxqbf")
var place_for_tower_control_scene := preload('uid://dp7m0dcsucwl3')
var leaderboard_row_secene = preload("uid://da306r6rg5ck5")
var topic_names: Dictionary[Types, String] = {Types.ELECTRIC: 'science', Types.ARCHER: 'history', Types.ART: 'culture', Types.TREE: 'nature'}
var tower_prices: Dictionary[Types, int] = {Types.ELECTRIC: electric_tower_price, Types.ARCHER: archer_tower_price, Types.ART: art_tower_price, Types.TREE: tree_tower_price}
var tower_scenes: Dictionary[Types, PackedScene] = {Types.ELECTRIC: electric_tower , Types.ARCHER: archer_tower, Types.ART: art_tower, Types.TREE: tree_tower}
var max_question_level := 5
var is_campaign: bool = false
var plot: Array
var gold_after_wave: int = 75

var java_script := JavaScriptBridge.get_interface("window")
var volume: float = 0.5

func send_analytics(goal: String, params = {}):
	if OS.get_name() == 'Web':
		java_script.sendMetricGoal(goal, JSON.stringify(params))

class Properties:
	var power: int
	var min_count_in_group: int
	var max_count_in_group: int
	var scene: PackedScene
	func _init(power: int, min_count_in_group: int,  max_count_in_group: int, scene: PackedScene) -> void:
		self.power = power
		self.min_count_in_group = min_count_in_group
		self.max_count_in_group = max_count_in_group
		self.scene = scene
		
	
	
enum Enemies {FLY, SLIME, SKELETON, MUSHROOM_GOLEM}
var enemy_properties: Dictionary[Enemies, Properties]  = {
	Enemies.SLIME: Properties.new(250, 3, 6, preload("uid://bm1ng04ojad8f")),
	Enemies.FLY: Properties.new(150, 5, 9, preload("uid://841ivpjbv8wr")),
	Enemies.SKELETON: Properties.new(390, 2, 5, preload("uid://bcfbn4m7snohl")),
	Enemies.MUSHROOM_GOLEM: Properties.new(583, 1, 2, preload("uid://k1oxy458hcmj"))
	}

func slice_spritesheet(texture: Texture2D, rows: int, columns: int) -> Array[Texture2D]:
	var result: Array[Texture2D] = []
	var frame_size = Vector2i(texture.get_size().x / columns, texture.get_size().y / rows)
	for y in rows:
		for x in columns:
			var region := Rect2i(x * frame_size.x, y * frame_size.y, frame_size.x, frame_size.y)
			var sub_texture := AtlasTexture.new()
			sub_texture.atlas = texture
			sub_texture.region = region
			result.append(sub_texture)

	return result

const CONFIG_PATH = "user://session_data.cfg"
func _ready() -> void:
	gold = 600
	var file = FileAccess.open("res://plot.json", FileAccess.READ)
	if file != null:
		plot =  JSON.parse_string(file.get_as_text())
	if not FileAccess.file_exists(Global.CONFIG_PATH):
		var config = ConfigFile.new()
		config.save(CONFIG_PATH)
