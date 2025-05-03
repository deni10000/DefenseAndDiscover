extends HBoxContainer

func is_text_clipped(label: Label) -> bool:
	var font := label.get_theme_font("font")
	var font_size := label.get_theme_font_size("font_size")
	var text_width := font.get_string_size(label.text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
	return text_width > label.get_size().x

func set_params(number, nickname, waves):
	$Label.text = number
	$Label2.text = nickname
	$Label3.text = waves

func set_bold():
	for x in get_children():
		x.add_theme_color_override("font_color", Color.YELLOW)

func _process(delta: float) -> void:
	resize()

func resize():
	for x: Label in get_children():
		if is_text_clipped(x):
			x.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
