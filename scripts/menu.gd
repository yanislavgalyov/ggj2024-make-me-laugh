extends Control


func _process(_delta):
    if Input.is_action_just_pressed("Reload"):
        TransitionLayer.change_scene("res://scenes/001.tscn")
    if Input.is_action_just_pressed("Quit"):
        get_tree().quit()

func _on_play_pressed():
    TransitionLayer.change_scene("res://scenes/001.tscn")

func _on_quit_pressed():
    get_tree().quit()
