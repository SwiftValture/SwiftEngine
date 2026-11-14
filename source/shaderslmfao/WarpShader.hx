package shaderslmfao;

import flixel.system.FlxAssets.FlxShader;

class WarpShader extends FlxShader
{
	@:glFragmentSource('
	// Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel

#pragma header

#define iResolution vec3(openfl_TextureSize, 0.)
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D

// end of ShadertoyToFlixel header

// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// make 1 to see a procedural warp/deformation
#define PROCEDURAL 1

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord/iResolution.xy;

#if PROCEDURAL==0
    vec2 warp = texture( iChannel0, uv*0.1 + iTime*vec2(0.04,0.03) ).xz;
#else    
    float freq = 3.0*sin(0.5*iTime);
    vec2 warp = 0.5000*cos( uv.xy*1.0*freq + vec2(0.0,1.0) + iTime ) +
                0.2500*cos( uv.yx*2.3*freq + vec2(1.0,2.0) + iTime) +
                0.1250*cos( uv.xy*4.1*freq + vec2(5.0,3.0) + iTime ) +
                0.0625*cos( uv.yx*7.9*freq + vec2(3.0,4.0) + iTime );
#endif
    
	vec2 st = uv + warp*0.5;

	fragColor = vec4(texture( iChannel0, st ).xyz, texture(iChannel0, fragCoord / iResolution.xy).a);
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
