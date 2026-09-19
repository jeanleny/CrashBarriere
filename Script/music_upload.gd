extends Node

@onready var fDialog: FileDialog = $"."
@onready var audioPlayer: AudioStreamPlayer = $"../../../MixingAudio"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fDialog.root_subfolder = "/"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_file_dialog_file_selected(path: String) -> void:
	pass # Replace with function body.
