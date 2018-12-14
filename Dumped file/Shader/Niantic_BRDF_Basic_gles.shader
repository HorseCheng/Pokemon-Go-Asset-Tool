Shader "Niantic/BRDF/Basic" {
Properties {
_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
_Ramp2D ("BRDF Ramp", 2D) = "grey" { }
_Amount_Blend ("BRDF Amount", Range(0, 2)) = 1
_Amount_Wrap ("Lambert Wrap Amount", Range(0, 1)) = 0
_cTint ("Tint", Color) = (0,0,0,0.5)
_cDiff ("Diffuse", Color) = (1,1,1,0.5)
_cAmbn ("Ambient", Color) = (0,0,0,0.5)
_cKeyf ("Specular (.a=0.5)", Color) = (1,1,1,0.5)
_cRimt ("RimTop   (.a=0.5)", Color) = (1,1,0,0.5)
_cRimb ("RimBottom(.a=0.5)", Color) = (0,0,1,0.5)
_Amount_RimLt ("RimLight Mult", Range(0, 2)) = 1
_vAmOc ("vAmbOcclusion", Color) = (0,0,0,1)
_cOverride ("Color override (rgb = color, a = blend)", Color) = (0,0,0,0)
[Header(STENCIL_ID_TO_CONTROL_SORTING_SPECIAL_FX)] _Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare Function", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling", Float) = 2
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  Cull Off
  GpuProgramID 58382
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8 * tmpvar_1) * diff_16);
  c_15.w = 0.0;
  c_3.xyz = (c_15.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8 * tmpvar_1) * diff_16);
  c_15.w = 0.0;
  c_3.xyz = (c_15.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8 * tmpvar_1) * diff_16);
  c_15.w = 0.0;
  c_3.xyz = (c_15.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), tmpvar_22);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8 * tmpvar_1) * diff_16);
  c_15.w = 0.0;
  c_3.xyz = (c_15.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), tmpvar_22);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8 * tmpvar_1) * diff_16);
  c_15.w = 0.0;
  c_3.xyz = (c_15.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), tmpvar_22);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8 * tmpvar_1) * diff_16);
  c_15.w = 0.0;
  c_3.xyz = (c_15.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp float diff_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_31 = tmpvar_32;
  c_30.xyz = ((tmpvar_10 * tmpvar_29) * diff_31);
  c_30.w = 0.0;
  c_4.xyz = (c_30.xyz + tmpvar_11);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp float diff_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_31 = tmpvar_32;
  c_30.xyz = ((tmpvar_10 * tmpvar_29) * diff_31);
  c_30.w = 0.0;
  c_4.xyz = (c_30.xyz + tmpvar_11);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp float diff_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_31 = tmpvar_32;
  c_30.xyz = ((tmpvar_10 * tmpvar_29) * diff_31);
  c_30.w = 0.0;
  c_4.xyz = (c_30.xyz + tmpvar_11);
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  mediump vec3 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_17.xyzz * normal_17.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (x1_18 + (unity_SHC.xyz * (
    (normal_17.x * normal_17.x)
   - 
    (normal_17.y * normal_17.y)
  )));
  xlv_TEXCOORD6 = tmpvar_3;
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp float diff_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_31 = tmpvar_32;
  c_30.xyz = ((tmpvar_10 * tmpvar_29) * diff_31);
  c_30.w = 0.0;
  c_4.xyz = (c_30.xyz + tmpvar_11);
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  mediump vec3 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_17.xyzz * normal_17.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (x1_18 + (unity_SHC.xyz * (
    (normal_17.x * normal_17.x)
   - 
    (normal_17.y * normal_17.y)
  )));
  xlv_TEXCOORD6 = tmpvar_3;
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp float diff_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_31 = tmpvar_32;
  c_30.xyz = ((tmpvar_10 * tmpvar_29) * diff_31);
  c_30.w = 0.0;
  c_4.xyz = (c_30.xyz + tmpvar_11);
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  mediump vec3 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_17.xyzz * normal_17.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (x1_18 + (unity_SHC.xyz * (
    (normal_17.x * normal_17.x)
   - 
    (normal_17.y * normal_17.y)
  )));
  xlv_TEXCOORD6 = tmpvar_3;
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp float diff_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_31 = tmpvar_32;
  c_30.xyz = ((tmpvar_10 * tmpvar_29) * diff_31);
  c_30.w = 0.0;
  c_4.xyz = (c_30.xyz + tmpvar_11);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8 * tmpvar_1) * diff_16);
  c_15.w = 0.0;
  c_3.xyz = (c_15.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8 * tmpvar_1) * diff_16);
  c_15.w = 0.0;
  c_3.xyz = (c_15.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8 * tmpvar_1) * diff_16);
  c_15.w = 0.0;
  c_3.xyz = (c_15.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = ambient_32;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8 * tmpvar_1) * diff_16);
  c_15.w = 0.0;
  c_3.xyz = (c_15.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = ambient_32;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8 * tmpvar_1) * diff_16);
  c_15.w = 0.0;
  c_3.xyz = (c_15.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = ambient_32;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8 * tmpvar_1) * diff_16);
  c_15.w = 0.0;
  c_3.xyz = (c_15.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp float diff_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_31 = tmpvar_32;
  c_30.xyz = ((tmpvar_10 * tmpvar_29) * diff_31);
  c_30.w = 0.0;
  c_4.xyz = (c_30.xyz + tmpvar_11);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp float diff_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_31 = tmpvar_32;
  c_30.xyz = ((tmpvar_10 * tmpvar_29) * diff_31);
  c_30.w = 0.0;
  c_4.xyz = (c_30.xyz + tmpvar_11);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_15));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp float diff_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_31 = tmpvar_32;
  c_30.xyz = ((tmpvar_10 * tmpvar_29) * diff_31);
  c_30.w = 0.0;
  c_4.xyz = (c_30.xyz + tmpvar_11);
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_5;
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ambient_33;
  xlv_TEXCOORD6 = tmpvar_4;
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp float diff_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_31 = tmpvar_32;
  c_30.xyz = ((tmpvar_10 * tmpvar_29) * diff_31);
  c_30.w = 0.0;
  c_4.xyz = (c_30.xyz + tmpvar_11);
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_5;
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ambient_33;
  xlv_TEXCOORD6 = tmpvar_4;
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp float diff_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_31 = tmpvar_32;
  c_30.xyz = ((tmpvar_10 * tmpvar_29) * diff_31);
  c_30.w = 0.0;
  c_4.xyz = (c_30.xyz + tmpvar_11);
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_5;
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ambient_33;
  xlv_TEXCOORD6 = tmpvar_4;
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp float diff_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_31 = tmpvar_32;
  c_30.xyz = ((tmpvar_10 * tmpvar_29) * diff_31);
  c_30.w = 0.0;
  c_4.xyz = (c_30.xyz + tmpvar_11);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  c_15.w = c_16.w;
  c_15.xyz = c_16.xyz;
  c_3.w = c_15.w;
  c_3.xyz = (c_16.xyz + tmpvar_9);
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_19));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  c_15.w = c_16.w;
  c_15.xyz = c_16.xyz;
  c_3.w = c_15.w;
  c_3.xyz = (c_16.xyz + tmpvar_9);
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_19));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  c_15.w = c_16.w;
  c_15.xyz = c_16.xyz;
  c_3.w = c_15.w;
  c_3.xyz = (c_16.xyz + tmpvar_9);
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_19));
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  mediump vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = normal_17;
  mediump vec3 res_19;
  mediump vec3 x_20;
  x_20.x = dot (unity_SHAr, tmpvar_18);
  x_20.y = dot (unity_SHAg, tmpvar_18);
  x_20.z = dot (unity_SHAb, tmpvar_18);
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normal_17.xyzz * normal_17.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  res_19 = (x_20 + (x1_21 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_23;
  tmpvar_23 = max (((1.055 * 
    pow (max (res_19, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_19 = tmpvar_23;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), tmpvar_23);
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  c_15.w = c_16.w;
  c_15.xyz = c_16.xyz;
  c_3.w = c_15.w;
  c_3.xyz = (c_16.xyz + tmpvar_9);
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_19));
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  mediump vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = normal_17;
  mediump vec3 res_19;
  mediump vec3 x_20;
  x_20.x = dot (unity_SHAr, tmpvar_18);
  x_20.y = dot (unity_SHAg, tmpvar_18);
  x_20.z = dot (unity_SHAb, tmpvar_18);
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normal_17.xyzz * normal_17.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  res_19 = (x_20 + (x1_21 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_23;
  tmpvar_23 = max (((1.055 * 
    pow (max (res_19, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_19 = tmpvar_23;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), tmpvar_23);
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  c_15.w = c_16.w;
  c_15.xyz = c_16.xyz;
  c_3.w = c_15.w;
  c_3.xyz = (c_16.xyz + tmpvar_9);
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_19));
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  mediump vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = normal_17;
  mediump vec3 res_19;
  mediump vec3 x_20;
  x_20.x = dot (unity_SHAr, tmpvar_18);
  x_20.y = dot (unity_SHAg, tmpvar_18);
  x_20.z = dot (unity_SHAb, tmpvar_18);
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normal_17.xyzz * normal_17.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  res_19 = (x_20 + (x1_21 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_23;
  tmpvar_23 = max (((1.055 * 
    pow (max (res_19, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_19 = tmpvar_23;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), tmpvar_23);
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  c_15.w = c_16.w;
  c_15.xyz = c_16.xyz;
  c_3.w = c_15.w;
  c_3.xyz = (c_16.xyz + tmpvar_9);
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_19));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_16));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp vec4 c_31;
  lowp float diff_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_32 = tmpvar_33;
  c_31.xyz = ((tmpvar_10 * tmpvar_29) * diff_32);
  c_31.w = 0.0;
  c_30.w = c_31.w;
  c_30.xyz = c_31.xyz;
  c_4.w = c_30.w;
  c_4.xyz = (c_31.xyz + tmpvar_11);
  highp float tmpvar_34;
  tmpvar_34 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_34));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_16));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp vec4 c_31;
  lowp float diff_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_32 = tmpvar_33;
  c_31.xyz = ((tmpvar_10 * tmpvar_29) * diff_32);
  c_31.w = 0.0;
  c_30.w = c_31.w;
  c_30.xyz = c_31.xyz;
  c_4.w = c_30.w;
  c_4.xyz = (c_31.xyz + tmpvar_11);
  highp float tmpvar_34;
  tmpvar_34 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_34));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_16));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp vec4 c_31;
  lowp float diff_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_32 = tmpvar_33;
  c_31.xyz = ((tmpvar_10 * tmpvar_29) * diff_32);
  c_31.w = 0.0;
  c_30.w = c_31.w;
  c_30.xyz = c_31.xyz;
  c_4.w = c_30.w;
  c_4.xyz = (c_31.xyz + tmpvar_11);
  highp float tmpvar_34;
  tmpvar_34 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_34));
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  mediump vec3 normal_18;
  normal_18 = tmpvar_17;
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_18.xyzz * normal_18.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (x1_19 + (unity_SHC.xyz * (
    (normal_18.x * normal_18.x)
   - 
    (normal_18.y * normal_18.y)
  )));
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp vec4 c_31;
  lowp float diff_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_32 = tmpvar_33;
  c_31.xyz = ((tmpvar_10 * tmpvar_29) * diff_32);
  c_31.w = 0.0;
  c_30.w = c_31.w;
  c_30.xyz = c_31.xyz;
  c_4.w = c_30.w;
  c_4.xyz = (c_31.xyz + tmpvar_11);
  highp float tmpvar_34;
  tmpvar_34 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_34));
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  mediump vec3 normal_18;
  normal_18 = tmpvar_17;
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_18.xyzz * normal_18.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (x1_19 + (unity_SHC.xyz * (
    (normal_18.x * normal_18.x)
   - 
    (normal_18.y * normal_18.y)
  )));
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp vec4 c_31;
  lowp float diff_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_32 = tmpvar_33;
  c_31.xyz = ((tmpvar_10 * tmpvar_29) * diff_32);
  c_31.w = 0.0;
  c_30.w = c_31.w;
  c_30.xyz = c_31.xyz;
  c_4.w = c_30.w;
  c_4.xyz = (c_31.xyz + tmpvar_11);
  highp float tmpvar_34;
  tmpvar_34 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_34));
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  mediump vec3 normal_18;
  normal_18 = tmpvar_17;
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_18.xyzz * normal_18.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (x1_19 + (unity_SHC.xyz * (
    (normal_18.x * normal_18.x)
   - 
    (normal_18.y * normal_18.y)
  )));
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp vec4 c_31;
  lowp float diff_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_32 = tmpvar_33;
  c_31.xyz = ((tmpvar_10 * tmpvar_29) * diff_32);
  c_31.w = 0.0;
  c_30.w = c_31.w;
  c_30.xyz = c_31.xyz;
  c_4.w = c_30.w;
  c_4.xyz = (c_31.xyz + tmpvar_11);
  highp float tmpvar_34;
  tmpvar_34 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_34));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  c_15.w = c_16.w;
  c_15.xyz = c_16.xyz;
  c_3.w = c_15.w;
  c_3.xyz = (c_16.xyz + tmpvar_9);
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_19));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  c_15.w = c_16.w;
  c_15.xyz = c_16.xyz;
  c_3.w = c_15.w;
  c_3.xyz = (c_16.xyz + tmpvar_9);
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_19));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((tmpvar_11 * 0.5) + 0.5) * 0.9);
  tmpvar_3.x = ((tmpvar_11 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_3.y = 1.0;
  tmpvar_2.xy = tmpvar_12;
  tmpvar_2.zw = tmpvar_3;
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
  xlv_TEXCOORD2 = tmpvar_8.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_13.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  c_15.w = c_16.w;
  c_15.xyz = c_16.xyz;
  c_3.w = c_15.w;
  c_3.xyz = (c_16.xyz + tmpvar_9);
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_19));
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_9.z);
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
  mediump vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = normal_32;
  mediump vec3 res_35;
  mediump vec3 x_36;
  x_36.x = dot (unity_SHAr, tmpvar_34);
  x_36.y = dot (unity_SHAg, tmpvar_34);
  x_36.z = dot (unity_SHAb, tmpvar_34);
  mediump vec3 x1_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normal_32.xyzz * normal_32.yzzx);
  x1_37.x = dot (unity_SHBr, tmpvar_38);
  x1_37.y = dot (unity_SHBg, tmpvar_38);
  x1_37.z = dot (unity_SHBb, tmpvar_38);
  res_35 = (x_36 + (x1_37 + (unity_SHC.xyz * 
    ((normal_32.x * normal_32.x) - (normal_32.y * normal_32.y))
  )));
  mediump vec3 tmpvar_39;
  tmpvar_39 = max (((1.055 * 
    pow (max (res_35, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_35 = tmpvar_39;
  ambient_33 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_39));
  tmpvar_3 = ambient_33;
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = ambient_33;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  c_15.w = c_16.w;
  c_15.xyz = c_16.xyz;
  c_3.w = c_15.w;
  c_3.xyz = (c_16.xyz + tmpvar_9);
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_19));
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_9.z);
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
  mediump vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = normal_32;
  mediump vec3 res_35;
  mediump vec3 x_36;
  x_36.x = dot (unity_SHAr, tmpvar_34);
  x_36.y = dot (unity_SHAg, tmpvar_34);
  x_36.z = dot (unity_SHAb, tmpvar_34);
  mediump vec3 x1_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normal_32.xyzz * normal_32.yzzx);
  x1_37.x = dot (unity_SHBr, tmpvar_38);
  x1_37.y = dot (unity_SHBg, tmpvar_38);
  x1_37.z = dot (unity_SHBb, tmpvar_38);
  res_35 = (x_36 + (x1_37 + (unity_SHC.xyz * 
    ((normal_32.x * normal_32.x) - (normal_32.y * normal_32.y))
  )));
  mediump vec3 tmpvar_39;
  tmpvar_39 = max (((1.055 * 
    pow (max (res_35, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_35 = tmpvar_39;
  ambient_33 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_39));
  tmpvar_3 = ambient_33;
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = ambient_33;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  c_15.w = c_16.w;
  c_15.xyz = c_16.xyz;
  c_3.w = c_15.w;
  c_3.xyz = (c_16.xyz + tmpvar_9);
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_19));
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_9.z);
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
  mediump vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = normal_32;
  mediump vec3 res_35;
  mediump vec3 x_36;
  x_36.x = dot (unity_SHAr, tmpvar_34);
  x_36.y = dot (unity_SHAg, tmpvar_34);
  x_36.z = dot (unity_SHAb, tmpvar_34);
  mediump vec3 x1_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normal_32.xyzz * normal_32.yzzx);
  x1_37.x = dot (unity_SHBr, tmpvar_38);
  x1_37.y = dot (unity_SHBg, tmpvar_38);
  x1_37.z = dot (unity_SHBb, tmpvar_38);
  res_35 = (x_36 + (x1_37 + (unity_SHC.xyz * 
    ((normal_32.x * normal_32.x) - (normal_32.y * normal_32.y))
  )));
  mediump vec3 tmpvar_39;
  tmpvar_39 = max (((1.055 * 
    pow (max (res_35, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_35 = tmpvar_39;
  ambient_33 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_39));
  tmpvar_3 = ambient_33;
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = ambient_33;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_6.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_9 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  c_15.w = c_16.w;
  c_15.xyz = c_16.xyz;
  c_3.w = c_15.w;
  c_3.xyz = (c_16.xyz + tmpvar_9);
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_19));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_16));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp vec4 c_31;
  lowp float diff_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_32 = tmpvar_33;
  c_31.xyz = ((tmpvar_10 * tmpvar_29) * diff_32);
  c_31.w = 0.0;
  c_30.w = c_31.w;
  c_30.xyz = c_31.xyz;
  c_4.w = c_30.w;
  c_4.xyz = (c_31.xyz + tmpvar_11);
  highp float tmpvar_34;
  tmpvar_34 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_34));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_16));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp vec4 c_31;
  lowp float diff_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_32 = tmpvar_33;
  c_31.xyz = ((tmpvar_10 * tmpvar_29) * diff_32);
  c_31.w = 0.0;
  c_30.w = c_31.w;
  c_30.xyz = c_31.xyz;
  c_4.w = c_30.w;
  c_4.xyz = (c_31.xyz + tmpvar_11);
  highp float tmpvar_34;
  tmpvar_34 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_34));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_2.xy = tmpvar_13;
  tmpvar_2.zw = tmpvar_4;
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
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_16));
  xlv_TEXCOORD2 = tmpvar_9.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp vec4 c_31;
  lowp float diff_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_32 = tmpvar_33;
  c_31.xyz = ((tmpvar_10 * tmpvar_29) * diff_32);
  c_31.w = 0.0;
  c_30.w = c_31.w;
  c_30.xyz = c_31.xyz;
  c_4.w = c_30.w;
  c_4.xyz = (c_31.xyz + tmpvar_11);
  highp float tmpvar_34;
  tmpvar_34 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_34));
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  highp vec3 lightColor0_19;
  lightColor0_19 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_20;
  lightColor1_20 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_21;
  lightColor2_21 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_22;
  lightColor3_22 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_23;
  lightAttenSq_23 = unity_4LightAtten0;
  highp vec3 col_24;
  highp vec4 ndotl_25;
  highp vec4 lengthSq_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_26 = (tmpvar_27 * tmpvar_27);
  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
  highp vec4 tmpvar_30;
  tmpvar_30 = max (lengthSq_26, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_26 = tmpvar_30;
  ndotl_25 = (tmpvar_27 * tmpvar_18.x);
  ndotl_25 = (ndotl_25 + (tmpvar_28 * tmpvar_18.y));
  ndotl_25 = (ndotl_25 + (tmpvar_29 * tmpvar_18.z));
  highp vec4 tmpvar_31;
  tmpvar_31 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(tmpvar_30)));
  ndotl_25 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * (1.0/((1.0 + 
    (tmpvar_30 * lightAttenSq_23)
  ))));
  col_24 = (lightColor0_19 * tmpvar_32.x);
  col_24 = (col_24 + (lightColor1_20 * tmpvar_32.y));
  col_24 = (col_24 + (lightColor2_21 * tmpvar_32.z));
  col_24 = (col_24 + (lightColor3_22 * tmpvar_32.w));
  tmpvar_3 = col_24;
  mediump vec3 normal_33;
  normal_33 = tmpvar_18;
  mediump vec3 ambient_34;
  mediump vec3 x1_35;
  mediump vec4 tmpvar_36;
  tmpvar_36 = (normal_33.xyzz * normal_33.yzzx);
  x1_35.x = dot (unity_SHBr, tmpvar_36);
  x1_35.y = dot (unity_SHBg, tmpvar_36);
  x1_35.z = dot (unity_SHBb, tmpvar_36);
  ambient_34 = ((tmpvar_3 * (
    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_35 + (unity_SHC.xyz * 
    ((normal_33.x * normal_33.x) - (normal_33.y * normal_33.y))
  )));
  tmpvar_3 = ambient_34;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ambient_34;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp vec4 c_31;
  lowp float diff_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_32 = tmpvar_33;
  c_31.xyz = ((tmpvar_10 * tmpvar_29) * diff_32);
  c_31.w = 0.0;
  c_30.w = c_31.w;
  c_30.xyz = c_31.xyz;
  c_4.w = c_30.w;
  c_4.xyz = (c_31.xyz + tmpvar_11);
  highp float tmpvar_34;
  tmpvar_34 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_34));
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  highp vec3 lightColor0_19;
  lightColor0_19 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_20;
  lightColor1_20 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_21;
  lightColor2_21 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_22;
  lightColor3_22 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_23;
  lightAttenSq_23 = unity_4LightAtten0;
  highp vec3 col_24;
  highp vec4 ndotl_25;
  highp vec4 lengthSq_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_26 = (tmpvar_27 * tmpvar_27);
  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
  highp vec4 tmpvar_30;
  tmpvar_30 = max (lengthSq_26, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_26 = tmpvar_30;
  ndotl_25 = (tmpvar_27 * tmpvar_18.x);
  ndotl_25 = (ndotl_25 + (tmpvar_28 * tmpvar_18.y));
  ndotl_25 = (ndotl_25 + (tmpvar_29 * tmpvar_18.z));
  highp vec4 tmpvar_31;
  tmpvar_31 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(tmpvar_30)));
  ndotl_25 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * (1.0/((1.0 + 
    (tmpvar_30 * lightAttenSq_23)
  ))));
  col_24 = (lightColor0_19 * tmpvar_32.x);
  col_24 = (col_24 + (lightColor1_20 * tmpvar_32.y));
  col_24 = (col_24 + (lightColor2_21 * tmpvar_32.z));
  col_24 = (col_24 + (lightColor3_22 * tmpvar_32.w));
  tmpvar_3 = col_24;
  mediump vec3 normal_33;
  normal_33 = tmpvar_18;
  mediump vec3 ambient_34;
  mediump vec3 x1_35;
  mediump vec4 tmpvar_36;
  tmpvar_36 = (normal_33.xyzz * normal_33.yzzx);
  x1_35.x = dot (unity_SHBr, tmpvar_36);
  x1_35.y = dot (unity_SHBg, tmpvar_36);
  x1_35.z = dot (unity_SHBb, tmpvar_36);
  ambient_34 = ((tmpvar_3 * (
    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_35 + (unity_SHC.xyz * 
    ((normal_33.x * normal_33.x) - (normal_33.y * normal_33.y))
  )));
  tmpvar_3 = ambient_34;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ambient_34;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp vec4 c_31;
  lowp float diff_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_32 = tmpvar_33;
  c_31.xyz = ((tmpvar_10 * tmpvar_29) * diff_32);
  c_31.w = 0.0;
  c_30.w = c_31.w;
  c_30.xyz = c_31.xyz;
  c_4.w = c_30.w;
  c_4.xyz = (c_31.xyz + tmpvar_11);
  highp float tmpvar_34;
  tmpvar_34 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_34));
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_2.xy = tmpvar_14;
  tmpvar_2.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  highp vec3 lightColor0_19;
  lightColor0_19 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_20;
  lightColor1_20 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_21;
  lightColor2_21 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_22;
  lightColor3_22 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_23;
  lightAttenSq_23 = unity_4LightAtten0;
  highp vec3 col_24;
  highp vec4 ndotl_25;
  highp vec4 lengthSq_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_26 = (tmpvar_27 * tmpvar_27);
  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
  highp vec4 tmpvar_30;
  tmpvar_30 = max (lengthSq_26, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_26 = tmpvar_30;
  ndotl_25 = (tmpvar_27 * tmpvar_18.x);
  ndotl_25 = (ndotl_25 + (tmpvar_28 * tmpvar_18.y));
  ndotl_25 = (ndotl_25 + (tmpvar_29 * tmpvar_18.z));
  highp vec4 tmpvar_31;
  tmpvar_31 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(tmpvar_30)));
  ndotl_25 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * (1.0/((1.0 + 
    (tmpvar_30 * lightAttenSq_23)
  ))));
  col_24 = (lightColor0_19 * tmpvar_32.x);
  col_24 = (col_24 + (lightColor1_20 * tmpvar_32.y));
  col_24 = (col_24 + (lightColor2_21 * tmpvar_32.z));
  col_24 = (col_24 + (lightColor3_22 * tmpvar_32.w));
  tmpvar_3 = col_24;
  mediump vec3 normal_33;
  normal_33 = tmpvar_18;
  mediump vec3 ambient_34;
  mediump vec3 x1_35;
  mediump vec4 tmpvar_36;
  tmpvar_36 = (normal_33.xyzz * normal_33.yzzx);
  x1_35.x = dot (unity_SHBr, tmpvar_36);
  x1_35.y = dot (unity_SHBg, tmpvar_36);
  x1_35.z = dot (unity_SHBb, tmpvar_36);
  ambient_34 = ((tmpvar_3 * (
    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_35 + (unity_SHC.xyz * 
    ((normal_33.x * normal_33.x) - (normal_33.y * normal_33.y))
  )));
  tmpvar_3 = ambient_34;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ambient_34;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
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
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp float atten_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_6 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  mediump vec4 brdf_12;
  mediump vec4 tex_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_13 = tmpvar_14;
  tmpvar_10 = _cTint.xyz;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (((
    (tex_13.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_12.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_8.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_12.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_12.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_12.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_11 = tmpvar_16;
  mediump float realtimeShadowAttenuation_17;
  highp vec4 v_18;
  v_18.x = unity_MatrixV[0].z;
  v_18.y = unity_MatrixV[1].z;
  v_18.z = unity_MatrixV[2].z;
  v_18.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_18.xyz), sqrt(dot (tmpvar_19, tmpvar_19)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_23;
  highp vec4 shadowCoord_24;
  shadowCoord_24 = (unity_WorldToShadow[0] * tmpvar_22);
  highp float lightShadowDataX_25;
  mediump float tmpvar_26;
  tmpvar_26 = _LightShadowData.x;
  lightShadowDataX_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = max (float((texture2D (_ShadowMapTexture, shadowCoord_24.xy).x > shadowCoord_24.z)), lightShadowDataX_25);
  tmpvar_23 = tmpvar_27;
  realtimeShadowAttenuation_17 = tmpvar_23;
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((realtimeShadowAttenuation_17 + tmpvar_20), 0.0, 1.0);
  atten_5 = tmpvar_28;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_7;
  tmpvar_1 = atten_5;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_29;
  lowp vec4 c_30;
  lowp vec4 c_31;
  lowp float diff_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (tmpvar_6, tmpvar_3));
  diff_32 = tmpvar_33;
  c_31.xyz = ((tmpvar_10 * tmpvar_29) * diff_32);
  c_31.w = 0.0;
  c_30.w = c_31.w;
  c_30.xyz = c_31.xyz;
  c_4.w = c_30.w;
  c_4.xyz = (c_31.xyz + tmpvar_11);
  highp float tmpvar_34;
  tmpvar_34 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_34));
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
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  ZWrite Off
  Cull Off
  GpuProgramID 100761
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
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_13.xyz = ((tmpvar_9 * tmpvar_1) * diff_14);
  c_13.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_13.xyz = ((tmpvar_9 * tmpvar_1) * diff_14);
  c_13.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_13.xyz = ((tmpvar_9 * tmpvar_1) * diff_14);
  c_13.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
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
  mediump float tmpvar_10;
  tmpvar_10 = dot (vNormal_4, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_11.y = (((tmpvar_10 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((tmpvar_10 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_11;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7 * tmpvar_1) * diff_10);
  c_9.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
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
  mediump float tmpvar_10;
  tmpvar_10 = dot (vNormal_4, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_11.y = (((tmpvar_10 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((tmpvar_10 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_11;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7 * tmpvar_1) * diff_10);
  c_9.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
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
  mediump float tmpvar_10;
  tmpvar_10 = dot (vNormal_4, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_11.y = (((tmpvar_10 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((tmpvar_10 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_11;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7 * tmpvar_1) * diff_10);
  c_9.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_17.xyz = ((tmpvar_9 * tmpvar_1) * diff_18);
  c_17.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_17.xyz = ((tmpvar_9 * tmpvar_1) * diff_18);
  c_17.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_17.xyz = ((tmpvar_9 * tmpvar_1) * diff_18);
  c_17.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_13.xyz = ((tmpvar_9 * tmpvar_1) * diff_14);
  c_13.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_13.xyz = ((tmpvar_9 * tmpvar_1) * diff_14);
  c_13.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_13.xyz = ((tmpvar_9 * tmpvar_1) * diff_14);
  c_13.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
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
  mediump float tmpvar_10;
  tmpvar_10 = dot (vNormal_4, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_11.y = (((tmpvar_10 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((tmpvar_10 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_11;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = _cTint.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_8 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
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
  mediump float tmpvar_10;
  tmpvar_10 = dot (vNormal_4, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_11.y = (((tmpvar_10 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((tmpvar_10 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_11;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = _cTint.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_8 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
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
  mediump float tmpvar_10;
  tmpvar_10 = dot (vNormal_4, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_11.y = (((tmpvar_10 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((tmpvar_10 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_11;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_13));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = _cTint.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_8 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_9 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_9 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_9 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  mediump float tmpvar_10;
  tmpvar_10 = dot (vNormal_4, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_11.y = (((tmpvar_10 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((tmpvar_10 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_11;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7 * tmpvar_1) * diff_9);
  c_8.w = 0.0;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  mediump float tmpvar_10;
  tmpvar_10 = dot (vNormal_4, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_11.y = (((tmpvar_10 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((tmpvar_10 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_11;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7 * tmpvar_1) * diff_9);
  c_8.w = 0.0;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  mediump float tmpvar_10;
  tmpvar_10 = dot (vNormal_4, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_11.y = (((tmpvar_10 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((tmpvar_10 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_11;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7 * tmpvar_1) * diff_9);
  c_8.w = 0.0;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_16.xyz = ((tmpvar_9 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_16.xyz = ((tmpvar_9 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_16.xyz = ((tmpvar_9 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_9 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_9 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
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
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = _cTint.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_9 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  mediump float tmpvar_10;
  tmpvar_10 = dot (vNormal_4, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_11.y = (((tmpvar_10 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((tmpvar_10 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_11;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = _cTint.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
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
  c_11.xyz = ((tmpvar_8 * tmpvar_1) * diff_12);
  c_11.w = 0.0;
  highp float tmpvar_14;
  tmpvar_14 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  mediump float tmpvar_10;
  tmpvar_10 = dot (vNormal_4, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_11.y = (((tmpvar_10 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((tmpvar_10 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_11;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = _cTint.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
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
  c_11.xyz = ((tmpvar_8 * tmpvar_1) * diff_12);
  c_11.w = 0.0;
  highp float tmpvar_14;
  tmpvar_14 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
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
  mediump float tmpvar_10;
  tmpvar_10 = dot (vNormal_4, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = clamp (dot (vNormal_4, viewDir_5), 0.0, 1.0);
  tmpvar_11.y = (((tmpvar_10 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((tmpvar_10 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_11;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_14));
  xlv_TEXCOORD1 = tmpvar_7.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_12.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = _cTint.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
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
  c_11.xyz = ((tmpvar_8 * tmpvar_1) * diff_12);
  c_11.w = 0.0;
  highp float tmpvar_14;
  tmpvar_14 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
  Name "DEFERRED"
  Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 151997
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  mediump vec4 brdf_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  tmpvar_4 = _cTint.xyz;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_6 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = mix (((
    (tex_7.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_6.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_3.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_6.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_6.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_6.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_5 = tmpvar_10;
  mediump vec4 emission_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_4;
  tmpvar_13 = tmpvar_2;
  mediump vec4 outGBuffer2_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_12;
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
  tmpvar_18.xyz = tmpvar_5;
  emission_11 = tmpvar_18;
  emission_11.xyz = emission_11.xyz;
  outEmission_1.w = emission_11.w;
  outEmission_1.xyz = exp2(-(emission_11.xyz));
  gl_FragData[0] = tmpvar_15;
  gl_FragData[1] = tmpvar_16;
  gl_FragData[2] = outGBuffer2_14;
  gl_FragData[3] = outEmission_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  mediump vec4 brdf_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  tmpvar_4 = _cTint.xyz;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_6 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = mix (((
    (tex_7.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_6.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_3.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_6.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_6.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_6.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_5 = tmpvar_10;
  mediump vec4 emission_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_4;
  tmpvar_13 = tmpvar_2;
  mediump vec4 outGBuffer2_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_12;
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
  tmpvar_18.xyz = tmpvar_5;
  emission_11 = tmpvar_18;
  emission_11.xyz = emission_11.xyz;
  outEmission_1.w = emission_11.w;
  outEmission_1.xyz = exp2(-(emission_11.xyz));
  gl_FragData[0] = tmpvar_15;
  gl_FragData[1] = tmpvar_16;
  gl_FragData[2] = outGBuffer2_14;
  gl_FragData[3] = outEmission_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  mediump vec4 brdf_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  tmpvar_4 = _cTint.xyz;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_6 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = mix (((
    (tex_7.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_6.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_3.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_6.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_6.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_6.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_5 = tmpvar_10;
  mediump vec4 emission_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_4;
  tmpvar_13 = tmpvar_2;
  mediump vec4 outGBuffer2_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_12;
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
  tmpvar_18.xyz = tmpvar_5;
  emission_11 = tmpvar_18;
  emission_11.xyz = emission_11.xyz;
  outEmission_1.w = emission_11.w;
  outEmission_1.xyz = exp2(-(emission_11.xyz));
  gl_FragData[0] = tmpvar_15;
  gl_FragData[1] = tmpvar_16;
  gl_FragData[2] = outGBuffer2_14;
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  mediump vec4 brdf_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  tmpvar_4 = _cTint.xyz;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_6 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = mix (((
    (tex_7.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_6.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_3.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_6.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_6.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_6.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_5 = tmpvar_10;
  mediump vec4 emission_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_4;
  tmpvar_13 = tmpvar_2;
  mediump vec4 outGBuffer2_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_12;
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
  tmpvar_18.xyz = tmpvar_5;
  emission_11 = tmpvar_18;
  emission_11.xyz = emission_11.xyz;
  outEmission_1.w = emission_11.w;
  outEmission_1.xyz = exp2(-(emission_11.xyz));
  gl_FragData[0] = tmpvar_15;
  gl_FragData[1] = tmpvar_16;
  gl_FragData[2] = outGBuffer2_14;
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  mediump vec4 brdf_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  tmpvar_4 = _cTint.xyz;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_6 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = mix (((
    (tex_7.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_6.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_3.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_6.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_6.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_6.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_5 = tmpvar_10;
  mediump vec4 emission_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_4;
  tmpvar_13 = tmpvar_2;
  mediump vec4 outGBuffer2_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_12;
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
  tmpvar_18.xyz = tmpvar_5;
  emission_11 = tmpvar_18;
  emission_11.xyz = emission_11.xyz;
  outEmission_1.w = emission_11.w;
  outEmission_1.xyz = exp2(-(emission_11.xyz));
  gl_FragData[0] = tmpvar_15;
  gl_FragData[1] = tmpvar_16;
  gl_FragData[2] = outGBuffer2_14;
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  mediump vec4 brdf_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  tmpvar_4 = _cTint.xyz;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_6 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = mix (((
    (tex_7.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_6.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_3.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_6.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_6.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_6.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_5 = tmpvar_10;
  mediump vec4 emission_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_4;
  tmpvar_13 = tmpvar_2;
  mediump vec4 outGBuffer2_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_12;
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
  tmpvar_18.xyz = tmpvar_5;
  emission_11 = tmpvar_18;
  emission_11.xyz = emission_11.xyz;
  outEmission_1.w = emission_11.w;
  outEmission_1.xyz = exp2(-(emission_11.xyz));
  gl_FragData[0] = tmpvar_15;
  gl_FragData[1] = tmpvar_16;
  gl_FragData[2] = outGBuffer2_14;
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
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  tmpvar_1 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  mediump vec4 brdf_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  tmpvar_3 = _cTint.xyz;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (((
    (tex_6.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_5.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_2.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_5.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_5.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_5.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_4 = tmpvar_9;
  mediump vec4 emission_10;
  mediump vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_3;
  tmpvar_12 = tmpvar_1;
  mediump vec4 outGBuffer2_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_11;
  tmpvar_14.w = 1.0;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = 0.0;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((tmpvar_12 * 0.5) + 0.5);
  outGBuffer2_13 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_4;
  emission_10 = tmpvar_17;
  emission_10.xyz = emission_10.xyz;
  gl_FragData[0] = tmpvar_14;
  gl_FragData[1] = tmpvar_15;
  gl_FragData[2] = outGBuffer2_13;
  gl_FragData[3] = emission_10;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  tmpvar_1 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  mediump vec4 brdf_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  tmpvar_3 = _cTint.xyz;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (((
    (tex_6.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_5.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_2.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_5.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_5.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_5.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_4 = tmpvar_9;
  mediump vec4 emission_10;
  mediump vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_3;
  tmpvar_12 = tmpvar_1;
  mediump vec4 outGBuffer2_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_11;
  tmpvar_14.w = 1.0;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = 0.0;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((tmpvar_12 * 0.5) + 0.5);
  outGBuffer2_13 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_4;
  emission_10 = tmpvar_17;
  emission_10.xyz = emission_10.xyz;
  gl_FragData[0] = tmpvar_14;
  gl_FragData[1] = tmpvar_15;
  gl_FragData[2] = outGBuffer2_13;
  gl_FragData[3] = emission_10;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
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
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump vec4 _cOverride;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  tmpvar_1 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  mediump vec4 brdf_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  tmpvar_3 = _cTint.xyz;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_5 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (((
    (tex_6.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_5.yyy) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), tmpvar_2.wwww).xyz)
     + 
      ((_cRimb.xyz * brdf_5.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_5.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_5.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z), _cOverride.xyz, _cOverride.www);
  tmpvar_4 = tmpvar_9;
  mediump vec4 emission_10;
  mediump vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_3;
  tmpvar_12 = tmpvar_1;
  mediump vec4 outGBuffer2_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_11;
  tmpvar_14.w = 1.0;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = 0.0;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((tmpvar_12 * 0.5) + 0.5);
  outGBuffer2_13 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_4;
  emission_10 = tmpvar_17;
  emission_10.xyz = emission_10.xyz;
  gl_FragData[0] = tmpvar_14;
  gl_FragData[1] = tmpvar_15;
  gl_FragData[2] = outGBuffer2_13;
  gl_FragData[3] = emission_10;
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
  Cull Off
  GpuProgramID 233580
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
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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
uniform mediump float _Amount_Wrap;
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
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
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