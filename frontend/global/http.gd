extends Node

var base_url := "http://127.0.0.1:8000"
var token := ''
var user_name := ''
var cookie_time = 30

const TIMEOUT_SECONDS := 4.0

func  _ready() -> void:
	if OS.get_name() == 'Web':
		var dop = Global.java_script.getCookie("token")
		if dop != null:
			token = dop

func _create_http_request() -> HTTPRequest:
	var http_request := HTTPRequest.new()
	http_request.process_mode =Node.PROCESS_MODE_ALWAYS
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
		return {'error':''}

	var result = await http_request.request_completed
	http_request.queue_free()
	if result[0] != HTTPRequest.Result.RESULT_SUCCESS:
		return {'error':''}
	var response_code = result[1]
	var response_body = result[3].get_string_from_utf8()
	
	if response_code == 403:
		token = ''
		if OS.get_name() == 'Web':
			Global.java_script.setCookie("token", "", 0)
	
	if response_code / 100 == 2:
		var json = JSON.parse_string(response_body)
		return json if typeof(json) == TYPE_DICTIONARY else {}
	return {'error':''}

# ========== AUTH ==========

func register_user(email: String, login:String, password: String) -> Dictionary:
	return await _send_request(_create_http_request(), HTTPClient.METHOD_POST, "/api/regUser", {
		"email": email,
		"password": password,
		"login": login
	})

func confirm_user(email: String, login:String, password: String, code: String) -> Dictionary:
	var response := await _send_request(_create_http_request(), HTTPClient.METHOD_POST, "/api/confirmation/" + str(code), {
		"email": email,
		"password": password,
		"login": login
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
class QuestionDto:
	var qeustion_id: String
	var question: String
	var options: Array
	func _init(dct: Dictionary):
		qeustion_id = dct['questionId']
		question = dct['question']
		options = dct['options'] 

func get_question(category: String, difficulty: int):
	if user_name == '' and token != '':
		var res = await get_user()
		if 'error' not in res:
			user_name = res['login']
	var dct = await _send_request(_create_http_request(), HTTPClient.METHOD_POST, "/api/getQuestion", {
		'username': user_name,
		'prompt': {
			"topic": category,
			"difficulty": str(difficulty),
			"keyWords": []
		}
	})
	if 'error' in dct:
		return null
	return QuestionDto.new(dct)

class AnswerDto:
	var user_name: String
	var is_correct: bool
	var correct_answer: String
	func _init(dct: Dictionary):
		user_name = dct['userName']
		is_correct = dct['isCorrect']
		correct_answer = dct['correctAnswer']
	
func post_answer(question_id: String, answer: String):
	var res = await _send_request(_create_http_request(), HTTPClient.METHOD_POST, "/api/postAnswer", {
		'username': user_name,
		'questionId': question_id,
		'answer': answer
	})
	if 'error' in res:
		return null
	return AnswerDto.new(res)
