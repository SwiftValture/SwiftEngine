package shaderslmfao;

import flixel.system.FlxAssets.FlxShader;

class Vinegar extends FlxShader
{
	@:glFragmentSource('
    #pragma header

    #define iResolution vec3(openfl_TextureSize, 0.)
    #define iChannel0 bitmap
    #define texture flixel_texture2D

    // end of ShadertoyToFlixel 

    uniform float strength;

    void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    
    	float InnerVig = 0.0; // Position for the inner Vignette Ring
    
    	vec2 uv = fragCoord.xy / iResolution.xy;
    
    
    
    	vec4 color = texture(iChannel0, uv);
    
    	vec2 center = vec2(0.5,.5); // Center of Screen
    
    	float dist  = distance(center,uv )*1.414213; // Distance  between center and the current Uv. Multiplyed by 1.414213 to fit in the range of 0.0 to 1.0 
    
    	float vig = clamp((strength-dist) / (strength-InnerVig),0.0,1.0); // Generate the Vignette with Clamp which go from outer Viggnet ring to inner vignette ring with smooth steps
    
    	color *= vig; // Multiply the Vignette with the texture color
    
    	fragColor = color;
    }

    void main() {
    	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
    }
')
	public function new()
	{
		super();
	}
}
