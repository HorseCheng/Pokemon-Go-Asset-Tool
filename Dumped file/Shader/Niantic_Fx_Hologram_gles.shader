Shader "Niantic/Fx/Hologram" {
Properties {
_Color ("Tint Color", Color) = (1,1,1,1)
_MainTex ("Texture", 2D) = "white" { }
_ScanFrequency ("Scan Line Frequency", Float) = 1
_ScanSpeed ("Scan Line Speed", Float) = 1
_ScanMin ("Scan Strength (Minimum)", Float) = 0.7
_ScanMax ("Scan Strength (Maximum)", Float) = 1.25
_ScanColor ("Scan Color", Color) = (0.2,0.2,0.2,0.7)
_RandomOffset ("Random Offset (set by code per instance)", Vector) = (0,0,0,0)
_FlickerOffsetTime ("Flicker Offset Time", Float) = 1
_FlickerSpeed ("Flicker Speed", Float) = 10
_PhaseSpeed ("Phase Speed", Float) = 0.03
_PhaseEndBias ("Phase End Bias", Float) = 4
_PhaseInBias ("Phase In Bias", Range(0, 1)) = 0.5
}
SubShader {
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 42197
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform lowp vec4 _RandomOffset;
uniform lowp float _FlickerOffsetTime;
uniform lowp float _FlickerSpeed;
uniform lowp float _PhaseSpeed;
uniform lowp float _PhaseEndBias;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float flickerTime_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp float tmpvar_4;
  tmpvar_4 = ((_Time.y + _RandomOffset.x) * _FlickerOffsetTime);
  tmpvar_2.x = float(((
    sin(tmpvar_4)
   * 
    cos((tmpvar_4 * 0.7))
  ) >= 0.5));
  flickerTime_1 = ((_Time.y + _RandomOffset.y) * _FlickerSpeed);
  tmpvar_2.y = ceil((sin(flickerTime_1) * cos(
    (flickerTime_1 * 1.7)
  )));
  tmpvar_2.z = ceil((sin(
    (flickerTime_1 * 11.7)
  ) * cos(
    (flickerTime_1 * 9.3)
  )));
  tmpvar_2.w = clamp (((
    (sin((flickerTime_1 * _PhaseSpeed)) * _PhaseEndBias)
   + 
    (cos(((flickerTime_1 * _PhaseSpeed) * 3.4)) * _PhaseEndBias)
  ) + _PhaseEndBias), 0.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp float _ScanSpeed;
uniform lowp float _ScanMin;
uniform lowp float _ScanMax;
uniform lowp vec4 _ScanColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp float multiplier_1;
  lowp float scanLine_2;
  lowp vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_3.w = tmpvar_4.w;
  col_3.xyz = (tmpvar_4.xyz * (_Color.xyz * 2.0));
  highp float tmpvar_5;
  tmpvar_5 = clamp (sin((_Time.x * _ScanSpeed)), _ScanMin, _ScanMax);
  scanLine_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (scanLine_2, xlv_TEXCOORD1.w, _ScanMax);
  multiplier_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = mix (_ScanColor, col_3, vec4(max (multiplier_1, _ScanColor.w)));
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform lowp vec4 _RandomOffset;
uniform lowp float _FlickerOffsetTime;
uniform lowp float _FlickerSpeed;
uniform lowp float _PhaseSpeed;
uniform lowp float _PhaseEndBias;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float flickerTime_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp float tmpvar_4;
  tmpvar_4 = ((_Time.y + _RandomOffset.x) * _FlickerOffsetTime);
  tmpvar_2.x = float(((
    sin(tmpvar_4)
   * 
    cos((tmpvar_4 * 0.7))
  ) >= 0.5));
  flickerTime_1 = ((_Time.y + _RandomOffset.y) * _FlickerSpeed);
  tmpvar_2.y = ceil((sin(flickerTime_1) * cos(
    (flickerTime_1 * 1.7)
  )));
  tmpvar_2.z = ceil((sin(
    (flickerTime_1 * 11.7)
  ) * cos(
    (flickerTime_1 * 9.3)
  )));
  tmpvar_2.w = clamp (((
    (sin((flickerTime_1 * _PhaseSpeed)) * _PhaseEndBias)
   + 
    (cos(((flickerTime_1 * _PhaseSpeed) * 3.4)) * _PhaseEndBias)
  ) + _PhaseEndBias), 0.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp float _ScanSpeed;
uniform lowp float _ScanMin;
uniform lowp float _ScanMax;
uniform lowp vec4 _ScanColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp float multiplier_1;
  lowp float scanLine_2;
  lowp vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_3.w = tmpvar_4.w;
  col_3.xyz = (tmpvar_4.xyz * (_Color.xyz * 2.0));
  highp float tmpvar_5;
  tmpvar_5 = clamp (sin((_Time.x * _ScanSpeed)), _ScanMin, _ScanMax);
  scanLine_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (scanLine_2, xlv_TEXCOORD1.w, _ScanMax);
  multiplier_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = mix (_ScanColor, col_3, vec4(max (multiplier_1, _ScanColor.w)));
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform lowp vec4 _RandomOffset;
uniform lowp float _FlickerOffsetTime;
uniform lowp float _FlickerSpeed;
uniform lowp float _PhaseSpeed;
uniform lowp float _PhaseEndBias;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float flickerTime_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp float tmpvar_4;
  tmpvar_4 = ((_Time.y + _RandomOffset.x) * _FlickerOffsetTime);
  tmpvar_2.x = float(((
    sin(tmpvar_4)
   * 
    cos((tmpvar_4 * 0.7))
  ) >= 0.5));
  flickerTime_1 = ((_Time.y + _RandomOffset.y) * _FlickerSpeed);
  tmpvar_2.y = ceil((sin(flickerTime_1) * cos(
    (flickerTime_1 * 1.7)
  )));
  tmpvar_2.z = ceil((sin(
    (flickerTime_1 * 11.7)
  ) * cos(
    (flickerTime_1 * 9.3)
  )));
  tmpvar_2.w = clamp (((
    (sin((flickerTime_1 * _PhaseSpeed)) * _PhaseEndBias)
   + 
    (cos(((flickerTime_1 * _PhaseSpeed) * 3.4)) * _PhaseEndBias)
  ) + _PhaseEndBias), 0.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp float _ScanSpeed;
uniform lowp float _ScanMin;
uniform lowp float _ScanMax;
uniform lowp vec4 _ScanColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp float multiplier_1;
  lowp float scanLine_2;
  lowp vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_3.w = tmpvar_4.w;
  col_3.xyz = (tmpvar_4.xyz * (_Color.xyz * 2.0));
  highp float tmpvar_5;
  tmpvar_5 = clamp (sin((_Time.x * _ScanSpeed)), _ScanMin, _ScanMax);
  scanLine_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (scanLine_2, xlv_TEXCOORD1.w, _ScanMax);
  multiplier_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = mix (_ScanColor, col_3, vec4(max (multiplier_1, _ScanColor.w)));
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
}
}
}
}