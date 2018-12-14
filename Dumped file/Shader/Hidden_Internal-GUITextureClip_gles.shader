Shader "Hidden/Internal-GUITextureClip" {
Properties {
_MainTex ("Texture", any) = "white" { }
}
SubShader {
 Tags { "ForceSupported" = "true" }
 Pass {
  Tags { "ForceSupported" = "true" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 10209
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 unity_GUIClipTextureMatrix;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.xy = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_3)).xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_GUIClipTextureMatrix * tmpvar_4).xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GUIClipTexture;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = (tmpvar_2.w * texture2D (_GUIClipTexture, xlv_TEXCOORD1).w);
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
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 unity_GUIClipTextureMatrix;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.xy = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_3)).xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_GUIClipTextureMatrix * tmpvar_4).xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GUIClipTexture;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = (tmpvar_2.w * texture2D (_GUIClipTexture, xlv_TEXCOORD1).w);
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
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 unity_GUIClipTextureMatrix;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.xy = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_3)).xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_GUIClipTextureMatrix * tmpvar_4).xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GUIClipTexture;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = (tmpvar_2.w * texture2D (_GUIClipTexture, xlv_TEXCOORD1).w);
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
}
}
}
SubShader {
 Tags { "ForceSupported" = "true" }
 Pass {
  Tags { "ForceSupported" = "true" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 96838
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 unity_GUIClipTextureMatrix;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.xy = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_3)).xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_GUIClipTextureMatrix * tmpvar_4).xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GUIClipTexture;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = (tmpvar_2.w * texture2D (_GUIClipTexture, xlv_TEXCOORD1).w);
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
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 unity_GUIClipTextureMatrix;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.xy = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_3)).xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_GUIClipTextureMatrix * tmpvar_4).xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GUIClipTexture;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = (tmpvar_2.w * texture2D (_GUIClipTexture, xlv_TEXCOORD1).w);
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
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 unity_GUIClipTextureMatrix;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.xy = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_3)).xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_GUIClipTextureMatrix * tmpvar_4).xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GUIClipTexture;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = (tmpvar_2.w * texture2D (_GUIClipTexture, xlv_TEXCOORD1).w);
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
}
}
}
}