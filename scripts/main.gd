extends Node2D

func _ready() -> void:
	_setup_level()
	$GameOverUI.restart_pressed.connect(_restart_game)
	

func _setup_level() -> void:
	var player = $LevelRoot.get_node("Player")
# changed teh varible name from coins to cherries and now coin collecting works 
	var cherries = $LevelRoot.get_node_or_null("cherries")
	if cherries:
		for cherry in cherries.get_children():
			if cherry.has_signal("coins_collected"):
				cherry.coins_collected.connect(player._on_coin_collected)
				print("Connected cherry: ", cherry.name)# dont need cherry.name anymore but will keep just in case
	else:
		print("error, coins not in level root ")

func _on_player_died(body):
	$GameOverUI.show_game_over()

func _restart_game():
	get_tree().reload_current_scene()
