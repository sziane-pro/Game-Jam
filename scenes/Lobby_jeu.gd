# lobby_jeu.gd

extends CanvasLayer

signal player_selected

var selected_player: int = 0

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_player_selection():
	$Message.hide()
	$Napoleon.show()
	$LaraCroft.show()

func _ready():
	selected_player = 0

func _process(delta):
	pass

func _on_napoleon_pressed():
	Global.selectedPlayer = 1  # Mettez à jour la variable globale
	player_selected.emit(Global.selectedPlayer)
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_lara_croft_pressed():
	Global.selectedPlayer = 2  # Mettez à jour la variable globale
	player_selected.emit(Global.selectedPlayer)
	get_tree().change_scene_to_file("res://scenes/main.tscn")
