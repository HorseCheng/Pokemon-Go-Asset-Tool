Shader "Holo/Effects/Unlit Dissolve" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_DisolveTex ("Dissolve Texture", 2D) = "white" { }
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
[Toggle] _ZWrite ("Z Write", Float) = 1
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "TransparentCutout" }
 Pass {
  Tags { "QUEUE" = "Transparent" "RenderType" = "TransparentCutout" }
  ZWrite Off
  Cull Off
  GpuProgramID 52001
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
uniform mediump vec4 _DisolveTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DisolveTex_ST.xy) + _DisolveTex_ST.zw);
  tmpvar_4 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DisolveTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 dissolve_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_DisolveTex, xlv_TEXCOORD1);
  dissolve_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1 = tmpvar_4;
  color_1.xyz = (color_1.xyz * xlv_COLOR.xyz);
  dissolve_2 = (xlv_COLOR.w + ((dissolve_2 * xlv_COLOR.w) * 2.0));
  dissolve_2 = (dissolve_2 * dissolve_2);
  dissolve_2 = (dissolve_2 * dissolve_2);
  dissolve_2 = (dissolve_2 * dissolve_2);
  color_1.w = (color_1.w * dissolve_2.x);
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
uniform mediump vec4 _DisolveTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DisolveTex_ST.xy) + _DisolveTex_ST.zw);
  tmpvar_4 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DisolveTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 dissolve_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_DisolveTex, xlv_TEXCOORD1);
  dissolve_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1 = tmpvar_4;
  color_1.xyz = (color_1.xyz * xlv_COLOR.xyz);
  dissolve_2 = (xlv_COLOR.w + ((dissolve_2 * xlv_COLOR.w) * 2.0));
  dissolve_2 = (dissolve_2 * dissolve_2);
  dissolve_2 = (dissolve_2 * dissolve_2);
  dissolve_2 = (dissolve_2 * dissolve_2);
  color_1.w = (color_1.w * dissolve_2.x);
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
uniform mediump vec4 _DisolveTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DisolveTex_ST.xy) + _DisolveTex_ST.zw);
  tmpvar_4 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DisolveTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 dissolve_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_DisolveTex, xlv_TEXCOORD1);
  dissolve_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1 = tmpvar_4;
  color_1.xyz = (color_1.xyz * xlv_COLOR.xyz);
  dissolve_2 = (xlv_COLOR.w + ((dissolve_2 * xlv_COLOR.w) * 2.0));
  dissolve_2 = (dissolve_2 * dissolve_2);
  dissolve_2 = (dissolve_2 * dissolve_2);
  dissolve_2 = (dissolve_2 * dissolve_2);
  color_1.w = (color_1.w * dissolve_2.x);
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