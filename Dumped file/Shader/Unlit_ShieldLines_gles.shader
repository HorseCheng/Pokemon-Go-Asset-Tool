Shader "Unlit/ShieldLines" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_ProgressTex ("Progress Texture", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_Progress ("Progress", Range(0, 1)) = 1
_Speed ("Speed", Range(0, 1)) = 1
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 30610
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
uniform highp float _Progress;
uniform highp float _Speed;
highp vec4 xlat_mutable_MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  xlat_mutable_MainTex_ST.xyw = _MainTex_ST.xyw;
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
  tmpvar_1 = (tmpvar_3 + _MainTex_ST.zw);
  tmpvar_1.x = (tmpvar_1.x - (_Time.y * _Speed));
  xlat_mutable_MainTex_ST.z = (_MainTex_ST.z + (1.0 - (_Progress * 1.5)));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_3 + xlat_mutable_MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ProgressTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((_Color * texture2D (_MainTex, xlv_TEXCOORD0).wwww) * texture2D (_ProgressTex, xlv_TEXCOORD1).xxxx);
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Progress;
uniform highp float _Speed;
highp vec4 xlat_mutable_MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  xlat_mutable_MainTex_ST.xyw = _MainTex_ST.xyw;
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
  tmpvar_1 = (tmpvar_3 + _MainTex_ST.zw);
  tmpvar_1.x = (tmpvar_1.x - (_Time.y * _Speed));
  xlat_mutable_MainTex_ST.z = (_MainTex_ST.z + (1.0 - (_Progress * 1.5)));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_3 + xlat_mutable_MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ProgressTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((_Color * texture2D (_MainTex, xlv_TEXCOORD0).wwww) * texture2D (_ProgressTex, xlv_TEXCOORD1).xxxx);
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Progress;
uniform highp float _Speed;
highp vec4 xlat_mutable_MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  xlat_mutable_MainTex_ST.xyw = _MainTex_ST.xyw;
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
  tmpvar_1 = (tmpvar_3 + _MainTex_ST.zw);
  tmpvar_1.x = (tmpvar_1.x - (_Time.y * _Speed));
  xlat_mutable_MainTex_ST.z = (_MainTex_ST.z + (1.0 - (_Progress * 1.5)));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_3 + xlat_mutable_MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ProgressTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((_Color * texture2D (_MainTex, xlv_TEXCOORD0).wwww) * texture2D (_ProgressTex, xlv_TEXCOORD1).xxxx);
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