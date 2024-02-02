shader_type canvas_item;

void vertex() {
	// Called for every pixel the material is visible on.
    if (VERTEX.y < 0.0) {
        VERTEX += vec2(sin(TIME * 2.0) * 5.0, 0);
    }
}
