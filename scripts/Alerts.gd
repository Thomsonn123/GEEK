extends Node2D


var made = [0, 0, 0]
export(NodePath) var Player

func walkedIn(body:Node, name):
	if body.name == "Player":
		if name == "Herbalist" and made[0] == 0:
			info("Witaj u zielarza")
			made[0] = 1
		elif name == "Alchemist" and made[1] == 0:
			info("Znalazłeś pracownie alchemiczną")
			made[1] = 1
		elif name == "Village" and made [2] == 0:
			info("Znalazłeś wioskę")
			made[2] = 1

func info(message):
	get_node(Player).tutHelp(message)
