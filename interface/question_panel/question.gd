extends Control
var timer_time = 3
signal correct_answer
signal incorrect_answer
signal button_pressed(i) 

@onready var children = %GridContainer.get_children()

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
	var tween := get_tree().create_tween()
	tween.finished.connect(_on_any_button_pressed.bind(-1))
	tween.tween_property(%ProgressBar,  "value", 0, timer_time).from(%ProgressBar.max_value)
	var res = await button_pressed
	if res == -1 or res != correct_answer_index:
		incorrect_answer.emit()
	else:
		correct_answer.emit()
