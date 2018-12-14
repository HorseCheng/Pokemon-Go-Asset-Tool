Shader "Niantic/PowerBar" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_TintColor ("Tint Color", Color) = (1,0.7,0.5,1)
_PulseColor ("Pulse Color", Color) = (1,0.9,0.7,1)
_WidthColor ("Width Color", Color) = (1,1,1,1)
_BackGroundColor ("Background Color", Color) = (0.2,0.2,0.2,0.4)
_Width ("Width", Range(0, 1)) = 0.1
_Ratio ("BarRatio", Range(0, 1)) = 0.2
_Progress ("Progress", Range(0, 1)) = 0.5
_Tilt ("Tilt", Range(0, 0.3)) = 0.1
_Gap ("Gap", Range(0, 0.2)) = 0.1
_BarCount ("BarCount", Range(1, 3)) = 3
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 966
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Width;
uniform highp float _Ratio;
uniform highp float _Progress;
uniform highp float _Tilt;
uniform highp float _Gap;
uniform highp int _BarCount;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _PulseColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2.x = floor(float(_BarCount));
  tmpvar_2.y = (_Gap * float((
    (tmpvar_2.x - 0.5)
   >= 1.0)));
  highp float tmpvar_4;
  tmpvar_4 = (1.0 - _Tilt);
  tmpvar_2.z = (_Ratio / tmpvar_4);
  tmpvar_2.w = (tmpvar_2.y + ((_Width * tmpvar_2.z) * tmpvar_2.x));
  highp vec2 tmpvar_5;
  tmpvar_5.y = 1.0;
  tmpvar_5.x = tmpvar_4;
  tmpvar_1.xy = (_glesMultiTexCoord0.xy / tmpvar_5);
  lowp float tmpvar_6;
  tmpvar_6 = float((_PulseColor.w >= 0.5));
  tmpvar_1.z = ((tmpvar_6 * floor(
    (_Progress * tmpvar_2.x)
  )) / tmpvar_2.x);
  tmpvar_1.w = 0.0;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = mix (_PulseColor, vec4(1.0, 1.0, 1.0, 1.0), vec4(((
    sin((_Time.y * 5.0))
   / 2.0) + 0.5)));
  xlv_COLOR = (_TintColor * _glesColor);
}


#endif
#ifdef FRAGMENT
uniform highp float _Width;
uniform highp float _Progress;
uniform highp float _Tilt;
uniform lowp vec4 _WidthColor;
uniform lowp vec4 _BackGroundColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 bar_1;
  mediump vec2 ux_2;
  lowp vec4 col_3;
  mediump vec2 Width_4;
  mediump float gap_5;
  mediump float barCount_6;
  mediump float pulseProgress_7;
  highp float tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD0.z;
  pulseProgress_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.x;
  barCount_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD1.y;
  gap_5 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD1.w;
  tmpvar_11.y = _Width;
  Width_4 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.xy;
  ux_2 = tmpvar_12;
  ux_2.x = (ux_2.x - (_Tilt * ux_2.y));
  mediump float tmpvar_13;
  mediump float x_14;
  x_14 = (barCount_6 * ux_2.x);
  mediump float ip_15;
  ip_15 = float(int(x_14));
  tmpvar_13 = (x_14 - ip_15);
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_13;
  tmpvar_16.y = ux_2.y;
  mediump vec2 tmpvar_17;
  tmpvar_17 = vec2(greaterThanEqual (Width_4, (0.5 - 
    abs((tmpvar_16 - vec2(0.5, 0.5)))
  )));
  bar_1.y = tmpvar_17.y;
  bar_1.x = max (tmpvar_17.x, tmpvar_17.y);
  mediump vec4 tmpvar_18;
  tmpvar_18 = mix (_BackGroundColor, _WidthColor, bar_1.xxxx);
  col_3 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (col_3, xlv_COLOR, vec4(float((_Progress >= ux_2.x))));
  col_3 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = float((pulseProgress_7 >= ux_2.x));
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (col_3.xyz, xlv_TEXCOORD2.xyz, vec3(tmpvar_20));
  col_3.xyz = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (col_3 * (vec4(1.0, 1.0, 1.0, 1.0) - vec4(max (
    float((gap_5 >= tmpvar_13))
  , 
    float((tmpvar_13 >= (1.0 - gap_5)))
  ))));
  mediump float tmpvar_23;
  tmpvar_23 = float(((barCount_6 - 0.5) >= ip_15));
  col_3 = (tmpvar_22 * tmpvar_23);
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Width;
uniform highp float _Ratio;
uniform highp float _Progress;
uniform highp float _Tilt;
uniform highp float _Gap;
uniform highp int _BarCount;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _PulseColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2.x = floor(float(_BarCount));
  tmpvar_2.y = (_Gap * float((
    (tmpvar_2.x - 0.5)
   >= 1.0)));
  highp float tmpvar_4;
  tmpvar_4 = (1.0 - _Tilt);
  tmpvar_2.z = (_Ratio / tmpvar_4);
  tmpvar_2.w = (tmpvar_2.y + ((_Width * tmpvar_2.z) * tmpvar_2.x));
  highp vec2 tmpvar_5;
  tmpvar_5.y = 1.0;
  tmpvar_5.x = tmpvar_4;
  tmpvar_1.xy = (_glesMultiTexCoord0.xy / tmpvar_5);
  lowp float tmpvar_6;
  tmpvar_6 = float((_PulseColor.w >= 0.5));
  tmpvar_1.z = ((tmpvar_6 * floor(
    (_Progress * tmpvar_2.x)
  )) / tmpvar_2.x);
  tmpvar_1.w = 0.0;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = mix (_PulseColor, vec4(1.0, 1.0, 1.0, 1.0), vec4(((
    sin((_Time.y * 5.0))
   / 2.0) + 0.5)));
  xlv_COLOR = (_TintColor * _glesColor);
}


#endif
#ifdef FRAGMENT
uniform highp float _Width;
uniform highp float _Progress;
uniform highp float _Tilt;
uniform lowp vec4 _WidthColor;
uniform lowp vec4 _BackGroundColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 bar_1;
  mediump vec2 ux_2;
  lowp vec4 col_3;
  mediump vec2 Width_4;
  mediump float gap_5;
  mediump float barCount_6;
  mediump float pulseProgress_7;
  highp float tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD0.z;
  pulseProgress_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.x;
  barCount_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD1.y;
  gap_5 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD1.w;
  tmpvar_11.y = _Width;
  Width_4 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.xy;
  ux_2 = tmpvar_12;
  ux_2.x = (ux_2.x - (_Tilt * ux_2.y));
  mediump float tmpvar_13;
  mediump float x_14;
  x_14 = (barCount_6 * ux_2.x);
  mediump float ip_15;
  ip_15 = float(int(x_14));
  tmpvar_13 = (x_14 - ip_15);
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_13;
  tmpvar_16.y = ux_2.y;
  mediump vec2 tmpvar_17;
  tmpvar_17 = vec2(greaterThanEqual (Width_4, (0.5 - 
    abs((tmpvar_16 - vec2(0.5, 0.5)))
  )));
  bar_1.y = tmpvar_17.y;
  bar_1.x = max (tmpvar_17.x, tmpvar_17.y);
  mediump vec4 tmpvar_18;
  tmpvar_18 = mix (_BackGroundColor, _WidthColor, bar_1.xxxx);
  col_3 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (col_3, xlv_COLOR, vec4(float((_Progress >= ux_2.x))));
  col_3 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = float((pulseProgress_7 >= ux_2.x));
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (col_3.xyz, xlv_TEXCOORD2.xyz, vec3(tmpvar_20));
  col_3.xyz = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (col_3 * (vec4(1.0, 1.0, 1.0, 1.0) - vec4(max (
    float((gap_5 >= tmpvar_13))
  , 
    float((tmpvar_13 >= (1.0 - gap_5)))
  ))));
  mediump float tmpvar_23;
  tmpvar_23 = float(((barCount_6 - 0.5) >= ip_15));
  col_3 = (tmpvar_22 * tmpvar_23);
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Width;
uniform highp float _Ratio;
uniform highp float _Progress;
uniform highp float _Tilt;
uniform highp float _Gap;
uniform highp int _BarCount;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _PulseColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2.x = floor(float(_BarCount));
  tmpvar_2.y = (_Gap * float((
    (tmpvar_2.x - 0.5)
   >= 1.0)));
  highp float tmpvar_4;
  tmpvar_4 = (1.0 - _Tilt);
  tmpvar_2.z = (_Ratio / tmpvar_4);
  tmpvar_2.w = (tmpvar_2.y + ((_Width * tmpvar_2.z) * tmpvar_2.x));
  highp vec2 tmpvar_5;
  tmpvar_5.y = 1.0;
  tmpvar_5.x = tmpvar_4;
  tmpvar_1.xy = (_glesMultiTexCoord0.xy / tmpvar_5);
  lowp float tmpvar_6;
  tmpvar_6 = float((_PulseColor.w >= 0.5));
  tmpvar_1.z = ((tmpvar_6 * floor(
    (_Progress * tmpvar_2.x)
  )) / tmpvar_2.x);
  tmpvar_1.w = 0.0;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = mix (_PulseColor, vec4(1.0, 1.0, 1.0, 1.0), vec4(((
    sin((_Time.y * 5.0))
   / 2.0) + 0.5)));
  xlv_COLOR = (_TintColor * _glesColor);
}


#endif
#ifdef FRAGMENT
uniform highp float _Width;
uniform highp float _Progress;
uniform highp float _Tilt;
uniform lowp vec4 _WidthColor;
uniform lowp vec4 _BackGroundColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 bar_1;
  mediump vec2 ux_2;
  lowp vec4 col_3;
  mediump vec2 Width_4;
  mediump float gap_5;
  mediump float barCount_6;
  mediump float pulseProgress_7;
  highp float tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD0.z;
  pulseProgress_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.x;
  barCount_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD1.y;
  gap_5 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD1.w;
  tmpvar_11.y = _Width;
  Width_4 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.xy;
  ux_2 = tmpvar_12;
  ux_2.x = (ux_2.x - (_Tilt * ux_2.y));
  mediump float tmpvar_13;
  mediump float x_14;
  x_14 = (barCount_6 * ux_2.x);
  mediump float ip_15;
  ip_15 = float(int(x_14));
  tmpvar_13 = (x_14 - ip_15);
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_13;
  tmpvar_16.y = ux_2.y;
  mediump vec2 tmpvar_17;
  tmpvar_17 = vec2(greaterThanEqual (Width_4, (0.5 - 
    abs((tmpvar_16 - vec2(0.5, 0.5)))
  )));
  bar_1.y = tmpvar_17.y;
  bar_1.x = max (tmpvar_17.x, tmpvar_17.y);
  mediump vec4 tmpvar_18;
  tmpvar_18 = mix (_BackGroundColor, _WidthColor, bar_1.xxxx);
  col_3 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (col_3, xlv_COLOR, vec4(float((_Progress >= ux_2.x))));
  col_3 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = float((pulseProgress_7 >= ux_2.x));
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (col_3.xyz, xlv_TEXCOORD2.xyz, vec3(tmpvar_20));
  col_3.xyz = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (col_3 * (vec4(1.0, 1.0, 1.0, 1.0) - vec4(max (
    float((gap_5 >= tmpvar_13))
  , 
    float((tmpvar_13 >= (1.0 - gap_5)))
  ))));
  mediump float tmpvar_23;
  tmpvar_23 = float(((barCount_6 - 0.5) >= ip_15));
  col_3 = (tmpvar_22 * tmpvar_23);
  gl_FragData[0] = col_3;
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