extends CanvasLayer
    
@onready var loading_label = $Loading
@onready var fun_fact_label = $FunFact
    
func change_scene(target: String) -> void:
    $AnimationPlayer.play("fade_to_black")
    await $AnimationPlayer.animation_finished
    
    loading_label.text = "Loading..."
    await get_tree().create_timer(2).timeout
    
    fun_fact_label.text = ""
    loading_label.text = ""
    get_tree().change_scene_to_file(target)
    $AnimationPlayer.play_backwards("fade_to_black")
