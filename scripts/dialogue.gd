extends CanvasLayer

@export_file("*.json") var data
var lines: Array

func _ready():
    var json_as_text = FileAccess.get_file_as_string(data)
    lines = JSON.parse_string(json_as_text)
    $NinePatchRect/Label.text = lines[randi()%len(lines)]
    $LifetimeTimer.start()

func _on_timer_timeout():
    queue_free()
