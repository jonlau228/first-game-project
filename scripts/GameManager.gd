extends Node

var score : int = 0

func add_score(amount: int) -> void:
	score += amount
	print("Current Score: ", score)

func play_sfx(sound_stream: AudioStream) -> void:
	var p: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	add_child(p)
	p.stream = sound_stream
	p.bus = "SFX"
	p.play()
	p.finished.connect(p.queue_free)
