shader_type canvas_item;

uniform vec4 modulate : source_color;
uniform sampler2D mask_texture; // Drag your subtracting sprite's texture here

void fragment() {
    // Get the original color of the main sprite
    vec4 main_color = texture(TEXTURE, UV);
    
    // Get the color/alpha from the mask texture at the same UV
    vec4 mask_color = texture(mask_texture, UV);
    
    // Subtract the mask's alpha from the main sprite's alpha
    // The result will be used for the final color's alpha channel
    main_color.a = main_color.a - mask_color.a; 
    
    // Pass the modified color to the output
    COLOR = main_color * modulate;
}
