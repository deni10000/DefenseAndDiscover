extends Control

const ALLOWED_SPECIALS = "!@#$%^&*()_+-=[]{}|;:'\",.<>?/ "
var email: String:
	set(value):
		%EmailInput.text = value
		email = value
var nickname: String:
	set(value):
		%NicknameInput.text = value
		nickname = value

func _ready():
	for node in get_tree().get_nodes_in_group("text_fields") + find_children("", "LineEdit"):
		if node is LineEdit:
			node.gui_input.connect(_on_line_edit_gui_input)

func _on_line_edit_gui_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode in [KEY_BACKSPACE, KEY_DELETE, KEY_ENTER, KEY_LEFT, KEY_RIGHT]:
			return

		var char_str = char(event.unicode)

		if not ((char_str >= "A" and char_str <= "Z") or 
				(char_str >= "a" and char_str <= "z") or 
				(char_str >= "0" and char_str <= "9") or 
				char_str in ALLOWED_SPECIALS):
			get_viewport().set_input_as_handled()

func enable_waiting():
	$WaitingScreen.visible = true

func disable_waiting():
	$WaitingScreen.visible = false

func _on_cross_button_pressed() -> void:
	%Authorization.visible = false
	%Registration.visible = false
	%Profile.visible = false

	
func _on_profile_button_pressed() -> void:
	%Registration.visible = false
	if Http.token == "":
		%Authorization.visible = true
	else:
		enable_waiting()
		var dct = await Http.get_user()
		dct = {"email": "aagag", "nickname": "aboba"}
		if dct.is_empty():
			if Http.token == "":
				%Authorization.visible = true
			else:
				%AcceptDialog.visible = true
		else:
			email = dct["email"]
			nickname = dct["nickname"]
			%Profile.visible = true
		disable_waiting()
			

func _on_create_account_pressed() -> void:
	%Authorization.visible = false
	%Registration.visible = true

func _on_login_button_pressed() -> void:
	%Authorization.visible = true
	%Registration.visible = false


func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_packed(Global.level_scene)


func _on_check_statistic_pressed() -> void:
	%StatisticMenu.visible = true


func _on_statistic_cross_button_pressed() -> void:
	%StatisticMenu.visible = false
