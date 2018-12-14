Shader "Unlit/Park Painted" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_TintColor ("Tint", Color) = (1,1,1,1)
_AddColor ("Additive", Color) = (0,0,0,0)
_Saturation ("Saturation", Range(0, 1)) = 1
}
SubShader {
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Geometry+1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 43546
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _AddColor;
uniform lowp float _Saturation;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 sat_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2.w = tmpvar_3.w;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(dot (tmpvar_3.xyz, vec3(0.3, 0.59, 0.11)));
  sat_1 = tmpvar_4;
  col_2.xyz = mix (tmpvar_3.xyz, sat_1.xyz, vec3((1.0 - _Saturation)));
  col_2 = (col_2 * _TintColor);
  col_2.xyz = (col_2.xyz + _AddColor.xyz);
  gl_FragData[0] = col_2;
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
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _AddColor;
uniform lowp float _Saturation;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 sat_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2.w = tmpvar_3.w;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(dot (tmpvar_3.xyz, vec3(0.3, 0.59, 0.11)));
  sat_1 = tmpvar_4;
  col_2.xyz = mix (tmpvar_3.xyz, sat_1.xyz, vec3((1.0 - _Saturation)));
  col_2 = (col_2 * _TintColor);
  col_2.xyz = (col_2.xyz + _AddColor.xyz);
  gl_FragData[0] = col_2;
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
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _AddColor;
uniform lowp float _Saturation;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 sat_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2.w = tmpvar_3.w;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(dot (tmpvar_3.xyz, vec3(0.3, 0.59, 0.11)));
  sat_1 = tmpvar_4;
  col_2.xyz = mix (tmpvar_3.xyz, sat_1.xyz, vec3((1.0 - _Saturation)));
  col_2 = (col_2 * _TintColor);
  col_2.xyz = (col_2.xyz + _AddColor.xyz);
  gl_FragData[0] = col_2;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _AddColor;
uniform lowp float _Saturation;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 sat_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2.w = tmpvar_3.w;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(dot (tmpvar_3.xyz, vec3(0.3, 0.59, 0.11)));
  sat_1 = tmpvar_4;
  col_2.xyz = mix (tmpvar_3.xyz, sat_1.xyz, vec3((1.0 - _Saturation)));
  col_2 = (col_2 * _TintColor);
  col_2.xyz = (col_2.xyz + _AddColor.xyz);
  gl_FragData[0] = col_2;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _AddColor;
uniform lowp float _Saturation;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 sat_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2.w = tmpvar_3.w;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(dot (tmpvar_3.xyz, vec3(0.3, 0.59, 0.11)));
  sat_1 = tmpvar_4;
  col_2.xyz = mix (tmpvar_3.xyz, sat_1.xyz, vec3((1.0 - _Saturation)));
  col_2 = (col_2 * _TintColor);
  col_2.xyz = (col_2.xyz + _AddColor.xyz);
  gl_FragData[0] = col_2;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _AddColor;
uniform lowp float _Saturation;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 sat_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2.w = tmpvar_3.w;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(dot (tmpvar_3.xyz, vec3(0.3, 0.59, 0.11)));
  sat_1 = tmpvar_4;
  col_2.xyz = mix (tmpvar_3.xyz, sat_1.xyz, vec3((1.0 - _Saturation)));
  col_2 = (col_2 * _TintColor);
  col_2.xyz = (col_2.xyz + _AddColor.xyz);
  gl_FragData[0] = col_2;
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