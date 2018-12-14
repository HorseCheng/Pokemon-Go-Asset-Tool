Shader "Niantic/BRDF/UBER : vtxMask, uvAnimations, EyeShader" {
Properties {
_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
_Ramp2D ("BRDF Ramp", 2D) = "grey" { }
[KeywordEnum(DIFF, VCOLOR_DEBUG)] NIANTIC_MODE ("BRDF Normal or Debug", Float) = 0
_Amount_Blend ("BRDF Amount", Range(0, 2)) = 1
_Amount_Wrap ("Lambert Wrap Amount", Range(0, 1)) = 0
_cTint ("Tint", Color) = (0,0,0,0.5)
_cDiff ("Diffuse", Color) = (1,1,1,0.5)
_cAmbn ("Ambient", Color) = (0,0,0,0.5)
_cKeyf ("Specular (.a=0.5)", Color) = (1,1,1,0.5)
_cRimt ("RimTop   (.a=0.5)", Color) = (1,1,0,0.5)
_cRimb ("RimBottom(.a=0.5)", Color) = (0.5,0.5,0.5,0.5)
_Amount_RimLt ("RimLight Mult", Range(0, 2)) = 1
_vAmOc ("vAmbOcclusion", Color) = (0,0,0,1)
[Space] [Header(SPECULAR_SHADER_ACTIVATE____________)] [Space] [KeywordEnum(NONE, VERTEX, PIXEL, EYE_DEBUG)] BRB_SPECULAR ("Toggle for Specular", Float) = 0
_EyeSpec ("Specular", Range(0, 1)) = 1
_EyeGloss ("Glossiness", Range(0.025, 100)) = 0.95
_EyeIllum ("Eye Illum", Range(0.85, 2)) = 1
_EyeTiles ("Tile Count 'U', 'V', 'U Scale', 'V Scale'", Vector) = (2,4,1,1)
_Roundness ("Roundness UV 'Offset', 'UNUSED','Strength'", Vector) = (0,0,1,1)
_EyeMirrorOffset ("Mirror U Offset (keep for now)", Range(0, 2)) = 1
[Space] [Header(UV_ANIMATION_SETTINGS_______________)] [Space] [Toggle(NIANTIC_UV_ANIMATE)] _UVAnimated ("Activates UV Animation", Float) = 0
_uv0 ("uv animation 0 (green)", Vector) = (0,0,4,0)
_uv1 ("uv animation 1 (red  )", Vector) = (0,0,4,2)
_uv2 ("uv animation 2 (blue )", Vector) = (0,0,4,2)
[Space] [Header(ACIVATED_IGNORES_USE_VERTEXMASKS____)] [Space] [Space] [Header(USE_VERTEXMASKS_____________________)] [Space] [Header(COLOR____red_vRedd____green_vGren____blue_vBlue)] [Header(SP_AM_AO_red_specrim_green_ambient_blue_AO___)] [Space] [KeywordEnum(COLOR, SP_AM_AO)] NIANTIC_VERTEX ("Allows vertex variance on shared material ", Float) = 0
_vGren ("vGreen Channel", Color) = (1,1,1,0.5)
_vRedd ("vRed   Channel", Color) = (1,1,1,0.5)
_vBlue ("vBlue  Channel", Color) = (1,1,1,0.5)
[Header(STENCIL_ID_TO_CONTROL_SORTING_SPECIAL_FX)] _Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare Function", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
}
SubShader {
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  GpuProgramID 14108
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
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec4 envFogColor_9;
  mediump vec4 tcXFORM_10;
  mediump vec3 vNormal_11;
  mediump vec3 viewDir_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  viewDir_12 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = tmpvar_3;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((unity_ObjectToWorld * tmpvar_15).xyz);
  vNormal_11 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (vNormal_11, viewDir_12), 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = dot (vNormal_11, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_17;
  tmpvar_19.y = (((tmpvar_18 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_19;
  tmpvar_6.z = ((tmpvar_18 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_17);
  tcXFORM_10 = tmpvar_2;
  tmpvar_7.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_7.w = tmpvar_4.w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20)).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  envFogColor_9 = (tmpvar_22 * tmpvar_23);
  tmpvar_8 = envFogColor_9;
  tmpvar_5 = tmpvar_8;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_1.xyz;
  highp vec3 norm_25;
  norm_25 = tmpvar_3;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_24));
  xlv_TEXCOORD0 = normalize((norm_25 * tmpvar_26));
  xlv_TEXCOORD1 = tmpvar_14.xyz;
  xlv_TEXCOORD2 = tcXFORM_10;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD5;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_2 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_3.xyz, c_1.xyz, tmpvar_3.www);
  c_1.xyz = color_9.xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec4 envFogColor_9;
  mediump vec4 tcXFORM_10;
  mediump vec3 vNormal_11;
  mediump vec3 viewDir_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  viewDir_12 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = tmpvar_3;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((unity_ObjectToWorld * tmpvar_15).xyz);
  vNormal_11 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (vNormal_11, viewDir_12), 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = dot (vNormal_11, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_17;
  tmpvar_19.y = (((tmpvar_18 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_19;
  tmpvar_6.z = ((tmpvar_18 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_17);
  tcXFORM_10 = tmpvar_2;
  tmpvar_7.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_7.w = tmpvar_4.w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20)).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  envFogColor_9 = (tmpvar_22 * tmpvar_23);
  tmpvar_8 = envFogColor_9;
  tmpvar_5 = tmpvar_8;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_1.xyz;
  highp vec3 norm_25;
  norm_25 = tmpvar_3;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_24));
  xlv_TEXCOORD0 = normalize((norm_25 * tmpvar_26));
  xlv_TEXCOORD1 = tmpvar_14.xyz;
  xlv_TEXCOORD2 = tcXFORM_10;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD5;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_2 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_3.xyz, c_1.xyz, tmpvar_3.www);
  c_1.xyz = color_9.xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec4 envFogColor_9;
  mediump vec4 tcXFORM_10;
  mediump vec3 vNormal_11;
  mediump vec3 viewDir_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  viewDir_12 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = tmpvar_3;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((unity_ObjectToWorld * tmpvar_15).xyz);
  vNormal_11 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (vNormal_11, viewDir_12), 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = dot (vNormal_11, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_17;
  tmpvar_19.y = (((tmpvar_18 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_19;
  tmpvar_6.z = ((tmpvar_18 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_17);
  tcXFORM_10 = tmpvar_2;
  tmpvar_7.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_7.w = tmpvar_4.w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20)).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  envFogColor_9 = (tmpvar_22 * tmpvar_23);
  tmpvar_8 = envFogColor_9;
  tmpvar_5 = tmpvar_8;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_1.xyz;
  highp vec3 norm_25;
  norm_25 = tmpvar_3;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_24));
  xlv_TEXCOORD0 = normalize((norm_25 * tmpvar_26));
  xlv_TEXCOORD1 = tmpvar_14.xyz;
  xlv_TEXCOORD2 = tcXFORM_10;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD5;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_2 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_3.xyz, c_1.xyz, tmpvar_3.www);
  c_1.xyz = color_9.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp vec3 worldBinormal_5;
  lowp float tangentSign_6;
  lowp vec3 worldTangent_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_1.xyz;
  highp float tmpvar_28;
  tmpvar_28 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27)).z);
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_29.w = exp2((-(tmpvar_28) * tmpvar_28));
  lowp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = unity_FogColor.xyz;
  envFogColor_12 = (tmpvar_29 * tmpvar_30);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_33;
  norm_33 = tmpvar_3;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((norm_33 * tmpvar_34));
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_7 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_6 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (((tmpvar_35.yzx * worldTangent_7.zxy) - (tmpvar_35.zxy * worldTangent_7.yzx)) * tangentSign_6);
  worldBinormal_5 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_7.x;
  tmpvar_40.y = worldBinormal_5.x;
  tmpvar_40.z = tmpvar_35.x;
  tmpvar_40.w = tmpvar_32.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_7.y;
  tmpvar_41.y = worldBinormal_5.y;
  tmpvar_41.z = tmpvar_35.y;
  tmpvar_41.w = tmpvar_32.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_7.z;
  tmpvar_42.y = worldBinormal_5.z;
  tmpvar_42.z = tmpvar_35.z;
  tmpvar_42.w = tmpvar_32.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_31));
  xlv_TEXCOORD0 = tmpvar_40;
  xlv_TEXCOORD1 = tmpvar_41;
  xlv_TEXCOORD2 = tmpvar_42;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6;
  highp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.w;
  tmpvar_8.y = xlv_TEXCOORD1.w;
  tmpvar_8.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_9;
  worldViewDir_5 = normalize((_WorldSpaceCameraPos - tmpvar_8));
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_10 = tmpvar_13;
  tmpvar_4 = (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  worldN_1.x = xlv_TEXCOORD0.z;
  worldN_1.y = xlv_TEXCOORD1.z;
  worldN_1.z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(worldN_1);
  worldN_1 = tmpvar_14;
  tmpvar_3 = tmpvar_14;
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump vec3 viewDir_16;
  viewDir_16 = worldViewDir_5;
  mediump vec4 specular_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  specular_17.w = 0.0;
  specular_17.xyz = (pow (vec3(clamp (
    dot (tmpvar_18, normalize((viewDir_16 + lightDir_15)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (dot (viewDir_16, tmpvar_18), 0.0, 1.0);
  mediump float perceptualRoughness_20;
  perceptualRoughness_20 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = (-(viewDir_16) - ((2.0 * tmpvar_18) * -(tmpvar_19)));
  tmpvar_21.w = ((perceptualRoughness_20 * (1.7 - 
    (0.7 * perceptualRoughness_20)
  )) * 6.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_21.xyz, tmpvar_21.w);
  mediump vec4 tmpvar_23;
  tmpvar_23 = tmpvar_22;
  specular_17.xyz = (specular_17.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_23.w - 1.0)
    ) + 1.0)) * tmpvar_23.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_19)));
  specular_17.xyz = (specular_17.xyz * vec3((_EyeSpec * tex_11.w)));
  c_2 = specular_17;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  lowp vec4 color_24;
  color_24.w = c_2.w;
  color_24.xyz = mix (tmpvar_7.xyz, c_2.xyz, tmpvar_7.www);
  c_2.xyz = color_24.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp vec3 worldBinormal_5;
  lowp float tangentSign_6;
  lowp vec3 worldTangent_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_1.xyz;
  highp float tmpvar_28;
  tmpvar_28 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27)).z);
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_29.w = exp2((-(tmpvar_28) * tmpvar_28));
  lowp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = unity_FogColor.xyz;
  envFogColor_12 = (tmpvar_29 * tmpvar_30);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_33;
  norm_33 = tmpvar_3;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((norm_33 * tmpvar_34));
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_7 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_6 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (((tmpvar_35.yzx * worldTangent_7.zxy) - (tmpvar_35.zxy * worldTangent_7.yzx)) * tangentSign_6);
  worldBinormal_5 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_7.x;
  tmpvar_40.y = worldBinormal_5.x;
  tmpvar_40.z = tmpvar_35.x;
  tmpvar_40.w = tmpvar_32.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_7.y;
  tmpvar_41.y = worldBinormal_5.y;
  tmpvar_41.z = tmpvar_35.y;
  tmpvar_41.w = tmpvar_32.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_7.z;
  tmpvar_42.y = worldBinormal_5.z;
  tmpvar_42.z = tmpvar_35.z;
  tmpvar_42.w = tmpvar_32.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_31));
  xlv_TEXCOORD0 = tmpvar_40;
  xlv_TEXCOORD1 = tmpvar_41;
  xlv_TEXCOORD2 = tmpvar_42;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6;
  highp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.w;
  tmpvar_8.y = xlv_TEXCOORD1.w;
  tmpvar_8.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_9;
  worldViewDir_5 = normalize((_WorldSpaceCameraPos - tmpvar_8));
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_10 = tmpvar_13;
  tmpvar_4 = (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  worldN_1.x = xlv_TEXCOORD0.z;
  worldN_1.y = xlv_TEXCOORD1.z;
  worldN_1.z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(worldN_1);
  worldN_1 = tmpvar_14;
  tmpvar_3 = tmpvar_14;
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump vec3 viewDir_16;
  viewDir_16 = worldViewDir_5;
  mediump vec4 specular_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  specular_17.w = 0.0;
  specular_17.xyz = (pow (vec3(clamp (
    dot (tmpvar_18, normalize((viewDir_16 + lightDir_15)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (dot (viewDir_16, tmpvar_18), 0.0, 1.0);
  mediump float perceptualRoughness_20;
  perceptualRoughness_20 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = (-(viewDir_16) - ((2.0 * tmpvar_18) * -(tmpvar_19)));
  tmpvar_21.w = ((perceptualRoughness_20 * (1.7 - 
    (0.7 * perceptualRoughness_20)
  )) * 6.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_21.xyz, tmpvar_21.w);
  mediump vec4 tmpvar_23;
  tmpvar_23 = tmpvar_22;
  specular_17.xyz = (specular_17.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_23.w - 1.0)
    ) + 1.0)) * tmpvar_23.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_19)));
  specular_17.xyz = (specular_17.xyz * vec3((_EyeSpec * tex_11.w)));
  c_2 = specular_17;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  lowp vec4 color_24;
  color_24.w = c_2.w;
  color_24.xyz = mix (tmpvar_7.xyz, c_2.xyz, tmpvar_7.www);
  c_2.xyz = color_24.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp vec3 worldBinormal_5;
  lowp float tangentSign_6;
  lowp vec3 worldTangent_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_1.xyz;
  highp float tmpvar_28;
  tmpvar_28 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27)).z);
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_29.w = exp2((-(tmpvar_28) * tmpvar_28));
  lowp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = unity_FogColor.xyz;
  envFogColor_12 = (tmpvar_29 * tmpvar_30);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_33;
  norm_33 = tmpvar_3;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((norm_33 * tmpvar_34));
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_7 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_6 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (((tmpvar_35.yzx * worldTangent_7.zxy) - (tmpvar_35.zxy * worldTangent_7.yzx)) * tangentSign_6);
  worldBinormal_5 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_7.x;
  tmpvar_40.y = worldBinormal_5.x;
  tmpvar_40.z = tmpvar_35.x;
  tmpvar_40.w = tmpvar_32.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_7.y;
  tmpvar_41.y = worldBinormal_5.y;
  tmpvar_41.z = tmpvar_35.y;
  tmpvar_41.w = tmpvar_32.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_7.z;
  tmpvar_42.y = worldBinormal_5.z;
  tmpvar_42.z = tmpvar_35.z;
  tmpvar_42.w = tmpvar_32.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_31));
  xlv_TEXCOORD0 = tmpvar_40;
  xlv_TEXCOORD1 = tmpvar_41;
  xlv_TEXCOORD2 = tmpvar_42;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6;
  highp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.w;
  tmpvar_8.y = xlv_TEXCOORD1.w;
  tmpvar_8.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_9;
  worldViewDir_5 = normalize((_WorldSpaceCameraPos - tmpvar_8));
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_10 = tmpvar_13;
  tmpvar_4 = (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  worldN_1.x = xlv_TEXCOORD0.z;
  worldN_1.y = xlv_TEXCOORD1.z;
  worldN_1.z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(worldN_1);
  worldN_1 = tmpvar_14;
  tmpvar_3 = tmpvar_14;
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump vec3 viewDir_16;
  viewDir_16 = worldViewDir_5;
  mediump vec4 specular_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  specular_17.w = 0.0;
  specular_17.xyz = (pow (vec3(clamp (
    dot (tmpvar_18, normalize((viewDir_16 + lightDir_15)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (dot (viewDir_16, tmpvar_18), 0.0, 1.0);
  mediump float perceptualRoughness_20;
  perceptualRoughness_20 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = (-(viewDir_16) - ((2.0 * tmpvar_18) * -(tmpvar_19)));
  tmpvar_21.w = ((perceptualRoughness_20 * (1.7 - 
    (0.7 * perceptualRoughness_20)
  )) * 6.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_21.xyz, tmpvar_21.w);
  mediump vec4 tmpvar_23;
  tmpvar_23 = tmpvar_22;
  specular_17.xyz = (specular_17.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_23.w - 1.0)
    ) + 1.0)) * tmpvar_23.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_19)));
  specular_17.xyz = (specular_17.xyz * vec3((_EyeSpec * tex_11.w)));
  c_2 = specular_17;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  lowp vec4 color_24;
  color_24.w = c_2.w;
  color_24.xyz = mix (tmpvar_7.xyz, c_2.xyz, tmpvar_7.www);
  c_2.xyz = color_24.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec4 envFogColor_9;
  mediump vec4 tcXFORM_10;
  mediump vec3 vNormal_11;
  mediump vec3 viewDir_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  viewDir_12 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = tmpvar_3;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((unity_ObjectToWorld * tmpvar_15).xyz);
  vNormal_11 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (vNormal_11, viewDir_12), 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = dot (vNormal_11, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_17;
  tmpvar_19.y = (((tmpvar_18 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_19;
  tmpvar_6.z = ((tmpvar_18 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_17);
  tcXFORM_10 = tmpvar_2;
  tmpvar_7.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_7.w = tmpvar_4.w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20)).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  envFogColor_9 = (tmpvar_22 * tmpvar_23);
  tmpvar_8 = envFogColor_9;
  tmpvar_5 = tmpvar_8;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_1.xyz;
  highp vec3 norm_25;
  norm_25 = tmpvar_3;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_24));
  xlv_TEXCOORD0 = normalize((norm_25 * tmpvar_26));
  xlv_TEXCOORD1 = tmpvar_14.xyz;
  xlv_TEXCOORD2 = tcXFORM_10;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD5;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_2 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_3.xyz, c_1.xyz, tmpvar_3.www);
  c_1.xyz = color_9.xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec4 envFogColor_9;
  mediump vec4 tcXFORM_10;
  mediump vec3 vNormal_11;
  mediump vec3 viewDir_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  viewDir_12 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = tmpvar_3;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((unity_ObjectToWorld * tmpvar_15).xyz);
  vNormal_11 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (vNormal_11, viewDir_12), 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = dot (vNormal_11, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_17;
  tmpvar_19.y = (((tmpvar_18 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_19;
  tmpvar_6.z = ((tmpvar_18 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_17);
  tcXFORM_10 = tmpvar_2;
  tmpvar_7.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_7.w = tmpvar_4.w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20)).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  envFogColor_9 = (tmpvar_22 * tmpvar_23);
  tmpvar_8 = envFogColor_9;
  tmpvar_5 = tmpvar_8;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_1.xyz;
  highp vec3 norm_25;
  norm_25 = tmpvar_3;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_24));
  xlv_TEXCOORD0 = normalize((norm_25 * tmpvar_26));
  xlv_TEXCOORD1 = tmpvar_14.xyz;
  xlv_TEXCOORD2 = tcXFORM_10;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD5;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_2 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_3.xyz, c_1.xyz, tmpvar_3.www);
  c_1.xyz = color_9.xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec4 envFogColor_9;
  mediump vec4 tcXFORM_10;
  mediump vec3 vNormal_11;
  mediump vec3 viewDir_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  viewDir_12 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = tmpvar_3;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((unity_ObjectToWorld * tmpvar_15).xyz);
  vNormal_11 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (vNormal_11, viewDir_12), 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = dot (vNormal_11, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_17;
  tmpvar_19.y = (((tmpvar_18 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_19;
  tmpvar_6.z = ((tmpvar_18 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_17);
  tcXFORM_10 = tmpvar_2;
  tmpvar_7.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_7.w = tmpvar_4.w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20)).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  envFogColor_9 = (tmpvar_22 * tmpvar_23);
  tmpvar_8 = envFogColor_9;
  tmpvar_5 = tmpvar_8;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_1.xyz;
  highp vec3 norm_25;
  norm_25 = tmpvar_3;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_24));
  xlv_TEXCOORD0 = normalize((norm_25 * tmpvar_26));
  xlv_TEXCOORD1 = tmpvar_14.xyz;
  xlv_TEXCOORD2 = tcXFORM_10;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD5;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_2 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_3.xyz, c_1.xyz, tmpvar_3.www);
  c_1.xyz = color_9.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp vec3 worldBinormal_5;
  lowp float tangentSign_6;
  lowp vec3 worldTangent_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_1.xyz;
  highp float tmpvar_28;
  tmpvar_28 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27)).z);
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_29.w = exp2((-(tmpvar_28) * tmpvar_28));
  lowp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = unity_FogColor.xyz;
  envFogColor_12 = (tmpvar_29 * tmpvar_30);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_33;
  norm_33 = tmpvar_3;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((norm_33 * tmpvar_34));
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_7 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_6 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (((tmpvar_35.yzx * worldTangent_7.zxy) - (tmpvar_35.zxy * worldTangent_7.yzx)) * tangentSign_6);
  worldBinormal_5 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_7.x;
  tmpvar_40.y = worldBinormal_5.x;
  tmpvar_40.z = tmpvar_35.x;
  tmpvar_40.w = tmpvar_32.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_7.y;
  tmpvar_41.y = worldBinormal_5.y;
  tmpvar_41.z = tmpvar_35.y;
  tmpvar_41.w = tmpvar_32.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_7.z;
  tmpvar_42.y = worldBinormal_5.z;
  tmpvar_42.z = tmpvar_35.z;
  tmpvar_42.w = tmpvar_32.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_31));
  xlv_TEXCOORD0 = tmpvar_40;
  xlv_TEXCOORD1 = tmpvar_41;
  xlv_TEXCOORD2 = tmpvar_42;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6;
  highp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.w;
  tmpvar_8.y = xlv_TEXCOORD1.w;
  tmpvar_8.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_9;
  worldViewDir_5 = normalize((_WorldSpaceCameraPos - tmpvar_8));
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_10 = tmpvar_13;
  tmpvar_4 = (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  worldN_1.x = xlv_TEXCOORD0.z;
  worldN_1.y = xlv_TEXCOORD1.z;
  worldN_1.z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(worldN_1);
  worldN_1 = tmpvar_14;
  tmpvar_3 = tmpvar_14;
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump vec3 viewDir_16;
  viewDir_16 = worldViewDir_5;
  mediump vec4 specular_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  specular_17.w = 0.0;
  specular_17.xyz = (pow (vec3(clamp (
    dot (tmpvar_18, normalize((viewDir_16 + lightDir_15)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (dot (viewDir_16, tmpvar_18), 0.0, 1.0);
  mediump float perceptualRoughness_20;
  perceptualRoughness_20 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = (-(viewDir_16) - ((2.0 * tmpvar_18) * -(tmpvar_19)));
  tmpvar_21.w = ((perceptualRoughness_20 * (1.7 - 
    (0.7 * perceptualRoughness_20)
  )) * 6.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_21.xyz, tmpvar_21.w);
  mediump vec4 tmpvar_23;
  tmpvar_23 = tmpvar_22;
  specular_17.xyz = (specular_17.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_23.w - 1.0)
    ) + 1.0)) * tmpvar_23.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_19)));
  specular_17.xyz = (specular_17.xyz * vec3((_EyeSpec * tex_11.w)));
  c_2 = specular_17;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  lowp vec4 color_24;
  color_24.w = c_2.w;
  color_24.xyz = mix (tmpvar_7.xyz, c_2.xyz, tmpvar_7.www);
  c_2.xyz = color_24.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp vec3 worldBinormal_5;
  lowp float tangentSign_6;
  lowp vec3 worldTangent_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_1.xyz;
  highp float tmpvar_28;
  tmpvar_28 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27)).z);
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_29.w = exp2((-(tmpvar_28) * tmpvar_28));
  lowp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = unity_FogColor.xyz;
  envFogColor_12 = (tmpvar_29 * tmpvar_30);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_33;
  norm_33 = tmpvar_3;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((norm_33 * tmpvar_34));
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_7 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_6 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (((tmpvar_35.yzx * worldTangent_7.zxy) - (tmpvar_35.zxy * worldTangent_7.yzx)) * tangentSign_6);
  worldBinormal_5 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_7.x;
  tmpvar_40.y = worldBinormal_5.x;
  tmpvar_40.z = tmpvar_35.x;
  tmpvar_40.w = tmpvar_32.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_7.y;
  tmpvar_41.y = worldBinormal_5.y;
  tmpvar_41.z = tmpvar_35.y;
  tmpvar_41.w = tmpvar_32.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_7.z;
  tmpvar_42.y = worldBinormal_5.z;
  tmpvar_42.z = tmpvar_35.z;
  tmpvar_42.w = tmpvar_32.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_31));
  xlv_TEXCOORD0 = tmpvar_40;
  xlv_TEXCOORD1 = tmpvar_41;
  xlv_TEXCOORD2 = tmpvar_42;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6;
  highp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.w;
  tmpvar_8.y = xlv_TEXCOORD1.w;
  tmpvar_8.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_9;
  worldViewDir_5 = normalize((_WorldSpaceCameraPos - tmpvar_8));
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_10 = tmpvar_13;
  tmpvar_4 = (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  worldN_1.x = xlv_TEXCOORD0.z;
  worldN_1.y = xlv_TEXCOORD1.z;
  worldN_1.z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(worldN_1);
  worldN_1 = tmpvar_14;
  tmpvar_3 = tmpvar_14;
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump vec3 viewDir_16;
  viewDir_16 = worldViewDir_5;
  mediump vec4 specular_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  specular_17.w = 0.0;
  specular_17.xyz = (pow (vec3(clamp (
    dot (tmpvar_18, normalize((viewDir_16 + lightDir_15)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (dot (viewDir_16, tmpvar_18), 0.0, 1.0);
  mediump float perceptualRoughness_20;
  perceptualRoughness_20 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = (-(viewDir_16) - ((2.0 * tmpvar_18) * -(tmpvar_19)));
  tmpvar_21.w = ((perceptualRoughness_20 * (1.7 - 
    (0.7 * perceptualRoughness_20)
  )) * 6.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_21.xyz, tmpvar_21.w);
  mediump vec4 tmpvar_23;
  tmpvar_23 = tmpvar_22;
  specular_17.xyz = (specular_17.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_23.w - 1.0)
    ) + 1.0)) * tmpvar_23.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_19)));
  specular_17.xyz = (specular_17.xyz * vec3((_EyeSpec * tex_11.w)));
  c_2 = specular_17;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  lowp vec4 color_24;
  color_24.w = c_2.w;
  color_24.xyz = mix (tmpvar_7.xyz, c_2.xyz, tmpvar_7.www);
  c_2.xyz = color_24.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp vec3 worldBinormal_5;
  lowp float tangentSign_6;
  lowp vec3 worldTangent_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_1.xyz;
  highp float tmpvar_28;
  tmpvar_28 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27)).z);
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_29.w = exp2((-(tmpvar_28) * tmpvar_28));
  lowp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = unity_FogColor.xyz;
  envFogColor_12 = (tmpvar_29 * tmpvar_30);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_33;
  norm_33 = tmpvar_3;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((norm_33 * tmpvar_34));
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_7 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_6 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (((tmpvar_35.yzx * worldTangent_7.zxy) - (tmpvar_35.zxy * worldTangent_7.yzx)) * tangentSign_6);
  worldBinormal_5 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_7.x;
  tmpvar_40.y = worldBinormal_5.x;
  tmpvar_40.z = tmpvar_35.x;
  tmpvar_40.w = tmpvar_32.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_7.y;
  tmpvar_41.y = worldBinormal_5.y;
  tmpvar_41.z = tmpvar_35.y;
  tmpvar_41.w = tmpvar_32.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_7.z;
  tmpvar_42.y = worldBinormal_5.z;
  tmpvar_42.z = tmpvar_35.z;
  tmpvar_42.w = tmpvar_32.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_31));
  xlv_TEXCOORD0 = tmpvar_40;
  xlv_TEXCOORD1 = tmpvar_41;
  xlv_TEXCOORD2 = tmpvar_42;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6;
  highp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.w;
  tmpvar_8.y = xlv_TEXCOORD1.w;
  tmpvar_8.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_9;
  worldViewDir_5 = normalize((_WorldSpaceCameraPos - tmpvar_8));
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_10 = tmpvar_13;
  tmpvar_4 = (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  worldN_1.x = xlv_TEXCOORD0.z;
  worldN_1.y = xlv_TEXCOORD1.z;
  worldN_1.z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(worldN_1);
  worldN_1 = tmpvar_14;
  tmpvar_3 = tmpvar_14;
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump vec3 viewDir_16;
  viewDir_16 = worldViewDir_5;
  mediump vec4 specular_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  specular_17.w = 0.0;
  specular_17.xyz = (pow (vec3(clamp (
    dot (tmpvar_18, normalize((viewDir_16 + lightDir_15)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (dot (viewDir_16, tmpvar_18), 0.0, 1.0);
  mediump float perceptualRoughness_20;
  perceptualRoughness_20 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = (-(viewDir_16) - ((2.0 * tmpvar_18) * -(tmpvar_19)));
  tmpvar_21.w = ((perceptualRoughness_20 * (1.7 - 
    (0.7 * perceptualRoughness_20)
  )) * 6.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_21.xyz, tmpvar_21.w);
  mediump vec4 tmpvar_23;
  tmpvar_23 = tmpvar_22;
  specular_17.xyz = (specular_17.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_23.w - 1.0)
    ) + 1.0)) * tmpvar_23.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_19)));
  specular_17.xyz = (specular_17.xyz * vec3((_EyeSpec * tex_11.w)));
  c_2 = specular_17;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  lowp vec4 color_24;
  color_24.w = c_2.w;
  color_24.xyz = mix (tmpvar_7.xyz, c_2.xyz, tmpvar_7.www);
  c_2.xyz = color_24.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
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
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec4 envFogColor_9;
  mediump vec4 tcXFORM_10;
  mediump vec3 vNormal_11;
  mediump vec3 viewDir_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  viewDir_12 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = tmpvar_3;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((unity_ObjectToWorld * tmpvar_15).xyz);
  vNormal_11 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (vNormal_11, viewDir_12), 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = dot (vNormal_11, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_17;
  tmpvar_19.y = (((tmpvar_18 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_19;
  tmpvar_6.z = ((tmpvar_18 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_17);
  tcXFORM_10 = tmpvar_2;
  tmpvar_7.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_7.w = tmpvar_4.w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20)).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  envFogColor_9 = (tmpvar_22 * _CharacterColor);
  tmpvar_8 = envFogColor_9;
  tmpvar_5 = tmpvar_8;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_1.xyz;
  highp vec3 norm_24;
  norm_24 = tmpvar_3;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
  xlv_TEXCOORD0 = normalize((norm_24 * tmpvar_25));
  xlv_TEXCOORD1 = tmpvar_14.xyz;
  xlv_TEXCOORD2 = tcXFORM_10;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD5;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_2 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_3.xyz, c_1.xyz, tmpvar_3.www);
  c_1.xyz = color_9.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
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
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec4 envFogColor_9;
  mediump vec4 tcXFORM_10;
  mediump vec3 vNormal_11;
  mediump vec3 viewDir_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  viewDir_12 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = tmpvar_3;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((unity_ObjectToWorld * tmpvar_15).xyz);
  vNormal_11 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (vNormal_11, viewDir_12), 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = dot (vNormal_11, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_17;
  tmpvar_19.y = (((tmpvar_18 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_19;
  tmpvar_6.z = ((tmpvar_18 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_17);
  tcXFORM_10 = tmpvar_2;
  tmpvar_7.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_7.w = tmpvar_4.w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20)).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  envFogColor_9 = (tmpvar_22 * _CharacterColor);
  tmpvar_8 = envFogColor_9;
  tmpvar_5 = tmpvar_8;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_1.xyz;
  highp vec3 norm_24;
  norm_24 = tmpvar_3;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
  xlv_TEXCOORD0 = normalize((norm_24 * tmpvar_25));
  xlv_TEXCOORD1 = tmpvar_14.xyz;
  xlv_TEXCOORD2 = tcXFORM_10;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD5;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_2 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_3.xyz, c_1.xyz, tmpvar_3.www);
  c_1.xyz = color_9.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
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
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec4 envFogColor_9;
  mediump vec4 tcXFORM_10;
  mediump vec3 vNormal_11;
  mediump vec3 viewDir_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  viewDir_12 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = tmpvar_3;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((unity_ObjectToWorld * tmpvar_15).xyz);
  vNormal_11 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (vNormal_11, viewDir_12), 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = dot (vNormal_11, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_17;
  tmpvar_19.y = (((tmpvar_18 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_19;
  tmpvar_6.z = ((tmpvar_18 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_17);
  tcXFORM_10 = tmpvar_2;
  tmpvar_7.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_7.w = tmpvar_4.w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20)).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  envFogColor_9 = (tmpvar_22 * _CharacterColor);
  tmpvar_8 = envFogColor_9;
  tmpvar_5 = tmpvar_8;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_1.xyz;
  highp vec3 norm_24;
  norm_24 = tmpvar_3;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
  xlv_TEXCOORD0 = normalize((norm_24 * tmpvar_25));
  xlv_TEXCOORD1 = tmpvar_14.xyz;
  xlv_TEXCOORD2 = tcXFORM_10;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD5;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_2 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_3.xyz, c_1.xyz, tmpvar_3.www);
  c_1.xyz = color_9.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp vec3 worldBinormal_5;
  lowp float tangentSign_6;
  lowp vec3 worldTangent_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_1.xyz;
  highp float tmpvar_28;
  tmpvar_28 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27)).z);
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_29.w = exp2((-(tmpvar_28) * tmpvar_28));
  envFogColor_12 = (tmpvar_29 * _CharacterColor);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_32;
  norm_32 = tmpvar_3;
  highp mat3 tmpvar_33;
  tmpvar_33[0] = unity_WorldToObject[0].xyz;
  tmpvar_33[1] = unity_WorldToObject[1].xyz;
  tmpvar_33[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((norm_32 * tmpvar_33));
  highp mat3 tmpvar_35;
  tmpvar_35[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_35[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_35[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((tmpvar_35 * _glesTANGENT.xyz));
  worldTangent_7 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_6 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (((tmpvar_34.yzx * worldTangent_7.zxy) - (tmpvar_34.zxy * worldTangent_7.yzx)) * tangentSign_6);
  worldBinormal_5 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.x = worldTangent_7.x;
  tmpvar_39.y = worldBinormal_5.x;
  tmpvar_39.z = tmpvar_34.x;
  tmpvar_39.w = tmpvar_31.x;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_7.y;
  tmpvar_40.y = worldBinormal_5.y;
  tmpvar_40.z = tmpvar_34.y;
  tmpvar_40.w = tmpvar_31.y;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_7.z;
  tmpvar_41.y = worldBinormal_5.z;
  tmpvar_41.z = tmpvar_34.z;
  tmpvar_41.w = tmpvar_31.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
  xlv_TEXCOORD0 = tmpvar_39;
  xlv_TEXCOORD1 = tmpvar_40;
  xlv_TEXCOORD2 = tmpvar_41;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6;
  highp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.w;
  tmpvar_8.y = xlv_TEXCOORD1.w;
  tmpvar_8.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_9;
  worldViewDir_5 = normalize((_WorldSpaceCameraPos - tmpvar_8));
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_10 = tmpvar_13;
  tmpvar_4 = (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  worldN_1.x = xlv_TEXCOORD0.z;
  worldN_1.y = xlv_TEXCOORD1.z;
  worldN_1.z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(worldN_1);
  worldN_1 = tmpvar_14;
  tmpvar_3 = tmpvar_14;
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump vec3 viewDir_16;
  viewDir_16 = worldViewDir_5;
  mediump vec4 specular_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  specular_17.w = 0.0;
  specular_17.xyz = (pow (vec3(clamp (
    dot (tmpvar_18, normalize((viewDir_16 + lightDir_15)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (dot (viewDir_16, tmpvar_18), 0.0, 1.0);
  mediump float perceptualRoughness_20;
  perceptualRoughness_20 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = (-(viewDir_16) - ((2.0 * tmpvar_18) * -(tmpvar_19)));
  tmpvar_21.w = ((perceptualRoughness_20 * (1.7 - 
    (0.7 * perceptualRoughness_20)
  )) * 6.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_21.xyz, tmpvar_21.w);
  mediump vec4 tmpvar_23;
  tmpvar_23 = tmpvar_22;
  specular_17.xyz = (specular_17.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_23.w - 1.0)
    ) + 1.0)) * tmpvar_23.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_19)));
  specular_17.xyz = (specular_17.xyz * vec3((_EyeSpec * tex_11.w)));
  c_2 = specular_17;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  lowp vec4 color_24;
  color_24.w = c_2.w;
  color_24.xyz = mix (tmpvar_7.xyz, c_2.xyz, tmpvar_7.www);
  c_2.xyz = color_24.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp vec3 worldBinormal_5;
  lowp float tangentSign_6;
  lowp vec3 worldTangent_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_1.xyz;
  highp float tmpvar_28;
  tmpvar_28 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27)).z);
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_29.w = exp2((-(tmpvar_28) * tmpvar_28));
  envFogColor_12 = (tmpvar_29 * _CharacterColor);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_32;
  norm_32 = tmpvar_3;
  highp mat3 tmpvar_33;
  tmpvar_33[0] = unity_WorldToObject[0].xyz;
  tmpvar_33[1] = unity_WorldToObject[1].xyz;
  tmpvar_33[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((norm_32 * tmpvar_33));
  highp mat3 tmpvar_35;
  tmpvar_35[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_35[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_35[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((tmpvar_35 * _glesTANGENT.xyz));
  worldTangent_7 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_6 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (((tmpvar_34.yzx * worldTangent_7.zxy) - (tmpvar_34.zxy * worldTangent_7.yzx)) * tangentSign_6);
  worldBinormal_5 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.x = worldTangent_7.x;
  tmpvar_39.y = worldBinormal_5.x;
  tmpvar_39.z = tmpvar_34.x;
  tmpvar_39.w = tmpvar_31.x;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_7.y;
  tmpvar_40.y = worldBinormal_5.y;
  tmpvar_40.z = tmpvar_34.y;
  tmpvar_40.w = tmpvar_31.y;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_7.z;
  tmpvar_41.y = worldBinormal_5.z;
  tmpvar_41.z = tmpvar_34.z;
  tmpvar_41.w = tmpvar_31.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
  xlv_TEXCOORD0 = tmpvar_39;
  xlv_TEXCOORD1 = tmpvar_40;
  xlv_TEXCOORD2 = tmpvar_41;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6;
  highp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.w;
  tmpvar_8.y = xlv_TEXCOORD1.w;
  tmpvar_8.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_9;
  worldViewDir_5 = normalize((_WorldSpaceCameraPos - tmpvar_8));
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_10 = tmpvar_13;
  tmpvar_4 = (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  worldN_1.x = xlv_TEXCOORD0.z;
  worldN_1.y = xlv_TEXCOORD1.z;
  worldN_1.z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(worldN_1);
  worldN_1 = tmpvar_14;
  tmpvar_3 = tmpvar_14;
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump vec3 viewDir_16;
  viewDir_16 = worldViewDir_5;
  mediump vec4 specular_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  specular_17.w = 0.0;
  specular_17.xyz = (pow (vec3(clamp (
    dot (tmpvar_18, normalize((viewDir_16 + lightDir_15)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (dot (viewDir_16, tmpvar_18), 0.0, 1.0);
  mediump float perceptualRoughness_20;
  perceptualRoughness_20 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = (-(viewDir_16) - ((2.0 * tmpvar_18) * -(tmpvar_19)));
  tmpvar_21.w = ((perceptualRoughness_20 * (1.7 - 
    (0.7 * perceptualRoughness_20)
  )) * 6.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_21.xyz, tmpvar_21.w);
  mediump vec4 tmpvar_23;
  tmpvar_23 = tmpvar_22;
  specular_17.xyz = (specular_17.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_23.w - 1.0)
    ) + 1.0)) * tmpvar_23.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_19)));
  specular_17.xyz = (specular_17.xyz * vec3((_EyeSpec * tex_11.w)));
  c_2 = specular_17;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  lowp vec4 color_24;
  color_24.w = c_2.w;
  color_24.xyz = mix (tmpvar_7.xyz, c_2.xyz, tmpvar_7.www);
  c_2.xyz = color_24.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp vec3 worldBinormal_5;
  lowp float tangentSign_6;
  lowp vec3 worldTangent_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_1.xyz;
  highp float tmpvar_28;
  tmpvar_28 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27)).z);
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_29.w = exp2((-(tmpvar_28) * tmpvar_28));
  envFogColor_12 = (tmpvar_29 * _CharacterColor);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_32;
  norm_32 = tmpvar_3;
  highp mat3 tmpvar_33;
  tmpvar_33[0] = unity_WorldToObject[0].xyz;
  tmpvar_33[1] = unity_WorldToObject[1].xyz;
  tmpvar_33[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((norm_32 * tmpvar_33));
  highp mat3 tmpvar_35;
  tmpvar_35[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_35[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_35[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((tmpvar_35 * _glesTANGENT.xyz));
  worldTangent_7 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_6 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (((tmpvar_34.yzx * worldTangent_7.zxy) - (tmpvar_34.zxy * worldTangent_7.yzx)) * tangentSign_6);
  worldBinormal_5 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.x = worldTangent_7.x;
  tmpvar_39.y = worldBinormal_5.x;
  tmpvar_39.z = tmpvar_34.x;
  tmpvar_39.w = tmpvar_31.x;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_7.y;
  tmpvar_40.y = worldBinormal_5.y;
  tmpvar_40.z = tmpvar_34.y;
  tmpvar_40.w = tmpvar_31.y;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_7.z;
  tmpvar_41.y = worldBinormal_5.z;
  tmpvar_41.z = tmpvar_34.z;
  tmpvar_41.w = tmpvar_31.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
  xlv_TEXCOORD0 = tmpvar_39;
  xlv_TEXCOORD1 = tmpvar_40;
  xlv_TEXCOORD2 = tmpvar_41;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6;
  highp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.w;
  tmpvar_8.y = xlv_TEXCOORD1.w;
  tmpvar_8.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_9;
  worldViewDir_5 = normalize((_WorldSpaceCameraPos - tmpvar_8));
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_10 = tmpvar_13;
  tmpvar_4 = (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  worldN_1.x = xlv_TEXCOORD0.z;
  worldN_1.y = xlv_TEXCOORD1.z;
  worldN_1.z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(worldN_1);
  worldN_1 = tmpvar_14;
  tmpvar_3 = tmpvar_14;
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump vec3 viewDir_16;
  viewDir_16 = worldViewDir_5;
  mediump vec4 specular_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  specular_17.w = 0.0;
  specular_17.xyz = (pow (vec3(clamp (
    dot (tmpvar_18, normalize((viewDir_16 + lightDir_15)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (dot (viewDir_16, tmpvar_18), 0.0, 1.0);
  mediump float perceptualRoughness_20;
  perceptualRoughness_20 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = (-(viewDir_16) - ((2.0 * tmpvar_18) * -(tmpvar_19)));
  tmpvar_21.w = ((perceptualRoughness_20 * (1.7 - 
    (0.7 * perceptualRoughness_20)
  )) * 6.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_21.xyz, tmpvar_21.w);
  mediump vec4 tmpvar_23;
  tmpvar_23 = tmpvar_22;
  specular_17.xyz = (specular_17.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_23.w - 1.0)
    ) + 1.0)) * tmpvar_23.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_19)));
  specular_17.xyz = (specular_17.xyz * vec3((_EyeSpec * tex_11.w)));
  c_2 = specular_17;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  lowp vec4 color_24;
  color_24.w = c_2.w;
  color_24.xyz = mix (tmpvar_7.xyz, c_2.xyz, tmpvar_7.www);
  c_2.xyz = color_24.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" }
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
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec4 envFogColor_9;
  mediump vec4 tcXFORM_10;
  mediump vec3 vNormal_11;
  mediump vec3 viewDir_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  viewDir_12 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = tmpvar_3;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((unity_ObjectToWorld * tmpvar_15).xyz);
  vNormal_11 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (vNormal_11, viewDir_12), 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = dot (vNormal_11, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_17;
  tmpvar_19.y = (((tmpvar_18 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_19;
  tmpvar_6.z = ((tmpvar_18 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_17);
  tcXFORM_10 = tmpvar_2;
  tmpvar_7.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_7.w = tmpvar_4.w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20)).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  envFogColor_9 = (tmpvar_22 * _CharacterColor);
  tmpvar_8 = envFogColor_9;
  tmpvar_5 = tmpvar_8;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_1.xyz;
  highp vec3 norm_24;
  norm_24 = tmpvar_3;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
  xlv_TEXCOORD0 = normalize((norm_24 * tmpvar_25));
  xlv_TEXCOORD1 = tmpvar_14.xyz;
  xlv_TEXCOORD2 = tcXFORM_10;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD5;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_2 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_3.xyz, c_1.xyz, tmpvar_3.www);
  c_1.xyz = color_9.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" }
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
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec4 envFogColor_9;
  mediump vec4 tcXFORM_10;
  mediump vec3 vNormal_11;
  mediump vec3 viewDir_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  viewDir_12 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = tmpvar_3;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((unity_ObjectToWorld * tmpvar_15).xyz);
  vNormal_11 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (vNormal_11, viewDir_12), 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = dot (vNormal_11, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_17;
  tmpvar_19.y = (((tmpvar_18 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_19;
  tmpvar_6.z = ((tmpvar_18 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_17);
  tcXFORM_10 = tmpvar_2;
  tmpvar_7.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_7.w = tmpvar_4.w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20)).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  envFogColor_9 = (tmpvar_22 * _CharacterColor);
  tmpvar_8 = envFogColor_9;
  tmpvar_5 = tmpvar_8;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_1.xyz;
  highp vec3 norm_24;
  norm_24 = tmpvar_3;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
  xlv_TEXCOORD0 = normalize((norm_24 * tmpvar_25));
  xlv_TEXCOORD1 = tmpvar_14.xyz;
  xlv_TEXCOORD2 = tcXFORM_10;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD5;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_2 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_3.xyz, c_1.xyz, tmpvar_3.www);
  c_1.xyz = color_9.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" }
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
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec4 envFogColor_9;
  mediump vec4 tcXFORM_10;
  mediump vec3 vNormal_11;
  mediump vec3 viewDir_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  viewDir_12 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = tmpvar_3;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((unity_ObjectToWorld * tmpvar_15).xyz);
  vNormal_11 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (vNormal_11, viewDir_12), 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = dot (vNormal_11, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_17;
  tmpvar_19.y = (((tmpvar_18 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_19;
  tmpvar_6.z = ((tmpvar_18 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_17);
  tcXFORM_10 = tmpvar_2;
  tmpvar_7.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_7.w = tmpvar_4.w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20)).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  envFogColor_9 = (tmpvar_22 * _CharacterColor);
  tmpvar_8 = envFogColor_9;
  tmpvar_5 = tmpvar_8;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_1.xyz;
  highp vec3 norm_24;
  norm_24 = tmpvar_3;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
  xlv_TEXCOORD0 = normalize((norm_24 * tmpvar_25));
  xlv_TEXCOORD1 = tmpvar_14.xyz;
  xlv_TEXCOORD2 = tcXFORM_10;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD5;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_2 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_3.xyz, c_1.xyz, tmpvar_3.www);
  c_1.xyz = color_9.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp vec3 worldBinormal_5;
  lowp float tangentSign_6;
  lowp vec3 worldTangent_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_1.xyz;
  highp float tmpvar_28;
  tmpvar_28 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27)).z);
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_29.w = exp2((-(tmpvar_28) * tmpvar_28));
  envFogColor_12 = (tmpvar_29 * _CharacterColor);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_32;
  norm_32 = tmpvar_3;
  highp mat3 tmpvar_33;
  tmpvar_33[0] = unity_WorldToObject[0].xyz;
  tmpvar_33[1] = unity_WorldToObject[1].xyz;
  tmpvar_33[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((norm_32 * tmpvar_33));
  highp mat3 tmpvar_35;
  tmpvar_35[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_35[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_35[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((tmpvar_35 * _glesTANGENT.xyz));
  worldTangent_7 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_6 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (((tmpvar_34.yzx * worldTangent_7.zxy) - (tmpvar_34.zxy * worldTangent_7.yzx)) * tangentSign_6);
  worldBinormal_5 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.x = worldTangent_7.x;
  tmpvar_39.y = worldBinormal_5.x;
  tmpvar_39.z = tmpvar_34.x;
  tmpvar_39.w = tmpvar_31.x;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_7.y;
  tmpvar_40.y = worldBinormal_5.y;
  tmpvar_40.z = tmpvar_34.y;
  tmpvar_40.w = tmpvar_31.y;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_7.z;
  tmpvar_41.y = worldBinormal_5.z;
  tmpvar_41.z = tmpvar_34.z;
  tmpvar_41.w = tmpvar_31.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
  xlv_TEXCOORD0 = tmpvar_39;
  xlv_TEXCOORD1 = tmpvar_40;
  xlv_TEXCOORD2 = tmpvar_41;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6;
  highp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.w;
  tmpvar_8.y = xlv_TEXCOORD1.w;
  tmpvar_8.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_9;
  worldViewDir_5 = normalize((_WorldSpaceCameraPos - tmpvar_8));
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_10 = tmpvar_13;
  tmpvar_4 = (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  worldN_1.x = xlv_TEXCOORD0.z;
  worldN_1.y = xlv_TEXCOORD1.z;
  worldN_1.z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(worldN_1);
  worldN_1 = tmpvar_14;
  tmpvar_3 = tmpvar_14;
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump vec3 viewDir_16;
  viewDir_16 = worldViewDir_5;
  mediump vec4 specular_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  specular_17.w = 0.0;
  specular_17.xyz = (pow (vec3(clamp (
    dot (tmpvar_18, normalize((viewDir_16 + lightDir_15)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (dot (viewDir_16, tmpvar_18), 0.0, 1.0);
  mediump float perceptualRoughness_20;
  perceptualRoughness_20 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = (-(viewDir_16) - ((2.0 * tmpvar_18) * -(tmpvar_19)));
  tmpvar_21.w = ((perceptualRoughness_20 * (1.7 - 
    (0.7 * perceptualRoughness_20)
  )) * 6.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_21.xyz, tmpvar_21.w);
  mediump vec4 tmpvar_23;
  tmpvar_23 = tmpvar_22;
  specular_17.xyz = (specular_17.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_23.w - 1.0)
    ) + 1.0)) * tmpvar_23.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_19)));
  specular_17.xyz = (specular_17.xyz * vec3((_EyeSpec * tex_11.w)));
  c_2 = specular_17;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  lowp vec4 color_24;
  color_24.w = c_2.w;
  color_24.xyz = mix (tmpvar_7.xyz, c_2.xyz, tmpvar_7.www);
  c_2.xyz = color_24.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp vec3 worldBinormal_5;
  lowp float tangentSign_6;
  lowp vec3 worldTangent_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_1.xyz;
  highp float tmpvar_28;
  tmpvar_28 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27)).z);
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_29.w = exp2((-(tmpvar_28) * tmpvar_28));
  envFogColor_12 = (tmpvar_29 * _CharacterColor);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_32;
  norm_32 = tmpvar_3;
  highp mat3 tmpvar_33;
  tmpvar_33[0] = unity_WorldToObject[0].xyz;
  tmpvar_33[1] = unity_WorldToObject[1].xyz;
  tmpvar_33[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((norm_32 * tmpvar_33));
  highp mat3 tmpvar_35;
  tmpvar_35[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_35[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_35[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((tmpvar_35 * _glesTANGENT.xyz));
  worldTangent_7 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_6 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (((tmpvar_34.yzx * worldTangent_7.zxy) - (tmpvar_34.zxy * worldTangent_7.yzx)) * tangentSign_6);
  worldBinormal_5 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.x = worldTangent_7.x;
  tmpvar_39.y = worldBinormal_5.x;
  tmpvar_39.z = tmpvar_34.x;
  tmpvar_39.w = tmpvar_31.x;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_7.y;
  tmpvar_40.y = worldBinormal_5.y;
  tmpvar_40.z = tmpvar_34.y;
  tmpvar_40.w = tmpvar_31.y;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_7.z;
  tmpvar_41.y = worldBinormal_5.z;
  tmpvar_41.z = tmpvar_34.z;
  tmpvar_41.w = tmpvar_31.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
  xlv_TEXCOORD0 = tmpvar_39;
  xlv_TEXCOORD1 = tmpvar_40;
  xlv_TEXCOORD2 = tmpvar_41;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6;
  highp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.w;
  tmpvar_8.y = xlv_TEXCOORD1.w;
  tmpvar_8.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_9;
  worldViewDir_5 = normalize((_WorldSpaceCameraPos - tmpvar_8));
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_10 = tmpvar_13;
  tmpvar_4 = (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  worldN_1.x = xlv_TEXCOORD0.z;
  worldN_1.y = xlv_TEXCOORD1.z;
  worldN_1.z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(worldN_1);
  worldN_1 = tmpvar_14;
  tmpvar_3 = tmpvar_14;
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump vec3 viewDir_16;
  viewDir_16 = worldViewDir_5;
  mediump vec4 specular_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  specular_17.w = 0.0;
  specular_17.xyz = (pow (vec3(clamp (
    dot (tmpvar_18, normalize((viewDir_16 + lightDir_15)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (dot (viewDir_16, tmpvar_18), 0.0, 1.0);
  mediump float perceptualRoughness_20;
  perceptualRoughness_20 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = (-(viewDir_16) - ((2.0 * tmpvar_18) * -(tmpvar_19)));
  tmpvar_21.w = ((perceptualRoughness_20 * (1.7 - 
    (0.7 * perceptualRoughness_20)
  )) * 6.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_21.xyz, tmpvar_21.w);
  mediump vec4 tmpvar_23;
  tmpvar_23 = tmpvar_22;
  specular_17.xyz = (specular_17.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_23.w - 1.0)
    ) + 1.0)) * tmpvar_23.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_19)));
  specular_17.xyz = (specular_17.xyz * vec3((_EyeSpec * tex_11.w)));
  c_2 = specular_17;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  lowp vec4 color_24;
  color_24.w = c_2.w;
  color_24.xyz = mix (tmpvar_7.xyz, c_2.xyz, tmpvar_7.www);
  c_2.xyz = color_24.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp vec3 worldBinormal_5;
  lowp float tangentSign_6;
  lowp vec3 worldTangent_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_1.xyz;
  highp float tmpvar_28;
  tmpvar_28 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27)).z);
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_29.w = exp2((-(tmpvar_28) * tmpvar_28));
  envFogColor_12 = (tmpvar_29 * _CharacterColor);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_32;
  norm_32 = tmpvar_3;
  highp mat3 tmpvar_33;
  tmpvar_33[0] = unity_WorldToObject[0].xyz;
  tmpvar_33[1] = unity_WorldToObject[1].xyz;
  tmpvar_33[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((norm_32 * tmpvar_33));
  highp mat3 tmpvar_35;
  tmpvar_35[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_35[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_35[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((tmpvar_35 * _glesTANGENT.xyz));
  worldTangent_7 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_6 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (((tmpvar_34.yzx * worldTangent_7.zxy) - (tmpvar_34.zxy * worldTangent_7.yzx)) * tangentSign_6);
  worldBinormal_5 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.x = worldTangent_7.x;
  tmpvar_39.y = worldBinormal_5.x;
  tmpvar_39.z = tmpvar_34.x;
  tmpvar_39.w = tmpvar_31.x;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_7.y;
  tmpvar_40.y = worldBinormal_5.y;
  tmpvar_40.z = tmpvar_34.y;
  tmpvar_40.w = tmpvar_31.y;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_7.z;
  tmpvar_41.y = worldBinormal_5.z;
  tmpvar_41.z = tmpvar_34.z;
  tmpvar_41.w = tmpvar_31.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
  xlv_TEXCOORD0 = tmpvar_39;
  xlv_TEXCOORD1 = tmpvar_40;
  xlv_TEXCOORD2 = tmpvar_41;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldViewDir_5;
  lowp vec3 lightDir_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6;
  highp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.w;
  tmpvar_8.y = xlv_TEXCOORD1.w;
  tmpvar_8.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_9;
  worldViewDir_5 = normalize((_WorldSpaceCameraPos - tmpvar_8));
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_10 = tmpvar_13;
  tmpvar_4 = (((
    (tex_11.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_10.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_10.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  worldN_1.x = xlv_TEXCOORD0.z;
  worldN_1.y = xlv_TEXCOORD1.z;
  worldN_1.z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(worldN_1);
  worldN_1 = tmpvar_14;
  tmpvar_3 = tmpvar_14;
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_6;
  mediump vec3 viewDir_16;
  viewDir_16 = worldViewDir_5;
  mediump vec4 specular_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  specular_17.w = 0.0;
  specular_17.xyz = (pow (vec3(clamp (
    dot (tmpvar_18, normalize((viewDir_16 + lightDir_15)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (dot (viewDir_16, tmpvar_18), 0.0, 1.0);
  mediump float perceptualRoughness_20;
  perceptualRoughness_20 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = (-(viewDir_16) - ((2.0 * tmpvar_18) * -(tmpvar_19)));
  tmpvar_21.w = ((perceptualRoughness_20 * (1.7 - 
    (0.7 * perceptualRoughness_20)
  )) * 6.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_21.xyz, tmpvar_21.w);
  mediump vec4 tmpvar_23;
  tmpvar_23 = tmpvar_22;
  specular_17.xyz = (specular_17.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_23.w - 1.0)
    ) + 1.0)) * tmpvar_23.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_19)));
  specular_17.xyz = (specular_17.xyz * vec3((_EyeSpec * tex_11.w)));
  c_2 = specular_17;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  lowp vec4 color_24;
  color_24.w = c_2.w;
  color_24.xyz = mix (tmpvar_7.xyz, c_2.xyz, tmpvar_7.www);
  c_2.xyz = color_24.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_SPECULAR_VERTEX" }
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
Keywords { "DIRECTIONAL" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
}
}
}
}