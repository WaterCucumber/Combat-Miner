extends Button
class_name ChangeSceneButton

@export var transition : Transition
@export_file("*.tscn") var to_scene : String

func _pressed() -> void:
	transition.fade_to_scene(to_scene)
	disabled = true
