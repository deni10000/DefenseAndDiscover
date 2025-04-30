extends Node

enum Types {ELECTRIC, ARCHER, ART, TREE}

signal gold_changed
signal start_question(type: Types)
signal question_completed(is_successful: bool)

var gold : int:
	set(v):
		gold = v
		gold_changed.emit()
var archer_tower_price : int = 100
var electric_tower_price : int = 150
var art_tower_price : int = 150
var tree_tower_price : int = 200
var archer_tower := preload("uid://dblmp648wldnf")
var electric_tower := preload("uid://sqp3gbqgta6a")
var art_tower := preload("uid://bdth5uwj86qyt")
var arrow := preload("uid://d2bj3yntbkiuu")
var tree_tower := preload("uid://6a7dry2en0la")
var level_scene := preload("uid://mahg2nbldblf")
var main_menu_scene := preload("uid://dgd30hd5wxqbf")
var java_script := JavaScriptBridge.get_interface("window")
var volume: float = 0.5

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
		
	
	
enum Enemies {SLIME}
var enemy_properties: Dictionary[Enemies, Properties]  = {Enemies.SLIME : Properties.new(100, 3, 7, preload("uid://bm1ng04ojad8f"))}

func _ready() -> void:
	gold = 4000
