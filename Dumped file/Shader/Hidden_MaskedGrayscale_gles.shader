Shader "Hidden/MaskedGrayscale" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_MaskTex ("Mask (A)", 2D) = "white" { }
_MaskOffValue ("_MaskOffValue", Float) = 1
_MaskOnValue ("_MaskOnValue", Float) = 1
_RampTex ("Ramp (RGB)", 2D) = "grayscaleRamp" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 18022
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _RampTex;
uniform mediump float _MaskOffValue;
uniform mediump float _MaskOnValue;
uniform mediump float _RampOffset;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 xlat_varoutput_1;
  mediump float maskSample_2;
  lowp float grayscale_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 rgb_5;
  rgb_5 = tmpvar_4.xyz;
  mediump float tmpvar_6;
  tmpvar_6 = dot (rgb_5, vec3(0.22, 0.707, 0.071));
  grayscale_3 = tmpvar_6;
  mediump vec2 tmpvar_7;
  tmpvar_7.y = 0.5;
  tmpvar_7.x = (grayscale_3 + _RampOffset);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MaskTex, xlv_TEXCOORD0).x;
  maskSample_2 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_RampTex, tmpvar_7);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_4, tmpvar_9, vec4(mix (_MaskOffValue, _MaskOnValue, maskSample_2)));
  xlat_varoutput_1.xyz = tmpvar_10.xyz;
  xlat_varoutput_1.w = tmpvar_4.w;
  gl_FragData[0] = xlat_varoutput_1;
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
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _RampTex;
uniform mediump float _MaskOffValue;
uniform mediump float _MaskOnValue;
uniform mediump float _RampOffset;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 xlat_varoutput_1;
  mediump float maskSample_2;
  lowp float grayscale_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 rgb_5;
  rgb_5 = tmpvar_4.xyz;
  mediump float tmpvar_6;
  tmpvar_6 = dot (rgb_5, vec3(0.22, 0.707, 0.071));
  grayscale_3 = tmpvar_6;
  mediump vec2 tmpvar_7;
  tmpvar_7.y = 0.5;
  tmpvar_7.x = (grayscale_3 + _RampOffset);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MaskTex, xlv_TEXCOORD0).x;
  maskSample_2 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_RampTex, tmpvar_7);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_4, tmpvar_9, vec4(mix (_MaskOffValue, _MaskOnValue, maskSample_2)));
  xlat_varoutput_1.xyz = tmpvar_10.xyz;
  xlat_varoutput_1.w = tmpvar_4.w;
  gl_FragData[0] = xlat_varoutput_1;
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
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _RampTex;
uniform mediump float _MaskOffValue;
uniform mediump float _MaskOnValue;
uniform mediump float _RampOffset;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 xlat_varoutput_1;
  mediump float maskSample_2;
  lowp float grayscale_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 rgb_5;
  rgb_5 = tmpvar_4.xyz;
  mediump float tmpvar_6;
  tmpvar_6 = dot (rgb_5, vec3(0.22, 0.707, 0.071));
  grayscale_3 = tmpvar_6;
  mediump vec2 tmpvar_7;
  tmpvar_7.y = 0.5;
  tmpvar_7.x = (grayscale_3 + _RampOffset);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MaskTex, xlv_TEXCOORD0).x;
  maskSample_2 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_RampTex, tmpvar_7);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_4, tmpvar_9, vec4(mix (_MaskOffValue, _MaskOnValue, maskSample_2)));
  xlat_varoutput_1.xyz = tmpvar_10.xyz;
  xlat_varoutput_1.w = tmpvar_4.w;
  gl_FragData[0] = xlat_varoutput_1;
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