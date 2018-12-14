Shader "Legacy Shaders/Diffuse" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Base (RGB)", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 33959
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  mediump vec3 normal_4;
  normal_4 = tmpvar_3;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = normal_4;
  mediump vec3 res_6;
  mediump vec3 x_7;
  x_7.x = dot (unity_SHAr, tmpvar_5);
  x_7.y = dot (unity_SHAg, tmpvar_5);
  x_7.z = dot (unity_SHAb, tmpvar_5);
  mediump vec3 x1_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = (normal_4.xyzz * normal_4.yzzx);
  x1_8.x = dot (unity_SHBr, tmpvar_9);
  x1_8.y = dot (unity_SHBg, tmpvar_9);
  x1_8.z = dot (unity_SHBb, tmpvar_9);
  res_6 = (x_7 + (x1_8 + (unity_SHC.xyz * 
    ((normal_4.x * normal_4.x) - (normal_4.y * normal_4.y))
  )));
  mediump vec3 tmpvar_10;
  tmpvar_10 = max (((1.055 * 
    pow (max (res_6, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_6 = tmpvar_10;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_10);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  mediump vec3 normal_4;
  normal_4 = tmpvar_3;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = normal_4;
  mediump vec3 res_6;
  mediump vec3 x_7;
  x_7.x = dot (unity_SHAr, tmpvar_5);
  x_7.y = dot (unity_SHAg, tmpvar_5);
  x_7.z = dot (unity_SHAb, tmpvar_5);
  mediump vec3 x1_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = (normal_4.xyzz * normal_4.yzzx);
  x1_8.x = dot (unity_SHBr, tmpvar_9);
  x1_8.y = dot (unity_SHBg, tmpvar_9);
  x1_8.z = dot (unity_SHBb, tmpvar_9);
  res_6 = (x_7 + (x1_8 + (unity_SHC.xyz * 
    ((normal_4.x * normal_4.x) - (normal_4.y * normal_4.y))
  )));
  mediump vec3 tmpvar_10;
  tmpvar_10 = max (((1.055 * 
    pow (max (res_6, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_6 = tmpvar_10;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_10);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  mediump vec3 normal_4;
  normal_4 = tmpvar_3;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = normal_4;
  mediump vec3 res_6;
  mediump vec3 x_7;
  x_7.x = dot (unity_SHAr, tmpvar_5);
  x_7.y = dot (unity_SHAg, tmpvar_5);
  x_7.z = dot (unity_SHAb, tmpvar_5);
  mediump vec3 x1_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = (normal_4.xyzz * normal_4.yzzx);
  x1_8.x = dot (unity_SHBr, tmpvar_9);
  x1_8.y = dot (unity_SHBg, tmpvar_9);
  x1_8.z = dot (unity_SHBb, tmpvar_9);
  res_6 = (x_7 + (x1_8 + (unity_SHC.xyz * 
    ((normal_4.x * normal_4.x) - (normal_4.y * normal_4.y))
  )));
  mediump vec3 tmpvar_10;
  tmpvar_10 = max (((1.055 * 
    pow (max (res_6, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_6 = tmpvar_10;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_10);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp vec4 c_24;
  lowp float diff_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_25 = tmpvar_26;
  c_24.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_25);
  c_24.w = tmpvar_9.w;
  c_23.w = c_24.w;
  c_23.xyz = c_24.xyz;
  c_4.xyz = c_23.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp vec4 c_24;
  lowp float diff_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_25 = tmpvar_26;
  c_24.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_25);
  c_24.w = tmpvar_9.w;
  c_23.w = c_24.w;
  c_23.xyz = c_24.xyz;
  c_4.xyz = c_23.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp vec4 c_24;
  lowp float diff_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_25 = tmpvar_26;
  c_24.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_25);
  c_24.w = tmpvar_9.w;
  c_23.w = c_24.w;
  c_23.xyz = c_24.xyz;
  c_4.xyz = c_23.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  mediump vec3 normal_6;
  normal_6 = tmpvar_5;
  mediump vec3 x1_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = (normal_6.xyzz * normal_6.yzzx);
  x1_7.x = dot (unity_SHBr, tmpvar_8);
  x1_7.y = dot (unity_SHBg, tmpvar_8);
  x1_7.z = dot (unity_SHBb, tmpvar_8);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (x1_7 + (unity_SHC.xyz * (
    (normal_6.x * normal_6.x)
   - 
    (normal_6.y * normal_6.y)
  )));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 normalWorld_22;
  normalWorld_22 = tmpvar_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_2 * tmpvar_1);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = normalWorld_22;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_24);
  x_25.y = dot (unity_SHAg, tmpvar_24);
  x_25.z = dot (unity_SHAb, tmpvar_24);
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = tmpvar_23;
  lowp vec4 c_27;
  lowp vec4 c_28;
  lowp float diff_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_29 = tmpvar_30;
  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
  c_28.w = tmpvar_9.w;
  c_27.w = c_28.w;
  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
  c_4.xyz = c_27.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  mediump vec3 normal_6;
  normal_6 = tmpvar_5;
  mediump vec3 x1_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = (normal_6.xyzz * normal_6.yzzx);
  x1_7.x = dot (unity_SHBr, tmpvar_8);
  x1_7.y = dot (unity_SHBg, tmpvar_8);
  x1_7.z = dot (unity_SHBb, tmpvar_8);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (x1_7 + (unity_SHC.xyz * (
    (normal_6.x * normal_6.x)
   - 
    (normal_6.y * normal_6.y)
  )));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 normalWorld_22;
  normalWorld_22 = tmpvar_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_2 * tmpvar_1);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = normalWorld_22;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_24);
  x_25.y = dot (unity_SHAg, tmpvar_24);
  x_25.z = dot (unity_SHAb, tmpvar_24);
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = tmpvar_23;
  lowp vec4 c_27;
  lowp vec4 c_28;
  lowp float diff_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_29 = tmpvar_30;
  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
  c_28.w = tmpvar_9.w;
  c_27.w = c_28.w;
  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
  c_4.xyz = c_27.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  mediump vec3 normal_6;
  normal_6 = tmpvar_5;
  mediump vec3 x1_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = (normal_6.xyzz * normal_6.yzzx);
  x1_7.x = dot (unity_SHBr, tmpvar_8);
  x1_7.y = dot (unity_SHBg, tmpvar_8);
  x1_7.z = dot (unity_SHBb, tmpvar_8);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (x1_7 + (unity_SHC.xyz * (
    (normal_6.x * normal_6.x)
   - 
    (normal_6.y * normal_6.y)
  )));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 normalWorld_22;
  normalWorld_22 = tmpvar_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_2 * tmpvar_1);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = normalWorld_22;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_24);
  x_25.y = dot (unity_SHAg, tmpvar_24);
  x_25.z = dot (unity_SHAb, tmpvar_24);
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = tmpvar_23;
  lowp vec4 c_27;
  lowp vec4 c_28;
  lowp float diff_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_29 = tmpvar_30;
  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
  c_28.w = tmpvar_9.w;
  c_27.w = c_28.w;
  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
  c_4.xyz = c_27.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  highp vec3 lightColor0_6;
  lightColor0_6 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_7;
  lightColor1_7 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_8;
  lightColor2_8 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_9;
  lightColor3_9 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_10;
  lightAttenSq_10 = unity_4LightAtten0;
  highp vec3 col_11;
  highp vec4 ndotl_12;
  highp vec4 lengthSq_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - tmpvar_3.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - tmpvar_3.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - tmpvar_3.z);
  lengthSq_13 = (tmpvar_14 * tmpvar_14);
  lengthSq_13 = (lengthSq_13 + (tmpvar_15 * tmpvar_15));
  lengthSq_13 = (lengthSq_13 + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_17;
  tmpvar_17 = max (lengthSq_13, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_13 = tmpvar_17;
  ndotl_12 = (tmpvar_14 * tmpvar_5.x);
  ndotl_12 = (ndotl_12 + (tmpvar_15 * tmpvar_5.y));
  ndotl_12 = (ndotl_12 + (tmpvar_16 * tmpvar_5.z));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_12 * inversesqrt(tmpvar_17)));
  ndotl_12 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * (1.0/((1.0 + 
    (tmpvar_17 * lightAttenSq_10)
  ))));
  col_11 = (lightColor0_6 * tmpvar_19.x);
  col_11 = (col_11 + (lightColor1_7 * tmpvar_19.y));
  col_11 = (col_11 + (lightColor2_8 * tmpvar_19.z));
  col_11 = (col_11 + (lightColor3_9 * tmpvar_19.w));
  tmpvar_1 = col_11;
  mediump vec3 normal_20;
  normal_20 = tmpvar_5;
  mediump vec3 ambient_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = normal_20;
  mediump vec3 res_23;
  mediump vec3 x_24;
  x_24.x = dot (unity_SHAr, tmpvar_22);
  x_24.y = dot (unity_SHAg, tmpvar_22);
  x_24.z = dot (unity_SHAb, tmpvar_22);
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_20.xyzz * normal_20.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
    ((normal_20.x * normal_20.x) - (normal_20.y * normal_20.y))
  )));
  mediump vec3 tmpvar_27;
  tmpvar_27 = max (((1.055 * 
    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_23 = tmpvar_27;
  ambient_21 = (tmpvar_1 + max (vec3(0.0, 0.0, 0.0), tmpvar_27));
  tmpvar_1 = ambient_21;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = ambient_21;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  highp vec3 lightColor0_6;
  lightColor0_6 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_7;
  lightColor1_7 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_8;
  lightColor2_8 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_9;
  lightColor3_9 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_10;
  lightAttenSq_10 = unity_4LightAtten0;
  highp vec3 col_11;
  highp vec4 ndotl_12;
  highp vec4 lengthSq_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - tmpvar_3.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - tmpvar_3.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - tmpvar_3.z);
  lengthSq_13 = (tmpvar_14 * tmpvar_14);
  lengthSq_13 = (lengthSq_13 + (tmpvar_15 * tmpvar_15));
  lengthSq_13 = (lengthSq_13 + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_17;
  tmpvar_17 = max (lengthSq_13, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_13 = tmpvar_17;
  ndotl_12 = (tmpvar_14 * tmpvar_5.x);
  ndotl_12 = (ndotl_12 + (tmpvar_15 * tmpvar_5.y));
  ndotl_12 = (ndotl_12 + (tmpvar_16 * tmpvar_5.z));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_12 * inversesqrt(tmpvar_17)));
  ndotl_12 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * (1.0/((1.0 + 
    (tmpvar_17 * lightAttenSq_10)
  ))));
  col_11 = (lightColor0_6 * tmpvar_19.x);
  col_11 = (col_11 + (lightColor1_7 * tmpvar_19.y));
  col_11 = (col_11 + (lightColor2_8 * tmpvar_19.z));
  col_11 = (col_11 + (lightColor3_9 * tmpvar_19.w));
  tmpvar_1 = col_11;
  mediump vec3 normal_20;
  normal_20 = tmpvar_5;
  mediump vec3 ambient_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = normal_20;
  mediump vec3 res_23;
  mediump vec3 x_24;
  x_24.x = dot (unity_SHAr, tmpvar_22);
  x_24.y = dot (unity_SHAg, tmpvar_22);
  x_24.z = dot (unity_SHAb, tmpvar_22);
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_20.xyzz * normal_20.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
    ((normal_20.x * normal_20.x) - (normal_20.y * normal_20.y))
  )));
  mediump vec3 tmpvar_27;
  tmpvar_27 = max (((1.055 * 
    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_23 = tmpvar_27;
  ambient_21 = (tmpvar_1 + max (vec3(0.0, 0.0, 0.0), tmpvar_27));
  tmpvar_1 = ambient_21;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = ambient_21;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  highp vec3 lightColor0_6;
  lightColor0_6 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_7;
  lightColor1_7 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_8;
  lightColor2_8 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_9;
  lightColor3_9 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_10;
  lightAttenSq_10 = unity_4LightAtten0;
  highp vec3 col_11;
  highp vec4 ndotl_12;
  highp vec4 lengthSq_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - tmpvar_3.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - tmpvar_3.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - tmpvar_3.z);
  lengthSq_13 = (tmpvar_14 * tmpvar_14);
  lengthSq_13 = (lengthSq_13 + (tmpvar_15 * tmpvar_15));
  lengthSq_13 = (lengthSq_13 + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_17;
  tmpvar_17 = max (lengthSq_13, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_13 = tmpvar_17;
  ndotl_12 = (tmpvar_14 * tmpvar_5.x);
  ndotl_12 = (ndotl_12 + (tmpvar_15 * tmpvar_5.y));
  ndotl_12 = (ndotl_12 + (tmpvar_16 * tmpvar_5.z));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_12 * inversesqrt(tmpvar_17)));
  ndotl_12 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * (1.0/((1.0 + 
    (tmpvar_17 * lightAttenSq_10)
  ))));
  col_11 = (lightColor0_6 * tmpvar_19.x);
  col_11 = (col_11 + (lightColor1_7 * tmpvar_19.y));
  col_11 = (col_11 + (lightColor2_8 * tmpvar_19.z));
  col_11 = (col_11 + (lightColor3_9 * tmpvar_19.w));
  tmpvar_1 = col_11;
  mediump vec3 normal_20;
  normal_20 = tmpvar_5;
  mediump vec3 ambient_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = normal_20;
  mediump vec3 res_23;
  mediump vec3 x_24;
  x_24.x = dot (unity_SHAr, tmpvar_22);
  x_24.y = dot (unity_SHAg, tmpvar_22);
  x_24.z = dot (unity_SHAb, tmpvar_22);
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_20.xyzz * normal_20.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
    ((normal_20.x * normal_20.x) - (normal_20.y * normal_20.y))
  )));
  mediump vec3 tmpvar_27;
  tmpvar_27 = max (((1.055 * 
    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_23 = tmpvar_27;
  ambient_21 = (tmpvar_1 + max (vec3(0.0, 0.0, 0.0), tmpvar_27));
  tmpvar_1 = ambient_21;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = ambient_21;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp vec4 c_24;
  lowp float diff_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_25 = tmpvar_26;
  c_24.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_25);
  c_24.w = tmpvar_9.w;
  c_23.w = c_24.w;
  c_23.xyz = c_24.xyz;
  c_4.xyz = c_23.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp vec4 c_24;
  lowp float diff_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_25 = tmpvar_26;
  c_24.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_25);
  c_24.w = tmpvar_9.w;
  c_23.w = c_24.w;
  c_23.xyz = c_24.xyz;
  c_4.xyz = c_23.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp vec4 c_24;
  lowp float diff_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_25 = tmpvar_26;
  c_24.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_25);
  c_24.w = tmpvar_9.w;
  c_23.w = c_24.w;
  c_23.xyz = c_24.xyz;
  c_4.xyz = c_23.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  mediump vec3 normal_22;
  normal_22 = tmpvar_7;
  mediump vec3 ambient_23;
  mediump vec3 x1_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_22.xyzz * normal_22.yzzx);
  x1_24.x = dot (unity_SHBr, tmpvar_25);
  x1_24.y = dot (unity_SHBg, tmpvar_25);
  x1_24.z = dot (unity_SHBb, tmpvar_25);
  ambient_23 = ((tmpvar_1 * (
    (tmpvar_1 * ((tmpvar_1 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_24 + (unity_SHC.xyz * 
    ((normal_22.x * normal_22.x) - (normal_22.y * normal_22.y))
  )));
  tmpvar_1 = ambient_23;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = ambient_23;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 normalWorld_22;
  normalWorld_22 = tmpvar_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_2 * tmpvar_1);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = normalWorld_22;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_24);
  x_25.y = dot (unity_SHAg, tmpvar_24);
  x_25.z = dot (unity_SHAb, tmpvar_24);
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = tmpvar_23;
  lowp vec4 c_27;
  lowp vec4 c_28;
  lowp float diff_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_29 = tmpvar_30;
  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
  c_28.w = tmpvar_9.w;
  c_27.w = c_28.w;
  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
  c_4.xyz = c_27.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  mediump vec3 normal_22;
  normal_22 = tmpvar_7;
  mediump vec3 ambient_23;
  mediump vec3 x1_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_22.xyzz * normal_22.yzzx);
  x1_24.x = dot (unity_SHBr, tmpvar_25);
  x1_24.y = dot (unity_SHBg, tmpvar_25);
  x1_24.z = dot (unity_SHBb, tmpvar_25);
  ambient_23 = ((tmpvar_1 * (
    (tmpvar_1 * ((tmpvar_1 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_24 + (unity_SHC.xyz * 
    ((normal_22.x * normal_22.x) - (normal_22.y * normal_22.y))
  )));
  tmpvar_1 = ambient_23;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = ambient_23;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 normalWorld_22;
  normalWorld_22 = tmpvar_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_2 * tmpvar_1);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = normalWorld_22;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_24);
  x_25.y = dot (unity_SHAg, tmpvar_24);
  x_25.z = dot (unity_SHAb, tmpvar_24);
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = tmpvar_23;
  lowp vec4 c_27;
  lowp vec4 c_28;
  lowp float diff_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_29 = tmpvar_30;
  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
  c_28.w = tmpvar_9.w;
  c_27.w = c_28.w;
  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
  c_4.xyz = c_27.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 col_13;
  highp vec4 ndotl_14;
  highp vec4 lengthSq_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_15 = (tmpvar_16 * tmpvar_16);
  lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
  lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (lengthSq_15, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_15 = tmpvar_19;
  ndotl_14 = (tmpvar_16 * tmpvar_7.x);
  ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
  ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
  ndotl_14 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
    (tmpvar_19 * lightAttenSq_12)
  ))));
  col_13 = (lightColor0_8 * tmpvar_21.x);
  col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
  col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
  col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
  tmpvar_1 = col_13;
  mediump vec3 normal_22;
  normal_22 = tmpvar_7;
  mediump vec3 ambient_23;
  mediump vec3 x1_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_22.xyzz * normal_22.yzzx);
  x1_24.x = dot (unity_SHBr, tmpvar_25);
  x1_24.y = dot (unity_SHBg, tmpvar_25);
  x1_24.z = dot (unity_SHBb, tmpvar_25);
  ambient_23 = ((tmpvar_1 * (
    (tmpvar_1 * ((tmpvar_1 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_24 + (unity_SHC.xyz * 
    ((normal_22.x * normal_22.x) - (normal_22.y * normal_22.y))
  )));
  tmpvar_1 = ambient_23;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = ambient_23;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 normalWorld_22;
  normalWorld_22 = tmpvar_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_2 * tmpvar_1);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = normalWorld_22;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_24);
  x_25.y = dot (unity_SHAg, tmpvar_24);
  x_25.z = dot (unity_SHAb, tmpvar_24);
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = tmpvar_23;
  lowp vec4 c_27;
  lowp vec4 c_28;
  lowp float diff_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_29 = tmpvar_30;
  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
  c_28.w = tmpvar_9.w;
  c_27.w = c_28.w;
  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
  c_4.xyz = c_27.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
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
varying highp float xlv_TEXCOORD5;
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
  xlv_TEXCOORD5 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
  c_8.w = tmpvar_7.w;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
varying highp float xlv_TEXCOORD5;
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
  xlv_TEXCOORD5 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
  c_8.w = tmpvar_7.w;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
varying highp float xlv_TEXCOORD5;
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
  xlv_TEXCOORD5 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
  c_8.w = tmpvar_7.w;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
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
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_glesNormal * tmpvar_3));
  mediump vec3 normal_5;
  normal_5 = tmpvar_4;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = normal_5;
  mediump vec3 res_7;
  mediump vec3 x_8;
  x_8.x = dot (unity_SHAr, tmpvar_6);
  x_8.y = dot (unity_SHAg, tmpvar_6);
  x_8.z = dot (unity_SHAb, tmpvar_6);
  mediump vec3 x1_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (normal_5.xyzz * normal_5.yzzx);
  x1_9.x = dot (unity_SHBr, tmpvar_10);
  x1_9.y = dot (unity_SHBg, tmpvar_10);
  x1_9.z = dot (unity_SHBb, tmpvar_10);
  res_7 = (x_8 + (x1_9 + (unity_SHC.xyz * 
    ((normal_5.x * normal_5.x) - (normal_5.y * normal_5.y))
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = max (((1.055 * 
    pow (max (res_7, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_7 = tmpvar_11;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_11);
  xlv_TEXCOORD5 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
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
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_glesNormal * tmpvar_3));
  mediump vec3 normal_5;
  normal_5 = tmpvar_4;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = normal_5;
  mediump vec3 res_7;
  mediump vec3 x_8;
  x_8.x = dot (unity_SHAr, tmpvar_6);
  x_8.y = dot (unity_SHAg, tmpvar_6);
  x_8.z = dot (unity_SHAb, tmpvar_6);
  mediump vec3 x1_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (normal_5.xyzz * normal_5.yzzx);
  x1_9.x = dot (unity_SHBr, tmpvar_10);
  x1_9.y = dot (unity_SHBg, tmpvar_10);
  x1_9.z = dot (unity_SHBb, tmpvar_10);
  res_7 = (x_8 + (x1_9 + (unity_SHC.xyz * 
    ((normal_5.x * normal_5.x) - (normal_5.y * normal_5.y))
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = max (((1.055 * 
    pow (max (res_7, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_7 = tmpvar_11;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_11);
  xlv_TEXCOORD5 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
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
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_glesNormal * tmpvar_3));
  mediump vec3 normal_5;
  normal_5 = tmpvar_4;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = normal_5;
  mediump vec3 res_7;
  mediump vec3 x_8;
  x_8.x = dot (unity_SHAr, tmpvar_6);
  x_8.y = dot (unity_SHAg, tmpvar_6);
  x_8.z = dot (unity_SHAb, tmpvar_6);
  mediump vec3 x1_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (normal_5.xyzz * normal_5.yzzx);
  x1_9.x = dot (unity_SHBr, tmpvar_10);
  x1_9.y = dot (unity_SHBg, tmpvar_10);
  x1_9.z = dot (unity_SHBb, tmpvar_10);
  res_7 = (x_8 + (x1_9 + (unity_SHC.xyz * 
    ((normal_5.x * normal_5.x) - (normal_5.y * normal_5.y))
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = max (((1.055 * 
    pow (max (res_7, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_7 = tmpvar_11;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_11);
  xlv_TEXCOORD5 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
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
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp float diff_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_24 = tmpvar_25;
  c_23.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_24);
  c_23.w = tmpvar_9.w;
  highp float tmpvar_26;
  tmpvar_26 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_23.xyz, vec3(tmpvar_26));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
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
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp float diff_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_24 = tmpvar_25;
  c_23.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_24);
  c_23.w = tmpvar_9.w;
  highp float tmpvar_26;
  tmpvar_26 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_23.xyz, vec3(tmpvar_26));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
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
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp float diff_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_24 = tmpvar_25;
  c_23.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_24);
  c_23.w = tmpvar_9.w;
  highp float tmpvar_26;
  tmpvar_26 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_23.xyz, vec3(tmpvar_26));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
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
  mediump vec3 normal_7;
  normal_7 = tmpvar_6;
  mediump vec3 x1_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = (normal_7.xyzz * normal_7.yzzx);
  x1_8.x = dot (unity_SHBr, tmpvar_9);
  x1_8.y = dot (unity_SHBg, tmpvar_9);
  x1_8.z = dot (unity_SHBb, tmpvar_9);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (x1_8 + (unity_SHC.xyz * (
    (normal_7.x * normal_7.x)
   - 
    (normal_7.y * normal_7.y)
  )));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 normalWorld_22;
  normalWorld_22 = tmpvar_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_2 * tmpvar_1);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = normalWorld_22;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_24);
  x_25.y = dot (unity_SHAg, tmpvar_24);
  x_25.z = dot (unity_SHAb, tmpvar_24);
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = tmpvar_23;
  lowp vec4 c_27;
  lowp vec4 c_28;
  lowp float diff_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_29 = tmpvar_30;
  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
  c_28.w = tmpvar_9.w;
  c_27.w = c_28.w;
  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_27.xyz, vec3(tmpvar_31));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
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
  mediump vec3 normal_7;
  normal_7 = tmpvar_6;
  mediump vec3 x1_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = (normal_7.xyzz * normal_7.yzzx);
  x1_8.x = dot (unity_SHBr, tmpvar_9);
  x1_8.y = dot (unity_SHBg, tmpvar_9);
  x1_8.z = dot (unity_SHBb, tmpvar_9);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (x1_8 + (unity_SHC.xyz * (
    (normal_7.x * normal_7.x)
   - 
    (normal_7.y * normal_7.y)
  )));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 normalWorld_22;
  normalWorld_22 = tmpvar_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_2 * tmpvar_1);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = normalWorld_22;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_24);
  x_25.y = dot (unity_SHAg, tmpvar_24);
  x_25.z = dot (unity_SHAb, tmpvar_24);
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = tmpvar_23;
  lowp vec4 c_27;
  lowp vec4 c_28;
  lowp float diff_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_29 = tmpvar_30;
  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
  c_28.w = tmpvar_9.w;
  c_27.w = c_28.w;
  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_27.xyz, vec3(tmpvar_31));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
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
  mediump vec3 normal_7;
  normal_7 = tmpvar_6;
  mediump vec3 x1_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = (normal_7.xyzz * normal_7.yzzx);
  x1_8.x = dot (unity_SHBr, tmpvar_9);
  x1_8.y = dot (unity_SHBg, tmpvar_9);
  x1_8.z = dot (unity_SHBb, tmpvar_9);
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (x1_8 + (unity_SHC.xyz * (
    (normal_7.x * normal_7.x)
   - 
    (normal_7.y * normal_7.y)
  )));
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 normalWorld_22;
  normalWorld_22 = tmpvar_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_2 * tmpvar_1);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = normalWorld_22;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_24);
  x_25.y = dot (unity_SHAg, tmpvar_24);
  x_25.z = dot (unity_SHAb, tmpvar_24);
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = tmpvar_23;
  lowp vec4 c_27;
  lowp vec4 c_28;
  lowp float diff_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_29 = tmpvar_30;
  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
  c_28.w = tmpvar_9.w;
  c_27.w = c_28.w;
  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_27.xyz, vec3(tmpvar_31));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
varying highp float xlv_TEXCOORD5;
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
  xlv_TEXCOORD5 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
  c_8.w = tmpvar_7.w;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
varying highp float xlv_TEXCOORD5;
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
  xlv_TEXCOORD5 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
  c_8.w = tmpvar_7.w;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
varying highp float xlv_TEXCOORD5;
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
  xlv_TEXCOORD5 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
  c_8.w = tmpvar_7.w;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec3 lightColor0_7;
  lightColor0_7 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_8;
  lightColor1_8 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_9;
  lightColor2_9 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_10;
  lightColor3_10 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_11;
  lightAttenSq_11 = unity_4LightAtten0;
  highp vec3 col_12;
  highp vec4 ndotl_13;
  highp vec4 lengthSq_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_14 = (tmpvar_15 * tmpvar_15);
  lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
  lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (lengthSq_14, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_14 = tmpvar_18;
  ndotl_13 = (tmpvar_15 * tmpvar_6.x);
  ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
  ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
  ndotl_13 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
    (tmpvar_18 * lightAttenSq_11)
  ))));
  col_12 = (lightColor0_7 * tmpvar_20.x);
  col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
  col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
  col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
  tmpvar_1 = col_12;
  mediump vec3 normal_21;
  normal_21 = tmpvar_6;
  mediump vec3 ambient_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = normal_21;
  mediump vec3 res_24;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_23);
  x_25.y = dot (unity_SHAg, tmpvar_23);
  x_25.z = dot (unity_SHAb, tmpvar_23);
  mediump vec3 x1_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = (normal_21.xyzz * normal_21.yzzx);
  x1_26.x = dot (unity_SHBr, tmpvar_27);
  x1_26.y = dot (unity_SHBg, tmpvar_27);
  x1_26.z = dot (unity_SHBb, tmpvar_27);
  res_24 = (x_25 + (x1_26 + (unity_SHC.xyz * 
    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
  )));
  mediump vec3 tmpvar_28;
  tmpvar_28 = max (((1.055 * 
    pow (max (res_24, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_24 = tmpvar_28;
  ambient_22 = (tmpvar_1 + max (vec3(0.0, 0.0, 0.0), tmpvar_28));
  tmpvar_1 = ambient_22;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ambient_22;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec3 lightColor0_7;
  lightColor0_7 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_8;
  lightColor1_8 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_9;
  lightColor2_9 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_10;
  lightColor3_10 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_11;
  lightAttenSq_11 = unity_4LightAtten0;
  highp vec3 col_12;
  highp vec4 ndotl_13;
  highp vec4 lengthSq_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_14 = (tmpvar_15 * tmpvar_15);
  lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
  lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (lengthSq_14, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_14 = tmpvar_18;
  ndotl_13 = (tmpvar_15 * tmpvar_6.x);
  ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
  ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
  ndotl_13 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
    (tmpvar_18 * lightAttenSq_11)
  ))));
  col_12 = (lightColor0_7 * tmpvar_20.x);
  col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
  col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
  col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
  tmpvar_1 = col_12;
  mediump vec3 normal_21;
  normal_21 = tmpvar_6;
  mediump vec3 ambient_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = normal_21;
  mediump vec3 res_24;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_23);
  x_25.y = dot (unity_SHAg, tmpvar_23);
  x_25.z = dot (unity_SHAb, tmpvar_23);
  mediump vec3 x1_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = (normal_21.xyzz * normal_21.yzzx);
  x1_26.x = dot (unity_SHBr, tmpvar_27);
  x1_26.y = dot (unity_SHBg, tmpvar_27);
  x1_26.z = dot (unity_SHBb, tmpvar_27);
  res_24 = (x_25 + (x1_26 + (unity_SHC.xyz * 
    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
  )));
  mediump vec3 tmpvar_28;
  tmpvar_28 = max (((1.055 * 
    pow (max (res_24, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_24 = tmpvar_28;
  ambient_22 = (tmpvar_1 + max (vec3(0.0, 0.0, 0.0), tmpvar_28));
  tmpvar_1 = ambient_22;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ambient_22;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  highp vec3 lightColor0_7;
  lightColor0_7 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_8;
  lightColor1_8 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_9;
  lightColor2_9 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_10;
  lightColor3_10 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_11;
  lightAttenSq_11 = unity_4LightAtten0;
  highp vec3 col_12;
  highp vec4 ndotl_13;
  highp vec4 lengthSq_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
  lengthSq_14 = (tmpvar_15 * tmpvar_15);
  lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
  lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (lengthSq_14, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_14 = tmpvar_18;
  ndotl_13 = (tmpvar_15 * tmpvar_6.x);
  ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
  ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
  highp vec4 tmpvar_19;
  tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
  ndotl_13 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
    (tmpvar_18 * lightAttenSq_11)
  ))));
  col_12 = (lightColor0_7 * tmpvar_20.x);
  col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
  col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
  col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
  tmpvar_1 = col_12;
  mediump vec3 normal_21;
  normal_21 = tmpvar_6;
  mediump vec3 ambient_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = normal_21;
  mediump vec3 res_24;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_23);
  x_25.y = dot (unity_SHAg, tmpvar_23);
  x_25.z = dot (unity_SHAb, tmpvar_23);
  mediump vec3 x1_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = (normal_21.xyzz * normal_21.yzzx);
  x1_26.x = dot (unity_SHBr, tmpvar_27);
  x1_26.y = dot (unity_SHBg, tmpvar_27);
  x1_26.z = dot (unity_SHBb, tmpvar_27);
  res_24 = (x_25 + (x1_26 + (unity_SHC.xyz * 
    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
  )));
  mediump vec3 tmpvar_28;
  tmpvar_28 = max (((1.055 * 
    pow (max (res_24, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_24 = tmpvar_28;
  ambient_22 = (tmpvar_1 + max (vec3(0.0, 0.0, 0.0), tmpvar_28));
  tmpvar_1 = ambient_22;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ambient_22;
  xlv_TEXCOORD5 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp float diff_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_24 = tmpvar_25;
  c_23.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_24);
  c_23.w = tmpvar_9.w;
  highp float tmpvar_26;
  tmpvar_26 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_23.xyz, vec3(tmpvar_26));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp float diff_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_24 = tmpvar_25;
  c_23.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_24);
  c_23.w = tmpvar_9.w;
  highp float tmpvar_26;
  tmpvar_26 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_23.xyz, vec3(tmpvar_26));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp float diff_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_24 = tmpvar_25;
  c_23.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_24);
  c_23.w = tmpvar_9.w;
  highp float tmpvar_26;
  tmpvar_26 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_23.xyz, vec3(tmpvar_26));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec3 lightColor0_9;
  lightColor0_9 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_10;
  lightColor1_10 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_11;
  lightColor2_11 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_12;
  lightColor3_12 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_13;
  lightAttenSq_13 = unity_4LightAtten0;
  highp vec3 col_14;
  highp vec4 ndotl_15;
  highp vec4 lengthSq_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_16 = (tmpvar_17 * tmpvar_17);
  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_16 = tmpvar_20;
  ndotl_15 = (tmpvar_17 * tmpvar_8.x);
  ndotl_15 = (ndotl_15 + (tmpvar_18 * tmpvar_8.y));
  ndotl_15 = (ndotl_15 + (tmpvar_19 * tmpvar_8.z));
  highp vec4 tmpvar_21;
  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
  ndotl_15 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
    (tmpvar_20 * lightAttenSq_13)
  ))));
  col_14 = (lightColor0_9 * tmpvar_22.x);
  col_14 = (col_14 + (lightColor1_10 * tmpvar_22.y));
  col_14 = (col_14 + (lightColor2_11 * tmpvar_22.z));
  col_14 = (col_14 + (lightColor3_12 * tmpvar_22.w));
  tmpvar_1 = col_14;
  mediump vec3 normal_23;
  normal_23 = tmpvar_8;
  mediump vec3 ambient_24;
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_23.xyzz * normal_23.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  ambient_24 = ((tmpvar_1 * (
    (tmpvar_1 * ((tmpvar_1 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_25 + (unity_SHC.xyz * 
    ((normal_23.x * normal_23.x) - (normal_23.y * normal_23.y))
  )));
  tmpvar_1 = ambient_24;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = ambient_24;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 normalWorld_22;
  normalWorld_22 = tmpvar_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_2 * tmpvar_1);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = normalWorld_22;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_24);
  x_25.y = dot (unity_SHAg, tmpvar_24);
  x_25.z = dot (unity_SHAb, tmpvar_24);
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = tmpvar_23;
  lowp vec4 c_27;
  lowp vec4 c_28;
  lowp float diff_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_29 = tmpvar_30;
  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
  c_28.w = tmpvar_9.w;
  c_27.w = c_28.w;
  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_27.xyz, vec3(tmpvar_31));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec3 lightColor0_9;
  lightColor0_9 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_10;
  lightColor1_10 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_11;
  lightColor2_11 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_12;
  lightColor3_12 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_13;
  lightAttenSq_13 = unity_4LightAtten0;
  highp vec3 col_14;
  highp vec4 ndotl_15;
  highp vec4 lengthSq_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_16 = (tmpvar_17 * tmpvar_17);
  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_16 = tmpvar_20;
  ndotl_15 = (tmpvar_17 * tmpvar_8.x);
  ndotl_15 = (ndotl_15 + (tmpvar_18 * tmpvar_8.y));
  ndotl_15 = (ndotl_15 + (tmpvar_19 * tmpvar_8.z));
  highp vec4 tmpvar_21;
  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
  ndotl_15 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
    (tmpvar_20 * lightAttenSq_13)
  ))));
  col_14 = (lightColor0_9 * tmpvar_22.x);
  col_14 = (col_14 + (lightColor1_10 * tmpvar_22.y));
  col_14 = (col_14 + (lightColor2_11 * tmpvar_22.z));
  col_14 = (col_14 + (lightColor3_12 * tmpvar_22.w));
  tmpvar_1 = col_14;
  mediump vec3 normal_23;
  normal_23 = tmpvar_8;
  mediump vec3 ambient_24;
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_23.xyzz * normal_23.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  ambient_24 = ((tmpvar_1 * (
    (tmpvar_1 * ((tmpvar_1 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_25 + (unity_SHC.xyz * 
    ((normal_23.x * normal_23.x) - (normal_23.y * normal_23.y))
  )));
  tmpvar_1 = ambient_24;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = ambient_24;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 normalWorld_22;
  normalWorld_22 = tmpvar_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_2 * tmpvar_1);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = normalWorld_22;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_24);
  x_25.y = dot (unity_SHAg, tmpvar_24);
  x_25.z = dot (unity_SHAb, tmpvar_24);
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = tmpvar_23;
  lowp vec4 c_27;
  lowp vec4 c_28;
  lowp float diff_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_29 = tmpvar_30;
  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
  c_28.w = tmpvar_9.w;
  c_27.w = c_28.w;
  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_27.xyz, vec3(tmpvar_31));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec3 lightColor0_9;
  lightColor0_9 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_10;
  lightColor1_10 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_11;
  lightColor2_11 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_12;
  lightColor3_12 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_13;
  lightAttenSq_13 = unity_4LightAtten0;
  highp vec3 col_14;
  highp vec4 ndotl_15;
  highp vec4 lengthSq_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_16 = (tmpvar_17 * tmpvar_17);
  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_16 = tmpvar_20;
  ndotl_15 = (tmpvar_17 * tmpvar_8.x);
  ndotl_15 = (ndotl_15 + (tmpvar_18 * tmpvar_8.y));
  ndotl_15 = (ndotl_15 + (tmpvar_19 * tmpvar_8.z));
  highp vec4 tmpvar_21;
  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
  ndotl_15 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
    (tmpvar_20 * lightAttenSq_13)
  ))));
  col_14 = (lightColor0_9 * tmpvar_22.x);
  col_14 = (col_14 + (lightColor1_10 * tmpvar_22.y));
  col_14 = (col_14 + (lightColor2_11 * tmpvar_22.z));
  col_14 = (col_14 + (lightColor3_12 * tmpvar_22.w));
  tmpvar_1 = col_14;
  mediump vec3 normal_23;
  normal_23 = tmpvar_8;
  mediump vec3 ambient_24;
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_23.xyzz * normal_23.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  ambient_24 = ((tmpvar_1 * (
    (tmpvar_1 * ((tmpvar_1 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_25 + (unity_SHC.xyz * 
    ((normal_23.x * normal_23.x) - (normal_23.y * normal_23.y))
  )));
  tmpvar_1 = ambient_24;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = ambient_24;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  mediump float realtimeShadowAttenuation_10;
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].z;
  v_11.y = unity_MatrixV[1].z;
  v_11.z = unity_MatrixV[2].z;
  v_11.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_16;
  highp vec4 shadowCoord_17;
  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
  tmpvar_16 = tmpvar_20;
  realtimeShadowAttenuation_10 = tmpvar_16;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
  atten_5 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 normalWorld_22;
  normalWorld_22 = tmpvar_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_2 * tmpvar_1);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = normalWorld_22;
  mediump vec3 x_25;
  x_25.x = dot (unity_SHAr, tmpvar_24);
  x_25.y = dot (unity_SHAg, tmpvar_24);
  x_25.z = dot (unity_SHAb, tmpvar_24);
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = tmpvar_23;
  lowp vec4 c_27;
  lowp vec4 c_28;
  lowp float diff_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_29 = tmpvar_30;
  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
  c_28.w = tmpvar_9.w;
  c_27.w = c_28.w;
  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_27.xyz, vec3(tmpvar_31));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
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
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
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
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 88119
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
  highp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).w;
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_14);
  c_13.w = tmpvar_9.w;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
  highp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).w;
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_14);
  c_13.w = tmpvar_9.w;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
  highp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).w;
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_14);
  c_13.w = tmpvar_9.w;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec4 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10);
  lowp float tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, ((lightCoord_5.xy / lightCoord_5.w) + 0.5));
  tmpvar_11 = tmpvar_12.w;
  lowp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(dot (lightCoord_5.xyz, lightCoord_5.xyz)));
  tmpvar_13 = tmpvar_14.w;
  highp float tmpvar_15;
  tmpvar_15 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_11) * tmpvar_13);
  atten_4 = tmpvar_15;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_16;
  lowp vec4 c_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_18);
  c_17.w = tmpvar_9.w;
  c_16.w = c_17.w;
  c_16.xyz = c_17.xyz;
  c_3.xyz = c_16.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec4 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10);
  lowp float tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, ((lightCoord_5.xy / lightCoord_5.w) + 0.5));
  tmpvar_11 = tmpvar_12.w;
  lowp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(dot (lightCoord_5.xyz, lightCoord_5.xyz)));
  tmpvar_13 = tmpvar_14.w;
  highp float tmpvar_15;
  tmpvar_15 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_11) * tmpvar_13);
  atten_4 = tmpvar_15;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_16;
  lowp vec4 c_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_18);
  c_17.w = tmpvar_9.w;
  c_16.w = c_17.w;
  c_16.xyz = c_17.xyz;
  c_3.xyz = c_16.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec4 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10);
  lowp float tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, ((lightCoord_5.xy / lightCoord_5.w) + 0.5));
  tmpvar_11 = tmpvar_12.w;
  lowp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(dot (lightCoord_5.xyz, lightCoord_5.xyz)));
  tmpvar_13 = tmpvar_14.w;
  highp float tmpvar_15;
  tmpvar_15 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_11) * tmpvar_13);
  atten_4 = tmpvar_15;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_16;
  lowp vec4 c_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_18);
  c_17.w = tmpvar_9.w;
  c_16.w = c_17.w;
  c_16.xyz = c_17.xyz;
  c_3.xyz = c_16.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
  highp float tmpvar_11;
  tmpvar_11 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_5, lightCoord_5))).w * textureCube (_LightTexture0, lightCoord_5).w);
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_14);
  c_13.w = tmpvar_9.w;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
  highp float tmpvar_11;
  tmpvar_11 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_5, lightCoord_5))).w * textureCube (_LightTexture0, lightCoord_5).w);
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_14);
  c_13.w = tmpvar_9.w;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
  highp float tmpvar_11;
  tmpvar_11 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_5, lightCoord_5))).w * textureCube (_LightTexture0, lightCoord_5).w);
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_14);
  c_13.w = tmpvar_9.w;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  highp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_9).xy).w;
  atten_4 = tmpvar_10;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_11;
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_8.w;
  c_11.w = c_12.w;
  c_11.xyz = c_12.xyz;
  c_3.xyz = c_11.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  highp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_9).xy).w;
  atten_4 = tmpvar_10;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_11;
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_8.w;
  c_11.w = c_12.w;
  c_11.xyz = c_12.xyz;
  c_3.xyz = c_11.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  highp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_9).xy).w;
  atten_4 = tmpvar_10;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_11;
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_8.w;
  c_11.w = c_12.w;
  c_11.xyz = c_12.xyz;
  c_3.xyz = c_11.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
  highp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).w;
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_9.w;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
  highp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).w;
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_9.w;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
  highp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).w;
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_9.w;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
  c_8.w = tmpvar_7.w;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_8.xyz * vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
  c_8.w = tmpvar_7.w;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_8.xyz * vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
  c_8.w = tmpvar_7.w;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_8.xyz * vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec4 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10);
  lowp float tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, ((lightCoord_5.xy / lightCoord_5.w) + 0.5));
  tmpvar_11 = tmpvar_12.w;
  lowp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(dot (lightCoord_5.xyz, lightCoord_5.xyz)));
  tmpvar_13 = tmpvar_14.w;
  highp float tmpvar_15;
  tmpvar_15 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_11) * tmpvar_13);
  atten_4 = tmpvar_15;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_17);
  c_16.w = tmpvar_9.w;
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec4 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10);
  lowp float tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, ((lightCoord_5.xy / lightCoord_5.w) + 0.5));
  tmpvar_11 = tmpvar_12.w;
  lowp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(dot (lightCoord_5.xyz, lightCoord_5.xyz)));
  tmpvar_13 = tmpvar_14.w;
  highp float tmpvar_15;
  tmpvar_15 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_11) * tmpvar_13);
  atten_4 = tmpvar_15;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_17);
  c_16.w = tmpvar_9.w;
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec4 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10);
  lowp float tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, ((lightCoord_5.xy / lightCoord_5.w) + 0.5));
  tmpvar_11 = tmpvar_12.w;
  lowp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(dot (lightCoord_5.xyz, lightCoord_5.xyz)));
  tmpvar_13 = tmpvar_14.w;
  highp float tmpvar_15;
  tmpvar_15 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_11) * tmpvar_13);
  atten_4 = tmpvar_15;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_17);
  c_16.w = tmpvar_9.w;
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
  highp float tmpvar_11;
  tmpvar_11 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_5, lightCoord_5))).w * textureCube (_LightTexture0, lightCoord_5).w);
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_9.w;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
  highp float tmpvar_11;
  tmpvar_11 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_5, lightCoord_5))).w * textureCube (_LightTexture0, lightCoord_5).w);
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_9.w;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD2;
  lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
  highp float tmpvar_11;
  tmpvar_11 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_5, lightCoord_5))).w * textureCube (_LightTexture0, lightCoord_5).w);
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_9.w;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  highp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_9).xy).w;
  atten_4 = tmpvar_10;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_11;
  lowp float diff_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_12 = tmpvar_13;
  c_11.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_12);
  c_11.w = tmpvar_8.w;
  highp float tmpvar_14;
  tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  highp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_9).xy).w;
  atten_4 = tmpvar_10;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_11;
  lowp float diff_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_12 = tmpvar_13;
  c_11.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_12);
  c_11.w = tmpvar_8.w;
  highp float tmpvar_14;
  tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  highp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_9).xy).w;
  atten_4 = tmpvar_10;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_11;
  lowp float diff_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_12 = tmpvar_13;
  c_11.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_12);
  c_11.w = tmpvar_8.w;
  highp float tmpvar_14;
  tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
  Name "PREPASS"
  LOD 200
  Tags { "LIGHTMODE" = "PREPASSBASE" "RenderType" = "Opaque" }
  GpuProgramID 156603
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
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
  Name "PREPASS"
  LOD 200
  Tags { "LIGHTMODE" = "PREPASSFINAL" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 259371
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2.xyz = c_6.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2.xyz = c_6.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2.xyz = c_6.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2.xyz = c_6.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2.xyz = c_6.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2.xyz = c_6.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_6.w;
  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_7.w = tmpvar_4.w;
  c_2.xyz = c_7.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_6.w;
  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_7.w = tmpvar_4.w;
  c_2.xyz = c_7.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_6.w;
  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_7.w = tmpvar_4.w;
  c_2.xyz = c_7.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2 = c_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2 = c_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2 = c_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2 = c_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2 = c_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2 = c_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_6.w;
  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_7.w = tmpvar_4.w;
  c_2 = c_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_8));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_6.w;
  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_7.w = tmpvar_4.w;
  c_2 = c_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_8));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
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
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  tmpvar_2 = tmpvar_15;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_6.w;
  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_7.w = tmpvar_4.w;
  c_2 = c_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_8));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
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
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
}
}
 Pass {
  Name "DEFERRED"
  LOD 200
  Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
  GpuProgramID 310841
Program "vp" {
SubProgram "gles hw_tier00 " {
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
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
  mediump vec4 emission_4;
  mediump vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_3;
  tmpvar_6 = tmpvar_2;
  mediump vec4 outGBuffer2_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_5;
  tmpvar_8.w = 1.0;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((tmpvar_6 * 0.5) + 0.5);
  outGBuffer2_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  emission_4 = tmpvar_11;
  emission_4.xyz = emission_4.xyz;
  outEmission_1.w = emission_4.w;
  outEmission_1.xyz = exp2(-(emission_4.xyz));
  gl_FragData[0] = tmpvar_8;
  gl_FragData[1] = tmpvar_9;
  gl_FragData[2] = outGBuffer2_7;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
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
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
  mediump vec4 emission_4;
  mediump vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_3;
  tmpvar_6 = tmpvar_2;
  mediump vec4 outGBuffer2_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_5;
  tmpvar_8.w = 1.0;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((tmpvar_6 * 0.5) + 0.5);
  outGBuffer2_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  emission_4 = tmpvar_11;
  emission_4.xyz = emission_4.xyz;
  outEmission_1.w = emission_4.w;
  outEmission_1.xyz = exp2(-(emission_4.xyz));
  gl_FragData[0] = tmpvar_8;
  gl_FragData[1] = tmpvar_9;
  gl_FragData[2] = outGBuffer2_7;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
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
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
  mediump vec4 emission_4;
  mediump vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_3;
  tmpvar_6 = tmpvar_2;
  mediump vec4 outGBuffer2_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_5;
  tmpvar_8.w = 1.0;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((tmpvar_6 * 0.5) + 0.5);
  outGBuffer2_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  emission_4 = tmpvar_11;
  emission_4.xyz = emission_4.xyz;
  outEmission_1.w = emission_4.w;
  outEmission_1.xyz = exp2(-(emission_4.xyz));
  gl_FragData[0] = tmpvar_8;
  gl_FragData[1] = tmpvar_9;
  gl_FragData[2] = outGBuffer2_7;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
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
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_glesNormal * tmpvar_3));
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  mediump vec3 normal_5;
  normal_5 = tmpvar_4;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = normal_5;
  mediump vec3 res_7;
  mediump vec3 x_8;
  x_8.x = dot (unity_SHAr, tmpvar_6);
  x_8.y = dot (unity_SHAg, tmpvar_6);
  x_8.z = dot (unity_SHAb, tmpvar_6);
  mediump vec3 x1_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (normal_5.xyzz * normal_5.yzzx);
  x1_9.x = dot (unity_SHBr, tmpvar_10);
  x1_9.y = dot (unity_SHBg, tmpvar_10);
  x1_9.z = dot (unity_SHBb, tmpvar_10);
  res_7 = (x_8 + (x1_9 + (unity_SHC.xyz * 
    ((normal_5.x * normal_5.x) - (normal_5.y * normal_5.y))
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = max (((1.055 * 
    pow (max (res_7, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_7 = tmpvar_11;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), tmpvar_11);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_4.xyz;
  mediump vec4 emission_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_3;
  tmpvar_7 = tmpvar_2;
  mediump vec4 outGBuffer2_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_6;
  tmpvar_9.w = 1.0;
  mediump vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = 0.0;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((tmpvar_7 * 0.5) + 0.5);
  outGBuffer2_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = vec3(0.0, 0.0, 0.0);
  emission_5 = tmpvar_12;
  emission_5.xyz = (emission_5.xyz + (tmpvar_4.xyz * xlv_TEXCOORD4));
  outEmission_1.w = emission_5.w;
  outEmission_1.xyz = exp2(-(emission_5.xyz));
  gl_FragData[0] = tmpvar_9;
  gl_FragData[1] = tmpvar_10;
  gl_FragData[2] = outGBuffer2_8;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
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
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_glesNormal * tmpvar_3));
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  mediump vec3 normal_5;
  normal_5 = tmpvar_4;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = normal_5;
  mediump vec3 res_7;
  mediump vec3 x_8;
  x_8.x = dot (unity_SHAr, tmpvar_6);
  x_8.y = dot (unity_SHAg, tmpvar_6);
  x_8.z = dot (unity_SHAb, tmpvar_6);
  mediump vec3 x1_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (normal_5.xyzz * normal_5.yzzx);
  x1_9.x = dot (unity_SHBr, tmpvar_10);
  x1_9.y = dot (unity_SHBg, tmpvar_10);
  x1_9.z = dot (unity_SHBb, tmpvar_10);
  res_7 = (x_8 + (x1_9 + (unity_SHC.xyz * 
    ((normal_5.x * normal_5.x) - (normal_5.y * normal_5.y))
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = max (((1.055 * 
    pow (max (res_7, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_7 = tmpvar_11;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), tmpvar_11);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_4.xyz;
  mediump vec4 emission_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_3;
  tmpvar_7 = tmpvar_2;
  mediump vec4 outGBuffer2_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_6;
  tmpvar_9.w = 1.0;
  mediump vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = 0.0;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((tmpvar_7 * 0.5) + 0.5);
  outGBuffer2_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = vec3(0.0, 0.0, 0.0);
  emission_5 = tmpvar_12;
  emission_5.xyz = (emission_5.xyz + (tmpvar_4.xyz * xlv_TEXCOORD4));
  outEmission_1.w = emission_5.w;
  outEmission_1.xyz = exp2(-(emission_5.xyz));
  gl_FragData[0] = tmpvar_9;
  gl_FragData[1] = tmpvar_10;
  gl_FragData[2] = outGBuffer2_8;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
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
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_glesNormal * tmpvar_3));
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  mediump vec3 normal_5;
  normal_5 = tmpvar_4;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = normal_5;
  mediump vec3 res_7;
  mediump vec3 x_8;
  x_8.x = dot (unity_SHAr, tmpvar_6);
  x_8.y = dot (unity_SHAg, tmpvar_6);
  x_8.z = dot (unity_SHAb, tmpvar_6);
  mediump vec3 x1_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (normal_5.xyzz * normal_5.yzzx);
  x1_9.x = dot (unity_SHBr, tmpvar_10);
  x1_9.y = dot (unity_SHBg, tmpvar_10);
  x1_9.z = dot (unity_SHBb, tmpvar_10);
  res_7 = (x_8 + (x1_9 + (unity_SHC.xyz * 
    ((normal_5.x * normal_5.x) - (normal_5.y * normal_5.y))
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = max (((1.055 * 
    pow (max (res_7, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_7 = tmpvar_11;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), tmpvar_11);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_3 = tmpvar_4.xyz;
  mediump vec4 emission_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_3;
  tmpvar_7 = tmpvar_2;
  mediump vec4 outGBuffer2_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_6;
  tmpvar_9.w = 1.0;
  mediump vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = 0.0;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((tmpvar_7 * 0.5) + 0.5);
  outGBuffer2_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = vec3(0.0, 0.0, 0.0);
  emission_5 = tmpvar_12;
  emission_5.xyz = (emission_5.xyz + (tmpvar_4.xyz * xlv_TEXCOORD4));
  outEmission_1.w = emission_5.w;
  outEmission_1.xyz = exp2(-(emission_5.xyz));
  gl_FragData[0] = tmpvar_9;
  gl_FragData[1] = tmpvar_10;
  gl_FragData[2] = outGBuffer2_8;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_glesNormal * tmpvar_3));
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  mediump vec3 normal_5;
  normal_5 = tmpvar_4;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = normal_5;
  mediump vec3 res_7;
  mediump vec3 x_8;
  x_8.x = dot (unity_SHAr, tmpvar_6);
  x_8.y = dot (unity_SHAg, tmpvar_6);
  x_8.z = dot (unity_SHAb, tmpvar_6);
  mediump vec3 x1_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (normal_5.xyzz * normal_5.yzzx);
  x1_9.x = dot (unity_SHBr, tmpvar_10);
  x1_9.y = dot (unity_SHBg, tmpvar_10);
  x1_9.z = dot (unity_SHBb, tmpvar_10);
  res_7 = (x_8 + (x1_9 + (unity_SHC.xyz * 
    ((normal_5.x * normal_5.x) - (normal_5.y * normal_5.y))
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = max (((1.055 * 
    pow (max (res_7, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_7 = tmpvar_11;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), tmpvar_11);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_2 = tmpvar_3.xyz;
  mediump vec4 emission_4;
  mediump vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_1;
  mediump vec4 outGBuffer2_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_5;
  tmpvar_8.w = 1.0;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((tmpvar_6 * 0.5) + 0.5);
  outGBuffer2_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  emission_4 = tmpvar_11;
  emission_4.xyz = (emission_4.xyz + (tmpvar_3.xyz * xlv_TEXCOORD4));
  gl_FragData[0] = tmpvar_8;
  gl_FragData[1] = tmpvar_9;
  gl_FragData[2] = outGBuffer2_7;
  gl_FragData[3] = emission_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_glesNormal * tmpvar_3));
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  mediump vec3 normal_5;
  normal_5 = tmpvar_4;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = normal_5;
  mediump vec3 res_7;
  mediump vec3 x_8;
  x_8.x = dot (unity_SHAr, tmpvar_6);
  x_8.y = dot (unity_SHAg, tmpvar_6);
  x_8.z = dot (unity_SHAb, tmpvar_6);
  mediump vec3 x1_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (normal_5.xyzz * normal_5.yzzx);
  x1_9.x = dot (unity_SHBr, tmpvar_10);
  x1_9.y = dot (unity_SHBg, tmpvar_10);
  x1_9.z = dot (unity_SHBb, tmpvar_10);
  res_7 = (x_8 + (x1_9 + (unity_SHC.xyz * 
    ((normal_5.x * normal_5.x) - (normal_5.y * normal_5.y))
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = max (((1.055 * 
    pow (max (res_7, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_7 = tmpvar_11;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), tmpvar_11);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_2 = tmpvar_3.xyz;
  mediump vec4 emission_4;
  mediump vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_1;
  mediump vec4 outGBuffer2_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_5;
  tmpvar_8.w = 1.0;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((tmpvar_6 * 0.5) + 0.5);
  outGBuffer2_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  emission_4 = tmpvar_11;
  emission_4.xyz = (emission_4.xyz + (tmpvar_3.xyz * xlv_TEXCOORD4));
  gl_FragData[0] = tmpvar_8;
  gl_FragData[1] = tmpvar_9;
  gl_FragData[2] = outGBuffer2_7;
  gl_FragData[3] = emission_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_glesNormal * tmpvar_3));
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  mediump vec3 normal_5;
  normal_5 = tmpvar_4;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = normal_5;
  mediump vec3 res_7;
  mediump vec3 x_8;
  x_8.x = dot (unity_SHAr, tmpvar_6);
  x_8.y = dot (unity_SHAg, tmpvar_6);
  x_8.z = dot (unity_SHAb, tmpvar_6);
  mediump vec3 x1_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (normal_5.xyzz * normal_5.yzzx);
  x1_9.x = dot (unity_SHBr, tmpvar_10);
  x1_9.y = dot (unity_SHBg, tmpvar_10);
  x1_9.z = dot (unity_SHBb, tmpvar_10);
  res_7 = (x_8 + (x1_9 + (unity_SHC.xyz * 
    ((normal_5.x * normal_5.x) - (normal_5.y * normal_5.y))
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = max (((1.055 * 
    pow (max (res_7, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_7 = tmpvar_11;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), tmpvar_11);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_2 = tmpvar_3.xyz;
  mediump vec4 emission_4;
  mediump vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_1;
  mediump vec4 outGBuffer2_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_5;
  tmpvar_8.w = 1.0;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((tmpvar_6 * 0.5) + 0.5);
  outGBuffer2_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  emission_4 = tmpvar_11;
  emission_4.xyz = (emission_4.xyz + (tmpvar_3.xyz * xlv_TEXCOORD4));
  gl_FragData[0] = tmpvar_8;
  gl_FragData[1] = tmpvar_9;
  gl_FragData[2] = outGBuffer2_7;
  gl_FragData[3] = emission_4;
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
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
}
}
 Pass {
  Name "META"
  LOD 200
  Tags { "LIGHTMODE" = "META" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 333421
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
varying highp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
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
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_4;
  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_5;
    tmpvar_5.w = 1.0;
    tmpvar_5.xyz = tmpvar_2;
    res_4.w = tmpvar_5.w;
    highp vec3 tmpvar_6;
    tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_4.xyz = tmpvar_6;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_7;
    if (bool(unity_UseLinearSpace)) {
      emission_7 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_7 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = emission_7;
    res_4 = tmpvar_8;
  };
  tmpvar_1 = res_4;
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
varying highp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
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
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_4;
  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_5;
    tmpvar_5.w = 1.0;
    tmpvar_5.xyz = tmpvar_2;
    res_4.w = tmpvar_5.w;
    highp vec3 tmpvar_6;
    tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_4.xyz = tmpvar_6;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_7;
    if (bool(unity_UseLinearSpace)) {
      emission_7 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_7 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = emission_7;
    res_4 = tmpvar_8;
  };
  tmpvar_1 = res_4;
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
varying highp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
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
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_4;
  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_5;
    tmpvar_5.w = 1.0;
    tmpvar_5.xyz = tmpvar_2;
    res_4.w = tmpvar_5.w;
    highp vec3 tmpvar_6;
    tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_4.xyz = tmpvar_6;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_7;
    if (bool(unity_UseLinearSpace)) {
      emission_7 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_7 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = emission_7;
    res_4 = tmpvar_8;
  };
  tmpvar_1 = res_4;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "EDITOR_VISUALIZATION" }
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
varying highp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform highp int unity_VisualizationMode;
uniform highp int _CheckAlbedo;
uniform mediump vec4 _AlbedoCompareColor;
uniform mediump float _AlbedoMinLuminance;
uniform mediump float _AlbedoMaxLuminance;
uniform mediump float _AlbedoHueTolerance;
uniform mediump float _AlbedoSaturationTolerance;
uniform mediump vec4 unity_MaterialValidateLowColor;
uniform mediump vec4 unity_MaterialValidateHighColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_4;
  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((unity_VisualizationMode == 0)) {
    mediump vec4 tmpvar_5;
    mediump vec3 baseColor_6;
    baseColor_6 = tmpvar_2;
    highp float value_7;
    value_7 = tmpvar_2.x;
    highp float tmpvar_8;
    if ((value_7 <= 0.04045)) {
      tmpvar_8 = (value_7 / 12.92);
    } else {
      if ((value_7 < 1.0)) {
        tmpvar_8 = pow (((value_7 + 0.055) / 1.055), 2.4);
      } else {
        tmpvar_8 = pow (value_7, 2.2);
      };
    };
    highp float value_9;
    value_9 = tmpvar_2.y;
    highp float tmpvar_10;
    if ((value_9 <= 0.04045)) {
      tmpvar_10 = (value_9 / 12.92);
    } else {
      if ((value_9 < 1.0)) {
        tmpvar_10 = pow (((value_9 + 0.055) / 1.055), 2.4);
      } else {
        tmpvar_10 = pow (value_9, 2.2);
      };
    };
    highp float value_11;
    value_11 = tmpvar_2.z;
    highp float tmpvar_12;
    if ((value_11 <= 0.04045)) {
      tmpvar_12 = (value_11 / 12.92);
    } else {
      if ((value_11 < 1.0)) {
        tmpvar_12 = pow (((value_11 + 0.055) / 1.055), 2.4);
      } else {
        tmpvar_12 = pow (value_11, 2.2);
      };
    };
    highp vec3 tmpvar_13;
    tmpvar_13.x = tmpvar_8;
    tmpvar_13.y = tmpvar_10;
    tmpvar_13.z = tmpvar_12;
    baseColor_6 = tmpvar_13;
    mediump vec3 tmpvar_14;
    tmpvar_14 = vec3(dot (baseColor_6, vec3(0.2126729, 0.7151522, 0.072175)));
    mediump float tmpvar_15;
    if (bool(_CheckAlbedo)) {
      tmpvar_15 = dot (baseColor_6, vec3(0.2126729, 0.7151522, 0.072175));
    } else {
      tmpvar_15 = dot (baseColor_6, vec3(0.3333, 0.3333, 0.3333));
    };
    if ((_CheckAlbedo == 0)) {
      if ((tmpvar_15 < 0.012)) {
        tmpvar_5 = unity_MaterialValidateLowColor;
      } else {
        if ((tmpvar_15 > 0.9)) {
          tmpvar_5 = unity_MaterialValidateHighColor;
        } else {
          mediump vec4 tmpvar_16;
          tmpvar_16.w = 0.0;
          tmpvar_16.xyz = tmpvar_14;
          tmpvar_5 = tmpvar_16;
        };
      };
    } else {
      if ((_AlbedoMinLuminance > tmpvar_15)) {
        tmpvar_5 = unity_MaterialValidateLowColor;
      } else {
        if ((_AlbedoMaxLuminance < tmpvar_15)) {
          tmpvar_5 = unity_MaterialValidateHighColor;
        } else {
          mediump vec3 tmpvar_17;
          if (((tmpvar_2.z > tmpvar_2.y) && (tmpvar_2.z > tmpvar_2.x))) {
            mediump float dominantColor_18;
            dominantColor_18 = tmpvar_2.z;
            mediump float colorone_19;
            colorone_19 = tmpvar_2.x;
            mediump float colortwo_20;
            colortwo_20 = tmpvar_2.y;
            mediump float S_21;
            mediump float H_22;
            if ((tmpvar_2.z != 0.0)) {
              mediump float small_23;
              small_23 = 0.0;
              if ((tmpvar_2.x > tmpvar_2.y)) {
                small_23 = colortwo_20;
              } else {
                small_23 = colorone_19;
              };
              mediump float tmpvar_24;
              tmpvar_24 = (tmpvar_2.z - small_23);
              if ((tmpvar_24 != 0.0)) {
                S_21 = (tmpvar_24 / tmpvar_2.z);
                H_22 = (4.0 + ((tmpvar_2.x - tmpvar_2.y) / tmpvar_24));
              } else {
                S_21 = 0.0;
                H_22 = (4.0 + (tmpvar_2.x - tmpvar_2.y));
              };
              H_22 = (H_22 / 6.0);
              if ((H_22 < 6.0)) {
                H_22 += 1.0;
              };
            } else {
              S_21 = 0.0;
              H_22 = 0.0;
            };
            mediump vec3 tmpvar_25;
            tmpvar_25.x = H_22;
            tmpvar_25.y = S_21;
            tmpvar_25.z = dominantColor_18;
            tmpvar_17 = tmpvar_25;
          } else {
            if ((tmpvar_2.y > tmpvar_2.x)) {
              mediump float dominantColor_26;
              dominantColor_26 = tmpvar_2.y;
              mediump float colorone_27;
              colorone_27 = tmpvar_2.z;
              mediump float colortwo_28;
              colortwo_28 = tmpvar_2.x;
              mediump float S_29;
              mediump float H_30;
              if ((tmpvar_2.y != 0.0)) {
                mediump float small_31;
                small_31 = 0.0;
                if ((tmpvar_2.z > tmpvar_2.x)) {
                  small_31 = colortwo_28;
                } else {
                  small_31 = colorone_27;
                };
                mediump float tmpvar_32;
                tmpvar_32 = (tmpvar_2.y - small_31);
                if ((tmpvar_32 != 0.0)) {
                  S_29 = (tmpvar_32 / tmpvar_2.y);
                  H_30 = (2.0 + ((tmpvar_2.z - tmpvar_2.x) / tmpvar_32));
                } else {
                  S_29 = 0.0;
                  H_30 = (2.0 + (tmpvar_2.z - tmpvar_2.x));
                };
                H_30 = (H_30 / 6.0);
                if ((H_30 < 6.0)) {
                  H_30 += 1.0;
                };
              } else {
                S_29 = 0.0;
                H_30 = 0.0;
              };
              mediump vec3 tmpvar_33;
              tmpvar_33.x = H_30;
              tmpvar_33.y = S_29;
              tmpvar_33.z = dominantColor_26;
              tmpvar_17 = tmpvar_33;
            } else {
              mediump float dominantColor_34;
              dominantColor_34 = tmpvar_2.x;
              mediump float colorone_35;
              colorone_35 = tmpvar_2.y;
              mediump float colortwo_36;
              colortwo_36 = tmpvar_2.z;
              mediump float S_37;
              mediump float H_38;
              if ((tmpvar_2.x != 0.0)) {
                mediump float small_39;
                small_39 = 0.0;
                if ((tmpvar_2.y > tmpvar_2.z)) {
                  small_39 = colortwo_36;
                } else {
                  small_39 = colorone_35;
                };
                mediump float tmpvar_40;
                tmpvar_40 = (tmpvar_2.x - small_39);
                if ((tmpvar_40 != 0.0)) {
                  S_37 = (tmpvar_40 / tmpvar_2.x);
                  H_38 = ((tmpvar_2.y - tmpvar_2.z) / tmpvar_40);
                } else {
                  S_37 = 0.0;
                  H_38 = (tmpvar_2.y - tmpvar_2.z);
                };
                H_38 = (H_38 / 6.0);
                if ((H_38 < 6.0)) {
                  H_38 += 1.0;
                };
              } else {
                S_37 = 0.0;
                H_38 = 0.0;
              };
              mediump vec3 tmpvar_41;
              tmpvar_41.x = H_38;
              tmpvar_41.y = S_37;
              tmpvar_41.z = dominantColor_34;
              tmpvar_17 = tmpvar_41;
            };
          };
          mediump vec3 rgbColor_42;
          rgbColor_42 = _AlbedoCompareColor.xyz;
          mediump vec3 tmpvar_43;
          if (((_AlbedoCompareColor.z > _AlbedoCompareColor.y) && (_AlbedoCompareColor.z > _AlbedoCompareColor.x))) {
            mediump float dominantColor_44;
            dominantColor_44 = rgbColor_42.z;
            mediump float colorone_45;
            colorone_45 = rgbColor_42.x;
            mediump float colortwo_46;
            colortwo_46 = rgbColor_42.y;
            mediump float S_47;
            mediump float H_48;
            if ((_AlbedoCompareColor.z != 0.0)) {
              mediump float small_49;
              small_49 = 0.0;
              if ((_AlbedoCompareColor.x > _AlbedoCompareColor.y)) {
                small_49 = colortwo_46;
              } else {
                small_49 = colorone_45;
              };
              mediump float tmpvar_50;
              tmpvar_50 = (_AlbedoCompareColor.z - small_49);
              if ((tmpvar_50 != 0.0)) {
                S_47 = (tmpvar_50 / _AlbedoCompareColor.z);
                H_48 = (4.0 + ((_AlbedoCompareColor.x - _AlbedoCompareColor.y) / tmpvar_50));
              } else {
                S_47 = 0.0;
                H_48 = (4.0 + (_AlbedoCompareColor.x - _AlbedoCompareColor.y));
              };
              H_48 = (H_48 / 6.0);
              if ((H_48 < 6.0)) {
                H_48 += 1.0;
              };
            } else {
              S_47 = 0.0;
              H_48 = 0.0;
            };
            mediump vec3 tmpvar_51;
            tmpvar_51.x = H_48;
            tmpvar_51.y = S_47;
            tmpvar_51.z = dominantColor_44;
            tmpvar_43 = tmpvar_51;
          } else {
            if ((_AlbedoCompareColor.y > _AlbedoCompareColor.x)) {
              mediump float dominantColor_52;
              dominantColor_52 = rgbColor_42.y;
              mediump float colorone_53;
              colorone_53 = rgbColor_42.z;
              mediump float colortwo_54;
              colortwo_54 = rgbColor_42.x;
              mediump float S_55;
              mediump float H_56;
              if ((_AlbedoCompareColor.y != 0.0)) {
                mediump float small_57;
                small_57 = 0.0;
                if ((_AlbedoCompareColor.z > _AlbedoCompareColor.x)) {
                  small_57 = colortwo_54;
                } else {
                  small_57 = colorone_53;
                };
                mediump float tmpvar_58;
                tmpvar_58 = (_AlbedoCompareColor.y - small_57);
                if ((tmpvar_58 != 0.0)) {
                  S_55 = (tmpvar_58 / _AlbedoCompareColor.y);
                  H_56 = (2.0 + ((_AlbedoCompareColor.z - _AlbedoCompareColor.x) / tmpvar_58));
                } else {
                  S_55 = 0.0;
                  H_56 = (2.0 + (_AlbedoCompareColor.z - _AlbedoCompareColor.x));
                };
                H_56 = (H_56 / 6.0);
                if ((H_56 < 6.0)) {
                  H_56 += 1.0;
                };
              } else {
                S_55 = 0.0;
                H_56 = 0.0;
              };
              mediump vec3 tmpvar_59;
              tmpvar_59.x = H_56;
              tmpvar_59.y = S_55;
              tmpvar_59.z = dominantColor_52;
              tmpvar_43 = tmpvar_59;
            } else {
              mediump float dominantColor_60;
              dominantColor_60 = rgbColor_42.x;
              mediump float colorone_61;
              colorone_61 = rgbColor_42.y;
              mediump float colortwo_62;
              colortwo_62 = rgbColor_42.z;
              mediump float S_63;
              mediump float H_64;
              if ((_AlbedoCompareColor.x != 0.0)) {
                mediump float small_65;
                small_65 = 0.0;
                if ((_AlbedoCompareColor.y > _AlbedoCompareColor.z)) {
                  small_65 = colortwo_62;
                } else {
                  small_65 = colorone_61;
                };
                mediump float tmpvar_66;
                tmpvar_66 = (_AlbedoCompareColor.x - small_65);
                if ((tmpvar_66 != 0.0)) {
                  S_63 = (tmpvar_66 / _AlbedoCompareColor.x);
                  H_64 = ((_AlbedoCompareColor.y - _AlbedoCompareColor.z) / tmpvar_66);
                } else {
                  S_63 = 0.0;
                  H_64 = (_AlbedoCompareColor.y - _AlbedoCompareColor.z);
                };
                H_64 = (H_64 / 6.0);
                if ((H_64 < 6.0)) {
                  H_64 += 1.0;
                };
              } else {
                S_63 = 0.0;
                H_64 = 0.0;
              };
              mediump vec3 tmpvar_67;
              tmpvar_67.x = H_64;
              tmpvar_67.y = S_63;
              tmpvar_67.z = dominantColor_60;
              tmpvar_43 = tmpvar_67;
            };
          };
          if ((((tmpvar_43.y - _AlbedoSaturationTolerance) > tmpvar_17.y) || ((
            (tmpvar_43.x - _AlbedoHueTolerance)
           > tmpvar_17.x) && (
            ((tmpvar_43.x - _AlbedoHueTolerance) + 1.0)
           > tmpvar_17.x)))) {
            tmpvar_5 = unity_MaterialValidateLowColor;
          } else {
            if (((tmpvar_17.y > (tmpvar_43.y + _AlbedoSaturationTolerance)) || ((tmpvar_17.x > 
              (tmpvar_43.x + _AlbedoHueTolerance)
            ) && (tmpvar_17.x > 
              ((tmpvar_43.x + _AlbedoHueTolerance) - 1.0)
            )))) {
              tmpvar_5 = unity_MaterialValidateHighColor;
            } else {
              mediump vec4 tmpvar_68;
              tmpvar_68.w = 0.0;
              tmpvar_68.xyz = tmpvar_14;
              tmpvar_5 = tmpvar_68;
            };
          };
        };
      };
    };
    res_4 = tmpvar_5;
  } else {
    if ((unity_VisualizationMode == 1)) {
      res_4 = unity_MaterialValidateLowColor;
    };
  };
  tmpvar_1 = res_4;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "EDITOR_VISUALIZATION" }
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
varying highp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform highp int unity_VisualizationMode;
uniform highp int _CheckAlbedo;
uniform mediump vec4 _AlbedoCompareColor;
uniform mediump float _AlbedoMinLuminance;
uniform mediump float _AlbedoMaxLuminance;
uniform mediump float _AlbedoHueTolerance;
uniform mediump float _AlbedoSaturationTolerance;
uniform mediump vec4 unity_MaterialValidateLowColor;
uniform mediump vec4 unity_MaterialValidateHighColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_4;
  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((unity_VisualizationMode == 0)) {
    mediump vec4 tmpvar_5;
    mediump vec3 baseColor_6;
    baseColor_6 = tmpvar_2;
    highp float value_7;
    value_7 = tmpvar_2.x;
    highp float tmpvar_8;
    if ((value_7 <= 0.04045)) {
      tmpvar_8 = (value_7 / 12.92);
    } else {
      if ((value_7 < 1.0)) {
        tmpvar_8 = pow (((value_7 + 0.055) / 1.055), 2.4);
      } else {
        tmpvar_8 = pow (value_7, 2.2);
      };
    };
    highp float value_9;
    value_9 = tmpvar_2.y;
    highp float tmpvar_10;
    if ((value_9 <= 0.04045)) {
      tmpvar_10 = (value_9 / 12.92);
    } else {
      if ((value_9 < 1.0)) {
        tmpvar_10 = pow (((value_9 + 0.055) / 1.055), 2.4);
      } else {
        tmpvar_10 = pow (value_9, 2.2);
      };
    };
    highp float value_11;
    value_11 = tmpvar_2.z;
    highp float tmpvar_12;
    if ((value_11 <= 0.04045)) {
      tmpvar_12 = (value_11 / 12.92);
    } else {
      if ((value_11 < 1.0)) {
        tmpvar_12 = pow (((value_11 + 0.055) / 1.055), 2.4);
      } else {
        tmpvar_12 = pow (value_11, 2.2);
      };
    };
    highp vec3 tmpvar_13;
    tmpvar_13.x = tmpvar_8;
    tmpvar_13.y = tmpvar_10;
    tmpvar_13.z = tmpvar_12;
    baseColor_6 = tmpvar_13;
    mediump vec3 tmpvar_14;
    tmpvar_14 = vec3(dot (baseColor_6, vec3(0.2126729, 0.7151522, 0.072175)));
    mediump float tmpvar_15;
    if (bool(_CheckAlbedo)) {
      tmpvar_15 = dot (baseColor_6, vec3(0.2126729, 0.7151522, 0.072175));
    } else {
      tmpvar_15 = dot (baseColor_6, vec3(0.3333, 0.3333, 0.3333));
    };
    if ((_CheckAlbedo == 0)) {
      if ((tmpvar_15 < 0.012)) {
        tmpvar_5 = unity_MaterialValidateLowColor;
      } else {
        if ((tmpvar_15 > 0.9)) {
          tmpvar_5 = unity_MaterialValidateHighColor;
        } else {
          mediump vec4 tmpvar_16;
          tmpvar_16.w = 0.0;
          tmpvar_16.xyz = tmpvar_14;
          tmpvar_5 = tmpvar_16;
        };
      };
    } else {
      if ((_AlbedoMinLuminance > tmpvar_15)) {
        tmpvar_5 = unity_MaterialValidateLowColor;
      } else {
        if ((_AlbedoMaxLuminance < tmpvar_15)) {
          tmpvar_5 = unity_MaterialValidateHighColor;
        } else {
          mediump vec3 tmpvar_17;
          if (((tmpvar_2.z > tmpvar_2.y) && (tmpvar_2.z > tmpvar_2.x))) {
            mediump float dominantColor_18;
            dominantColor_18 = tmpvar_2.z;
            mediump float colorone_19;
            colorone_19 = tmpvar_2.x;
            mediump float colortwo_20;
            colortwo_20 = tmpvar_2.y;
            mediump float S_21;
            mediump float H_22;
            if ((tmpvar_2.z != 0.0)) {
              mediump float small_23;
              small_23 = 0.0;
              if ((tmpvar_2.x > tmpvar_2.y)) {
                small_23 = colortwo_20;
              } else {
                small_23 = colorone_19;
              };
              mediump float tmpvar_24;
              tmpvar_24 = (tmpvar_2.z - small_23);
              if ((tmpvar_24 != 0.0)) {
                S_21 = (tmpvar_24 / tmpvar_2.z);
                H_22 = (4.0 + ((tmpvar_2.x - tmpvar_2.y) / tmpvar_24));
              } else {
                S_21 = 0.0;
                H_22 = (4.0 + (tmpvar_2.x - tmpvar_2.y));
              };
              H_22 = (H_22 / 6.0);
              if ((H_22 < 6.0)) {
                H_22 += 1.0;
              };
            } else {
              S_21 = 0.0;
              H_22 = 0.0;
            };
            mediump vec3 tmpvar_25;
            tmpvar_25.x = H_22;
            tmpvar_25.y = S_21;
            tmpvar_25.z = dominantColor_18;
            tmpvar_17 = tmpvar_25;
          } else {
            if ((tmpvar_2.y > tmpvar_2.x)) {
              mediump float dominantColor_26;
              dominantColor_26 = tmpvar_2.y;
              mediump float colorone_27;
              colorone_27 = tmpvar_2.z;
              mediump float colortwo_28;
              colortwo_28 = tmpvar_2.x;
              mediump float S_29;
              mediump float H_30;
              if ((tmpvar_2.y != 0.0)) {
                mediump float small_31;
                small_31 = 0.0;
                if ((tmpvar_2.z > tmpvar_2.x)) {
                  small_31 = colortwo_28;
                } else {
                  small_31 = colorone_27;
                };
                mediump float tmpvar_32;
                tmpvar_32 = (tmpvar_2.y - small_31);
                if ((tmpvar_32 != 0.0)) {
                  S_29 = (tmpvar_32 / tmpvar_2.y);
                  H_30 = (2.0 + ((tmpvar_2.z - tmpvar_2.x) / tmpvar_32));
                } else {
                  S_29 = 0.0;
                  H_30 = (2.0 + (tmpvar_2.z - tmpvar_2.x));
                };
                H_30 = (H_30 / 6.0);
                if ((H_30 < 6.0)) {
                  H_30 += 1.0;
                };
              } else {
                S_29 = 0.0;
                H_30 = 0.0;
              };
              mediump vec3 tmpvar_33;
              tmpvar_33.x = H_30;
              tmpvar_33.y = S_29;
              tmpvar_33.z = dominantColor_26;
              tmpvar_17 = tmpvar_33;
            } else {
              mediump float dominantColor_34;
              dominantColor_34 = tmpvar_2.x;
              mediump float colorone_35;
              colorone_35 = tmpvar_2.y;
              mediump float colortwo_36;
              colortwo_36 = tmpvar_2.z;
              mediump float S_37;
              mediump float H_38;
              if ((tmpvar_2.x != 0.0)) {
                mediump float small_39;
                small_39 = 0.0;
                if ((tmpvar_2.y > tmpvar_2.z)) {
                  small_39 = colortwo_36;
                } else {
                  small_39 = colorone_35;
                };
                mediump float tmpvar_40;
                tmpvar_40 = (tmpvar_2.x - small_39);
                if ((tmpvar_40 != 0.0)) {
                  S_37 = (tmpvar_40 / tmpvar_2.x);
                  H_38 = ((tmpvar_2.y - tmpvar_2.z) / tmpvar_40);
                } else {
                  S_37 = 0.0;
                  H_38 = (tmpvar_2.y - tmpvar_2.z);
                };
                H_38 = (H_38 / 6.0);
                if ((H_38 < 6.0)) {
                  H_38 += 1.0;
                };
              } else {
                S_37 = 0.0;
                H_38 = 0.0;
              };
              mediump vec3 tmpvar_41;
              tmpvar_41.x = H_38;
              tmpvar_41.y = S_37;
              tmpvar_41.z = dominantColor_34;
              tmpvar_17 = tmpvar_41;
            };
          };
          mediump vec3 rgbColor_42;
          rgbColor_42 = _AlbedoCompareColor.xyz;
          mediump vec3 tmpvar_43;
          if (((_AlbedoCompareColor.z > _AlbedoCompareColor.y) && (_AlbedoCompareColor.z > _AlbedoCompareColor.x))) {
            mediump float dominantColor_44;
            dominantColor_44 = rgbColor_42.z;
            mediump float colorone_45;
            colorone_45 = rgbColor_42.x;
            mediump float colortwo_46;
            colortwo_46 = rgbColor_42.y;
            mediump float S_47;
            mediump float H_48;
            if ((_AlbedoCompareColor.z != 0.0)) {
              mediump float small_49;
              small_49 = 0.0;
              if ((_AlbedoCompareColor.x > _AlbedoCompareColor.y)) {
                small_49 = colortwo_46;
              } else {
                small_49 = colorone_45;
              };
              mediump float tmpvar_50;
              tmpvar_50 = (_AlbedoCompareColor.z - small_49);
              if ((tmpvar_50 != 0.0)) {
                S_47 = (tmpvar_50 / _AlbedoCompareColor.z);
                H_48 = (4.0 + ((_AlbedoCompareColor.x - _AlbedoCompareColor.y) / tmpvar_50));
              } else {
                S_47 = 0.0;
                H_48 = (4.0 + (_AlbedoCompareColor.x - _AlbedoCompareColor.y));
              };
              H_48 = (H_48 / 6.0);
              if ((H_48 < 6.0)) {
                H_48 += 1.0;
              };
            } else {
              S_47 = 0.0;
              H_48 = 0.0;
            };
            mediump vec3 tmpvar_51;
            tmpvar_51.x = H_48;
            tmpvar_51.y = S_47;
            tmpvar_51.z = dominantColor_44;
            tmpvar_43 = tmpvar_51;
          } else {
            if ((_AlbedoCompareColor.y > _AlbedoCompareColor.x)) {
              mediump float dominantColor_52;
              dominantColor_52 = rgbColor_42.y;
              mediump float colorone_53;
              colorone_53 = rgbColor_42.z;
              mediump float colortwo_54;
              colortwo_54 = rgbColor_42.x;
              mediump float S_55;
              mediump float H_56;
              if ((_AlbedoCompareColor.y != 0.0)) {
                mediump float small_57;
                small_57 = 0.0;
                if ((_AlbedoCompareColor.z > _AlbedoCompareColor.x)) {
                  small_57 = colortwo_54;
                } else {
                  small_57 = colorone_53;
                };
                mediump float tmpvar_58;
                tmpvar_58 = (_AlbedoCompareColor.y - small_57);
                if ((tmpvar_58 != 0.0)) {
                  S_55 = (tmpvar_58 / _AlbedoCompareColor.y);
                  H_56 = (2.0 + ((_AlbedoCompareColor.z - _AlbedoCompareColor.x) / tmpvar_58));
                } else {
                  S_55 = 0.0;
                  H_56 = (2.0 + (_AlbedoCompareColor.z - _AlbedoCompareColor.x));
                };
                H_56 = (H_56 / 6.0);
                if ((H_56 < 6.0)) {
                  H_56 += 1.0;
                };
              } else {
                S_55 = 0.0;
                H_56 = 0.0;
              };
              mediump vec3 tmpvar_59;
              tmpvar_59.x = H_56;
              tmpvar_59.y = S_55;
              tmpvar_59.z = dominantColor_52;
              tmpvar_43 = tmpvar_59;
            } else {
              mediump float dominantColor_60;
              dominantColor_60 = rgbColor_42.x;
              mediump float colorone_61;
              colorone_61 = rgbColor_42.y;
              mediump float colortwo_62;
              colortwo_62 = rgbColor_42.z;
              mediump float S_63;
              mediump float H_64;
              if ((_AlbedoCompareColor.x != 0.0)) {
                mediump float small_65;
                small_65 = 0.0;
                if ((_AlbedoCompareColor.y > _AlbedoCompareColor.z)) {
                  small_65 = colortwo_62;
                } else {
                  small_65 = colorone_61;
                };
                mediump float tmpvar_66;
                tmpvar_66 = (_AlbedoCompareColor.x - small_65);
                if ((tmpvar_66 != 0.0)) {
                  S_63 = (tmpvar_66 / _AlbedoCompareColor.x);
                  H_64 = ((_AlbedoCompareColor.y - _AlbedoCompareColor.z) / tmpvar_66);
                } else {
                  S_63 = 0.0;
                  H_64 = (_AlbedoCompareColor.y - _AlbedoCompareColor.z);
                };
                H_64 = (H_64 / 6.0);
                if ((H_64 < 6.0)) {
                  H_64 += 1.0;
                };
              } else {
                S_63 = 0.0;
                H_64 = 0.0;
              };
              mediump vec3 tmpvar_67;
              tmpvar_67.x = H_64;
              tmpvar_67.y = S_63;
              tmpvar_67.z = dominantColor_60;
              tmpvar_43 = tmpvar_67;
            };
          };
          if ((((tmpvar_43.y - _AlbedoSaturationTolerance) > tmpvar_17.y) || ((
            (tmpvar_43.x - _AlbedoHueTolerance)
           > tmpvar_17.x) && (
            ((tmpvar_43.x - _AlbedoHueTolerance) + 1.0)
           > tmpvar_17.x)))) {
            tmpvar_5 = unity_MaterialValidateLowColor;
          } else {
            if (((tmpvar_17.y > (tmpvar_43.y + _AlbedoSaturationTolerance)) || ((tmpvar_17.x > 
              (tmpvar_43.x + _AlbedoHueTolerance)
            ) && (tmpvar_17.x > 
              ((tmpvar_43.x + _AlbedoHueTolerance) - 1.0)
            )))) {
              tmpvar_5 = unity_MaterialValidateHighColor;
            } else {
              mediump vec4 tmpvar_68;
              tmpvar_68.w = 0.0;
              tmpvar_68.xyz = tmpvar_14;
              tmpvar_5 = tmpvar_68;
            };
          };
        };
      };
    };
    res_4 = tmpvar_5;
  } else {
    if ((unity_VisualizationMode == 1)) {
      res_4 = unity_MaterialValidateLowColor;
    };
  };
  tmpvar_1 = res_4;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "EDITOR_VISUALIZATION" }
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
varying highp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform highp int unity_VisualizationMode;
uniform highp int _CheckAlbedo;
uniform mediump vec4 _AlbedoCompareColor;
uniform mediump float _AlbedoMinLuminance;
uniform mediump float _AlbedoMaxLuminance;
uniform mediump float _AlbedoHueTolerance;
uniform mediump float _AlbedoSaturationTolerance;
uniform mediump vec4 unity_MaterialValidateLowColor;
uniform mediump vec4 unity_MaterialValidateHighColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_4;
  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((unity_VisualizationMode == 0)) {
    mediump vec4 tmpvar_5;
    mediump vec3 baseColor_6;
    baseColor_6 = tmpvar_2;
    highp float value_7;
    value_7 = tmpvar_2.x;
    highp float tmpvar_8;
    if ((value_7 <= 0.04045)) {
      tmpvar_8 = (value_7 / 12.92);
    } else {
      if ((value_7 < 1.0)) {
        tmpvar_8 = pow (((value_7 + 0.055) / 1.055), 2.4);
      } else {
        tmpvar_8 = pow (value_7, 2.2);
      };
    };
    highp float value_9;
    value_9 = tmpvar_2.y;
    highp float tmpvar_10;
    if ((value_9 <= 0.04045)) {
      tmpvar_10 = (value_9 / 12.92);
    } else {
      if ((value_9 < 1.0)) {
        tmpvar_10 = pow (((value_9 + 0.055) / 1.055), 2.4);
      } else {
        tmpvar_10 = pow (value_9, 2.2);
      };
    };
    highp float value_11;
    value_11 = tmpvar_2.z;
    highp float tmpvar_12;
    if ((value_11 <= 0.04045)) {
      tmpvar_12 = (value_11 / 12.92);
    } else {
      if ((value_11 < 1.0)) {
        tmpvar_12 = pow (((value_11 + 0.055) / 1.055), 2.4);
      } else {
        tmpvar_12 = pow (value_11, 2.2);
      };
    };
    highp vec3 tmpvar_13;
    tmpvar_13.x = tmpvar_8;
    tmpvar_13.y = tmpvar_10;
    tmpvar_13.z = tmpvar_12;
    baseColor_6 = tmpvar_13;
    mediump vec3 tmpvar_14;
    tmpvar_14 = vec3(dot (baseColor_6, vec3(0.2126729, 0.7151522, 0.072175)));
    mediump float tmpvar_15;
    if (bool(_CheckAlbedo)) {
      tmpvar_15 = dot (baseColor_6, vec3(0.2126729, 0.7151522, 0.072175));
    } else {
      tmpvar_15 = dot (baseColor_6, vec3(0.3333, 0.3333, 0.3333));
    };
    if ((_CheckAlbedo == 0)) {
      if ((tmpvar_15 < 0.012)) {
        tmpvar_5 = unity_MaterialValidateLowColor;
      } else {
        if ((tmpvar_15 > 0.9)) {
          tmpvar_5 = unity_MaterialValidateHighColor;
        } else {
          mediump vec4 tmpvar_16;
          tmpvar_16.w = 0.0;
          tmpvar_16.xyz = tmpvar_14;
          tmpvar_5 = tmpvar_16;
        };
      };
    } else {
      if ((_AlbedoMinLuminance > tmpvar_15)) {
        tmpvar_5 = unity_MaterialValidateLowColor;
      } else {
        if ((_AlbedoMaxLuminance < tmpvar_15)) {
          tmpvar_5 = unity_MaterialValidateHighColor;
        } else {
          mediump vec3 tmpvar_17;
          if (((tmpvar_2.z > tmpvar_2.y) && (tmpvar_2.z > tmpvar_2.x))) {
            mediump float dominantColor_18;
            dominantColor_18 = tmpvar_2.z;
            mediump float colorone_19;
            colorone_19 = tmpvar_2.x;
            mediump float colortwo_20;
            colortwo_20 = tmpvar_2.y;
            mediump float S_21;
            mediump float H_22;
            if ((tmpvar_2.z != 0.0)) {
              mediump float small_23;
              small_23 = 0.0;
              if ((tmpvar_2.x > tmpvar_2.y)) {
                small_23 = colortwo_20;
              } else {
                small_23 = colorone_19;
              };
              mediump float tmpvar_24;
              tmpvar_24 = (tmpvar_2.z - small_23);
              if ((tmpvar_24 != 0.0)) {
                S_21 = (tmpvar_24 / tmpvar_2.z);
                H_22 = (4.0 + ((tmpvar_2.x - tmpvar_2.y) / tmpvar_24));
              } else {
                S_21 = 0.0;
                H_22 = (4.0 + (tmpvar_2.x - tmpvar_2.y));
              };
              H_22 = (H_22 / 6.0);
              if ((H_22 < 6.0)) {
                H_22 += 1.0;
              };
            } else {
              S_21 = 0.0;
              H_22 = 0.0;
            };
            mediump vec3 tmpvar_25;
            tmpvar_25.x = H_22;
            tmpvar_25.y = S_21;
            tmpvar_25.z = dominantColor_18;
            tmpvar_17 = tmpvar_25;
          } else {
            if ((tmpvar_2.y > tmpvar_2.x)) {
              mediump float dominantColor_26;
              dominantColor_26 = tmpvar_2.y;
              mediump float colorone_27;
              colorone_27 = tmpvar_2.z;
              mediump float colortwo_28;
              colortwo_28 = tmpvar_2.x;
              mediump float S_29;
              mediump float H_30;
              if ((tmpvar_2.y != 0.0)) {
                mediump float small_31;
                small_31 = 0.0;
                if ((tmpvar_2.z > tmpvar_2.x)) {
                  small_31 = colortwo_28;
                } else {
                  small_31 = colorone_27;
                };
                mediump float tmpvar_32;
                tmpvar_32 = (tmpvar_2.y - small_31);
                if ((tmpvar_32 != 0.0)) {
                  S_29 = (tmpvar_32 / tmpvar_2.y);
                  H_30 = (2.0 + ((tmpvar_2.z - tmpvar_2.x) / tmpvar_32));
                } else {
                  S_29 = 0.0;
                  H_30 = (2.0 + (tmpvar_2.z - tmpvar_2.x));
                };
                H_30 = (H_30 / 6.0);
                if ((H_30 < 6.0)) {
                  H_30 += 1.0;
                };
              } else {
                S_29 = 0.0;
                H_30 = 0.0;
              };
              mediump vec3 tmpvar_33;
              tmpvar_33.x = H_30;
              tmpvar_33.y = S_29;
              tmpvar_33.z = dominantColor_26;
              tmpvar_17 = tmpvar_33;
            } else {
              mediump float dominantColor_34;
              dominantColor_34 = tmpvar_2.x;
              mediump float colorone_35;
              colorone_35 = tmpvar_2.y;
              mediump float colortwo_36;
              colortwo_36 = tmpvar_2.z;
              mediump float S_37;
              mediump float H_38;
              if ((tmpvar_2.x != 0.0)) {
                mediump float small_39;
                small_39 = 0.0;
                if ((tmpvar_2.y > tmpvar_2.z)) {
                  small_39 = colortwo_36;
                } else {
                  small_39 = colorone_35;
                };
                mediump float tmpvar_40;
                tmpvar_40 = (tmpvar_2.x - small_39);
                if ((tmpvar_40 != 0.0)) {
                  S_37 = (tmpvar_40 / tmpvar_2.x);
                  H_38 = ((tmpvar_2.y - tmpvar_2.z) / tmpvar_40);
                } else {
                  S_37 = 0.0;
                  H_38 = (tmpvar_2.y - tmpvar_2.z);
                };
                H_38 = (H_38 / 6.0);
                if ((H_38 < 6.0)) {
                  H_38 += 1.0;
                };
              } else {
                S_37 = 0.0;
                H_38 = 0.0;
              };
              mediump vec3 tmpvar_41;
              tmpvar_41.x = H_38;
              tmpvar_41.y = S_37;
              tmpvar_41.z = dominantColor_34;
              tmpvar_17 = tmpvar_41;
            };
          };
          mediump vec3 rgbColor_42;
          rgbColor_42 = _AlbedoCompareColor.xyz;
          mediump vec3 tmpvar_43;
          if (((_AlbedoCompareColor.z > _AlbedoCompareColor.y) && (_AlbedoCompareColor.z > _AlbedoCompareColor.x))) {
            mediump float dominantColor_44;
            dominantColor_44 = rgbColor_42.z;
            mediump float colorone_45;
            colorone_45 = rgbColor_42.x;
            mediump float colortwo_46;
            colortwo_46 = rgbColor_42.y;
            mediump float S_47;
            mediump float H_48;
            if ((_AlbedoCompareColor.z != 0.0)) {
              mediump float small_49;
              small_49 = 0.0;
              if ((_AlbedoCompareColor.x > _AlbedoCompareColor.y)) {
                small_49 = colortwo_46;
              } else {
                small_49 = colorone_45;
              };
              mediump float tmpvar_50;
              tmpvar_50 = (_AlbedoCompareColor.z - small_49);
              if ((tmpvar_50 != 0.0)) {
                S_47 = (tmpvar_50 / _AlbedoCompareColor.z);
                H_48 = (4.0 + ((_AlbedoCompareColor.x - _AlbedoCompareColor.y) / tmpvar_50));
              } else {
                S_47 = 0.0;
                H_48 = (4.0 + (_AlbedoCompareColor.x - _AlbedoCompareColor.y));
              };
              H_48 = (H_48 / 6.0);
              if ((H_48 < 6.0)) {
                H_48 += 1.0;
              };
            } else {
              S_47 = 0.0;
              H_48 = 0.0;
            };
            mediump vec3 tmpvar_51;
            tmpvar_51.x = H_48;
            tmpvar_51.y = S_47;
            tmpvar_51.z = dominantColor_44;
            tmpvar_43 = tmpvar_51;
          } else {
            if ((_AlbedoCompareColor.y > _AlbedoCompareColor.x)) {
              mediump float dominantColor_52;
              dominantColor_52 = rgbColor_42.y;
              mediump float colorone_53;
              colorone_53 = rgbColor_42.z;
              mediump float colortwo_54;
              colortwo_54 = rgbColor_42.x;
              mediump float S_55;
              mediump float H_56;
              if ((_AlbedoCompareColor.y != 0.0)) {
                mediump float small_57;
                small_57 = 0.0;
                if ((_AlbedoCompareColor.z > _AlbedoCompareColor.x)) {
                  small_57 = colortwo_54;
                } else {
                  small_57 = colorone_53;
                };
                mediump float tmpvar_58;
                tmpvar_58 = (_AlbedoCompareColor.y - small_57);
                if ((tmpvar_58 != 0.0)) {
                  S_55 = (tmpvar_58 / _AlbedoCompareColor.y);
                  H_56 = (2.0 + ((_AlbedoCompareColor.z - _AlbedoCompareColor.x) / tmpvar_58));
                } else {
                  S_55 = 0.0;
                  H_56 = (2.0 + (_AlbedoCompareColor.z - _AlbedoCompareColor.x));
                };
                H_56 = (H_56 / 6.0);
                if ((H_56 < 6.0)) {
                  H_56 += 1.0;
                };
              } else {
                S_55 = 0.0;
                H_56 = 0.0;
              };
              mediump vec3 tmpvar_59;
              tmpvar_59.x = H_56;
              tmpvar_59.y = S_55;
              tmpvar_59.z = dominantColor_52;
              tmpvar_43 = tmpvar_59;
            } else {
              mediump float dominantColor_60;
              dominantColor_60 = rgbColor_42.x;
              mediump float colorone_61;
              colorone_61 = rgbColor_42.y;
              mediump float colortwo_62;
              colortwo_62 = rgbColor_42.z;
              mediump float S_63;
              mediump float H_64;
              if ((_AlbedoCompareColor.x != 0.0)) {
                mediump float small_65;
                small_65 = 0.0;
                if ((_AlbedoCompareColor.y > _AlbedoCompareColor.z)) {
                  small_65 = colortwo_62;
                } else {
                  small_65 = colorone_61;
                };
                mediump float tmpvar_66;
                tmpvar_66 = (_AlbedoCompareColor.x - small_65);
                if ((tmpvar_66 != 0.0)) {
                  S_63 = (tmpvar_66 / _AlbedoCompareColor.x);
                  H_64 = ((_AlbedoCompareColor.y - _AlbedoCompareColor.z) / tmpvar_66);
                } else {
                  S_63 = 0.0;
                  H_64 = (_AlbedoCompareColor.y - _AlbedoCompareColor.z);
                };
                H_64 = (H_64 / 6.0);
                if ((H_64 < 6.0)) {
                  H_64 += 1.0;
                };
              } else {
                S_63 = 0.0;
                H_64 = 0.0;
              };
              mediump vec3 tmpvar_67;
              tmpvar_67.x = H_64;
              tmpvar_67.y = S_63;
              tmpvar_67.z = dominantColor_60;
              tmpvar_43 = tmpvar_67;
            };
          };
          if ((((tmpvar_43.y - _AlbedoSaturationTolerance) > tmpvar_17.y) || ((
            (tmpvar_43.x - _AlbedoHueTolerance)
           > tmpvar_17.x) && (
            ((tmpvar_43.x - _AlbedoHueTolerance) + 1.0)
           > tmpvar_17.x)))) {
            tmpvar_5 = unity_MaterialValidateLowColor;
          } else {
            if (((tmpvar_17.y > (tmpvar_43.y + _AlbedoSaturationTolerance)) || ((tmpvar_17.x > 
              (tmpvar_43.x + _AlbedoHueTolerance)
            ) && (tmpvar_17.x > 
              ((tmpvar_43.x + _AlbedoHueTolerance) - 1.0)
            )))) {
              tmpvar_5 = unity_MaterialValidateHighColor;
            } else {
              mediump vec4 tmpvar_68;
              tmpvar_68.w = 0.0;
              tmpvar_68.xyz = tmpvar_14;
              tmpvar_5 = tmpvar_68;
            };
          };
        };
      };
    };
    res_4 = tmpvar_5;
  } else {
    if ((unity_VisualizationMode == 1)) {
      res_4 = unity_MaterialValidateLowColor;
    };
  };
  tmpvar_1 = res_4;
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
SubProgram "gles hw_tier00 " {
Keywords { "EDITOR_VISUALIZATION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "EDITOR_VISUALIZATION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "EDITOR_VISUALIZATION" }
""
}
}
}
}
Fallback "Legacy Shaders/VertexLit"
}