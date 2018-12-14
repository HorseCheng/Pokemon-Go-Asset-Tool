Shader "Holo/Character/FX/FireCore - Horizontally Stepped" {
Properties {
_MainTex ("Combo (R=A1 G=A2)", 2D) = "black" { }
_FPS ("FPS", Float) = 15
_Step ("Step", Float) = 0
_Offset ("Depth Offset", Float) = 0
_Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare Function", Float) = 8
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 2
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 62295
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _Step;
uniform mediump float _FPS;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_1.x = (tmpvar_1.x + fract((
    floor((_Time.y * _FPS))
   * _Step)));
  tmpvar_1.yw = clamp ((tmpvar_1.yw + ceil(
    (tmpvar_1.yw - 1.0)
  )), vec2(0.05, 0.05), vec2(0.95, 0.95));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy).x * texture2D (_MainTex, xlv_TEXCOORD0.zw).y);
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.5);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 0.5, 0.0);
  tmpvar_5.w = alpha_2;
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _Step;
uniform mediump float _FPS;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_1.x = (tmpvar_1.x + fract((
    floor((_Time.y * _FPS))
   * _Step)));
  tmpvar_1.yw = clamp ((tmpvar_1.yw + ceil(
    (tmpvar_1.yw - 1.0)
  )), vec2(0.05, 0.05), vec2(0.95, 0.95));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy).x * texture2D (_MainTex, xlv_TEXCOORD0.zw).y);
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.5);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 0.5, 0.0);
  tmpvar_5.w = alpha_2;
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _Step;
uniform mediump float _FPS;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_1.x = (tmpvar_1.x + fract((
    floor((_Time.y * _FPS))
   * _Step)));
  tmpvar_1.yw = clamp ((tmpvar_1.yw + ceil(
    (tmpvar_1.yw - 1.0)
  )), vec2(0.05, 0.05), vec2(0.95, 0.95));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy).x * texture2D (_MainTex, xlv_TEXCOORD0.zw).y);
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.5);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 0.5, 0.0);
  tmpvar_5.w = alpha_2;
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
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