extends Camera2D

var target_position = Vector2.ZERO
var background_color = Color("#dff6f5")

func _ready():
	VisualServer.set_default_clear_color(background_color)

func _process(delta):
	aquire_target_position()
	
	global_position = lerp(target_position, global_position, pow(2, -25 * delta))

func aquire_target_position():
	var players = get_tree().get_nodes_in_group("players")
	if (players.size() > 0):
		var player = players[0]
		target_position = player.global_position
