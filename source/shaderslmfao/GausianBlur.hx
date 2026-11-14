package shaderslmfao;

import flixel.system.FlxAssets.FlxShader;

class GausianBlur extends FlxShader
{
	@:glFragmentSource('
	#pragma header

    #define iResolution vec3(openfl_TextureSize, 0.)
    #define iChannel0 bitmap
    #define texture flixel_texture2D
    
    uniform float fuck;
    
    // third argument fix
    vec4 flixel_texture2D(sampler2D bitmap, vec2 coord, float bias) {
    	vec4 color = texture2D(bitmap, coord, bias);
    	if (!hasTransform && !openfl_HasColorTransform)
    		return color;
    
    	if (color.a == 0.0)
    		return vec4(0.0, 0.0, 0.0, 0.0);
    
    	if (openfl_HasColorTransform || hasColorTransform) {
    		color = vec4 (color.rgb / color.a, color.a);
    		vec4 mult = vec4 (openfl_ColorMultiplierv.rgb, 1.0);
    		color = clamp (openfl_ColorOffsetv + (color * mult), 0.0, 1.0);
    
    		if (color.a == 0.0)
    			return vec4 (0.0, 0.0, 0.0, 0.0);
        
    		return vec4 (color.rgb * color.a * openfl_Alphav, color.a * openfl_Alphav);
    	}
    
    	return color * openfl_Alphav;
    }
    
    // end of ShadertoyToFlixel header
    
    vec4 BlurImage(in vec2 inputUV)
    {
      float vx_offset = 0.7;
      float rt_h = 450.0;
      float rt_w = 800.0;
      float offset[3];
      offset[0] = 1.17328910;
      offset[1] = 4.7846153846;
      offset[2] = 8.2307692308;

      float weight[3];
      weight[0] = 0.2270270270;
      weight[1] = 0.4162162162;
      weight[2] = 0.0302702703;
      vec4 tc = vec4(0.4, 0.4, 0.0, 1.0);
      vec4 fragColor[4];
    
        vec2 uv = inputUV.xy;
        tc = texture(iChannel0, uv).rgba * weight[0];
        for (int i=1; i<3; i++) 
        {
          //VerticalBlur
          //tc += texture(iChannel0, uv + vec2(0.0, offset[i])/rt_h).rgba * weight[i];
          //tc += texture(iChannel0, uv - vec2(0.0, offset[i])/rt_h).rgba * weight[i];
         
          //HorizontalBlur
          tc += texture(iChannel0, uv + vec2(offset[i])/rt_w, 0.0).rgba * weight[i];
          tc += texture(iChannel0, uv - vec2(offset[i])/rt_w, 0.0).rgba * weight[i];
         
        }
      return tc;
    }
    
    void mainImage( out vec4 fragColor, in vec2 fragCoord )
    {
        // Normalized pixel coordinates (from 0 to 1)
        vec2 uv = fragCoord/iResolution.xy;
    
        // Output to screen
        fragColor = mix(texture(iChannel0, uv), BlurImage(uv), fuck);
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
