extends Node

var mob_scene = preload("res://scenes/mob.tscn")
var lobby_scene = preload("res://scenes/Lobby_jeu.tscn")
var score
var player_choice

func _ready():
	$Lobby.connect("player_selected", _on_player_selected)
	score = 0

func _process(delta):
	pass

func game_over():
	$Music.stop()
	$GameOverSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	
	score = 0
	$Music.play()
	$StartTimer.start()
	$HUD.show_message("GET READY!")
	$HUD.update_score(0)
	$Player.start($StartPosition.position)
	

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	$HUD.show_message("")


func show_lobby():
	var lobby = lobby_scene.instance()
	if lobby:
		get_tree().root.add_child(lobby)
		lobby.show_player_selection()
	else:
		print("Erreur: Impossible de charger la scène du lobby.")
	

func _on_player_selected(selected_player):
	player_choice = selected_player
	show_game()

func show_game():
	# Effectuez les initialisations nécessaires
	# Par exemple, chargez la scène du jeu et effectuez d'autres configurations
	var game_scene = preload("res://scenes/main.tscn")
	var game = game_scene.instance()
	get_tree().current_scene.add_child(game)
	game.new_game()  # Initialisez le jeu avec le choix du personnage


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
	

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()

	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	var direction = mob_spawn_location.rotation + PI / 2;

	mob.position = mob_spawn_location.position;

	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)
