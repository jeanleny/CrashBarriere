extends Node

@onready var fDialog: FileDialog = $FileDialog
@onready var audioPlayer: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fDialog.root_subfolder = "/"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_file_dialog_file_selected(path: String) -> void:
	var newAudio:AudioStreamMP3 = AudioStreamMP3.load_from_file(path)
	audioPlayer.stream = newAudio
	audioPlayer.play(0)
	pass # Replace with function body.
