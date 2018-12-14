Shader "Hidden/FrameDebuggerRenderTargetDisplay" {
Properties {
_MainTex ("", any) = "white" { }
}
SubShader {
 Tags { "ForceSupported" = "true" }
 Pass {
  Tags { "ForceSupported" = "true" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 52480
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Channels;
uniform mediump vec4 _Levels;
uniform highp sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  mediump vec4 col_4;
  col_4 = (tex_1 - _Levels.xxxx);
  col_4 = (col_4 / (_Levels.yyyy - _Levels.xxxx));
  col_4 = (col_4 * _Channels);
  lowp float tmpvar_5;
  tmpvar_5 = dot (_Channels, vec4(1.0, 1.0, 1.0, 1.0));
  if ((tmpvar_5 == 1.0)) {
    col_4 = vec4(dot (col_4, vec4(1.0, 1.0, 1.0, 1.0)));
  };
  tmpvar_3 = col_4;
  gl_FragData[0] = tmpvar_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Channels;
uniform mediump vec4 _Levels;
uniform highp sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  mediump vec4 col_4;
  col_4 = (tex_1 - _Levels.xxxx);
  col_4 = (col_4 / (_Levels.yyyy - _Levels.xxxx));
  col_4 = (col_4 * _Channels);
  lowp float tmpvar_5;
  tmpvar_5 = dot (_Channels, vec4(1.0, 1.0, 1.0, 1.0));
  if ((tmpvar_5 == 1.0)) {
    col_4 = vec4(dot (col_4, vec4(1.0, 1.0, 1.0, 1.0)));
  };
  tmpvar_3 = col_4;
  gl_FragData[0] = tmpvar_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Channels;
uniform mediump vec4 _Levels;
uniform highp sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  mediump vec4 col_4;
  col_4 = (tex_1 - _Levels.xxxx);
  col_4 = (col_4 / (_Levels.yyyy - _Levels.xxxx));
  col_4 = (col_4 * _Channels);
  lowp float tmpvar_5;
  tmpvar_5 = dot (_Channels, vec4(1.0, 1.0, 1.0, 1.0));
  if ((tmpvar_5 == 1.0)) {
    col_4 = vec4(dot (col_4, vec4(1.0, 1.0, 1.0, 1.0)));
  };
  tmpvar_3 = col_4;
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
}
}
 Pass {
  Tags { "ForceSupported" = "true" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 86592
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Channels;
uniform mediump vec4 _Levels;
uniform highp samplerCube _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = textureCube (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  mediump vec4 col_4;
  col_4 = (tex_1 - _Levels.xxxx);
  col_4 = (col_4 / (_Levels.yyyy - _Levels.xxxx));
  col_4 = (col_4 * _Channels);
  lowp float tmpvar_5;
  tmpvar_5 = dot (_Channels, vec4(1.0, 1.0, 1.0, 1.0));
  if ((tmpvar_5 == 1.0)) {
    col_4 = vec4(dot (col_4, vec4(1.0, 1.0, 1.0, 1.0)));
  };
  tmpvar_3 = col_4;
  gl_FragData[0] = tmpvar_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Channels;
uniform mediump vec4 _Levels;
uniform highp samplerCube _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = textureCube (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  mediump vec4 col_4;
  col_4 = (tex_1 - _Levels.xxxx);
  col_4 = (col_4 / (_Levels.yyyy - _Levels.xxxx));
  col_4 = (col_4 * _Channels);
  lowp float tmpvar_5;
  tmpvar_5 = dot (_Channels, vec4(1.0, 1.0, 1.0, 1.0));
  if ((tmpvar_5 == 1.0)) {
    col_4 = vec4(dot (col_4, vec4(1.0, 1.0, 1.0, 1.0)));
  };
  tmpvar_3 = col_4;
  gl_FragData[0] = tmpvar_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Channels;
uniform mediump vec4 _Levels;
uniform highp samplerCube _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = textureCube (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  mediump vec4 col_4;
  col_4 = (tex_1 - _Levels.xxxx);
  col_4 = (col_4 / (_Levels.yyyy - _Levels.xxxx));
  col_4 = (col_4 * _Channels);
  lowp float tmpvar_5;
  tmpvar_5 = dot (_Channels, vec4(1.0, 1.0, 1.0, 1.0));
  if ((tmpvar_5 == 1.0)) {
    col_4 = vec4(dot (col_4, vec4(1.0, 1.0, 1.0, 1.0)));
  };
  tmpvar_3 = col_4;
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
}
}
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 154206
Program "vp" {
}
Program "fp" {
}
}
}
}