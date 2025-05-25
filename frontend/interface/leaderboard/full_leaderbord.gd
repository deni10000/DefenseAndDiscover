extends Control

var row_scene = preload("uid://d3h4dvey07doa")
var leaderBoardRows: Array

func fill_leaderboard():
	var res = await Http.get_waves()
	#res = Http.LeaderBoardDto.new([{'username': 'alex', 'countWave': 10}])
	if res == null:
		return
	for x in leaderBoardRows:
		x.queue_free()
	leaderBoardRows.clear()
	
	res = res as Http.LeaderBoardDto
	for i in range(len(res.users)):
		var x: Http.UserScore = res.users[i]
		var row = row_scene.instantiate()
		row.set_values(i + 1, x.username, x.count_wave)
		leaderBoardRows.append(row)
		%VBoxContainer.add_child(row)

func show_leaderbord():
	await fill_leaderboard()
	visible = true
	

func _on_cross_button_pressed() -> void:
	visible = false
