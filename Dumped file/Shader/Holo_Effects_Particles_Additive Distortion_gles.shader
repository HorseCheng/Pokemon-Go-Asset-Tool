Shader "Holo/Effects/Particles/Additive Distortion" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
_WarpTex ("Warp Texture", 2D) = "bump" { }
_WarpStrength ("Warp Strength", Float) = 1
_WarpSpeedX ("Warp X Pan Speed", Float) = 0
_WarpSpeedY ("Warp Y Pan Speed", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  Lighting On
  GpuProgramID 39907
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
uniform lowp float _WarpSpeedX;
uniform lowp float _WarpSpeedY;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _WarpTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.x * _WarpSpeedX);
  tmpvar_2.y = (_Time.x * _WarpSpeedY);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw) + tmpvar_2);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((texture2D (_WarpTex, xlv_TEXCOORD1) - 0.5) * _WarpStrength);
  highp vec2 P_2;
  P_2 = (xlv_TEXCOORD0 + tmpvar_1.xy);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, P_2) * xlv_COLOR);
  gl_FragData[0] = tmpvar_3;
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
uniform lowp float _WarpSpeedX;
uniform lowp float _WarpSpeedY;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _WarpTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.x * _WarpSpeedX);
  tmpvar_2.y = (_Time.x * _WarpSpeedY);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw) + tmpvar_2);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((texture2D (_WarpTex, xlv_TEXCOORD1) - 0.5) * _WarpStrength);
  highp vec2 P_2;
  P_2 = (xlv_TEXCOORD0 + tmpvar_1.xy);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, P_2) * xlv_COLOR);
  gl_FragData[0] = tmpvar_3;
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
uniform lowp float _WarpSpeedX;
uniform lowp float _WarpSpeedY;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _WarpTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.x * _WarpSpeedX);
  tmpvar_2.y = (_Time.x * _WarpSpeedY);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw) + tmpvar_2);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((texture2D (_WarpTex, xlv_TEXCOORD1) - 0.5) * _WarpStrength);
  highp vec2 P_2;
  P_2 = (xlv_TEXCOORD0 + tmpvar_1.xy);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, P_2) * xlv_COLOR);
  gl_FragData[0] = tmpvar_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp float _WarpSpeedX;
uniform lowp float _WarpSpeedY;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _WarpTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.x * _WarpSpeedX);
  tmpvar_2.y = (_Time.x * _WarpSpeedY);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw) + tmpvar_2);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((texture2D (_WarpTex, xlv_TEXCOORD1) - 0.5) * _WarpStrength);
  highp vec2 P_2;
  P_2 = (xlv_TEXCOORD0 + tmpvar_1.xy);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, P_2) * xlv_COLOR);
  gl_FragData[0] = tmpvar_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp float _WarpSpeedX;
uniform lowp float _WarpSpeedY;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _WarpTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.x * _WarpSpeedX);
  tmpvar_2.y = (_Time.x * _WarpSpeedY);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw) + tmpvar_2);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((texture2D (_WarpTex, xlv_TEXCOORD1) - 0.5) * _WarpStrength);
  highp vec2 P_2;
  P_2 = (xlv_TEXCOORD0 + tmpvar_1.xy);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, P_2) * xlv_COLOR);
  gl_FragData[0] = tmpvar_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp float _WarpSpeedX;
uniform lowp float _WarpSpeedY;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _WarpTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.x * _WarpSpeedX);
  tmpvar_2.y = (_Time.x * _WarpSpeedY);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw) + tmpvar_2);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((texture2D (_WarpTex, xlv_TEXCOORD1) - 0.5) * _WarpStrength);
  highp vec2 P_2;
  P_2 = (xlv_TEXCOORD0 + tmpvar_1.xy);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, P_2) * xlv_COLOR);
  gl_FragData[0] = tmpvar_3;
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
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
}
}
}
}