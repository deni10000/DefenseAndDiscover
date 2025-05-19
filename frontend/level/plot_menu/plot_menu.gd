extends Control
class_name PlotMenu
var speed := 0.02
@onready
var label := %Label
@onready
var button := %Button

func _ready() -> void:
	show_text("Жил-был в старом лесу могучий дуб. Он стоял на холме у опушки, раскинув свои ветви к небу, как будто обнимал солнце. Его звали Мудрый Дуб — не потому что он умел говорить, а потому что веками наблюдал за всем, что происходило вокруг, и знал больше, чем кто-либо в лесу.")

@onready
var player := %AudioStreamPlayer

func show_text(text: String):
	label.text = text
	button.visible = true
	await  %VBoxContainer.resized
	await  %VBoxContainer.resized
	var size =  %VBoxContainer.size
	label.text = ''
	button.visible = false
	%VBoxContainer.size = size
	player.volume_db = Music.master_volume_db - 20
	
	Music.stop()
	get_tree().paused = true

	visible = true
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.3).from(Color(1, 1, 1, 0))
	await  tween.finished
	await get_tree().create_timer(0.1).timeout
	for i in range(text.length()):
		label.text += text[i]

		if text[i] != ' ' and not player.playing:
			player.pitch_scale = randf_range(0.6, 0.8)
			player.play()

		await get_tree().create_timer(speed).timeout
	
	button.visible = true
	await button.pressed
	get_tree().paused = false
	visible = false
	Music.play()
	
