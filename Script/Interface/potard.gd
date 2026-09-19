extends Area2D

@export var filter: AudioEffect
@export var div : float
@export var mul : float
@export var add : float
@export var busIndex : int

@onready var potar: Sprite2D = $Potar
@onready var audio: AudioStreamPlayer = $"../MixingAudio"

const LOW:int = 0
const HIGH:int = 0
var mPos: float
var bus: int = AudioServer.get_bus_index("MixBus")
var inside :bool = false
var index: int = 0
var rotDeg:int = 0
var indexTrad:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	filter = AudioServer.get_bus_effect(bus,busIndex)
	pass # Replace with function body.
	

func low_effect_normalization(res) -> float:
	res = index / div
	res = (res / 100) * mul + add
	return res

#The value of the audio effect is normalised with the rotation of the sprite
#The rotation is set with the mouse position
func set_potard_value(mPos: float):
	var res = mPos
	if rad_to_deg(mPos) > 130 or rad_to_deg(mPos) < 50 :
		potar.rotation = mPos
		rotDeg = rad_to_deg(potar.rotation)
		if rotDeg >= 130 and rotDeg <= 180 :
			index = rad_to_deg(potar.rotation) - 130
		else :
			index = rad_to_deg(potar.rotation) + 230
		if busIndex == LOW:
			res = index / div
			res = (res / 100) * mul + add
			filter.cutoff_hz = res
		else :
			res = index / div
			res = (res / 100) * mul - mul
			res *= -1
			filter.cutoff_hz = res

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if inside and Input.is_action_pressed("left_click") :
		mPos = potar.global_position.angle_to_point(get_global_mouse_position())
		set_potard_value(mPos)
		

func _on_mouse_entered() -> void:
	inside = true

func _on_mouse_exited() -> void:
	inside = false
