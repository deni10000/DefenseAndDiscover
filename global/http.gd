extends Node

var base_url := "https://example.com"
var token := "laglagl"
var cookie_time = 30

const TIMEOUT_SECONDS := 4.0

func  _ready() -> void:
	if OS.get_name() == 'Web':
		var dop = Global.java_script.getCookie("token")
		if dop != null:
			token = dop

func _create_http_request() -> HTTPRequest:
	var http_request := HTTPRequest.new()
	add_child(http_request)
	http_request.timeout = TIMEOUT_SECONDS
	return http_request

func _send_request(http_request: HTTPRequest, method: int, url: String, data: Dictionary = {}, auth: bool = false) -> Dictionary:
	var headers := ["Content-Type: application/json"]
	if auth:
		headers.append("Authorization: Bearer %s" % token)

	var body := JSON.stringify(data)
	var error := http_request.request(base_url + url, headers, method, body)
	if error != OK:
		http_request.queue_free()
		return {}

	var result = await http_request.request_completed
	http_request.queue_free()
	if result[0] != HTTPRequest.Result.RESULT_SUCCESS:
		return {}
	var response_code = result[1]
	var response_body = result[3].get_string_from_utf8()
	
	if response_code == 403:
		token = ''
		if OS.get_name() == 'Web':
			Global.java_script.setCookie("token", "", cookie_time)
	
	if response_code in [200, 201]:
		var json = JSON.parse_string(response_body)
		return json if typeof(json) == TYPE_DICTIONARY else {}
	return {}

# ========== AUTH ==========

func register_user(email: String, password: String) -> Dictionary:
	return await _send_request(_create_http_request(), HTTPClient.METHOD_POST, "/api/regUser", {
		"email": email,
		"password": password
	})

func confirm_user(email: String, code: int) -> Dictionary:
	var response := await _send_request(_create_http_request(), HTTPClient.METHOD_POST, "/api/confirmation", {
		"email": email,
		"code": code
	})
	if response.has("token"):
		token = response["token"]
		if OS.get_name() == 'Web':
			Global.java_script.setCookie("token", token, cookie_time)
	return response

func login_user(email: String, password: String) -> Dictionary:
	var response := await _send_request(_create_http_request(), HTTPClient.METHOD_POST, "/api/login", {
		"email": email,
		"password": password
	})
	if response.has("token"):
		token = response["token"]
		if OS.get_name() == 'Web':
			Global.java_script.setCookie("token", token, cookie_time)
	return response

# ========== USER ==========

func get_user() -> Dictionary:
	return await _send_request(_create_http_request(), HTTPClient.METHOD_GET, "/api/user", {}, true)

func delete_user() -> Dictionary:
	return await _send_request(_create_http_request(), HTTPClient.METHOD_DELETE, "/api/user", {}, true)

func update_user(email: String, password: String) -> Dictionary:
	return await _send_request(_create_http_request(), HTTPClient.METHOD_PATCH, "/api/user", {
		"email": email,
		"password": password
	}, true)

# ========== QUIZ ==========

func get_question(category: String) -> Dictionary:
	return await _send_request(_create_http_request(), HTTPClient.METHOD_POST, "/api/getQuestion", {
		"category": category
	})

func send_stat(category: String, correct_answers: int) -> Dictionary:
	return await _send_request(_create_http_request(), HTTPClient.METHOD_POST, "/api/stat", {
		"category": category,
		"correctAnswers": correct_answers
	}, true)

func get_stat() -> Dictionary:
	return await _send_request(_create_http_request(), HTTPClient.METHOD_GET, "/api/stat", {}, true)
