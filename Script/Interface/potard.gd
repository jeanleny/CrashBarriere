extends Area2D

@export var filter: AudioEffect
@export var div : float
@export var mul : float
@export var add : float
@export var busIndex : int

@onready var potar: Sprite2D = $Potar
@onready var audio: AudioStreamPlayer = $"../MixingAudio"

const LOW:int = 0
const HIGH:int = 1
var mPos: float
var bus: int = AudioServer.get_bus_index("MixBus")
var inside :bool = false
var rotConversion: int = 0
var rotDeg:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	filter = AudioServer.get_bus_effect(bus,busIndex)
	pass # Replace with function body.
	

#To map a value from a 0 - 100
#range up to a 200 - 21 000 range, the formula is
#Divide to turn into a decimal (percentage)
#Multiply by the max minus the minimum
#Add the minimum 
func low_effect_normalization(res:float) -> float:
	res = rotConversion / div
	res = (res / 100) * mul + add
	return res
	
#Tthe same but inverted (21 000 - 200)
#Divide to turn into a decimal (percentage)
#Multiply by the max
#Substract the maximum
#SAMER CT CHO
func high_effect_normalization(res : float) -> float:
	res = rotConversion / div
	res = (res / 100) * mul - mul
	res *= -1
	return res

#Weird Conversion
#The actual Rotation angle of the sprite match these awfull values (sorry)
#Because the angle becomes negative at 180, we have to check it before converting
func convertAngleToRange() -> int :
	if rotDeg >= 130 and rotDeg <= 180 :
		rotConversion = rotDeg - 130
	else :
		rotConversion = rotDeg + 230
	return rotConversion

#The value of the audio effect is normalised with the rotation of the sprite
#The rotation is set with the mouse position
func set_potard_value(mPos: float):
	var res:float = mPos
	if rad_to_deg(mPos) > 130 or rad_to_deg(mPos) < 50 :
		potar.rotation = mPos
		rotDeg = rad_to_deg(potar.rotation)
		rotConversion = convertAngleToRange()
		if busIndex == LOW:
			filter.cutoff_hz = low_effect_normalization(res)
		else:
			filter.cutoff_hz = high_effect_normalization(res)

 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if inside and Input.is_action_pressed("left_click") :
		mPos = potar.global_position.angle_to_point(get_global_mouse_position())
		set_potard_value(mPos)

func _on_mouse_entered() -> void:
	inside = true

func _on_mouse_exited() -> void:
	inside = false
