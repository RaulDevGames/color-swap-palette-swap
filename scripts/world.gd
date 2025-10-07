extends Node2D

@onready var player_palette_swap: Sprite2D = $PlayerPaletteSwap
@onready var player_color_swap: Sprite2D = $PlayerColorSwap
@onready var index: SpinBox = $CanvasLayer/VBoxContainer2/Index
@onready var color_picker: ColorPickerButton = $CanvasLayer/VBoxContainer2/Color

var palettes = {
	"pal1": preload("res://assets/player_palette_1.png"),
	"pal2": preload("res://assets/player_palette_2.png"),
	"pal3": preload("res://assets/player_palette_3.png")
}

func _ready() -> void:
	var mat := player_palette_swap.material
	if mat is ShaderMaterial:
		player_palette_swap.material = mat.duplicate()

	var mat2 := player_color_swap.material
	if mat2 is ShaderMaterial:
		player_color_swap.material = mat2.duplicate()

	_on_index_value_changed(index.value)

#PALETTE SWAP
func _on_pallete_1_pressed() -> void:
	_set_palette("pal1")

func _on_pallete_2_pressed() -> void:
	_set_palette("pal2")

func _on_pallete_3_pressed() -> void:
	_set_palette("pal3")

func _set_palette(palette_name: String) -> void:
	var mat: ShaderMaterial = player_palette_swap.material
	if mat:
		mat.set_shader_parameter("palette_to", palettes[palette_name])


#COLOR SWAP
func _on_color_color_changed(color: Color) -> void:
	var idx := int(index.value)
	_set_color(idx, color)

func _set_color(idx: int, new_color: Color) -> void:
	var mat: ShaderMaterial = player_color_swap.material
	if mat:
		var colors: Array = mat.get_shader_parameter("to_palette")
		if idx >= 0 and idx < colors.size():
			colors[idx] = new_color
			mat.set_shader_parameter("to_palette", colors)

func _on_index_value_changed(value: float) -> void:
	var mat: ShaderMaterial = player_color_swap.material
	if mat:
		var colors: Array = mat.get_shader_parameter("to_palette")
		var idx := int(value)
		if idx >= 0 and idx < colors.size():
			color_picker.color = colors[idx]
