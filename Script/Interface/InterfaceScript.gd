extends Control
@onready var fDialog: FileDialog = $FileDialog
@onready var tunePlayer: AudioStreamPlayer = $"../AudioPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	print(fDialog)
	fDialog.visible = true
	pass # Replace with function body.


func _on_play_pressed() -> void:
	print(tunePlayer)
	tunePlayer.play(0)
	pass # Replace with function body.


func _on_file_dialog_file_selected(path: String) -> void:
	var newAudio:AudioStreamMP3 = AudioStreamMP3.load_from_file(path)
	tunePlayer.stream = newAudio
	print(tunePlayer)
	pass # Replace with function body.
