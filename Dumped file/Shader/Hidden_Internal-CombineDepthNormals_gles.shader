Shader "Hidden/Internal-CombineDepthNormals" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 249
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _CameraNormalsTexture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _CameraNormalsTexture_ST.xy) + _CameraNormalsTexture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp mat4 unity_WorldToCamera;
uniform highp sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 n_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_CameraNormalsTexture, xlv_TEXCOORD0) * 2.0) - 1.0).xyz;
  n_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.y)));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToCamera[0].xyz;
  tmpvar_5[1] = unity_WorldToCamera[1].xyz;
  tmpvar_5[2] = unity_WorldToCamera[2].xyz;
  n_2 = (tmpvar_5 * n_2);
  n_2.z = -(n_2.z);
  highp vec4 tmpvar_6;
  if ((tmpvar_4 < 0.9999846)) {
    highp vec4 enc_7;
    highp vec2 enc_8;
    enc_8 = (n_2.xy / (n_2.z + 1.0));
    enc_8 = (enc_8 / 1.7777);
    enc_8 = ((enc_8 * 0.5) + 0.5);
    enc_7.xy = enc_8;
    highp vec2 enc_9;
    highp vec2 tmpvar_10;
    tmpvar_10 = fract((vec2(1.0, 255.0) * tmpvar_4));
    enc_9.y = tmpvar_10.y;
    enc_9.x = (tmpvar_10.x - (tmpvar_10.y * 0.003921569));
    enc_7.zw = enc_9;
    tmpvar_6 = enc_7;
  } else {
    tmpvar_6 = vec4(0.5, 0.5, 1.0, 1.0);
  };
  tmpvar_1 = tmpvar_6;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _CameraNormalsTexture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _CameraNormalsTexture_ST.xy) + _CameraNormalsTexture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp mat4 unity_WorldToCamera;
uniform highp sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 n_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_CameraNormalsTexture, xlv_TEXCOORD0) * 2.0) - 1.0).xyz;
  n_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.y)));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToCamera[0].xyz;
  tmpvar_5[1] = unity_WorldToCamera[1].xyz;
  tmpvar_5[2] = unity_WorldToCamera[2].xyz;
  n_2 = (tmpvar_5 * n_2);
  n_2.z = -(n_2.z);
  highp vec4 tmpvar_6;
  if ((tmpvar_4 < 0.9999846)) {
    highp vec4 enc_7;
    highp vec2 enc_8;
    enc_8 = (n_2.xy / (n_2.z + 1.0));
    enc_8 = (enc_8 / 1.7777);
    enc_8 = ((enc_8 * 0.5) + 0.5);
    enc_7.xy = enc_8;
    highp vec2 enc_9;
    highp vec2 tmpvar_10;
    tmpvar_10 = fract((vec2(1.0, 255.0) * tmpvar_4));
    enc_9.y = tmpvar_10.y;
    enc_9.x = (tmpvar_10.x - (tmpvar_10.y * 0.003921569));
    enc_7.zw = enc_9;
    tmpvar_6 = enc_7;
  } else {
    tmpvar_6 = vec4(0.5, 0.5, 1.0, 1.0);
  };
  tmpvar_1 = tmpvar_6;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _CameraNormalsTexture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _CameraNormalsTexture_ST.xy) + _CameraNormalsTexture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp mat4 unity_WorldToCamera;
uniform highp sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 n_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_CameraNormalsTexture, xlv_TEXCOORD0) * 2.0) - 1.0).xyz;
  n_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.y)));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToCamera[0].xyz;
  tmpvar_5[1] = unity_WorldToCamera[1].xyz;
  tmpvar_5[2] = unity_WorldToCamera[2].xyz;
  n_2 = (tmpvar_5 * n_2);
  n_2.z = -(n_2.z);
  highp vec4 tmpvar_6;
  if ((tmpvar_4 < 0.9999846)) {
    highp vec4 enc_7;
    highp vec2 enc_8;
    enc_8 = (n_2.xy / (n_2.z + 1.0));
    enc_8 = (enc_8 / 1.7777);
    enc_8 = ((enc_8 * 0.5) + 0.5);
    enc_7.xy = enc_8;
    highp vec2 enc_9;
    highp vec2 tmpvar_10;
    tmpvar_10 = fract((vec2(1.0, 255.0) * tmpvar_4));
    enc_9.y = tmpvar_10.y;
    enc_9.x = (tmpvar_10.x - (tmpvar_10.y * 0.003921569));
    enc_7.zw = enc_9;
    tmpvar_6 = enc_7;
  } else {
    tmpvar_6 = vec4(0.5, 0.5, 1.0, 1.0);
  };
  tmpvar_1 = tmpvar_6;
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