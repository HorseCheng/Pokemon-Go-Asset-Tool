Shader "Niantic/Rainbow" {
Properties {
_TintColor ("Tint Color", Color) = (1,1,1,1)
_Height ("Height", Float) = 10
_Width ("Width", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _ZComp ("Z Compare Function", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 44842
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2.xy = tmpvar_1.xy;
  tmpvar_2.z = (unity_ObjectToWorld * _glesVertex).y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform highp float _Width;
uniform highp float _Height;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp float a_1;
  lowp float q_2;
  lowp vec4 col_3;
  lowp float d_4;
  lowp float w_5;
  w_5 = _Width;
  highp float tmpvar_6;
  tmpvar_6 = sqrt(dot (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.xy));
  d_4 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((d_4 - (_Height - w_5)) / (2.0 * w_5));
  q_2 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = clamp (q_2, 0.0, 1.0);
  highp vec4 c_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (vec4(1.0, 1.0, 0.8, 0.2) * pow (vec4(2.718282, 2.718282, 2.718282, 2.718282), (
    ((vec4(0.6, 0.45, 0.175, 0.16) - tmpvar_8) * (tmpvar_8 - vec4(0.6, 0.45, 0.175, 0.16)))
   / vec4(0.0275, 0.045, 0.006, 0.004))));
  c_9.yzw = tmpvar_10.yzw;
  c_9.x = (tmpvar_10.x + tmpvar_10.w);
  lowp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = clamp (c_9.xyz, 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  col_3.xyz = (tmpvar_11 * 1.25);
  highp float tmpvar_13;
  tmpvar_13 = (abs((d_4 - _Height)) / w_5);
  a_1 = tmpvar_13;
  col_3.w = (((
    clamp ((1.0 - (a_1 * a_1)), 0.0, 1.0)
   * 
    (xlv_TEXCOORD0.z / _Height)
  ) * 0.3) * dot (col_3.xyz, vec3(1.0, 1.0, 1.0)));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (col_3 * _TintColor);
  gl_FragData[0] = tmpvar_14;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2.xy = tmpvar_1.xy;
  tmpvar_2.z = (unity_ObjectToWorld * _glesVertex).y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform highp float _Width;
uniform highp float _Height;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp float a_1;
  lowp float q_2;
  lowp vec4 col_3;
  lowp float d_4;
  lowp float w_5;
  w_5 = _Width;
  highp float tmpvar_6;
  tmpvar_6 = sqrt(dot (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.xy));
  d_4 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((d_4 - (_Height - w_5)) / (2.0 * w_5));
  q_2 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = clamp (q_2, 0.0, 1.0);
  highp vec4 c_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (vec4(1.0, 1.0, 0.8, 0.2) * pow (vec4(2.718282, 2.718282, 2.718282, 2.718282), (
    ((vec4(0.6, 0.45, 0.175, 0.16) - tmpvar_8) * (tmpvar_8 - vec4(0.6, 0.45, 0.175, 0.16)))
   / vec4(0.0275, 0.045, 0.006, 0.004))));
  c_9.yzw = tmpvar_10.yzw;
  c_9.x = (tmpvar_10.x + tmpvar_10.w);
  lowp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = clamp (c_9.xyz, 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  col_3.xyz = (tmpvar_11 * 1.25);
  highp float tmpvar_13;
  tmpvar_13 = (abs((d_4 - _Height)) / w_5);
  a_1 = tmpvar_13;
  col_3.w = (((
    clamp ((1.0 - (a_1 * a_1)), 0.0, 1.0)
   * 
    (xlv_TEXCOORD0.z / _Height)
  ) * 0.3) * dot (col_3.xyz, vec3(1.0, 1.0, 1.0)));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (col_3 * _TintColor);
  gl_FragData[0] = tmpvar_14;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2.xy = tmpvar_1.xy;
  tmpvar_2.z = (unity_ObjectToWorld * _glesVertex).y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform highp float _Width;
uniform highp float _Height;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp float a_1;
  lowp float q_2;
  lowp vec4 col_3;
  lowp float d_4;
  lowp float w_5;
  w_5 = _Width;
  highp float tmpvar_6;
  tmpvar_6 = sqrt(dot (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.xy));
  d_4 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((d_4 - (_Height - w_5)) / (2.0 * w_5));
  q_2 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = clamp (q_2, 0.0, 1.0);
  highp vec4 c_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (vec4(1.0, 1.0, 0.8, 0.2) * pow (vec4(2.718282, 2.718282, 2.718282, 2.718282), (
    ((vec4(0.6, 0.45, 0.175, 0.16) - tmpvar_8) * (tmpvar_8 - vec4(0.6, 0.45, 0.175, 0.16)))
   / vec4(0.0275, 0.045, 0.006, 0.004))));
  c_9.yzw = tmpvar_10.yzw;
  c_9.x = (tmpvar_10.x + tmpvar_10.w);
  lowp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = clamp (c_9.xyz, 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  col_3.xyz = (tmpvar_11 * 1.25);
  highp float tmpvar_13;
  tmpvar_13 = (abs((d_4 - _Height)) / w_5);
  a_1 = tmpvar_13;
  col_3.w = (((
    clamp ((1.0 - (a_1 * a_1)), 0.0, 1.0)
   * 
    (xlv_TEXCOORD0.z / _Height)
  ) * 0.3) * dot (col_3.xyz, vec3(1.0, 1.0, 1.0)));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (col_3 * _TintColor);
  gl_FragData[0] = tmpvar_14;
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