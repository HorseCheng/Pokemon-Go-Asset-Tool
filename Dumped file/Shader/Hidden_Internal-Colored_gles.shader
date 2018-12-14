Shader "Hidden/Internal-Colored" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_SrcBlend ("SrcBlend", Float) = 5
_DstBlend ("DstBlend", Float) = 10
_ZWrite ("ZWrite", Float) = 1
_ZTest ("ZTest", Float) = 4
_Cull ("Cull", Float) = 0
_ZBias ("ZBias", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 37372
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (_glesColor * _Color);
  xlv_COLOR = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (_glesColor * _Color);
  xlv_COLOR = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (_glesColor * _Color);
  xlv_COLOR = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _Color;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (_glesColor * _Color);
  xlv_COLOR = tmpvar_1;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _Color;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (_glesColor * _Color);
  xlv_COLOR = tmpvar_1;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _Color;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (_glesColor * _Color);
  xlv_COLOR = tmpvar_1;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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