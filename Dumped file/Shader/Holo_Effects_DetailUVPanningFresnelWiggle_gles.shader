Shader "Holo/Effects/DetailUVPanningFresnelWiggle" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_DetailTex ("Detail Texture", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
_PanningSpeed ("Panning Speed", Vector) = (0,0,0,0)
_FresnelScale ("Fresnel Scale", Float) = 1
_FresnelPower ("Fresnel Power", Float) = 1
_VertexNoise ("Vertex Noise", Float) = 0
_VertexSpeed ("Vertex Speed", Float) = 1
_VertexFrequency ("Vertex Frequency", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 61504
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _DetailTex_ST;
uniform lowp vec4 _PanningSpeed;
uniform lowp float _FresnelScale;
uniform lowp float _FresnelPower;
uniform lowp float _VertexNoise;
uniform lowp float _VertexSpeed;
uniform lowp float _VertexFrequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump vec2 uv2_2;
  mediump vec2 uv_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_1.x = (_glesVertex.x + ((
    sin(((_Time.y + (_glesVertex.x * _VertexFrequency)) * _VertexSpeed))
   * _VertexNoise) * _glesColor.x));
  tmpvar_1.y = (_glesVertex.y + ((
    sin(((_Time.y + (_glesVertex.y * _VertexFrequency)) * _VertexSpeed))
   * _VertexNoise) * _glesColor.y));
  tmpvar_1.z = (_glesVertex.z + ((
    sin(((_Time.y + (_glesVertex.z * _VertexFrequency)) * _VertexSpeed))
   * _VertexNoise) * _glesColor.z));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_3 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  uv2_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (normalize(
    ((unity_WorldToObject * tmpvar_10).xyz - tmpvar_1.xyz)
  ), _glesNormal), 0.0, 1.0);
  lowp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, _FresnelPower);
  tmpvar_6 = ((_FresnelScale * tmpvar_12) * _glesColor.w);
  uv_3.x = (uv_3.x + (_Time.y * _PanningSpeed.z));
  uv_3.y = (uv_3.y + (_Time.y * _PanningSpeed.w));
  uv2_2.x = (uv2_2.x + (_Time.y * _PanningSpeed.x));
  uv2_2.y = (uv2_2.y + (_Time.y * _PanningSpeed.y));
  tmpvar_4 = uv_3;
  tmpvar_5 = uv2_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 detail_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DetailTex, xlv_TEXCOORD1);
  detail_1 = tmpvar_4;
  color_2 = (color_2 * detail_1);
  color_2 = (color_2 * _Color);
  color_2.w = (color_2.w * xlv_TEXCOORD2);
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _DetailTex_ST;
uniform lowp vec4 _PanningSpeed;
uniform lowp float _FresnelScale;
uniform lowp float _FresnelPower;
uniform lowp float _VertexNoise;
uniform lowp float _VertexSpeed;
uniform lowp float _VertexFrequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump vec2 uv2_2;
  mediump vec2 uv_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_1.x = (_glesVertex.x + ((
    sin(((_Time.y + (_glesVertex.x * _VertexFrequency)) * _VertexSpeed))
   * _VertexNoise) * _glesColor.x));
  tmpvar_1.y = (_glesVertex.y + ((
    sin(((_Time.y + (_glesVertex.y * _VertexFrequency)) * _VertexSpeed))
   * _VertexNoise) * _glesColor.y));
  tmpvar_1.z = (_glesVertex.z + ((
    sin(((_Time.y + (_glesVertex.z * _VertexFrequency)) * _VertexSpeed))
   * _VertexNoise) * _glesColor.z));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_3 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  uv2_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (normalize(
    ((unity_WorldToObject * tmpvar_10).xyz - tmpvar_1.xyz)
  ), _glesNormal), 0.0, 1.0);
  lowp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, _FresnelPower);
  tmpvar_6 = ((_FresnelScale * tmpvar_12) * _glesColor.w);
  uv_3.x = (uv_3.x + (_Time.y * _PanningSpeed.z));
  uv_3.y = (uv_3.y + (_Time.y * _PanningSpeed.w));
  uv2_2.x = (uv2_2.x + (_Time.y * _PanningSpeed.x));
  uv2_2.y = (uv2_2.y + (_Time.y * _PanningSpeed.y));
  tmpvar_4 = uv_3;
  tmpvar_5 = uv2_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 detail_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DetailTex, xlv_TEXCOORD1);
  detail_1 = tmpvar_4;
  color_2 = (color_2 * detail_1);
  color_2 = (color_2 * _Color);
  color_2.w = (color_2.w * xlv_TEXCOORD2);
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _DetailTex_ST;
uniform lowp vec4 _PanningSpeed;
uniform lowp float _FresnelScale;
uniform lowp float _FresnelPower;
uniform lowp float _VertexNoise;
uniform lowp float _VertexSpeed;
uniform lowp float _VertexFrequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump vec2 uv2_2;
  mediump vec2 uv_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_1.x = (_glesVertex.x + ((
    sin(((_Time.y + (_glesVertex.x * _VertexFrequency)) * _VertexSpeed))
   * _VertexNoise) * _glesColor.x));
  tmpvar_1.y = (_glesVertex.y + ((
    sin(((_Time.y + (_glesVertex.y * _VertexFrequency)) * _VertexSpeed))
   * _VertexNoise) * _glesColor.y));
  tmpvar_1.z = (_glesVertex.z + ((
    sin(((_Time.y + (_glesVertex.z * _VertexFrequency)) * _VertexSpeed))
   * _VertexNoise) * _glesColor.z));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_3 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  uv2_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (normalize(
    ((unity_WorldToObject * tmpvar_10).xyz - tmpvar_1.xyz)
  ), _glesNormal), 0.0, 1.0);
  lowp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, _FresnelPower);
  tmpvar_6 = ((_FresnelScale * tmpvar_12) * _glesColor.w);
  uv_3.x = (uv_3.x + (_Time.y * _PanningSpeed.z));
  uv_3.y = (uv_3.y + (_Time.y * _PanningSpeed.w));
  uv2_2.x = (uv2_2.x + (_Time.y * _PanningSpeed.x));
  uv2_2.y = (uv2_2.y + (_Time.y * _PanningSpeed.y));
  tmpvar_4 = uv_3;
  tmpvar_5 = uv2_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 detail_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DetailTex, xlv_TEXCOORD1);
  detail_1 = tmpvar_4;
  color_2 = (color_2 * detail_1);
  color_2 = (color_2 * _Color);
  color_2.w = (color_2.w * xlv_TEXCOORD2);
  gl_FragData[0] = color_2;
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