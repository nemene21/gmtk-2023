extends Node

func _ready():
	add_sound("gun_shoot", "res://sfx/gunshot.mp3")
	add_sound("enemy_spawn", "res://sfx/enemyspawn.mp3")
	add_sound("money_collect", "res://sfx/Crystal.mp3")
	add_sound("player_hit", "res://sfx/Playerhit.mp3")
	add_sound("wave_start", "res://sfx/wave spawn.mp3")
	add_sound("enemy_hit", "res://sfx/Alienhit.mp3")
	add_sound("enemy_kill", "res://sfx/Alienkill.mp3")
	add_sound("leave_menu", "res://sfx/leavemenu.mp3")
	add_track("battle", "res://music/battle.mp3")
	add_track("menu", "res://music/Menu.mp3")
	process_mode = Node.PROCESS_MODE_ALWAYS

# Sound effects
var sounds = {}

func add_sound(name : String, path : String):
	sounds[name] = load(path)
	
func play_sound(name: String, pitch: float = 1.0, volume: float = 1.0, pitch_rand: float = .0, volume_rand: float = .0):
	var player = AudioStreamPlayer.new()
	
	player.stream = sounds[name]
	player.connect("finished", player.queue_free)
	
	player.set_bus("SFX")
	player.pitch_scale = pitch + randf_range(-pitch_rand, pitch_rand)
	player.volume_db = linear_to_db(volume + randf_range(-volume_rand, volume_rand))
	
	add_child(player)
	player.play()
	
	return player
	
func play_sound2d(name: String, position: Vector2, pitch: float = 1.0, volume: float = 1.0, pitch_rand: float = .0, volume_rand: float = .0):
	var player = AudioStreamPlayer2D.new()
	
	player.stream = sounds[name]
	player.connect("finished", player.queue_free)
	
	player.global_position = position
	
	player.set_bus("SFX")
	player.pitch_scale = pitch + randf_range(-pitch_rand, pitch_rand)
	player.volume_db = linear_to_db(volume + randf_range(-volume_rand, volume_rand))
	
	add_child(player)
	player.play()
	
	return player

# Tracks
var tracks = {}
var last_track = null

func add_track(name : String, path : String):
	var track_node = AudioStreamPlayer.new()
	track_node.stream = load(path)
	track_node.stream.loop = true
	track_node.volume_db = -80
	track_node.set_bus("Music")
	
	add_child(track_node)
	
	tracks[name] = track_node
	

func play_track(name : String, fade_time : float = 0.5):
	
	if name == last_track: return
	
	if last_track != null:
		var tween = get_tree().create_tween()
		tween.tween_property(tracks[last_track], "volume_db", -80, fade_time).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

	var tween = get_tree().create_tween()
	tween.tween_property(tracks[name], "volume_db", -5, fade_time).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	
	tracks[name].play()
	
	if last_track != null:
		var new_tween = get_tree().create_tween()
		new_tween.tween_property(tracks[last_track], "volume_db", -80, fade_time).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

		await get_tree().create_timer(fade_time).timeout
		tracks[last_track].stop()
	
	last_track = name
	
