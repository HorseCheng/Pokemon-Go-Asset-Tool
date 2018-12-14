Shader "GUI/Text Shader" {
Properties {
_MainTex ("Font Texture", 2D) = "white" { }
_Color ("Text Color", Color) = (1,1,1,1)
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 52291
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = (_glesColor * _Color);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = xlv_COLOR.xyz;
  col_1.w = (xlv_COLOR.w * texture2D (_MainTex, xlv_TEXCOORD0).w);
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MainTex_ST;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = (_glesColor * _Color);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = xlv_COLOR.xyz;
  col_1.w = (xlv_COLOR.w * texture2D (_MainTex, xlv_TEXCOORD0).w);
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MainTex_ST;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = (_glesColor * _Color);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = xlv_COLOR.xyz;
  col_1.w = (xlv_COLOR.w * texture2D (_MainTex, xlv_TEXCOORD0).w);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _MainTex_ST;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = (_glesColor * _Color);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = xlv_COLOR.xyz;
  col_1.w = (xlv_COLOR.w * texture2D (_MainTex, xlv_TEXCOORD0).w);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _MainTex_ST;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = (_glesColor * _Color);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = xlv_COLOR.xyz;
  col_1.w = (xlv_COLOR.w * texture2D (_MainTex, xlv_TEXCOORD0).w);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _MainTex_ST;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = (_glesColor * _Color);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = xlv_COLOR.xyz;
  col_1.w = (xlv_COLOR.w * texture2D (_MainTex, xlv_TEXCOORD0).w);
  gl_FragData[0] = col_1;
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
Keywords { "UNITY_SINGLE_PASS_STEREO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
""
}
}
}
}
}