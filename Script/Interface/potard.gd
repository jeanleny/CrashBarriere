extends Area2D

var inside :bool = false
@onready var potar: Sprite2D = $Potar
var mPos: float
@onready var audio: AudioStreamPlayer = $"../MixingAudio"
var bus = AudioServer.get_bus_index("MixBus")
var low = AudioServer.get_bus_effect()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if inside and Input.is_action_pressed("left_click") :
		mPos = potar.global_position.angle_to_point(get_global_mouse_position())
		if rad_to_deg(mPos) > 130 or rad_to_deg(mPos) < 50 :
			potar.rotation = mPos 
		print(rad_to_deg(potar.rotation))

func _on_mouse_entered() -> void:
	inside = true

func _on_mouse_exited() -> void:
	inside = false
