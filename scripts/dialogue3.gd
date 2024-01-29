extends NinePatchRect

# todo: read file once!
@export_file("*.json") var data
var lines: Array

@onready var label = $Label

func _ready():
    var json_as_text = FileAccess.get_file_as_string(data)
    lines = JSON.parse_string(json_as_text)
    label.text = lines[randi()%len(lines)]

func _on_timer_timeout():
    queue_free()
