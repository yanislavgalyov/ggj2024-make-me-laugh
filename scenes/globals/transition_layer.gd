extends CanvasLayer
    
@onready var loading_label = $Loading
@onready var fun_fact_label = $FunFact
    
func change_scene(target: String) -> void:
    loading_label.text = "Loading..."
    #$HTTPRequest.request("https://api.chucknorris.io/jokes/random")
    $HTTPRequest.request("https://uselessfacts.jsph.pl/api/v2/facts/random")

    $AnimationPlayer.play("fade_to_black")
    await $AnimationPlayer.animation_finished
    await get_tree().create_timer(2).timeout
    fun_fact_label.text = ""
    loading_label.text = ""
    get_tree().change_scene_to_file(target)
    $AnimationPlayer.play_backwards("fade_to_black")


func _on_http_request_request_completed(result, response_code, headers, body):
    var json = JSON.parse_string(body.get_string_from_utf8())
    #fun_fact_label.text = json["value"]
    fun_fact_label.text = json["text"]
