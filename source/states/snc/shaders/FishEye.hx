package states.snc.shaders;

import flixel.system.FlxAssets.FlxShader;
import lime.utils.Assets;
import haxe.Json;
import states.snc.shaders.SncTypedef.ShadersDef;

class FishEye extends FlxShader // https://www.shadertoy.com/view/WsVSzV
{
		@:glFragmentSource('
			#pragma header
			vec2 uv = openfl_TextureCoordv.xy;
			vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
			vec2 iResolution = openfl_TextureSize;
			uniform float iTime;
			#define iChannel0 bitmap
			#define texture flixel_texture2D
			#define fragColor gl_FragColor
			#define mainImage main

			//For AMD, uniform cannot have anything after its been assigned. 
			uniform float warp; // simulate curvature of CRT monitor
			uniform float scan; // simulate darkness between scanlines

			void mainImage()
				{
				// squared distance from center
				vec2 uv = fragCoord/iResolution.xy;
				vec2 dc = abs(0.5-uv);
				dc *= dc;
				
				// warp the fragment coordinates
				uv.x -= 0.5; uv.x *= 1.0+(dc.y*(0.7*warp)); uv.x += 0.5;
   				uv.y -= 0.5; uv.y *= 1.0+(dc.x*(0.9*warp)); uv.y += 0.5;

				// sample inside boundaries, otherwise set to black
				if (uv.y > 1.0 || uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0)
					fragColor = vec4(0.0,0.0,0.0,1.0);
				else
					{
					// determine if we are drawing in a scanline
					float apply = abs(sin(fragCoord.y)*0.5*scan);
					// sample the texture
					fragColor = vec4(mix(flixel_texture2D(bitmap,uv).rgb,vec3(0.0),apply),1.0);
					}
				}
		')


    var __json:ShadersDef = null;
    var curjson:Array<Array<Dynamic>> = [];

	public var preset(default, set):Int = 0;

	function set_preset(value:Int):Int
	{
		var presetData:Array<Dynamic> = curjson[value];
		data.warp.value = [presetData[0]];
		data.scan.value = [presetData[1]];
		return value;
	}

	public function new(){
		super();

		__json = Json.parse(getText('assets/archive/data/shaders.json'));
		for(i in __json.fisheye)
			curjson.push(i);

		iTime.value = [0];
		this.preset = preset;
	}

	public static function path(path:String){
		if (!FileSystem.exists(path)){
			trace('could not find $path');
			return null;
        }
		return path;
    }
	inline static public function getText(key:String):String{
		var path:String = path(key);
		return (FileSystem.exists(path)) ? File.getContent(path) : null;
	}
}

