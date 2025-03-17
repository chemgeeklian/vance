extends Node2D
		
@onready var treemap = $TreeMap
var speed: float = 20.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var min_scale = 0.05  # Minimum scale
	var max_scale = 0.6   # Adjust this based on the game's max scale

	# Normalize scale between 0 and 1
	var scale_factor = clamp(($VanceFace.scale.x - min_scale) / (max_scale - min_scale), 0, 1)

	# Map scale_factor (0-1) to frame range (1-3)
	var frame = int(round(lerp(0,2, scale_factor)))

	$VanceFace.set_frame(frame)
	$Label_egg.self_modulate = Color(0,0,0,1)

func _on_timer_timeout():
	
	var rddn = randi_range(7, 14)
	nasidx = nasidx - rddn * speed
	
	#treemap.self_modulate = Color(1.0, 0.7, 0.7)
	$TextureButton.set_scale(Vector2(0.3,0.3))
	$Label.text = "NASDAQ INDEX\n         " + str(nasidx)
	$Label.self_modulate = Color(1,0.5,0.5,1)
	$Label_egg.text = str(egg)
	
	if nasidx < 15000:
		get_tree().change_scene_to_file("res://badend.tscn")
		return
		
	if egg < 12:
		egg += 1
	
	keyboard_position *= -1
	$keyboard.position = $keyboard.position + Vector2(0, keyboard_position)
	
	$Vance.set_frame(0) # make vance's body go back to normal
	$singleegg.set_frame(0) # egg disappear
		
	if $VanceFace.scale < Vector2(0.1, 0.1):
		return
	#$VanceFace.scale -= Vector2(rddn/50, rddn/50)
	$VanceFace.scale -= Vector2(0.05, 0.05)

var nasidx: int = 17000
var egg: int = 9
var keyboard_position = 5
		
func _on_texture_button_pressed():
	$TextureButton.set_scale(Vector2(0.32,0.32))
	$VanceFace.scale += Vector2(0.05, 0.05)
	$Vance.set_frame(1) # set Vance body to eat egg
	$singleegg.set_frame(1) # make the egg appear
	
	var rdn = randi_range(8, 14)
	nasidx = nasidx + rdn * speed * 1.06
	#$VanceFace.scale += Vector2(rdn/50, rdn/50)
	
	egg = egg - 1
	$Label_egg.text = str(egg)
	$Label.self_modulate = Color(0.5,1,0.5,1)
	$Label.text = "NASDAQ INDEX\n         " + str(nasidx)
	#treemap.self_modulate = Color(0.7, 1.0, 0.7)

	if egg < 1:
		get_tree().change_scene_to_file("res://deadend.tscn")
		return
	
	if nasidx > 20000:
		get_tree().change_scene_to_file("res://story.tscn")
