extends Control

const ALLOWED_SPECIALS = "!@#$%^&*()_+-=[]{}|;:'\",.<>?/ "
var email: String:
	set(value):
		%EmailInput.text = value
		%EmailInput2.text = value
		%EmailLine.text = value
		email = value
var nickname: String:
	set(value):
		%NicknameInput.text = value
		%NicknameInput2.text = value
		%NicknameLine.text = value
		nickname = value

func _ready():
	%TabContainer.set_tab_title(0, 'Профиль')
	%TabContainer.set_tab_title(1, 'Статистика')
	var tab_bar: TabBar = %TabContainer.get_tab_bar()
	tab_bar.max_tab_width

	
	for node in get_tree().get_nodes_in_group("text_fields") + find_children("", "LineEdit"):
		if node is LineEdit:
			node.gui_input.connect(_on_line_edit_gui_input)
	%ConfirmationButton.gui_input.connect(_only_numbers_line_edit)

func _only_numbers_line_edit(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode in [KEY_BACKSPACE, KEY_DELETE, KEY_ENTER, KEY_LEFT, KEY_RIGHT]:
			return

		var char_str = char(event.unicode)

		if not (char_str >= "0" and char_str <= "9"):
			get_viewport().set_input_as_handled()

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
		if 'error' in dct:
			if Http.token == "":
				%Authorization.visible = true
			else:
				%AcceptDialog.visible = true
		else:
			email = dct["email"]
			nickname = dct["login"]
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


func _on_volume_slider_value_changed(value: float) -> void:
	Global.volume = value
	

func _on_settings_button_pressed() -> void:
	%Settings.visible = true



func _on_registration_button_pressed() -> void:
	enable_waiting()
	var ret = await Http.register_user(%EmailLineEdit.text, %LoginLineEdit.text, %PasswordLineEdit.text)
	if 'error' not in ret:
		%Registration.visible = false
		$ConfirmationMenu.visible = true	
	disable_waiting()


func _on_confirmation_cross_button_pressed() -> void:
	$ConfirmationMenu.visible = false
	%ConfirmationLineEdit.text = ''


func _on_confirmation_button_pressed() -> void:
	enable_waiting()
	var ret = await Http.confirm_user(%EmailLineEdit.text, %LoginLineEdit.text, %PasswordLineEdit.text, %ConfirmationLineEdit.text)
	if 'error' not in ret:
		$ConfirmationMenu.visible = false
		%ConfirmationLineEdit.text = ''
	disable_waiting()


func _on_exit_button_pressed() -> void:
	Http.token = ''
	if OS.get_name() == 'Web':
		Global.java_script.setCookie("token", "", 0)
	%Profile.visible = false


func _on_authorization_button_pressed() -> void:
	enable_waiting()
	var ret = await Http.login_user(%EmailLineEdit2.text, %PasswordLineEdit2.text)
	if 'error' not in ret:
		%Authorization.visible =false
	disable_waiting()


func _on_recover_password_button_pressed() -> void:
	%GetPassword.visible = true
