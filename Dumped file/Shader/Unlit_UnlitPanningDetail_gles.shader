Shader "Unlit/UnlitPanningDetail" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_DetailTex ("Detail Texture", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
_PanningSpeed ("Panning Speed", Vector) = (0,0,0,0)
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 48029
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
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _PanningSpeed;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 uv2_1;
  mediump vec2 uv_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_2 = tmpvar_4;
  uv2_1.x = (uv_2.x + (_Time.y * _PanningSpeed.x));
  uv2_1.y = (uv_2.y + (_Time.y * _PanningSpeed.y));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = uv_2;
  xlv_TEXCOORD1 = uv2_1;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec4 detail_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DetailTex, xlv_TEXCOORD1);
  detail_1 = tmpvar_4;
  color_2 = (color_2 * detail_1);
  color_2.xyz = (color_2.xyz * _Color.xyz);
  color_2 = (color_2 * xlv_COLOR);
  gl_FragData[0] = color_2;
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
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _PanningSpeed;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 uv2_1;
  mediump vec2 uv_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_2 = tmpvar_4;
  uv2_1.x = (uv_2.x + (_Time.y * _PanningSpeed.x));
  uv2_1.y = (uv_2.y + (_Time.y * _PanningSpeed.y));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = uv_2;
  xlv_TEXCOORD1 = uv2_1;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec4 detail_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DetailTex, xlv_TEXCOORD1);
  detail_1 = tmpvar_4;
  color_2 = (color_2 * detail_1);
  color_2.xyz = (color_2.xyz * _Color.xyz);
  color_2 = (color_2 * xlv_COLOR);
  gl_FragData[0] = color_2;
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
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _PanningSpeed;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 uv2_1;
  mediump vec2 uv_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_2 = tmpvar_4;
  uv2_1.x = (uv_2.x + (_Time.y * _PanningSpeed.x));
  uv2_1.y = (uv_2.y + (_Time.y * _PanningSpeed.y));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = uv_2;
  xlv_TEXCOORD1 = uv2_1;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec4 detail_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DetailTex, xlv_TEXCOORD1);
  detail_1 = tmpvar_4;
  color_2 = (color_2 * detail_1);
  color_2.xyz = (color_2.xyz * _Color.xyz);
  color_2 = (color_2 * xlv_COLOR);
  gl_FragData[0] = color_2;
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