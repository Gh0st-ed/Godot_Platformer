extends Node

signal gained_coins(int)

var coins : int
var score : int = 0

var current_checkpoint : Checkpoint
var pause_menu
var win_screen
var score_label

var player : Player

var paused = false

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position

func gain_coins(coins_gained:int):
	coins += coins_gained
	emit_signal("gained_coins", coins_gained)
	print(coins)

func win():
	win_screen.visible  = true
	
	score_label.text = "score:" + str(score)


func pause_play():
	paused = !paused
	
	pause_menu.visible = paused

func resume():
	pause_play()

func restart():
	coins = 0
	score = 0
	get_tree().reload_current_scene()

func load_world():
	get_tree().change_scene_to_file("res://Scenes/WorldScenes/world_map.tscn")

func quit():
	get_tree().quit



