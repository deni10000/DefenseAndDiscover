extends Control
var question_time = 7
var await_time = 2
signal correct_answer
signal incorrect_answer
signal button_pressed(i) 

@onready var children = %GridContainer.get_children()
@onready var filling: StyleBoxFlat = %ProgressBar.get_theme_stylebox("fill")

func _on_any_button_pressed(i):
	button_pressed.emit(i)

func _ready() -> void:
	for i in range(len(children)):
		children[i].pressed.connect(_on_any_button_pressed.bind(i))

func start_question(question: String, answers: Array[String], correct_answer_index: int):
	if len(answers) != 4 or correct_answer_index > 3 or correct_answer_index < 0:
		incorrect_answer.emit()
		return
	visible = true
	for i in range(len(children)):
		var button: Button = children[i]
		button.text = answers[i]
	%Label.text = question
	var prev_color = filling.bg_color
	var tween := get_tree().create_tween()
	tween.set_parallel()
	
	tween.finished.connect(_on_any_button_pressed.bind(-1))
	tween.tween_property(%ProgressBar,  "value", 0, question_time).from(%ProgressBar.max_value)
	
	var modulate_tween := create_tween()
	modulate_tween.tween_interval(0.6 * question_time)
	modulate_tween.tween_property(filling, "bg_color", Color.RED, 0.4 * question_time)
	
	tween.tween_subtween(modulate_tween)
	
	var res = await button_pressed
	tween.stop()
	var timer := get_tree().create_timer(await_time)
	children[correct_answer_index].modulate = Color.GREEN
	if res == -1 or res != correct_answer_index:
		incorrect_answer.emit()
		if res != -1:
			children[res].modulate = Color.INDIAN_RED
		else:
			for i in range(len(children)):
				if i != correct_answer_index:
					children[i].modulate = Color.INDIAN_RED
					
	else:
		correct_answer.emit()
	await timer.timeout
	visible = false
	filling.bg_color = prev_color
	for i in range(len(children)):
		children[i].modulate = Color.WHITE
	
