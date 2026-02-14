extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.has_singleton("MusicPlayer") and Engine.get_singleton("MusicPlayer") != self:
		queue_free()
		return
		
	if not is_playing():
		play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
