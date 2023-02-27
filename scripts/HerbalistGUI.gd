extends Node2D

export(NodePath) var Player
var herbs
var shop = false
var melisaValue = 0
var dandelionValue = 0
var poppyValue = 0
var firstOpen = true

#prices
var melisaPrice = [7, 5]
var dandelionPrice = [10, 8]
var poppyPrice = [5, 3]

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

var wasDubbing = false
var herbalistDubbing = load("res://sounds/zielarz.mp3")

func open():
	if firstOpen:
		if !wasDubbing:
			wasDubbing = true
			$Audio.stream = herbalistDubbing
			$Audio/Timer.wait_time = $Audio.stream.get_length()
			$Audio/Timer.start()
			$Audio.play()
		firstOpen = false
	herbs = get_node(Player).herbs
	refresh()

func changePage():
	shop = !shop
	refresh()

func valueChanged(value, name):
	if name == "melisa":
		melisaValue = value
	elif name == "dandelion":
		dandelionValue = value
	elif name == "poppy":
		poppyValue = value
	refresh()

func refresh():
	#GUI update
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
	#shop
	#buy
	var playerMoney = get_node(Player).money
	if melisaValue * melisaPrice[0] > playerMoney:
		$Shop/MelisaBuy.disabled = true
	else:
		$Shop/MelisaBuy.disabled = false
	if dandelionValue * dandelionPrice[0] > playerMoney:
		$Shop/DandelionBuy.disabled = true
	else:
		$Shop/DandelionBuy.disabled = false
	if poppyValue * poppyPrice[0] > playerMoney:
		$Shop/PoppyBuy2.disabled = true
	else:
		$Shop/PoppyBuy2.disabled = false
	
	#sell
	if melisaValue <= herbs[0]:
		$Shop/MelisaBuy/Melisasell.disabled = false
	else:
		$Shop/MelisaBuy/Melisasell.disabled = true
	if dandelionValue <= herbs[1]:
		$Shop/DandelionBuy/Dandelionsell.disabled = false
	else:
		$Shop/DandelionBuy/Dandelionsell.disabled = true
	if poppyValue <= herbs[2]:
		$Shop/PoppyBuy2/Poppysell.disabled = false
	else:
		$Shop/PoppyBuy2/Poppysell.disabled = true
	
	$Shop/MelisaBuy/MelisasellAll.disabled = $Shop/MelisaBuy/Melisasell.disabled
	$Shop/DandelionBuy/DandelionsellAll.disabled = $Shop/DandelionBuy/Dandelionsell.disabled
	$Shop/PoppyBuy2/PoppysellAll.disabled = $Shop/PoppyBuy2/Poppysell.disabled
	
func GetWin(value):
	#quests
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
	get_node(Player).addMoney(50)
	get_node(Player).herbs = herbs

func buy(name):
	if name == "melisa":
		herbs[0] += melisaValue
		price(melisaValue * melisaPrice[0] * -1)
	if name == "dandelion":
		herbs[1] += dandelionValue
		price(dandelionValue * dandelionPrice[0] * -1)
	elif name == "poppy":
		herbs[2] += poppyValue
		price(poppyValue * poppyPrice[0] * -1)
	print(herbs)
	refresh()

func sell(name):
	if name == "melisa":
		herbs[0] -= melisaValue
		price(melisaValue * melisaPrice[1])
	if name == "dandelion":
		herbs[1] -= dandelionValue
		price(dandelionValue * dandelionPrice[1])
	elif name == "poppy":
		herbs[2] -= poppyValue
		price(poppyValue * poppyPrice[1])
	print(herbs)
	refresh()

func sellAll(name):
	if name == "melisa":
		melisaValue = herbs[0]
	elif name == "dandelion":
		dandelionValue = herbs[1]
	elif name == "poppy":
		poppyValue = herbs[2]
	sell(name)

func price(priceValue):
	get_node(Player).money += priceValue
	refresh()
	$Shop/MelisaValue/SpinBox.set_value(0)
	$Shop/DandelionValue2/SpinBox.set_value(0)
	$Shop/PoppyValue2/SpinBox.set_value(0)
	melisaValue = $Shop/MelisaValue/SpinBox.get_value()
	dandelionValue = $Shop/DandelionValue2/SpinBox.get_value()
	poppyValue = $Shop/PoppyValue2/SpinBox.get_value()

func dubbingFinish():
	$Audio.queue_free()