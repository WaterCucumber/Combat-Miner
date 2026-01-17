# Make it Autoload to run
extends Node

var loading_screen := preload("res://Addons/Loading/Scenes/loading_screen.tscn") # Change to your path or uid
var next_scene : String = [
		"res://Scenes/UI/menu.tscn", 
		"res://Scenes/test.tscn"
	][0] # Change to your menu scene

func load_scene(path: String, canvas_layer: CanvasLayer = null):
	next_scene = path
	var v = loading_screen.instantiate()
	if canvas_layer:
		canvas_layer.add_child(v)
	else:
		get_tree().root.add_child(v)
