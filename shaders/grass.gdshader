shader_type canvas_item;

void fragment() {
	// Called for every pixel the material is visible on.
    if (VERTEX.y < 0.0) {
        VERTEX += vec2(sin(TIME * 0.5) * 200.0, 0);
    }
}
