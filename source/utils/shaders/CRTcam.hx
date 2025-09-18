package utils.shaders;

import flixel.system.FlxAssets.FlxShader;

class CRTcam {
    public var shader(default, null):CamCam = new CamCam();
    public var curvature(default, set):Float;
    public var scanlineIntensity(default, set):Float;
    public var scanlineFreq(default, set):Float;
    public var chromAbOffset(default, set):Float;

    public function new() {
        // Set sensible defaults
        shader.curvature.value = [0.08];           // subtle curvature
        shader.scanlineIntensity.value = [0.03];  // faint scanlines
        shader.scanlineFreq.value = [360.0];      // medium frequency
        shader.chromAbOffset.value = [0.015];     // mild offset
    }


    function set_curvature(v:Float):Float {
        shader.curvature.value[0] = v;
        return v;
    }

    function set_scanlineIntensity(v:Float):Float {
        shader.scanlineIntensity.value[0] = v;
        return v;
    }

    function set_scanlineFreq(v:Float):Float {
        shader.scanlineFreq.value[0] = v;
        return v;
    }

    function set_chromAbOffset(v:Float):Float {
        shader.chromAbOffset.value[0] = v;
        return v;
    }
}

class CamCam extends FlxShader {
 @:glFragmentSource('
        #pragma header

        uniform float curvature;       // 0.0 - 1.0
        uniform float scanlineIntensity; // 0.0 - 1.0
        uniform float scanlineFreq;    // pixels (e.g. 300–800)
        uniform float chromAbOffset;   // pixels (e.g. 0.0–0.01)

        void main() {
            vec2 uv = openfl_TextureCoordv;

            // Curvature distortion
            uv = uv * 2.0 - 1.0;
            uv.x *= 1.0 + curvature * pow(abs(uv.y), 2.0);
            uv.y *= 1.0 + curvature * pow(abs(uv.x), 2.0);
            uv = (uv + 1.0) / 2.0;

            // If outside bounds after distortion, fade out
            if (uv.x < 0.0 || uv.y < 0.0 || uv.x > 1.0 || uv.y > 1.0) {
                gl_FragColor = vec4(0.0);
                return;
            }

            vec4 baseCol = texture2D(bitmap, uv);

            // Scanlines
            float scanline = sin(uv.y * scanlineFreq) * scanlineIntensity;
            baseCol.rgb -= scanline;

            // Chromatic aberration
            float offset = chromAbOffset;
            float r = texture2D(bitmap, uv + vec2(offset, 0.0)).r;
            float g = texture2D(bitmap, uv).g;
            float b = texture2D(bitmap, uv - vec2(offset, 0.0)).b;

            gl_FragColor = vec4(r, g, b, baseCol.a);
        }
    ')
    public function new() {
        super();
    }
}
