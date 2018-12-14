Shader "Unlit/UnlitColorTexture" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Texture", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 26676
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
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
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
}
}
}
}