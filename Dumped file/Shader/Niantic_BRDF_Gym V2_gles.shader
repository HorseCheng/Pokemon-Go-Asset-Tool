Shader "Niantic/BRDF/Gym V2" {
Properties {
_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
_BlendTex ("Blend Texture (for team swap)", 2D) = "black" { }
_BlendAmount ("Texture Blend", Range(0, 1)) = 0
_Ramp2D ("BRDF Ramp", 2D) = "grey" { }
_GymBrdfAmount ("BRDF Amount", Range(0, 2)) = 1
_GymDiffuse ("Diffuse", Color) = (1,1,1,0.5)
_GymAmbient ("Ambient", Color) = (0,0,0,0.5)
_GymRimTop ("RimTop   (.a=0.5)", Color) = (1,1,0,0.5)
_GymRimBottom ("RimBottom(.a=0.5)", Color) = (0,0,1,0.5)
_GymRimMultiply ("RimLight Mult", Range(0, 2)) = 1
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 49046
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  mediump vec3 normal_15;
  normal_15 = tmpvar_14;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = normal_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, tmpvar_16);
  x_18.y = dot (unity_SHAg, tmpvar_16);
  x_18.z = dot (unity_SHAb, tmpvar_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_15.xyzz * normal_15.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), tmpvar_21);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  mediump vec3 normal_15;
  normal_15 = tmpvar_14;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = normal_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, tmpvar_16);
  x_18.y = dot (unity_SHAg, tmpvar_16);
  x_18.z = dot (unity_SHAb, tmpvar_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_15.xyzz * normal_15.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), tmpvar_21);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  mediump vec3 normal_15;
  normal_15 = tmpvar_14;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = normal_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, tmpvar_16);
  x_18.y = dot (unity_SHAg, tmpvar_16);
  x_18.z = dot (unity_SHAb, tmpvar_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_15.xyzz * normal_15.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), tmpvar_21);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  mediump vec3 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 x1_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_16.xyzz * normal_16.yzzx);
  x1_17.x = dot (unity_SHBr, tmpvar_18);
  x1_17.y = dot (unity_SHBg, tmpvar_18);
  x1_17.z = dot (unity_SHBb, tmpvar_18);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (x1_17 + (unity_SHC.xyz * (
    (normal_16.x * normal_16.x)
   - 
    (normal_16.y * normal_16.y)
  )));
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  mediump vec3 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 x1_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_16.xyzz * normal_16.yzzx);
  x1_17.x = dot (unity_SHBr, tmpvar_18);
  x1_17.y = dot (unity_SHBg, tmpvar_18);
  x1_17.z = dot (unity_SHBb, tmpvar_18);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (x1_17 + (unity_SHC.xyz * (
    (normal_16.x * normal_16.x)
   - 
    (normal_16.y * normal_16.y)
  )));
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  mediump vec3 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 x1_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_16.xyzz * normal_16.yzzx);
  x1_17.x = dot (unity_SHBr, tmpvar_18);
  x1_17.y = dot (unity_SHBg, tmpvar_18);
  x1_17.z = dot (unity_SHBb, tmpvar_18);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (x1_17 + (unity_SHC.xyz * (
    (normal_16.x * normal_16.x)
   - 
    (normal_16.y * normal_16.y)
  )));
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_15.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_15.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_15.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_3 = col_21;
  mediump vec3 normal_30;
  normal_30 = tmpvar_15;
  mediump vec3 ambient_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = normal_30;
  mediump vec3 res_33;
  mediump vec3 x_34;
  x_34.x = dot (unity_SHAr, tmpvar_32);
  x_34.y = dot (unity_SHAg, tmpvar_32);
  x_34.z = dot (unity_SHAb, tmpvar_32);
  mediump vec3 x1_35;
  mediump vec4 tmpvar_36;
  tmpvar_36 = (normal_30.xyzz * normal_30.yzzx);
  x1_35.x = dot (unity_SHBr, tmpvar_36);
  x1_35.y = dot (unity_SHBg, tmpvar_36);
  x1_35.z = dot (unity_SHBb, tmpvar_36);
  res_33 = (x_34 + (x1_35 + (unity_SHC.xyz * 
    ((normal_30.x * normal_30.x) - (normal_30.y * normal_30.y))
  )));
  mediump vec3 tmpvar_37;
  tmpvar_37 = max (((1.055 * 
    pow (max (res_33, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_33 = tmpvar_37;
  ambient_31 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_37));
  tmpvar_3 = ambient_31;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = ambient_31;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_15.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_15.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_15.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_3 = col_21;
  mediump vec3 normal_30;
  normal_30 = tmpvar_15;
  mediump vec3 ambient_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = normal_30;
  mediump vec3 res_33;
  mediump vec3 x_34;
  x_34.x = dot (unity_SHAr, tmpvar_32);
  x_34.y = dot (unity_SHAg, tmpvar_32);
  x_34.z = dot (unity_SHAb, tmpvar_32);
  mediump vec3 x1_35;
  mediump vec4 tmpvar_36;
  tmpvar_36 = (normal_30.xyzz * normal_30.yzzx);
  x1_35.x = dot (unity_SHBr, tmpvar_36);
  x1_35.y = dot (unity_SHBg, tmpvar_36);
  x1_35.z = dot (unity_SHBb, tmpvar_36);
  res_33 = (x_34 + (x1_35 + (unity_SHC.xyz * 
    ((normal_30.x * normal_30.x) - (normal_30.y * normal_30.y))
  )));
  mediump vec3 tmpvar_37;
  tmpvar_37 = max (((1.055 * 
    pow (max (res_33, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_33 = tmpvar_37;
  ambient_31 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_37));
  tmpvar_3 = ambient_31;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = ambient_31;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_15.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_15.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_15.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_3 = col_21;
  mediump vec3 normal_30;
  normal_30 = tmpvar_15;
  mediump vec3 ambient_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = normal_30;
  mediump vec3 res_33;
  mediump vec3 x_34;
  x_34.x = dot (unity_SHAr, tmpvar_32);
  x_34.y = dot (unity_SHAg, tmpvar_32);
  x_34.z = dot (unity_SHAb, tmpvar_32);
  mediump vec3 x1_35;
  mediump vec4 tmpvar_36;
  tmpvar_36 = (normal_30.xyzz * normal_30.yzzx);
  x1_35.x = dot (unity_SHBr, tmpvar_36);
  x1_35.y = dot (unity_SHBg, tmpvar_36);
  x1_35.z = dot (unity_SHBb, tmpvar_36);
  res_33 = (x_34 + (x1_35 + (unity_SHC.xyz * 
    ((normal_30.x * normal_30.x) - (normal_30.y * normal_30.y))
  )));
  mediump vec3 tmpvar_37;
  tmpvar_37 = max (((1.055 * 
    pow (max (res_33, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_33 = tmpvar_37;
  ambient_31 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_37));
  tmpvar_3 = ambient_31;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = ambient_31;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_13.y = (((
    dot (vNormal_7, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = 1.0;
  tmpvar_5.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_5;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 col_22;
  highp vec4 ndotl_23;
  highp vec4 lengthSq_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_24 = (tmpvar_25 * tmpvar_25);
  lengthSq_24 = (lengthSq_24 + (tmpvar_26 * tmpvar_26));
  lengthSq_24 = (lengthSq_24 + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (lengthSq_24, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_24 = tmpvar_28;
  ndotl_23 = (tmpvar_25 * tmpvar_16.x);
  ndotl_23 = (ndotl_23 + (tmpvar_26 * tmpvar_16.y));
  ndotl_23 = (ndotl_23 + (tmpvar_27 * tmpvar_16.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_23 * inversesqrt(tmpvar_28)));
  ndotl_23 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (tmpvar_28 * lightAttenSq_21)
  ))));
  col_22 = (lightColor0_17 * tmpvar_30.x);
  col_22 = (col_22 + (lightColor1_18 * tmpvar_30.y));
  col_22 = (col_22 + (lightColor2_19 * tmpvar_30.z));
  col_22 = (col_22 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_3 = col_22;
  mediump vec3 normal_31;
  normal_31 = tmpvar_16;
  mediump vec3 ambient_32;
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_31.xyzz * normal_31.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  ambient_32 = ((tmpvar_3 * (
    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_33 + (unity_SHC.xyz * 
    ((normal_31.x * normal_31.x) - (normal_31.y * normal_31.y))
  )));
  tmpvar_3 = ambient_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ambient_32;
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_13.y = (((
    dot (vNormal_7, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = 1.0;
  tmpvar_5.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_5;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 col_22;
  highp vec4 ndotl_23;
  highp vec4 lengthSq_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_24 = (tmpvar_25 * tmpvar_25);
  lengthSq_24 = (lengthSq_24 + (tmpvar_26 * tmpvar_26));
  lengthSq_24 = (lengthSq_24 + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (lengthSq_24, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_24 = tmpvar_28;
  ndotl_23 = (tmpvar_25 * tmpvar_16.x);
  ndotl_23 = (ndotl_23 + (tmpvar_26 * tmpvar_16.y));
  ndotl_23 = (ndotl_23 + (tmpvar_27 * tmpvar_16.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_23 * inversesqrt(tmpvar_28)));
  ndotl_23 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (tmpvar_28 * lightAttenSq_21)
  ))));
  col_22 = (lightColor0_17 * tmpvar_30.x);
  col_22 = (col_22 + (lightColor1_18 * tmpvar_30.y));
  col_22 = (col_22 + (lightColor2_19 * tmpvar_30.z));
  col_22 = (col_22 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_3 = col_22;
  mediump vec3 normal_31;
  normal_31 = tmpvar_16;
  mediump vec3 ambient_32;
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_31.xyzz * normal_31.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  ambient_32 = ((tmpvar_3 * (
    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_33 + (unity_SHC.xyz * 
    ((normal_31.x * normal_31.x) - (normal_31.y * normal_31.y))
  )));
  tmpvar_3 = ambient_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ambient_32;
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_13.y = (((
    dot (vNormal_7, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = 1.0;
  tmpvar_5.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_5;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 col_22;
  highp vec4 ndotl_23;
  highp vec4 lengthSq_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_24 = (tmpvar_25 * tmpvar_25);
  lengthSq_24 = (lengthSq_24 + (tmpvar_26 * tmpvar_26));
  lengthSq_24 = (lengthSq_24 + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (lengthSq_24, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_24 = tmpvar_28;
  ndotl_23 = (tmpvar_25 * tmpvar_16.x);
  ndotl_23 = (ndotl_23 + (tmpvar_26 * tmpvar_16.y));
  ndotl_23 = (ndotl_23 + (tmpvar_27 * tmpvar_16.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_23 * inversesqrt(tmpvar_28)));
  ndotl_23 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (tmpvar_28 * lightAttenSq_21)
  ))));
  col_22 = (lightColor0_17 * tmpvar_30.x);
  col_22 = (col_22 + (lightColor1_18 * tmpvar_30.y));
  col_22 = (col_22 + (lightColor2_19 * tmpvar_30.z));
  col_22 = (col_22 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_3 = col_22;
  mediump vec3 normal_31;
  normal_31 = tmpvar_16;
  mediump vec3 ambient_32;
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_31.xyzz * normal_31.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  ambient_32 = ((tmpvar_3 * (
    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_33 + (unity_SHC.xyz * 
    ((normal_31.x * normal_31.x) - (normal_31.y * normal_31.y))
  )));
  tmpvar_3 = ambient_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ambient_32;
  xlv_TEXCOORD6 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  c_1.xyz = tmpvar_2;
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  mediump vec3 normal_16;
  normal_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = normal_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, tmpvar_17);
  x_19.y = dot (unity_SHAg, tmpvar_17);
  x_19.z = dot (unity_SHAb, tmpvar_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_16.xyzz * normal_16.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), tmpvar_22);
  xlv_TEXCOORD7 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  mediump vec3 normal_16;
  normal_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = normal_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, tmpvar_17);
  x_19.y = dot (unity_SHAg, tmpvar_17);
  x_19.z = dot (unity_SHAb, tmpvar_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_16.xyzz * normal_16.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), tmpvar_22);
  xlv_TEXCOORD7 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  mediump vec3 normal_16;
  normal_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = normal_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, tmpvar_17);
  x_19.y = dot (unity_SHAg, tmpvar_17);
  x_19.z = dot (unity_SHAb, tmpvar_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_16.xyzz * normal_16.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), tmpvar_22);
  xlv_TEXCOORD7 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  mediump vec3 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_17.xyzz * normal_17.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (x1_18 + (unity_SHC.xyz * (
    (normal_17.x * normal_17.x)
   - 
    (normal_17.y * normal_17.y)
  )));
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  mediump vec3 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_17.xyzz * normal_17.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (x1_18 + (unity_SHC.xyz * (
    (normal_17.x * normal_17.x)
   - 
    (normal_17.y * normal_17.y)
  )));
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  mediump vec3 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_17.xyzz * normal_17.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (x1_18 + (unity_SHC.xyz * (
    (normal_17.x * normal_17.x)
   - 
    (normal_17.y * normal_17.y)
  )));
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_11.y = (((
    dot (vNormal_5, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = 1.0;
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_11;
  tmpvar_2.zw = tmpvar_3;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 col_22;
  highp vec4 ndotl_23;
  highp vec4 lengthSq_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_24 = (tmpvar_25 * tmpvar_25);
  lengthSq_24 = (lengthSq_24 + (tmpvar_26 * tmpvar_26));
  lengthSq_24 = (lengthSq_24 + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (lengthSq_24, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_24 = tmpvar_28;
  ndotl_23 = (tmpvar_25 * tmpvar_16.x);
  ndotl_23 = (ndotl_23 + (tmpvar_26 * tmpvar_16.y));
  ndotl_23 = (ndotl_23 + (tmpvar_27 * tmpvar_16.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_23 * inversesqrt(tmpvar_28)));
  ndotl_23 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (tmpvar_28 * lightAttenSq_21)
  ))));
  col_22 = (lightColor0_17 * tmpvar_30.x);
  col_22 = (col_22 + (lightColor1_18 * tmpvar_30.y));
  col_22 = (col_22 + (lightColor2_19 * tmpvar_30.z));
  col_22 = (col_22 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_3 = col_22;
  mediump vec3 normal_31;
  normal_31 = tmpvar_16;
  mediump vec3 ambient_32;
  mediump vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = normal_31;
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, tmpvar_33);
  x_35.y = dot (unity_SHAg, tmpvar_33);
  x_35.z = dot (unity_SHAb, tmpvar_33);
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normal_31.xyzz * normal_31.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  res_34 = (x_35 + (x1_36 + (unity_SHC.xyz * 
    ((normal_31.x * normal_31.x) - (normal_31.y * normal_31.y))
  )));
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_38;
  ambient_32 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_38));
  tmpvar_3 = ambient_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = ambient_32;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 col_22;
  highp vec4 ndotl_23;
  highp vec4 lengthSq_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_24 = (tmpvar_25 * tmpvar_25);
  lengthSq_24 = (lengthSq_24 + (tmpvar_26 * tmpvar_26));
  lengthSq_24 = (lengthSq_24 + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (lengthSq_24, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_24 = tmpvar_28;
  ndotl_23 = (tmpvar_25 * tmpvar_16.x);
  ndotl_23 = (ndotl_23 + (tmpvar_26 * tmpvar_16.y));
  ndotl_23 = (ndotl_23 + (tmpvar_27 * tmpvar_16.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_23 * inversesqrt(tmpvar_28)));
  ndotl_23 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (tmpvar_28 * lightAttenSq_21)
  ))));
  col_22 = (lightColor0_17 * tmpvar_30.x);
  col_22 = (col_22 + (lightColor1_18 * tmpvar_30.y));
  col_22 = (col_22 + (lightColor2_19 * tmpvar_30.z));
  col_22 = (col_22 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_3 = col_22;
  mediump vec3 normal_31;
  normal_31 = tmpvar_16;
  mediump vec3 ambient_32;
  mediump vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = normal_31;
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, tmpvar_33);
  x_35.y = dot (unity_SHAg, tmpvar_33);
  x_35.z = dot (unity_SHAb, tmpvar_33);
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normal_31.xyzz * normal_31.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  res_34 = (x_35 + (x1_36 + (unity_SHC.xyz * 
    ((normal_31.x * normal_31.x) - (normal_31.y * normal_31.y))
  )));
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_38;
  ambient_32 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_38));
  tmpvar_3 = ambient_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = ambient_32;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 col_22;
  highp vec4 ndotl_23;
  highp vec4 lengthSq_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_24 = (tmpvar_25 * tmpvar_25);
  lengthSq_24 = (lengthSq_24 + (tmpvar_26 * tmpvar_26));
  lengthSq_24 = (lengthSq_24 + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (lengthSq_24, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_24 = tmpvar_28;
  ndotl_23 = (tmpvar_25 * tmpvar_16.x);
  ndotl_23 = (ndotl_23 + (tmpvar_26 * tmpvar_16.y));
  ndotl_23 = (ndotl_23 + (tmpvar_27 * tmpvar_16.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_23 * inversesqrt(tmpvar_28)));
  ndotl_23 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (tmpvar_28 * lightAttenSq_21)
  ))));
  col_22 = (lightColor0_17 * tmpvar_30.x);
  col_22 = (col_22 + (lightColor1_18 * tmpvar_30.y));
  col_22 = (col_22 + (lightColor2_19 * tmpvar_30.z));
  col_22 = (col_22 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_3 = col_22;
  mediump vec3 normal_31;
  normal_31 = tmpvar_16;
  mediump vec3 ambient_32;
  mediump vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = normal_31;
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, tmpvar_33);
  x_35.y = dot (unity_SHAg, tmpvar_33);
  x_35.z = dot (unity_SHAb, tmpvar_33);
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normal_31.xyzz * normal_31.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  res_34 = (x_35 + (x1_36 + (unity_SHC.xyz * 
    ((normal_31.x * normal_31.x) - (normal_31.y * normal_31.y))
  )));
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_38;
  ambient_32 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_38));
  tmpvar_3 = ambient_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = ambient_32;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_12.y = (((
    dot (vNormal_6, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_13.y = (((
    dot (vNormal_7, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = 1.0;
  tmpvar_5.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_5;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_14 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_glesNormal * tmpvar_16));
  highp vec3 lightColor0_18;
  lightColor0_18 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_19;
  lightColor1_19 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_20;
  lightColor2_20 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_21;
  lightColor3_21 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_22;
  lightAttenSq_22 = unity_4LightAtten0;
  highp vec3 col_23;
  highp vec4 ndotl_24;
  highp vec4 lengthSq_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_25 = (tmpvar_26 * tmpvar_26);
  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (lengthSq_25, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_25 = tmpvar_29;
  ndotl_24 = (tmpvar_26 * tmpvar_17.x);
  ndotl_24 = (ndotl_24 + (tmpvar_27 * tmpvar_17.y));
  ndotl_24 = (ndotl_24 + (tmpvar_28 * tmpvar_17.z));
  highp vec4 tmpvar_30;
  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(tmpvar_29)));
  ndotl_24 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
    (tmpvar_29 * lightAttenSq_22)
  ))));
  col_23 = (lightColor0_18 * tmpvar_31.x);
  col_23 = (col_23 + (lightColor1_19 * tmpvar_31.y));
  col_23 = (col_23 + (lightColor2_20 * tmpvar_31.z));
  col_23 = (col_23 + (lightColor3_21 * tmpvar_31.w));
  tmpvar_3 = col_23;
  mediump vec3 normal_32;
  normal_32 = tmpvar_17;
  mediump vec3 ambient_33;
  mediump vec3 x1_34;
  mediump vec4 tmpvar_35;
  tmpvar_35 = (normal_32.xyzz * normal_32.yzzx);
  x1_34.x = dot (unity_SHBr, tmpvar_35);
  x1_34.y = dot (unity_SHBg, tmpvar_35);
  x1_34.z = dot (unity_SHBb, tmpvar_35);
  ambient_33 = ((tmpvar_3 * (
    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_34 + (unity_SHC.xyz * 
    ((normal_32.x * normal_32.x) - (normal_32.y * normal_32.y))
  )));
  tmpvar_3 = ambient_33;
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ambient_33;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_13.y = (((
    dot (vNormal_7, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = 1.0;
  tmpvar_5.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_5;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_14 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_glesNormal * tmpvar_16));
  highp vec3 lightColor0_18;
  lightColor0_18 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_19;
  lightColor1_19 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_20;
  lightColor2_20 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_21;
  lightColor3_21 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_22;
  lightAttenSq_22 = unity_4LightAtten0;
  highp vec3 col_23;
  highp vec4 ndotl_24;
  highp vec4 lengthSq_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_25 = (tmpvar_26 * tmpvar_26);
  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (lengthSq_25, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_25 = tmpvar_29;
  ndotl_24 = (tmpvar_26 * tmpvar_17.x);
  ndotl_24 = (ndotl_24 + (tmpvar_27 * tmpvar_17.y));
  ndotl_24 = (ndotl_24 + (tmpvar_28 * tmpvar_17.z));
  highp vec4 tmpvar_30;
  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(tmpvar_29)));
  ndotl_24 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
    (tmpvar_29 * lightAttenSq_22)
  ))));
  col_23 = (lightColor0_18 * tmpvar_31.x);
  col_23 = (col_23 + (lightColor1_19 * tmpvar_31.y));
  col_23 = (col_23 + (lightColor2_20 * tmpvar_31.z));
  col_23 = (col_23 + (lightColor3_21 * tmpvar_31.w));
  tmpvar_3 = col_23;
  mediump vec3 normal_32;
  normal_32 = tmpvar_17;
  mediump vec3 ambient_33;
  mediump vec3 x1_34;
  mediump vec4 tmpvar_35;
  tmpvar_35 = (normal_32.xyzz * normal_32.yzzx);
  x1_34.x = dot (unity_SHBr, tmpvar_35);
  x1_34.y = dot (unity_SHBg, tmpvar_35);
  x1_34.z = dot (unity_SHBb, tmpvar_35);
  ambient_33 = ((tmpvar_3 * (
    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_34 + (unity_SHC.xyz * 
    ((normal_32.x * normal_32.x) - (normal_32.y * normal_32.y))
  )));
  tmpvar_3 = ambient_33;
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ambient_33;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_13.y = (((
    dot (vNormal_7, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = 1.0;
  tmpvar_5.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_5;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_14 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_glesNormal * tmpvar_16));
  highp vec3 lightColor0_18;
  lightColor0_18 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_19;
  lightColor1_19 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_20;
  lightColor2_20 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_21;
  lightColor3_21 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_22;
  lightAttenSq_22 = unity_4LightAtten0;
  highp vec3 col_23;
  highp vec4 ndotl_24;
  highp vec4 lengthSq_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_25 = (tmpvar_26 * tmpvar_26);
  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (lengthSq_25, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_25 = tmpvar_29;
  ndotl_24 = (tmpvar_26 * tmpvar_17.x);
  ndotl_24 = (ndotl_24 + (tmpvar_27 * tmpvar_17.y));
  ndotl_24 = (ndotl_24 + (tmpvar_28 * tmpvar_17.z));
  highp vec4 tmpvar_30;
  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(tmpvar_29)));
  ndotl_24 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
    (tmpvar_29 * lightAttenSq_22)
  ))));
  col_23 = (lightColor0_18 * tmpvar_31.x);
  col_23 = (col_23 + (lightColor1_19 * tmpvar_31.y));
  col_23 = (col_23 + (lightColor2_20 * tmpvar_31.z));
  col_23 = (col_23 + (lightColor3_21 * tmpvar_31.w));
  tmpvar_3 = col_23;
  mediump vec3 normal_32;
  normal_32 = tmpvar_17;
  mediump vec3 ambient_33;
  mediump vec3 x1_34;
  mediump vec4 tmpvar_35;
  tmpvar_35 = (normal_32.xyzz * normal_32.yzzx);
  x1_34.x = dot (unity_SHBr, tmpvar_35);
  x1_34.y = dot (unity_SHBg, tmpvar_35);
  x1_34.z = dot (unity_SHBb, tmpvar_35);
  ambient_33 = ((tmpvar_3 * (
    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_34 + (unity_SHC.xyz * 
    ((normal_32.x * normal_32.x) - (normal_32.y * normal_32.y))
  )));
  tmpvar_3 = ambient_33;
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ambient_33;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, tmpvar_2, vec3(tmpvar_12));
  c_1.w = 1.0;
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
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 107334
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 vNormal_4;
  mediump vec3 viewDir_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = normalize((_WorldSpaceCameraPos - tmpvar_7.xyz));
  viewDir_5 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((unity_ObjectToWorld * tmpvar_8).xyz);
  vNormal_4 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_10.y = (((
    dot (vNormal_4, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_10;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_12));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 vNormal_4;
  mediump vec3 viewDir_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = normalize((_WorldSpaceCameraPos - tmpvar_7.xyz));
  viewDir_5 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((unity_ObjectToWorld * tmpvar_8).xyz);
  vNormal_4 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_10.y = (((
    dot (vNormal_4, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_10;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_12));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 vNormal_4;
  mediump vec3 viewDir_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = normalize((_WorldSpaceCameraPos - tmpvar_7.xyz));
  viewDir_5 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((unity_ObjectToWorld * tmpvar_8).xyz);
  vNormal_4 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_10.y = (((
    dot (vNormal_4, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_10;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_12));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 vNormal_4;
  mediump vec3 viewDir_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = normalize((_WorldSpaceCameraPos - tmpvar_7.xyz));
  viewDir_5 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((unity_ObjectToWorld * tmpvar_8).xyz);
  vNormal_4 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_10.y = (((
    dot (vNormal_4, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_10;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_12));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 vNormal_4;
  mediump vec3 viewDir_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = normalize((_WorldSpaceCameraPos - tmpvar_7.xyz));
  viewDir_5 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((unity_ObjectToWorld * tmpvar_8).xyz);
  vNormal_4 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_10.y = (((
    dot (vNormal_4, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_10;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_12));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 vNormal_4;
  mediump vec3 viewDir_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = normalize((_WorldSpaceCameraPos - tmpvar_7.xyz));
  viewDir_5 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((unity_ObjectToWorld * tmpvar_8).xyz);
  vNormal_4 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_10.y = (((
    dot (vNormal_4, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_10;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_12));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 vNormal_4;
  mediump vec3 viewDir_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = normalize((_WorldSpaceCameraPos - tmpvar_7.xyz));
  viewDir_5 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((unity_ObjectToWorld * tmpvar_8).xyz);
  vNormal_4 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_10.y = (((
    dot (vNormal_4, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_10;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_11.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 vNormal_4;
  mediump vec3 viewDir_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = normalize((_WorldSpaceCameraPos - tmpvar_7.xyz));
  viewDir_5 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((unity_ObjectToWorld * tmpvar_8).xyz);
  vNormal_4 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_10.y = (((
    dot (vNormal_4, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_10;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_11.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 vNormal_4;
  mediump vec3 viewDir_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = normalize((_WorldSpaceCameraPos - tmpvar_7.xyz));
  viewDir_5 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((unity_ObjectToWorld * tmpvar_8).xyz);
  vNormal_4 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_10.y = (((
    dot (vNormal_4, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_10;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_11.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 vNormal_4;
  mediump vec3 viewDir_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = normalize((_WorldSpaceCameraPos - tmpvar_7.xyz));
  viewDir_5 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((unity_ObjectToWorld * tmpvar_8).xyz);
  vNormal_4 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_10.y = (((
    dot (vNormal_4, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_10;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_11.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 vNormal_4;
  mediump vec3 viewDir_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = normalize((_WorldSpaceCameraPos - tmpvar_7.xyz));
  viewDir_5 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((unity_ObjectToWorld * tmpvar_8).xyz);
  vNormal_4 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_10.y = (((
    dot (vNormal_4, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_10;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_11.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 vNormal_4;
  mediump vec3 viewDir_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = normalize((_WorldSpaceCameraPos - tmpvar_7.xyz));
  viewDir_5 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((unity_ObjectToWorld * tmpvar_8).xyz);
  vNormal_4 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_10.y = (((
    dot (vNormal_4, _WorldSpaceLightPos0.xyz)
   * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_10;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_11.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = 1.0;
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
  Name "DEFERRED"
  Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
  GpuProgramID 194147
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_16));
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  mediump vec4 tex2_4;
  mediump vec4 tex1_5;
  mediump vec4 brdf_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = ((_GymRimTop.xyz * brdf_6.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (tex1_5, tex2_4, vec4(_BlendAmount));
  mediump vec3 tmpvar_12;
  tmpvar_12 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_6.yyy) + (
    (_GymRimBottom.xyz * brdf_6.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_3 = (((tmpvar_11.xyz * 
    (tmpvar_12 + (tmpvar_10 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  mediump vec4 emission_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = tmpvar_2;
  mediump vec4 outGBuffer2_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = 1.0;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = 0.0;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = ((tmpvar_14 * 0.5) + 0.5);
  outGBuffer2_15 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_3;
  emission_13 = tmpvar_19;
  emission_13.xyz = emission_13.xyz;
  outEmission_1.w = emission_13.w;
  outEmission_1.xyz = exp2(-(emission_13.xyz));
  gl_FragData[0] = tmpvar_16;
  gl_FragData[1] = tmpvar_17;
  gl_FragData[2] = outGBuffer2_15;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_16));
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  mediump vec4 tex2_4;
  mediump vec4 tex1_5;
  mediump vec4 brdf_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = ((_GymRimTop.xyz * brdf_6.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (tex1_5, tex2_4, vec4(_BlendAmount));
  mediump vec3 tmpvar_12;
  tmpvar_12 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_6.yyy) + (
    (_GymRimBottom.xyz * brdf_6.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_3 = (((tmpvar_11.xyz * 
    (tmpvar_12 + (tmpvar_10 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  mediump vec4 emission_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = tmpvar_2;
  mediump vec4 outGBuffer2_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = 1.0;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = 0.0;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = ((tmpvar_14 * 0.5) + 0.5);
  outGBuffer2_15 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_3;
  emission_13 = tmpvar_19;
  emission_13.xyz = emission_13.xyz;
  outEmission_1.w = emission_13.w;
  outEmission_1.xyz = exp2(-(emission_13.xyz));
  gl_FragData[0] = tmpvar_16;
  gl_FragData[1] = tmpvar_17;
  gl_FragData[2] = outGBuffer2_15;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_16));
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  mediump vec4 tex2_4;
  mediump vec4 tex1_5;
  mediump vec4 brdf_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = ((_GymRimTop.xyz * brdf_6.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (tex1_5, tex2_4, vec4(_BlendAmount));
  mediump vec3 tmpvar_12;
  tmpvar_12 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_6.yyy) + (
    (_GymRimBottom.xyz * brdf_6.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_3 = (((tmpvar_11.xyz * 
    (tmpvar_12 + (tmpvar_10 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  mediump vec4 emission_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = tmpvar_2;
  mediump vec4 outGBuffer2_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = 1.0;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = 0.0;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = ((tmpvar_14 * 0.5) + 0.5);
  outGBuffer2_15 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_3;
  emission_13 = tmpvar_19;
  emission_13.xyz = emission_13.xyz;
  outEmission_1.w = emission_13.w;
  outEmission_1.xyz = exp2(-(emission_13.xyz));
  gl_FragData[0] = tmpvar_16;
  gl_FragData[1] = tmpvar_17;
  gl_FragData[2] = outGBuffer2_15;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_glesNormal * tmpvar_16));
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  mediump vec3 normal_18;
  normal_18 = tmpvar_17;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normal_18;
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  mediump vec3 x1_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_18.xyzz * normal_18.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((normal_18.x * normal_18.x) - (normal_18.y * normal_18.y))
  )));
  mediump vec3 tmpvar_24;
  tmpvar_24 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_24;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  mediump vec4 tex2_4;
  mediump vec4 tex1_5;
  mediump vec4 brdf_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = ((_GymRimTop.xyz * brdf_6.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (tex1_5, tex2_4, vec4(_BlendAmount));
  mediump vec3 tmpvar_12;
  tmpvar_12 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_6.yyy) + (
    (_GymRimBottom.xyz * brdf_6.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_3 = (((tmpvar_11.xyz * 
    (tmpvar_12 + (tmpvar_10 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  mediump vec4 emission_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = tmpvar_2;
  mediump vec4 outGBuffer2_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = 1.0;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = 0.0;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = ((tmpvar_14 * 0.5) + 0.5);
  outGBuffer2_15 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_3;
  emission_13 = tmpvar_19;
  emission_13.xyz = emission_13.xyz;
  outEmission_1.w = emission_13.w;
  outEmission_1.xyz = exp2(-(emission_13.xyz));
  gl_FragData[0] = tmpvar_16;
  gl_FragData[1] = tmpvar_17;
  gl_FragData[2] = outGBuffer2_15;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_glesNormal * tmpvar_16));
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  mediump vec3 normal_18;
  normal_18 = tmpvar_17;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normal_18;
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  mediump vec3 x1_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_18.xyzz * normal_18.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((normal_18.x * normal_18.x) - (normal_18.y * normal_18.y))
  )));
  mediump vec3 tmpvar_24;
  tmpvar_24 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_24;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  mediump vec4 tex2_4;
  mediump vec4 tex1_5;
  mediump vec4 brdf_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = ((_GymRimTop.xyz * brdf_6.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (tex1_5, tex2_4, vec4(_BlendAmount));
  mediump vec3 tmpvar_12;
  tmpvar_12 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_6.yyy) + (
    (_GymRimBottom.xyz * brdf_6.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_3 = (((tmpvar_11.xyz * 
    (tmpvar_12 + (tmpvar_10 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  mediump vec4 emission_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = tmpvar_2;
  mediump vec4 outGBuffer2_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = 1.0;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = 0.0;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = ((tmpvar_14 * 0.5) + 0.5);
  outGBuffer2_15 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_3;
  emission_13 = tmpvar_19;
  emission_13.xyz = emission_13.xyz;
  outEmission_1.w = emission_13.w;
  outEmission_1.xyz = exp2(-(emission_13.xyz));
  gl_FragData[0] = tmpvar_16;
  gl_FragData[1] = tmpvar_17;
  gl_FragData[2] = outGBuffer2_15;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_glesNormal * tmpvar_16));
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  mediump vec3 normal_18;
  normal_18 = tmpvar_17;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normal_18;
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  mediump vec3 x1_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_18.xyzz * normal_18.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((normal_18.x * normal_18.x) - (normal_18.y * normal_18.y))
  )));
  mediump vec3 tmpvar_24;
  tmpvar_24 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_24;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  mediump vec4 tex2_4;
  mediump vec4 tex1_5;
  mediump vec4 brdf_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = ((_GymRimTop.xyz * brdf_6.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (tex1_5, tex2_4, vec4(_BlendAmount));
  mediump vec3 tmpvar_12;
  tmpvar_12 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_6.yyy) + (
    (_GymRimBottom.xyz * brdf_6.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_3 = (((tmpvar_11.xyz * 
    (tmpvar_12 + (tmpvar_10 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  mediump vec4 emission_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = tmpvar_2;
  mediump vec4 outGBuffer2_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = 1.0;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_17.w = 0.0;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = ((tmpvar_14 * 0.5) + 0.5);
  outGBuffer2_15 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_3;
  emission_13 = tmpvar_19;
  emission_13.xyz = emission_13.xyz;
  outEmission_1.w = emission_13.w;
  outEmission_1.xyz = exp2(-(emission_13.xyz));
  gl_FragData[0] = tmpvar_16;
  gl_FragData[1] = tmpvar_17;
  gl_FragData[2] = outGBuffer2_15;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_glesNormal * tmpvar_16));
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  mediump vec3 normal_18;
  normal_18 = tmpvar_17;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normal_18;
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  mediump vec3 x1_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_18.xyzz * normal_18.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((normal_18.x * normal_18.x) - (normal_18.y * normal_18.y))
  )));
  mediump vec3 tmpvar_24;
  tmpvar_24 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_24;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  mediump vec4 emission_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = tmpvar_1;
  mediump vec4 outGBuffer2_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = 1.0;
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = 0.0;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_13 * 0.5) + 0.5);
  outGBuffer2_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_2;
  emission_12 = tmpvar_18;
  emission_12.xyz = emission_12.xyz;
  gl_FragData[0] = tmpvar_15;
  gl_FragData[1] = tmpvar_16;
  gl_FragData[2] = outGBuffer2_14;
  gl_FragData[3] = emission_12;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_glesNormal * tmpvar_16));
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  mediump vec3 normal_18;
  normal_18 = tmpvar_17;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normal_18;
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  mediump vec3 x1_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_18.xyzz * normal_18.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((normal_18.x * normal_18.x) - (normal_18.y * normal_18.y))
  )));
  mediump vec3 tmpvar_24;
  tmpvar_24 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_24;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  mediump vec4 emission_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = tmpvar_1;
  mediump vec4 outGBuffer2_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = 1.0;
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = 0.0;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_13 * 0.5) + 0.5);
  outGBuffer2_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_2;
  emission_12 = tmpvar_18;
  emission_12.xyz = emission_12.xyz;
  gl_FragData[0] = tmpvar_15;
  gl_FragData[1] = tmpvar_16;
  gl_FragData[2] = outGBuffer2_14;
  gl_FragData[3] = emission_12;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = 1.0;
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_glesNormal * tmpvar_16));
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  mediump vec3 normal_18;
  normal_18 = tmpvar_17;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normal_18;
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  mediump vec3 x1_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_18.xyzz * normal_18.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((normal_18.x * normal_18.x) - (normal_18.y * normal_18.y))
  )));
  mediump vec3 tmpvar_24;
  tmpvar_24 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_24;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform lowp float _BlendAmount;
uniform sampler2D _Ramp2D;
uniform mediump float _GymBrdfAmount;
uniform mediump float _GymRimMultiply;
uniform mediump vec4 _GymDiffuse;
uniform mediump vec4 _GymAmbient;
uniform mediump vec4 _GymRimTop;
uniform mediump vec4 _GymRimBottom;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_2;
  mediump vec4 tex2_3;
  mediump vec4 tex1_4;
  mediump vec4 brdf_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BlendTex, xlv_TEXCOORD0);
  tex2_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((_GymRimTop.xyz * brdf_5.x) * (_GymRimTop.w * 2.0));
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tex1_4, tex2_3, vec4(_BlendAmount));
  mediump vec3 tmpvar_11;
  tmpvar_11 = clamp ((mix (_GymAmbient.xyz, _GymDiffuse.xyz, brdf_5.yyy) + (
    (_GymRimBottom.xyz * brdf_5.w)
   * 
    (_GymRimBottom.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_2 = (((tmpvar_10.xyz * 
    (tmpvar_11 + (tmpvar_9 * _GymRimMultiply))
  ) * _GymBrdfAmount) * xlv_TEXCOORD3.z);
  mediump vec4 emission_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = tmpvar_1;
  mediump vec4 outGBuffer2_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = 1.0;
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_16.w = 0.0;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_13 * 0.5) + 0.5);
  outGBuffer2_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_2;
  emission_12 = tmpvar_18;
  emission_12.xyz = emission_12.xyz;
  gl_FragData[0] = tmpvar_15;
  gl_FragData[1] = tmpvar_16;
  gl_FragData[2] = outGBuffer2_14;
  gl_FragData[3] = emission_12;
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
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE" = "SHADOWCASTER" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 261044
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec3 tmpvar_13;
  tmpvar_13 = tmpvar_8.xyz;
  highp vec4 tmpvar_14;
  highp vec4 wPos_15;
  wPos_15 = tmpvar_8;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((_glesNormal * tmpvar_16));
    highp float tmpvar_18;
    tmpvar_18 = dot (tmpvar_17, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_8.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_15.xyz = (tmpvar_8.xyz - (tmpvar_17 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_18 * tmpvar_18)))
    )));
  };
  tmpvar_14 = (unity_MatrixVP * wPos_15);
  highp vec4 clipPos_19;
  clipPos_19.xyw = tmpvar_14.xyw;
  clipPos_19.z = (tmpvar_14.z + clamp ((unity_LightShadowBias.x / tmpvar_14.w), 0.0, 1.0));
  clipPos_19.z = mix (clipPos_19.z, max (clipPos_19.z, -(tmpvar_14.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_19;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec3 tmpvar_13;
  tmpvar_13 = tmpvar_8.xyz;
  highp vec4 tmpvar_14;
  highp vec4 wPos_15;
  wPos_15 = tmpvar_8;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((_glesNormal * tmpvar_16));
    highp float tmpvar_18;
    tmpvar_18 = dot (tmpvar_17, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_8.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_15.xyz = (tmpvar_8.xyz - (tmpvar_17 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_18 * tmpvar_18)))
    )));
  };
  tmpvar_14 = (unity_MatrixVP * wPos_15);
  highp vec4 clipPos_19;
  clipPos_19.xyw = tmpvar_14.xyw;
  clipPos_19.z = (tmpvar_14.z + clamp ((unity_LightShadowBias.x / tmpvar_14.w), 0.0, 1.0));
  clipPos_19.z = mix (clipPos_19.z, max (clipPos_19.z, -(tmpvar_14.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_19;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec3 tmpvar_13;
  tmpvar_13 = tmpvar_8.xyz;
  highp vec4 tmpvar_14;
  highp vec4 wPos_15;
  wPos_15 = tmpvar_8;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((_glesNormal * tmpvar_16));
    highp float tmpvar_18;
    tmpvar_18 = dot (tmpvar_17, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_8.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_15.xyz = (tmpvar_8.xyz - (tmpvar_17 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_18 * tmpvar_18)))
    )));
  };
  tmpvar_14 = (unity_MatrixVP * wPos_15);
  highp vec4 clipPos_19;
  clipPos_19.xyw = tmpvar_14.xyw;
  clipPos_19.z = (tmpvar_14.z + clamp ((unity_LightShadowBias.x / tmpvar_14.w), 0.0, 1.0));
  clipPos_19.z = mix (clipPos_19.z, max (clipPos_19.z, -(tmpvar_14.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_19;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_8.xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_8.xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = 1.0;
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_8.xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
}
}