extends Node2D

export(NodePath) var Player
var herbs
var shop = false

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

#quest5
var quest5 = [2, 5, 0	, 50]
var quest5status = true
onready var buttonQuest5 = $Quests/Quest5/Button
onready var finishedLabelQuest5 = $Quests/Quest5/Label3

func open():
	herbs = get_node(Player).herbs
	refresh()

func changePage():
	shop = !shop
	refresh()

func refresh():
	$EQ/Label.text = str(herbs[0])
	$EQ/Label2.text = str(herbs[1])
	$EQ/Label3.text = str(herbs[2])

	if !quest1status && !quest2status && !quest3status && !quest4status && !quest5status:
		$Page.disabled = false
	else:
		$Page.disabled = true

	if shop:
		$Quests.visible = false
		$Shop.visible = true
		$Page.text = "Otwórz zadania"
	else:
		$Quests.visible = true
		$Shop.visible = false
		$Page.text = "Otwórz sklep"

	finishedLabelQuest1.visible = !quest1status
	finishedLabelQuest2.visible = !quest2status
	finishedLabelQuest3.visible = !quest3status
	finishedLabelQuest4.visible = !quest4status
	finishedLabelQuest5.visible = !quest5status
	buttonQuest1.disabled = quest1status
	buttonQuest2.disabled = quest2status
	buttonQuest3.disabled = quest3status
	buttonQuest4.disabled = quest4status
	buttonQuest5.disabled = quest5status

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
	if herbs[0] >= quest4[0] and herbs[1] >= quest4[1] and herbs[2] >= quest4[2] and quest4status:
		buttonQuest4.disabled = false
	else:
		buttonQuest4.disabled = true
	#quest5
	if herbs[0] >= quest5[0] and herbs[1] >= quest5[1] and herbs[2] >= quest5[2] and quest5status:
		buttonQuest5.disabled = false
	else:
		buttonQuest5.disabled = true

func GetWin(value):
	if value == "quest1":
		get_node(Player).money += quest1[3]
		herbs[0] -= quest1[0]
		herbs[1] -= quest1[1]
		herbs[2] -= quest1[2]
		quest1status = false
	if value == "quest2":
		herbs[0] -= quest2[0]
		herbs[1] -= quest2[1]
		herbs[2] -= quest2[2]
		get_node(Player).money += quest2[3]
		quest2status = false
	if value == "quest3":
		herbs[0] -= quest3[0]
		herbs[1] -= quest3[1]
		herbs[2] -= quest3[2]
		get_node(Player).money += quest3[3]
		quest3status = false
	if value == "quest4":
		herbs[0] -= quest4[0]
		herbs[1] -= quest4[1]
		herbs[2] -= quest4[2]
		get_node(Player).money += quest4[3]
		quest4status = false
	if value == "quest5":
		herbs[0] -= quest5[0]
		herbs[1] -= quest5[1]
		herbs[2] -= quest5[2]
		get_node(Player).money += quest5[3]
		quest5status = false
	refresh()
	get_node(Player).herbs = herbs
	



