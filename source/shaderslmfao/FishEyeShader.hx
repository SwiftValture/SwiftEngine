package shaderslmfao;

import flixel.system.FlxAssets.FlxShader;

class FishEyeShader extends FlxShader
{
	@:glFragmentSource('
    	#pragma header

    uniform float dist;

    #define iChannel0 bitmap
    #define iResolution vec3(openfl_TextureSize, 0.)
    #define fragColor gl_FragColor 
    #define fragCoord gl_FragCoord
    #define texture flixel_texture2D

    void main() {
    	                                                         //(assume 1:1 prop)
        vec2 p = fragCoord.xy / iResolution.x;//normalized coords with some cheat
    	float prop = iResolution.x / iResolution.y;//screen proroption
    	vec2 m = vec2(0.5, 0.5 / prop);//center coords
    	vec2 d = p - m;//vector from center to current fragment
    	float r = sqrt(dot(d, d)); // distance of pixel from center

    	float power = ( 2.0 * 3.141592 / (2.0 * sqrt(dot(m, m))) ) *
    				(-dist);//amount of effect

    	float bind;//radius of 1:1 effect
    	if (power > 0.0) 
    		bind = sqrt(dot(m, m));//stick to corners
    	else {
    		if (prop < 1.0)
    			bind = m.x; 
    		else 
    			bind = m.y;
    	}//stick to borders

    	//Weird formulas
    	vec2 uv;
    	uv.y -= 20;
    	if (power > 0.0)//fisheye
    		uv = m + normalize(d) * tan(r * power) * bind / tan( bind * power);
    	else if (power < 0.0)//antifisheye
    		uv = m + normalize(d) * atan(r * -power * 10.0) * bind / atan(-power * bind * 10.0);
    	else uv = p;//no effect for power = 1.0

    	vec3 col = texture(iChannel0, vec2(uv.x, uv.y * prop)).xyz;//Second part of cheat
    	                                                  //for round effect, not elliptical
    	fragColor = vec4(col, texture(iChannel0, uv).a);

    }
')
	public function new()
	{
		super();
	}
}
