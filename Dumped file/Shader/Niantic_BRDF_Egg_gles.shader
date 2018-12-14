Shader "Niantic/BRDF/Egg" {
Properties {
_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
_Ramp2D ("BRDF Ramp", 2D) = "grey" { }
_Amount_Blend ("BRDF Amount", Range(0, 2)) = 1
_Amount_Wrap ("Lambert Wrap Amount", Range(0, 1)) = 0
_cTint ("Tint", Color) = (0,0,0,0.5)
_cDiff ("Diffuse", Color) = (1,1,1,0.5)
_cAmbn ("Ambient", Color) = (0,0,0,0.5)
_cKeyf ("Shine Color (.a=0.5)", Color) = (1,1,1,0.5)
_cRimt ("RimTop   (.a=0.5)", Color) = (1,1,0,0.5)
_cRimb ("RimBottom(.a=0.5)", Color) = (0.5,0.5,0.5,0.5)
_Amount_RimLt ("RimLight Mult", Range(0, 2)) = 1
[Space] [Header(AO_MODE_____________________________)] [Space] [KeywordEnum(OFF, HUE)] AO_MODE ("Toggle AO_MODE", Float) = 0
_vAmOc ("vAmbOcclusion", Color) = (0,0,0,1)
_vAmOcPower ("vAmbOcclusion Power", Range(0.1, 10)) = 1
_vAmTxPower ("vAmbTexture Power", Range(1, 10)) = 5
[Space] [Header(SPECULAR____________)] [Space] _Spec ("Specular", Range(0, 1)) = 1
_Gloss ("Glossiness", Range(0.025, 100)) = 0.95
[Space] [Header(FRESNEL_____________)] [Space] _FresnelEdge ("Fresnel Outer Color", Color) = (1,1,1,0)
_FresnelCenter ("Fresnel Center Color", Color) = (0,0,0,0)
_FresnelBias ("Fresnel Bias", Float) = 0
_FresnelPinch ("Fresnel Pinch", Float) = 1
_FresnelPower ("Fresnel Power", Float) = 1
[Space] [Header(FX_____________)] [Space] _cOverride ("Color override (rgb = color, a = blend)", Color) = (1,1,1,0)
_CrackTex ("Crack Texture", 2D) = "black" { }
_CrackAmount ("Crack Amount", Range(0, 0.999)) = 0
}
SubShader {
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  GpuProgramID 38636
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
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CrackTex_ST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_13;
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.95);
  tmpvar_5.xy = tmpvar_15;
  tmpvar_5.z = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.w = (1.0 - tmpvar_13);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16)).z);
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_18.w = exp2((-(tmpvar_17) * tmpvar_17));
  tmpvar_6 = tmpvar_18;
  tmpvar_3 = tmpvar_6;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp vec3 norm_20;
  norm_20 = tmpvar_2;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_19));
  xlv_TEXCOORD0 = normalize((norm_20 * tmpvar_21));
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CrackTex_ST.xy) + _CrackTex_ST.zw);
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
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
uniform mediump vec4 _cOverride;
uniform lowp vec4 _FresnelEdge;
uniform lowp vec4 _FresnelCenter;
uniform lowp float _FresnelBias;
uniform lowp float _FresnelPinch;
uniform lowp float _FresnelPower;
uniform sampler2D _CrackTex;
uniform lowp float _CrackAmount;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump float _Spec;
uniform mediump float _Gloss;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldViewDir_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  worldViewDir_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  tmpvar_2 = xlv_TEXCOORD0;
  mediump vec3 finalColor_6;
  mediump vec4 brdf_7;
  mediump vec4 crackTex_8;
  mediump vec4 tex_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CrackTex, xlv_TEXCOORD3);
  crackTex_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_7 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_FresnelEdge, _FresnelCenter, vec4(pow (clamp (
    (xlv_TEXCOORD4.x + _FresnelBias)
  , 0.0, 1.0), _FresnelPinch)));
  lowp float edge_14;
  edge_14 = (1.0 - _CrackAmount);
  lowp float edge_15;
  edge_15 = (1.05 - _CrackAmount);
  mediump float tmpvar_16;
  tmpvar_16 = float((crackTex_8.x >= edge_15));
  finalColor_6 = (mix ((
    ((tex_9.xyz * (clamp (
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_7.yyy) + ((_cRimb.xyz * brdf_7.w) * (_cRimb.w * 2.0)))
    , 0.0, 1.0) + (
      (((_cKeyf.xyz * brdf_7.z) * (_cKeyf.w * 2.0)) + ((_cRimt.xyz * brdf_7.x) * (_cRimt.w * 2.0)))
     * _Amount_RimLt))) * _Amount_Blend)
   * xlv_TEXCOORD4.z), (tmpvar_13.xyz * _FresnelPower), tmpvar_13.www) * max ((
    (1.0 - float((crackTex_8.x >= edge_14)))
   + tmpvar_16), 0.75));
  finalColor_6 = (finalColor_6 + ((tmpvar_16 * 2.0) * crackTex_8.y));
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (finalColor_6, _cOverride.xyz, _cOverride.www);
  mediump vec3 lightDir_18;
  lightDir_18 = lightDir_4;
  mediump vec3 viewDir_19;
  viewDir_19 = worldViewDir_3;
  mediump vec4 specular_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_2);
  specular_20.w = 0.0;
  specular_20.xyz = (pow (vec3(clamp (
    dot (tmpvar_21, normalize((viewDir_19 + lightDir_18)))
  , 0.0, 1.0)), vec3((_Gloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (dot (viewDir_19, tmpvar_21), 0.0, 1.0);
  mediump float perceptualRoughness_23;
  perceptualRoughness_23 = (1.0 - _Gloss);
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = (-(viewDir_19) - ((2.0 * tmpvar_21) * -(tmpvar_22)));
  tmpvar_24.w = ((perceptualRoughness_23 * (1.7 - 
    (0.7 * perceptualRoughness_23)
  )) * 6.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_24.xyz, tmpvar_24.w);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  specular_20.xyz = (specular_20.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_26.w - 1.0)
    ) + 1.0)) * tmpvar_26.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_22)));
  specular_20.xyz = (specular_20.xyz * vec3(_Spec));
  c_1 = specular_20;
  c_1.xyz = (c_1.xyz + tmpvar_17);
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
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CrackTex_ST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_13;
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.95);
  tmpvar_5.xy = tmpvar_15;
  tmpvar_5.z = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.w = (1.0 - tmpvar_13);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16)).z);
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_18.w = exp2((-(tmpvar_17) * tmpvar_17));
  tmpvar_6 = tmpvar_18;
  tmpvar_3 = tmpvar_6;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp vec3 norm_20;
  norm_20 = tmpvar_2;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_19));
  xlv_TEXCOORD0 = normalize((norm_20 * tmpvar_21));
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CrackTex_ST.xy) + _CrackTex_ST.zw);
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
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
uniform mediump vec4 _cOverride;
uniform lowp vec4 _FresnelEdge;
uniform lowp vec4 _FresnelCenter;
uniform lowp float _FresnelBias;
uniform lowp float _FresnelPinch;
uniform lowp float _FresnelPower;
uniform sampler2D _CrackTex;
uniform lowp float _CrackAmount;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump float _Spec;
uniform mediump float _Gloss;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldViewDir_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  worldViewDir_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  tmpvar_2 = xlv_TEXCOORD0;
  mediump vec3 finalColor_6;
  mediump vec4 brdf_7;
  mediump vec4 crackTex_8;
  mediump vec4 tex_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CrackTex, xlv_TEXCOORD3);
  crackTex_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_7 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_FresnelEdge, _FresnelCenter, vec4(pow (clamp (
    (xlv_TEXCOORD4.x + _FresnelBias)
  , 0.0, 1.0), _FresnelPinch)));
  lowp float edge_14;
  edge_14 = (1.0 - _CrackAmount);
  lowp float edge_15;
  edge_15 = (1.05 - _CrackAmount);
  mediump float tmpvar_16;
  tmpvar_16 = float((crackTex_8.x >= edge_15));
  finalColor_6 = (mix ((
    ((tex_9.xyz * (clamp (
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_7.yyy) + ((_cRimb.xyz * brdf_7.w) * (_cRimb.w * 2.0)))
    , 0.0, 1.0) + (
      (((_cKeyf.xyz * brdf_7.z) * (_cKeyf.w * 2.0)) + ((_cRimt.xyz * brdf_7.x) * (_cRimt.w * 2.0)))
     * _Amount_RimLt))) * _Amount_Blend)
   * xlv_TEXCOORD4.z), (tmpvar_13.xyz * _FresnelPower), tmpvar_13.www) * max ((
    (1.0 - float((crackTex_8.x >= edge_14)))
   + tmpvar_16), 0.75));
  finalColor_6 = (finalColor_6 + ((tmpvar_16 * 2.0) * crackTex_8.y));
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (finalColor_6, _cOverride.xyz, _cOverride.www);
  mediump vec3 lightDir_18;
  lightDir_18 = lightDir_4;
  mediump vec3 viewDir_19;
  viewDir_19 = worldViewDir_3;
  mediump vec4 specular_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_2);
  specular_20.w = 0.0;
  specular_20.xyz = (pow (vec3(clamp (
    dot (tmpvar_21, normalize((viewDir_19 + lightDir_18)))
  , 0.0, 1.0)), vec3((_Gloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (dot (viewDir_19, tmpvar_21), 0.0, 1.0);
  mediump float perceptualRoughness_23;
  perceptualRoughness_23 = (1.0 - _Gloss);
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = (-(viewDir_19) - ((2.0 * tmpvar_21) * -(tmpvar_22)));
  tmpvar_24.w = ((perceptualRoughness_23 * (1.7 - 
    (0.7 * perceptualRoughness_23)
  )) * 6.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_24.xyz, tmpvar_24.w);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  specular_20.xyz = (specular_20.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_26.w - 1.0)
    ) + 1.0)) * tmpvar_26.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_22)));
  specular_20.xyz = (specular_20.xyz * vec3(_Spec));
  c_1 = specular_20;
  c_1.xyz = (c_1.xyz + tmpvar_17);
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
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CrackTex_ST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_13;
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.95);
  tmpvar_5.xy = tmpvar_15;
  tmpvar_5.z = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.w = (1.0 - tmpvar_13);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16)).z);
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_18.w = exp2((-(tmpvar_17) * tmpvar_17));
  tmpvar_6 = tmpvar_18;
  tmpvar_3 = tmpvar_6;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp vec3 norm_20;
  norm_20 = tmpvar_2;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_19));
  xlv_TEXCOORD0 = normalize((norm_20 * tmpvar_21));
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CrackTex_ST.xy) + _CrackTex_ST.zw);
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
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
uniform mediump vec4 _cOverride;
uniform lowp vec4 _FresnelEdge;
uniform lowp vec4 _FresnelCenter;
uniform lowp float _FresnelBias;
uniform lowp float _FresnelPinch;
uniform lowp float _FresnelPower;
uniform sampler2D _CrackTex;
uniform lowp float _CrackAmount;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump float _Spec;
uniform mediump float _Gloss;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldViewDir_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  worldViewDir_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  tmpvar_2 = xlv_TEXCOORD0;
  mediump vec3 finalColor_6;
  mediump vec4 brdf_7;
  mediump vec4 crackTex_8;
  mediump vec4 tex_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CrackTex, xlv_TEXCOORD3);
  crackTex_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_7 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_FresnelEdge, _FresnelCenter, vec4(pow (clamp (
    (xlv_TEXCOORD4.x + _FresnelBias)
  , 0.0, 1.0), _FresnelPinch)));
  lowp float edge_14;
  edge_14 = (1.0 - _CrackAmount);
  lowp float edge_15;
  edge_15 = (1.05 - _CrackAmount);
  mediump float tmpvar_16;
  tmpvar_16 = float((crackTex_8.x >= edge_15));
  finalColor_6 = (mix ((
    ((tex_9.xyz * (clamp (
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_7.yyy) + ((_cRimb.xyz * brdf_7.w) * (_cRimb.w * 2.0)))
    , 0.0, 1.0) + (
      (((_cKeyf.xyz * brdf_7.z) * (_cKeyf.w * 2.0)) + ((_cRimt.xyz * brdf_7.x) * (_cRimt.w * 2.0)))
     * _Amount_RimLt))) * _Amount_Blend)
   * xlv_TEXCOORD4.z), (tmpvar_13.xyz * _FresnelPower), tmpvar_13.www) * max ((
    (1.0 - float((crackTex_8.x >= edge_14)))
   + tmpvar_16), 0.75));
  finalColor_6 = (finalColor_6 + ((tmpvar_16 * 2.0) * crackTex_8.y));
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (finalColor_6, _cOverride.xyz, _cOverride.www);
  mediump vec3 lightDir_18;
  lightDir_18 = lightDir_4;
  mediump vec3 viewDir_19;
  viewDir_19 = worldViewDir_3;
  mediump vec4 specular_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_2);
  specular_20.w = 0.0;
  specular_20.xyz = (pow (vec3(clamp (
    dot (tmpvar_21, normalize((viewDir_19 + lightDir_18)))
  , 0.0, 1.0)), vec3((_Gloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (dot (viewDir_19, tmpvar_21), 0.0, 1.0);
  mediump float perceptualRoughness_23;
  perceptualRoughness_23 = (1.0 - _Gloss);
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = (-(viewDir_19) - ((2.0 * tmpvar_21) * -(tmpvar_22)));
  tmpvar_24.w = ((perceptualRoughness_23 * (1.7 - 
    (0.7 * perceptualRoughness_23)
  )) * 6.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_24.xyz, tmpvar_24.w);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  specular_20.xyz = (specular_20.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_26.w - 1.0)
    ) + 1.0)) * tmpvar_26.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_22)));
  specular_20.xyz = (specular_20.xyz * vec3(_Spec));
  c_1 = specular_20;
  c_1.xyz = (c_1.xyz + tmpvar_17);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CrackTex_ST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_13;
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.95);
  tmpvar_5.xy = tmpvar_15;
  tmpvar_5.z = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.w = (1.0 - tmpvar_13);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16)).z);
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_18.w = exp2((-(tmpvar_17) * tmpvar_17));
  tmpvar_6 = tmpvar_18;
  tmpvar_3 = tmpvar_6;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp vec3 norm_20;
  norm_20 = tmpvar_2;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_19));
  xlv_TEXCOORD0 = normalize((norm_20 * tmpvar_21));
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CrackTex_ST.xy) + _CrackTex_ST.zw);
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
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
uniform mediump vec4 _cOverride;
uniform lowp vec4 _FresnelEdge;
uniform lowp vec4 _FresnelCenter;
uniform lowp float _FresnelBias;
uniform lowp float _FresnelPinch;
uniform lowp float _FresnelPower;
uniform sampler2D _CrackTex;
uniform lowp float _CrackAmount;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump float _Spec;
uniform mediump float _Gloss;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldViewDir_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  worldViewDir_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  tmpvar_2 = xlv_TEXCOORD0;
  mediump vec3 finalColor_6;
  mediump vec4 brdf_7;
  mediump vec4 crackTex_8;
  mediump vec4 tex_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CrackTex, xlv_TEXCOORD3);
  crackTex_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_7 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_FresnelEdge, _FresnelCenter, vec4(pow (clamp (
    (xlv_TEXCOORD4.x + _FresnelBias)
  , 0.0, 1.0), _FresnelPinch)));
  lowp float edge_14;
  edge_14 = (1.0 - _CrackAmount);
  lowp float edge_15;
  edge_15 = (1.05 - _CrackAmount);
  mediump float tmpvar_16;
  tmpvar_16 = float((crackTex_8.x >= edge_15));
  finalColor_6 = (mix ((
    ((tex_9.xyz * (clamp (
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_7.yyy) + ((_cRimb.xyz * brdf_7.w) * (_cRimb.w * 2.0)))
    , 0.0, 1.0) + (
      (((_cKeyf.xyz * brdf_7.z) * (_cKeyf.w * 2.0)) + ((_cRimt.xyz * brdf_7.x) * (_cRimt.w * 2.0)))
     * _Amount_RimLt))) * _Amount_Blend)
   * xlv_TEXCOORD4.z), (tmpvar_13.xyz * _FresnelPower), tmpvar_13.www) * max ((
    (1.0 - float((crackTex_8.x >= edge_14)))
   + tmpvar_16), 0.75));
  finalColor_6 = (finalColor_6 + ((tmpvar_16 * 2.0) * crackTex_8.y));
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (finalColor_6, _cOverride.xyz, _cOverride.www);
  mediump vec3 lightDir_18;
  lightDir_18 = lightDir_4;
  mediump vec3 viewDir_19;
  viewDir_19 = worldViewDir_3;
  mediump vec4 specular_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_2);
  specular_20.w = 0.0;
  specular_20.xyz = (pow (vec3(clamp (
    dot (tmpvar_21, normalize((viewDir_19 + lightDir_18)))
  , 0.0, 1.0)), vec3((_Gloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (dot (viewDir_19, tmpvar_21), 0.0, 1.0);
  mediump float perceptualRoughness_23;
  perceptualRoughness_23 = (1.0 - _Gloss);
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = (-(viewDir_19) - ((2.0 * tmpvar_21) * -(tmpvar_22)));
  tmpvar_24.w = ((perceptualRoughness_23 * (1.7 - 
    (0.7 * perceptualRoughness_23)
  )) * 6.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_24.xyz, tmpvar_24.w);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  specular_20.xyz = (specular_20.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_26.w - 1.0)
    ) + 1.0)) * tmpvar_26.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_22)));
  specular_20.xyz = (specular_20.xyz * vec3(_Spec));
  c_1 = specular_20;
  c_1.xyz = (c_1.xyz + tmpvar_17);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CrackTex_ST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_13;
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.95);
  tmpvar_5.xy = tmpvar_15;
  tmpvar_5.z = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.w = (1.0 - tmpvar_13);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16)).z);
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_18.w = exp2((-(tmpvar_17) * tmpvar_17));
  tmpvar_6 = tmpvar_18;
  tmpvar_3 = tmpvar_6;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp vec3 norm_20;
  norm_20 = tmpvar_2;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_19));
  xlv_TEXCOORD0 = normalize((norm_20 * tmpvar_21));
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CrackTex_ST.xy) + _CrackTex_ST.zw);
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
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
uniform mediump vec4 _cOverride;
uniform lowp vec4 _FresnelEdge;
uniform lowp vec4 _FresnelCenter;
uniform lowp float _FresnelBias;
uniform lowp float _FresnelPinch;
uniform lowp float _FresnelPower;
uniform sampler2D _CrackTex;
uniform lowp float _CrackAmount;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump float _Spec;
uniform mediump float _Gloss;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldViewDir_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  worldViewDir_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  tmpvar_2 = xlv_TEXCOORD0;
  mediump vec3 finalColor_6;
  mediump vec4 brdf_7;
  mediump vec4 crackTex_8;
  mediump vec4 tex_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CrackTex, xlv_TEXCOORD3);
  crackTex_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_7 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_FresnelEdge, _FresnelCenter, vec4(pow (clamp (
    (xlv_TEXCOORD4.x + _FresnelBias)
  , 0.0, 1.0), _FresnelPinch)));
  lowp float edge_14;
  edge_14 = (1.0 - _CrackAmount);
  lowp float edge_15;
  edge_15 = (1.05 - _CrackAmount);
  mediump float tmpvar_16;
  tmpvar_16 = float((crackTex_8.x >= edge_15));
  finalColor_6 = (mix ((
    ((tex_9.xyz * (clamp (
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_7.yyy) + ((_cRimb.xyz * brdf_7.w) * (_cRimb.w * 2.0)))
    , 0.0, 1.0) + (
      (((_cKeyf.xyz * brdf_7.z) * (_cKeyf.w * 2.0)) + ((_cRimt.xyz * brdf_7.x) * (_cRimt.w * 2.0)))
     * _Amount_RimLt))) * _Amount_Blend)
   * xlv_TEXCOORD4.z), (tmpvar_13.xyz * _FresnelPower), tmpvar_13.www) * max ((
    (1.0 - float((crackTex_8.x >= edge_14)))
   + tmpvar_16), 0.75));
  finalColor_6 = (finalColor_6 + ((tmpvar_16 * 2.0) * crackTex_8.y));
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (finalColor_6, _cOverride.xyz, _cOverride.www);
  mediump vec3 lightDir_18;
  lightDir_18 = lightDir_4;
  mediump vec3 viewDir_19;
  viewDir_19 = worldViewDir_3;
  mediump vec4 specular_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_2);
  specular_20.w = 0.0;
  specular_20.xyz = (pow (vec3(clamp (
    dot (tmpvar_21, normalize((viewDir_19 + lightDir_18)))
  , 0.0, 1.0)), vec3((_Gloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (dot (viewDir_19, tmpvar_21), 0.0, 1.0);
  mediump float perceptualRoughness_23;
  perceptualRoughness_23 = (1.0 - _Gloss);
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = (-(viewDir_19) - ((2.0 * tmpvar_21) * -(tmpvar_22)));
  tmpvar_24.w = ((perceptualRoughness_23 * (1.7 - 
    (0.7 * perceptualRoughness_23)
  )) * 6.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_24.xyz, tmpvar_24.w);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  specular_20.xyz = (specular_20.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_26.w - 1.0)
    ) + 1.0)) * tmpvar_26.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_22)));
  specular_20.xyz = (specular_20.xyz * vec3(_Spec));
  c_1 = specular_20;
  c_1.xyz = (c_1.xyz + tmpvar_17);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CrackTex_ST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_2;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_13;
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.95);
  tmpvar_5.xy = tmpvar_15;
  tmpvar_5.z = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.w = (1.0 - tmpvar_13);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16)).z);
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_18.w = exp2((-(tmpvar_17) * tmpvar_17));
  tmpvar_6 = tmpvar_18;
  tmpvar_3 = tmpvar_6;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp vec3 norm_20;
  norm_20 = tmpvar_2;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_19));
  xlv_TEXCOORD0 = normalize((norm_20 * tmpvar_21));
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CrackTex_ST.xy) + _CrackTex_ST.zw);
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
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
uniform mediump vec4 _cOverride;
uniform lowp vec4 _FresnelEdge;
uniform lowp vec4 _FresnelCenter;
uniform lowp float _FresnelBias;
uniform lowp float _FresnelPinch;
uniform lowp float _FresnelPower;
uniform sampler2D _CrackTex;
uniform lowp float _CrackAmount;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump float _Spec;
uniform mediump float _Gloss;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldViewDir_3;
  lowp vec3 lightDir_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_5;
  worldViewDir_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  tmpvar_2 = xlv_TEXCOORD0;
  mediump vec3 finalColor_6;
  mediump vec4 brdf_7;
  mediump vec4 crackTex_8;
  mediump vec4 tex_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CrackTex, xlv_TEXCOORD3);
  crackTex_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_7 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_FresnelEdge, _FresnelCenter, vec4(pow (clamp (
    (xlv_TEXCOORD4.x + _FresnelBias)
  , 0.0, 1.0), _FresnelPinch)));
  lowp float edge_14;
  edge_14 = (1.0 - _CrackAmount);
  lowp float edge_15;
  edge_15 = (1.05 - _CrackAmount);
  mediump float tmpvar_16;
  tmpvar_16 = float((crackTex_8.x >= edge_15));
  finalColor_6 = (mix ((
    ((tex_9.xyz * (clamp (
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_7.yyy) + ((_cRimb.xyz * brdf_7.w) * (_cRimb.w * 2.0)))
    , 0.0, 1.0) + (
      (((_cKeyf.xyz * brdf_7.z) * (_cKeyf.w * 2.0)) + ((_cRimt.xyz * brdf_7.x) * (_cRimt.w * 2.0)))
     * _Amount_RimLt))) * _Amount_Blend)
   * xlv_TEXCOORD4.z), (tmpvar_13.xyz * _FresnelPower), tmpvar_13.www) * max ((
    (1.0 - float((crackTex_8.x >= edge_14)))
   + tmpvar_16), 0.75));
  finalColor_6 = (finalColor_6 + ((tmpvar_16 * 2.0) * crackTex_8.y));
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (finalColor_6, _cOverride.xyz, _cOverride.www);
  mediump vec3 lightDir_18;
  lightDir_18 = lightDir_4;
  mediump vec3 viewDir_19;
  viewDir_19 = worldViewDir_3;
  mediump vec4 specular_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_2);
  specular_20.w = 0.0;
  specular_20.xyz = (pow (vec3(clamp (
    dot (tmpvar_21, normalize((viewDir_19 + lightDir_18)))
  , 0.0, 1.0)), vec3((_Gloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (dot (viewDir_19, tmpvar_21), 0.0, 1.0);
  mediump float perceptualRoughness_23;
  perceptualRoughness_23 = (1.0 - _Gloss);
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = (-(viewDir_19) - ((2.0 * tmpvar_21) * -(tmpvar_22)));
  tmpvar_24.w = ((perceptualRoughness_23 * (1.7 - 
    (0.7 * perceptualRoughness_23)
  )) * 6.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_24.xyz, tmpvar_24.w);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  specular_20.xyz = (specular_20.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * 
      (tmpvar_26.w - 1.0)
    ) + 1.0)) * tmpvar_26.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_22)));
  specular_20.xyz = (specular_20.xyz * vec3(_Spec));
  c_1 = specular_20;
  c_1.xyz = (c_1.xyz + tmpvar_17);
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
}
}
}
}