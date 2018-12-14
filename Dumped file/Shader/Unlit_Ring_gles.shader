Shader "Unlit/Ring" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_Distort ("Distort", Vector) = (0.5,0.5,1,1)
_OuterRadius ("Outer Radius", Float) = 0.5
_InnerRadius ("Inner Radius", Float) = -0.5
_Hardness ("Hardness", Float) = 1
}
SubShader {
 Tags { "AllowProjectors" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "AllowProjectors" = "False" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 65192
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec4 normal_7;
  normal_7 = tmpvar_6;
  mediump vec3 res_8;
  mediump vec3 x_9;
  x_9.x = dot (unity_SHAr, normal_7);
  x_9.y = dot (unity_SHAg, normal_7);
  x_9.z = dot (unity_SHAb, normal_7);
  mediump vec3 x1_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (normal_7.xyzz * normal_7.yzzx);
  x1_10.x = dot (unity_SHBr, tmpvar_11);
  x1_10.y = dot (unity_SHBg, tmpvar_11);
  x1_10.z = dot (unity_SHBb, tmpvar_11);
  res_8 = (x_9 + (x1_10 + (unity_SHC.xyz * 
    ((normal_7.x * normal_7.x) - (normal_7.y * normal_7.y))
  )));
  mediump vec3 tmpvar_12;
  tmpvar_12 = max (((1.055 * 
    pow (max (res_8, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_8 = tmpvar_12;
  shlight_1 = tmpvar_12;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec4 normal_7;
  normal_7 = tmpvar_6;
  mediump vec3 res_8;
  mediump vec3 x_9;
  x_9.x = dot (unity_SHAr, normal_7);
  x_9.y = dot (unity_SHAg, normal_7);
  x_9.z = dot (unity_SHAb, normal_7);
  mediump vec3 x1_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (normal_7.xyzz * normal_7.yzzx);
  x1_10.x = dot (unity_SHBr, tmpvar_11);
  x1_10.y = dot (unity_SHBg, tmpvar_11);
  x1_10.z = dot (unity_SHBb, tmpvar_11);
  res_8 = (x_9 + (x1_10 + (unity_SHC.xyz * 
    ((normal_7.x * normal_7.x) - (normal_7.y * normal_7.y))
  )));
  mediump vec3 tmpvar_12;
  tmpvar_12 = max (((1.055 * 
    pow (max (res_8, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_8 = tmpvar_12;
  shlight_1 = tmpvar_12;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec4 normal_7;
  normal_7 = tmpvar_6;
  mediump vec3 res_8;
  mediump vec3 x_9;
  x_9.x = dot (unity_SHAr, normal_7);
  x_9.y = dot (unity_SHAg, normal_7);
  x_9.z = dot (unity_SHAb, normal_7);
  mediump vec3 x1_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (normal_7.xyzz * normal_7.yzzx);
  x1_10.x = dot (unity_SHBr, tmpvar_11);
  x1_10.y = dot (unity_SHBg, tmpvar_11);
  x1_10.z = dot (unity_SHBb, tmpvar_11);
  res_8 = (x_9 + (x1_10 + (unity_SHC.xyz * 
    ((normal_7.x * normal_7.x) - (normal_7.y * normal_7.y))
  )));
  mediump vec3 tmpvar_12;
  tmpvar_12 = max (((1.055 * 
    pow (max (res_8, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_8 = tmpvar_12;
  shlight_1 = tmpvar_12;
  tmpvar_2 = shlight_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 col_19;
  highp vec4 ndotl_20;
  highp vec4 lengthSq_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_21 = (tmpvar_22 * tmpvar_22);
  lengthSq_21 = (lengthSq_21 + (tmpvar_23 * tmpvar_23));
  lengthSq_21 = (lengthSq_21 + (tmpvar_24 * tmpvar_24));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (lengthSq_21, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_21 = tmpvar_25;
  ndotl_20 = (tmpvar_22 * tmpvar_6.x);
  ndotl_20 = (ndotl_20 + (tmpvar_23 * tmpvar_6.y));
  ndotl_20 = (ndotl_20 + (tmpvar_24 * tmpvar_6.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_20 * inversesqrt(tmpvar_25)));
  ndotl_20 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (tmpvar_25 * lightAttenSq_18)
  ))));
  col_19 = (lightColor0_14 * tmpvar_27.x);
  col_19 = (col_19 + (lightColor1_15 * tmpvar_27.y));
  col_19 = (col_19 + (lightColor2_16 * tmpvar_27.z));
  col_19 = (col_19 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_2 = (tmpvar_2 + col_19);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 col_19;
  highp vec4 ndotl_20;
  highp vec4 lengthSq_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_21 = (tmpvar_22 * tmpvar_22);
  lengthSq_21 = (lengthSq_21 + (tmpvar_23 * tmpvar_23));
  lengthSq_21 = (lengthSq_21 + (tmpvar_24 * tmpvar_24));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (lengthSq_21, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_21 = tmpvar_25;
  ndotl_20 = (tmpvar_22 * tmpvar_6.x);
  ndotl_20 = (ndotl_20 + (tmpvar_23 * tmpvar_6.y));
  ndotl_20 = (ndotl_20 + (tmpvar_24 * tmpvar_6.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_20 * inversesqrt(tmpvar_25)));
  ndotl_20 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (tmpvar_25 * lightAttenSq_18)
  ))));
  col_19 = (lightColor0_14 * tmpvar_27.x);
  col_19 = (col_19 + (lightColor1_15 * tmpvar_27.y));
  col_19 = (col_19 + (lightColor2_16 * tmpvar_27.z));
  col_19 = (col_19 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_2 = (tmpvar_2 + col_19);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 col_19;
  highp vec4 ndotl_20;
  highp vec4 lengthSq_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_21 = (tmpvar_22 * tmpvar_22);
  lengthSq_21 = (lengthSq_21 + (tmpvar_23 * tmpvar_23));
  lengthSq_21 = (lengthSq_21 + (tmpvar_24 * tmpvar_24));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (lengthSq_21, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_21 = tmpvar_25;
  ndotl_20 = (tmpvar_22 * tmpvar_6.x);
  ndotl_20 = (ndotl_20 + (tmpvar_23 * tmpvar_6.y));
  ndotl_20 = (ndotl_20 + (tmpvar_24 * tmpvar_6.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_20 * inversesqrt(tmpvar_25)));
  ndotl_20 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (tmpvar_25 * lightAttenSq_18)
  ))));
  col_19 = (lightColor0_14 * tmpvar_27.x);
  col_19 = (col_19 + (lightColor1_15 * tmpvar_27.y));
  col_19 = (col_19 + (lightColor2_16 * tmpvar_27.z));
  col_19 = (col_19 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_2 = (tmpvar_2 + col_19);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec4 normal_8;
  normal_8 = tmpvar_7;
  mediump vec3 res_9;
  mediump vec3 x_10;
  x_10.x = dot (unity_SHAr, normal_8);
  x_10.y = dot (unity_SHAg, normal_8);
  x_10.z = dot (unity_SHAb, normal_8);
  mediump vec3 x1_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal_8.xyzz * normal_8.yzzx);
  x1_11.x = dot (unity_SHBr, tmpvar_12);
  x1_11.y = dot (unity_SHBg, tmpvar_12);
  x1_11.z = dot (unity_SHBb, tmpvar_12);
  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = max (((1.055 * 
    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_9 = tmpvar_13;
  shlight_1 = tmpvar_13;
  tmpvar_2 = shlight_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_15;
  lightColor0_15 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_16;
  lightColor1_16 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_17;
  lightColor2_17 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_18;
  lightColor3_18 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_19;
  lightAttenSq_19 = unity_4LightAtten0;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * tmpvar_7.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * tmpvar_7.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * tmpvar_7.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_19)
  ))));
  col_20 = (lightColor0_15 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_16 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_17 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_18 * tmpvar_28.w));
  tmpvar_2 = (tmpvar_2 + col_20);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_15;
  lightColor0_15 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_16;
  lightColor1_16 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_17;
  lightColor2_17 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_18;
  lightColor3_18 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_19;
  lightAttenSq_19 = unity_4LightAtten0;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * tmpvar_7.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * tmpvar_7.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * tmpvar_7.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_19)
  ))));
  col_20 = (lightColor0_15 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_16 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_17 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_18 * tmpvar_28.w));
  tmpvar_2 = (tmpvar_2 + col_20);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
  tmpvar_2 = shlight_1;
  highp vec3 lightColor0_15;
  lightColor0_15 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_16;
  lightColor1_16 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_17;
  lightColor2_17 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_18;
  lightColor3_18 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_19;
  lightAttenSq_19 = unity_4LightAtten0;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * tmpvar_7.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * tmpvar_7.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * tmpvar_7.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_19)
  ))));
  col_20 = (lightColor0_15 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_16 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_17 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_18 * tmpvar_28.w));
  tmpvar_2 = (tmpvar_2 + col_20);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD3);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "AllowProjectors" = "False" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 92405
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "META"
  Tags { "AllowProjectors" = "False" "LIGHTMODE" = "META" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 145413
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 vertex_1;
  vertex_1 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_2;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_2 = 0.0001;
    } else {
      tmpvar_2 = 0.0;
    };
    vertex_1.z = tmpvar_2;
  };
  if (unity_MetaVertexControl.y) {
    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_3;
    if ((vertex_1.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_1.z = tmpvar_3;
  };
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = vertex_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  tmpvar_3 = (_Color.xyz * c_4.xyz);
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_6;
  res_6 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = tmpvar_2;
    res_6.w = tmpvar_7.w;
    highp vec3 tmpvar_8;
    tmpvar_8 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_6.xyz = tmpvar_8;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_9;
    if (bool(unity_UseLinearSpace)) {
      emission_9 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_9 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = emission_9;
    res_6 = tmpvar_10;
  };
  tmpvar_1 = res_6;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 vertex_1;
  vertex_1 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_2;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_2 = 0.0001;
    } else {
      tmpvar_2 = 0.0;
    };
    vertex_1.z = tmpvar_2;
  };
  if (unity_MetaVertexControl.y) {
    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_3;
    if ((vertex_1.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_1.z = tmpvar_3;
  };
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = vertex_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  tmpvar_3 = (_Color.xyz * c_4.xyz);
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_6;
  res_6 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = tmpvar_2;
    res_6.w = tmpvar_7.w;
    highp vec3 tmpvar_8;
    tmpvar_8 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_6.xyz = tmpvar_8;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_9;
    if (bool(unity_UseLinearSpace)) {
      emission_9 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_9 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = emission_9;
    res_6 = tmpvar_10;
  };
  tmpvar_1 = res_6;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 vertex_1;
  vertex_1 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_2;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_2 = 0.0001;
    } else {
      tmpvar_2 = 0.0;
    };
    vertex_1.z = tmpvar_2;
  };
  if (unity_MetaVertexControl.y) {
    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_3;
    if ((vertex_1.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_1.z = tmpvar_3;
  };
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = vertex_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  tmpvar_3 = (_Color.xyz * c_4.xyz);
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_6;
  res_6 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = tmpvar_2;
    res_6.w = tmpvar_7.w;
    highp vec3 tmpvar_8;
    tmpvar_8 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_6.xyz = tmpvar_8;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_9;
    if (bool(unity_UseLinearSpace)) {
      emission_9 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_9 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = emission_9;
    res_6 = tmpvar_10;
  };
  tmpvar_1 = res_6;
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