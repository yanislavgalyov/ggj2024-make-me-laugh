extends CanvasLayer
    
func change_scene(target: String) -> void:
    $HTTPRequest.request("https://api.chucknorris.io/jokes/random")

    $AnimationPlayer.play("fade_to_black")
    await $AnimationPlayer.animation_finished
    await get_tree().create_timer(5).timeout
    $Label.text = ""
    get_tree().change_scene_to_file(target)
    $AnimationPlayer.play_backwards("fade_to_black")

func _on_http_request_request_completed(result, response_code, headers, body):
    var json = JSON.parse_string(body.get_string_from_utf8())
    $Label.text = json["value"]
