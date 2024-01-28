extends CanvasLayer

@export_file("*.json") var data
var lines: Array

@onready var rect = $NinePatchRect as NinePatchRect

var global_position_anchor: Vector2

func _ready():
    var json_as_text = FileAccess.get_file_as_string(data)
    lines = JSON.parse_string(json_as_text)
    $NinePatchRect/Label.text = lines[randi()%len(lines)]
    $LifetimeTimer.start()

func _process(_delta):
    # todo: fix anchoring to global_position
    pass
        

func _on_timer_timeout():
    queue_free()

func set_global_position_anchor(pos: Vector2)-> void:
    global_position_anchor = pos
