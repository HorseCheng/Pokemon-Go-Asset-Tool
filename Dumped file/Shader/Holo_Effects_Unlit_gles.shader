Shader "Holo/Effects/Unlit" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
[Toggle] _ZWrite ("Z Write", Float) = 1
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 64757
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1 = tmpvar_2;
  color_1 = (color_1 * xlv_COLOR);
  gl_FragData[0] = color_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1 = tmpvar_2;
  color_1 = (color_1 * xlv_COLOR);
  gl_FragData[0] = color_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1 = tmpvar_2;
  color_1 = (color_1 * xlv_COLOR);
  gl_FragData[0] = color_1;
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