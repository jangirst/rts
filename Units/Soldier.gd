extends CharacterBody2D

@export var selected: bool = false
@onready var box: Node = %Box
@onready var animation = get_node("AnimatedSprite2D")

@onready var target = position
var follow_cursor = false
const SPEED = 50

func _ready():
	set_selected(selected)


func set_selected(value):
	selected = value
	box.visible = value


func _on_input_event(viewport, event, shape_idx):
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("RightClick"):
		follow_cursor = true
	
	if event.is_action_released("RightClick"):
		follow_cursor = false


func _physics_process(delta):
	if follow_cursor == true:
		if selected:
			target = get_global_mouse_position()
			animation.play("Walk_Down")
	
	# Move the seleted unit(s) to the clicked position
	velocity = position.direction_to(target) * SPEED
	
	if position.distance_to(target) > 20:
		move_and_slide()
	else:
		animation.stop()
