extends Node2D

export(NodePath) var Player
#quest1
var quest1 = [5, 0, 0, 50]
var quest1status = true
onready var buttonQuest1 = $Quests/Quest1/Button
onready var finishedLabelQuest1 = $Quests/Quest1/Label3

#quest2
var quest2 = [0, 1, 0, 50]
var quest2status = true
onready var buttonQuest2 = $Quests/Quest2/Button
onready var finishedLabelQuest2 = $Quests/Quest2/Label3

#quest3
var quest3 = [0, 0, 7, 50]
var quest3status = true
onready var buttonQuest3 = $Quests/Quest3/Button
onready var finishedLabelQuest3 = $Quests/Quest3/Label3

#quest4
var quest4 = [4, 0, 7, 50]
var quest4status = true
onready var buttonQuest4 = $Quests/Quest4/Button
onready var finishedLabelQuest4 = $Quests/Quest4/Label3

func open():
	var herbs = get_node(Player).herbs
	#quest1
	if herbs[0] >= quest1[0] and herbs[1] >= quest1[1] and herbs[2] >= quest1[2] and quest1status:
		buttonQuest1.disabled = false
	else:
		buttonQuest1.disabled = true
	#quest2
	if herbs[0] >= quest2[0] and herbs[1] >= quest2[1] and herbs[2] >= quest2[2] and quest2status:
		buttonQuest2.disabled = false
	else:
		buttonQuest2.disabled = true
	#quest3
	if herbs[0] >= quest3[0] and herbs[1] >= quest3[1] and herbs[2] >= quest3[2] and quest3status:
		buttonQuest3.disabled = false
	else:
		buttonQuest3.disabled = true
	#quest4
	if herbs[0] >= quest4[0] and herbs[1] >= quest4[1] and herbs[2] >= quest4[2] and quest3status:
		buttonQuest4.disabled = false
	else:
		buttonQuest4.disabled = true
	
	refresh()

func refresh():
	finishedLabelQuest1.visible = !quest1status
	finishedLabelQuest2.visible = !quest2status
	finishedLabelQuest3.visible = !quest3status
	finishedLabelQuest4.visible = !quest4status

func GetWin(value):
	if value == "quest1":
		get_node(Player).money += quest1[3]
		buttonQuest1.disabled = true
		quest1status = false
		refresh()
	if value == "quest2":
		get_node(Player).money += quest2[3]
		buttonQuest2.disabled = true
		quest2status = false
		refresh()
	if value == "quest3":
		get_node(Player).money += quest3[3]
		buttonQuest3.disabled = true
		quest3status = false
		refresh()
	if value == "quest3":
		get_node(Player).money += quest3[3]
		buttonQuest3.disabled = true
		quest3status = false
		refresh()
	if value == "quest4":
		get_node(Player).money += quest4[3]
		buttonQuest4.disabled = true
		quest4status = false
		refresh()



