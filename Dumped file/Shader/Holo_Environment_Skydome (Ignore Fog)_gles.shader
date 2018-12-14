Shader "Holo/Environment/Skydome (Ignore Fog)" {
Properties {
_SkyColor ("Sky Main Color", Color) = (1,1,1,1)
_HorizonColor ("Horizon Color", Color) = (1,1,1,1)
_HorizonPinch ("Horizon Pinch", Float) = 1
_HorizonHeight ("Horizon Height", Float) = 0
_FogPinch ("Fog Pinch", Float) = 1
_FogHeight ("Fog Height", Float) = 0
_StarTex ("Star Texture", 2D) = "black" { }
_StarStrength ("Star Brightness", Range(0, 1)) = 0
_StarFalloff ("Star Falloff", Float) = 5
_PanningSpeed ("Panning Speed", Float) = 0.01
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Background" }
  ZWrite Off
  GpuProgramID 26792
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform mediump vec4 _SkyColor;
uniform mediump vec4 _HorizonColor;
uniform lowp float _HorizonPinch;
uniform lowp float _HorizonHeight;
uniform lowp float _FogPinch;
uniform lowp float _FogHeight;
uniform highp vec4 _StarTex_ST;
uniform lowp float _StarFalloff;
uniform lowp float _PanningSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump float fogGradient_1;
  mediump float skyGradient_2;
  mediump float uvGrad_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp float tmpvar_5;
  tmpvar_5 = (1.0 - _glesMultiTexCoord0.y);
  uvGrad_3 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp ((uvGrad_3 + _HorizonHeight), 0.0, 1.0);
  lowp float tmpvar_7;
  tmpvar_7 = pow (tmpvar_6, _HorizonPinch);
  skyGradient_2 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp ((uvGrad_3 + _FogHeight), 0.0, 1.0);
  lowp float tmpvar_9;
  tmpvar_9 = pow (tmpvar_8, _FogPinch);
  fogGradient_1 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.y = 0.0;
  tmpvar_10.x = (_Time.x * _PanningSpeed);
  xlv_TEXCOORD0 = (((_glesMultiTexCoord1.xy * _StarTex_ST.xy) + _StarTex_ST.zw) + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = mix (mix (_SkyColor, _HorizonColor, vec4(skyGradient_2)), unity_FogColor, vec4(fogGradient_1));
  xlv_TEXCOORD1 = (1.0 - pow (uvGrad_3, _StarFalloff));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _StarTex;
uniform lowp float _StarStrength;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 stars_1;
  lowp vec4 col_2;
  col_2 = xlv_COLOR;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_StarTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_TEXCOORD1);
  stars_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = (col_2 + (stars_1 * _StarStrength));
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform mediump vec4 _SkyColor;
uniform mediump vec4 _HorizonColor;
uniform lowp float _HorizonPinch;
uniform lowp float _HorizonHeight;
uniform lowp float _FogPinch;
uniform lowp float _FogHeight;
uniform highp vec4 _StarTex_ST;
uniform lowp float _StarFalloff;
uniform lowp float _PanningSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump float fogGradient_1;
  mediump float skyGradient_2;
  mediump float uvGrad_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp float tmpvar_5;
  tmpvar_5 = (1.0 - _glesMultiTexCoord0.y);
  uvGrad_3 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp ((uvGrad_3 + _HorizonHeight), 0.0, 1.0);
  lowp float tmpvar_7;
  tmpvar_7 = pow (tmpvar_6, _HorizonPinch);
  skyGradient_2 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp ((uvGrad_3 + _FogHeight), 0.0, 1.0);
  lowp float tmpvar_9;
  tmpvar_9 = pow (tmpvar_8, _FogPinch);
  fogGradient_1 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.y = 0.0;
  tmpvar_10.x = (_Time.x * _PanningSpeed);
  xlv_TEXCOORD0 = (((_glesMultiTexCoord1.xy * _StarTex_ST.xy) + _StarTex_ST.zw) + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = mix (mix (_SkyColor, _HorizonColor, vec4(skyGradient_2)), unity_FogColor, vec4(fogGradient_1));
  xlv_TEXCOORD1 = (1.0 - pow (uvGrad_3, _StarFalloff));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _StarTex;
uniform lowp float _StarStrength;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 stars_1;
  lowp vec4 col_2;
  col_2 = xlv_COLOR;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_StarTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_TEXCOORD1);
  stars_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = (col_2 + (stars_1 * _StarStrength));
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform mediump vec4 _SkyColor;
uniform mediump vec4 _HorizonColor;
uniform lowp float _HorizonPinch;
uniform lowp float _HorizonHeight;
uniform lowp float _FogPinch;
uniform lowp float _FogHeight;
uniform highp vec4 _StarTex_ST;
uniform lowp float _StarFalloff;
uniform lowp float _PanningSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump float fogGradient_1;
  mediump float skyGradient_2;
  mediump float uvGrad_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp float tmpvar_5;
  tmpvar_5 = (1.0 - _glesMultiTexCoord0.y);
  uvGrad_3 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp ((uvGrad_3 + _HorizonHeight), 0.0, 1.0);
  lowp float tmpvar_7;
  tmpvar_7 = pow (tmpvar_6, _HorizonPinch);
  skyGradient_2 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp ((uvGrad_3 + _FogHeight), 0.0, 1.0);
  lowp float tmpvar_9;
  tmpvar_9 = pow (tmpvar_8, _FogPinch);
  fogGradient_1 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.y = 0.0;
  tmpvar_10.x = (_Time.x * _PanningSpeed);
  xlv_TEXCOORD0 = (((_glesMultiTexCoord1.xy * _StarTex_ST.xy) + _StarTex_ST.zw) + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = mix (mix (_SkyColor, _HorizonColor, vec4(skyGradient_2)), unity_FogColor, vec4(fogGradient_1));
  xlv_TEXCOORD1 = (1.0 - pow (uvGrad_3, _StarFalloff));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _StarTex;
uniform lowp float _StarStrength;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 stars_1;
  lowp vec4 col_2;
  col_2 = xlv_COLOR;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_StarTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_TEXCOORD1);
  stars_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = (col_2 + (stars_1 * _StarStrength));
  gl_FragData[0] = tmpvar_5;
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