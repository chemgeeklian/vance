extends Control

# 对话内容数组
var dialogues = [
	"",
	"[Vance]\n......",
	"[???]\nVance.",
	"[Vance]\nOh, my dear president.",
	"[Vance]\nI love you, more than loving any eggs.",
	"[???]\nVance. You’ve worked so hard. \nMaybe the hardest ever.",
	"[???]\nPeople are saying you’re the best egg eater! \nTremendous.",
	"[???]\nAnd look at this—NASDAQ? 20,000 points. \nUnbelievable!",
	"[???]\nYou did brought it back!",
	"[???]\nAnd so I wasn't impeached! Fantastic! \nJust fantastic!!!",
	"[Vance]\nWell, sir, eatin’ so many eggs is definitely hard work.",
	"[Vance]\nBut hey, mission accomplished.",
	"[Vance]\nAnd your second, and final, term is finally over.",
	"[???]\n!!!Final?",
	"[???]\nFake news! Maybe the most fake news ever!",
	"[???]\n...Sir, calm down.",
	"[Vance]\nLet's just move on.",
	"[Vance]\nNow we can go back to Ohio and drive pickup truck."
]

# 当前对话索引
var current_index = 0
var dialogue_finished = false  # 标记对话是否结束

# 引用 Label 节点
@onready var dialogue_label = $Label

func _ready():
	# 设置文本颜色为黑色
	dialogue_label.add_theme_color_override("font_color", Color.BLACK)
	# 初始化对话文本
	dialogue_label.text = dialogues[current_index]

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if dialogue_finished:
			get_tree().change_scene_to_file("res://goodend.tscn")
			# 这个可能有问题因为和下面的get_tree()重复调用了
		else:
			advance_dialogue()  # 继续对话

func advance_dialogue():
	current_index += 1  # 增加对话索引
	if current_index < dialogues.size():
		dialogue_label.text = dialogues[current_index]  # 更新文本
	else:
		dialogue_finished = true  # 标记对话结束
		get_tree().change_scene_to_file("res://goodend.tscn")  # 立即切换场景
