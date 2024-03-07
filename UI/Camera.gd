extends Camera2D

var mousePos: Vector2 = Vector2()
var mousePosGlobal: Vector2 = Vector2()

var start: Vector2 = Vector2()
var startV: Vector2 = Vector2()
var end: Vector2 = Vector2()
var endV: Vector2 = Vector2()

var isDragging: bool = false

signal area_selected
signal start_move_selection

@onready var box = %Panel

func _ready():
	connect("area_selected", Callable(get_parent(), "_on_area_selected"))

func _process(delta):
	if Input.is_action_just_pressed("LeftClick"):
		start = mousePosGlobal
		startV = mousePos
		isDragging = true
	
	if isDragging:
		end = mousePosGlobal
		endV = mousePos
		draw_area()
	
	if Input.is_action_just_released("LeftClick"):
		if startV.distance_to(mousePos) > 20:
			end = mousePosGlobal
			endV = mousePos
			isDragging = false
			draw_area(false)
			emit_signal("area_selected", self)
		else:
			end = start
			isDragging = false
			draw_area(false)


func _input(event):
	if event is InputEventMouse:
		# Depends on the zoom level of the camera
		mousePos = event.position
		
		# Is absolute, relative to the world
		mousePosGlobal = get_global_mouse_position()


func draw_area(s=true):
	var pos: Vector2 = Vector2()
	pos.x = min(startV.x, endV.x)
	pos.y = min(startV.y, endV.y) 
	
	# Initial size: (0, 0) < Panel < Inspector < Layout < Transform
	box.size = Vector2(abs(startV.x - endV.x), abs(startV.y - endV.y))
	box.position = pos
	
	# Multiply with 0 (false) or 1 (true) 
	box.size *= int(s)







