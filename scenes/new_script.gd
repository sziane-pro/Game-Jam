extends CanvasLayer
 
signal player_selected
 
var selected_player: int = 0
 
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
 
func show_player_selection():
	$Message.hide()
	$Player1Button.show()
	$Player2Button.show()
 
func _ready():
	selected_player = 0
 
func _process(delta):
	pass
 
func _on_player1_button_pressed():
	select_player(1)
 
func _on_player2_button_pressed():
	select_player(2)
 
func select_player(player_number):
	selected_player = player_number
	$Player1Button.hide()
	$Player2Button.hide()
	player_selected.emit(selected_player)
