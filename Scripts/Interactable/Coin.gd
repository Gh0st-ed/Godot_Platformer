extends Node2D

func _on_area_2d_area_entered(_area):
	GameManager.gain_coins(1)
	GameManager.score +- 50
	queue_free()
	
