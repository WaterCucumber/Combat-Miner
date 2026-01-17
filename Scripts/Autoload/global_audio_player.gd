extends Node

# Signals
# Enums
# Consts
# Static vars
# Public vars
# Export vars
# Onready vars
# Private vars

# Funcs
#region Public funcs

func play_sound(stream: AudioStream, loop := false,
		volume_db : float = -5) -> AudioStreamPlayer:
	var player := AudioStreamPlayer.new()
	player.stream = stream
	player.pitch_scale = randf_range(0.8, 1.2)
	player.volume_db = volume_db
	if not loop: player.finished.connect(player.queue_free)
	add_child(player)
	player.play()
	return player


func play_music(stream: AudioStream, volume_db : float = -10) -> AudioStreamPlayer:
	var player := AudioStreamPlayer.new()
	player.stream = stream
	player.volume_db = volume_db
	add_child(player)
	player.play()
	return player


#endregion

#region Virtual funcs

#endregion

#region Private funcs

#endregion

#region Godot funcs

#endregion

#region Signal funcs

#endregion
