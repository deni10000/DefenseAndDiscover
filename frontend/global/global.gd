extends Node

enum Types {ELECTRIC, ARCHER, ART, TREE}

signal gold_changed
signal start_question(type: Types)
signal question_completed(is_successful: bool)

var gold : int:
	set(v):
		gold = v
		gold_changed.emit()
var archer_tower_price : int = 115 #было 100
var electric_tower_price : int = 150
var art_tower_price : int = 170 #было 150
var tree_tower_price : int = 200
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
var analytics_id:
	set(value):
		analytics_id = int(value)
		load_metrika(analytics_id)

var java_script := JavaScriptBridge.get_interface("window")
var volume: float = 0.5

func send_analytics(goal: String):
	if OS.get_name() == 'Web':
		JavaScriptBridge.eval("ym(%d, 'reachGoal', '%s')" % [analytics_id, goal])

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

func load_metrika(counter_id: int):
	var code := """
	   (function(m,e,t,r,i,k,a){m[i]=m[i]||function(){(m[i].a=m[i].a||[]).push(arguments)};
	   m[i].l=1*new Date();
	   for (var j = 0; j < document.scripts.length; j++) {if (document.scripts[j].src === r) { return; }}
	   k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a)})
	   (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");

	   ym(%d, "init", {
			clickmap:true,
			trackLinks:true,
			accurateTrackBounce:true
	   });	
	""" % counter_id
	JavaScriptBridge.eval(code)

func _ready() -> void:
	gold = 600
