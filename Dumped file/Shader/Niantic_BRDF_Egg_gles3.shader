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
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CrackTex_ST;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat25;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
mediump float u_xlat16_27;
void main()
{
    u_xlat16_0.x = _cKeyf.w + _cKeyf.w;
    u_xlat16_8.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_8.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_26 = vs_TEXCOORD4.x + _FresnelBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * _FresnelPinch;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_26) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_0.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat10_1.xy = texture(_CrackTex, vs_TEXCOORD3.xy).xy;
    u_xlatb1.xzw = greaterThanEqual(u_xlat10_1.xxxx, u_xlat16_3.xxyz).xzw;
    u_xlat16_3.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_3.y = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.w) ? float(2.0) : float(0.0);
    u_xlat16_26 = u_xlat10_1.y * u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.75);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xxx + vec3(u_xlat16_26);
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _cOverride.xyz;
    u_xlat16_2.xyz = _cOverride.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_1.x = (-_Gloss) + 1.0;
    u_xlat16_26 = (-u_xlat16_1.x) * 0.699999988 + 1.70000005;
    u_xlat16_26 = u_xlat16_1.x * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * 6.0;
    u_xlat16_3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat6.xyz = vec3(u_xlat25) * u_xlat5.xyz;
    u_xlat16_4.xyz = u_xlat5.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_27 = dot(u_xlat6.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat16_1.xyz) * (-vec3(u_xlat16_27)) + (-u_xlat6.xyz);
    u_xlat16_25 = (-u_xlat16_27) + 1.0;
    u_xlat10_0 = textureLod(unity_SpecCube0, u_xlat1.xyz, u_xlat16_26);
    u_xlat16_26 = u_xlat10_0.w + -1.0;
    u_xlat16_26 = unity_SpecCube0_HDR.w * u_xlat16_26 + 1.0;
    u_xlat16_26 = u_xlat16_26 * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.xyz = min(max(u_xlat16_7.xyz, 0.0), 1.0);
#else
    u_xlat16_7.xyz = clamp(u_xlat16_7.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vec3(u_xlat16_25) * u_xlat16_7.xyz;
    u_xlat16_26 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_4.xyz = vec3(u_xlat16_26) * u_xlat16_4.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_1.x = log2(u_xlat16_26);
    u_xlat16_9 = _Gloss * 128.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_3.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(_Spec) + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CrackTex_ST;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat25;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
mediump float u_xlat16_27;
void main()
{
    u_xlat16_0.x = _cKeyf.w + _cKeyf.w;
    u_xlat16_8.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_8.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_26 = vs_TEXCOORD4.x + _FresnelBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * _FresnelPinch;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_26) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_0.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat10_1.xy = texture(_CrackTex, vs_TEXCOORD3.xy).xy;
    u_xlatb1.xzw = greaterThanEqual(u_xlat10_1.xxxx, u_xlat16_3.xxyz).xzw;
    u_xlat16_3.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_3.y = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.w) ? float(2.0) : float(0.0);
    u_xlat16_26 = u_xlat10_1.y * u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.75);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xxx + vec3(u_xlat16_26);
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _cOverride.xyz;
    u_xlat16_2.xyz = _cOverride.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_1.x = (-_Gloss) + 1.0;
    u_xlat16_26 = (-u_xlat16_1.x) * 0.699999988 + 1.70000005;
    u_xlat16_26 = u_xlat16_1.x * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * 6.0;
    u_xlat16_3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat6.xyz = vec3(u_xlat25) * u_xlat5.xyz;
    u_xlat16_4.xyz = u_xlat5.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_27 = dot(u_xlat6.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat16_1.xyz) * (-vec3(u_xlat16_27)) + (-u_xlat6.xyz);
    u_xlat16_25 = (-u_xlat16_27) + 1.0;
    u_xlat10_0 = textureLod(unity_SpecCube0, u_xlat1.xyz, u_xlat16_26);
    u_xlat16_26 = u_xlat10_0.w + -1.0;
    u_xlat16_26 = unity_SpecCube0_HDR.w * u_xlat16_26 + 1.0;
    u_xlat16_26 = u_xlat16_26 * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.xyz = min(max(u_xlat16_7.xyz, 0.0), 1.0);
#else
    u_xlat16_7.xyz = clamp(u_xlat16_7.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vec3(u_xlat16_25) * u_xlat16_7.xyz;
    u_xlat16_26 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_4.xyz = vec3(u_xlat16_26) * u_xlat16_4.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_1.x = log2(u_xlat16_26);
    u_xlat16_9 = _Gloss * 128.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_3.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(_Spec) + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CrackTex_ST;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat25;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
mediump float u_xlat16_27;
void main()
{
    u_xlat16_0.x = _cKeyf.w + _cKeyf.w;
    u_xlat16_8.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_8.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_26 = vs_TEXCOORD4.x + _FresnelBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * _FresnelPinch;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_26) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_0.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat10_1.xy = texture(_CrackTex, vs_TEXCOORD3.xy).xy;
    u_xlatb1.xzw = greaterThanEqual(u_xlat10_1.xxxx, u_xlat16_3.xxyz).xzw;
    u_xlat16_3.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_3.y = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.w) ? float(2.0) : float(0.0);
    u_xlat16_26 = u_xlat10_1.y * u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.75);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xxx + vec3(u_xlat16_26);
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _cOverride.xyz;
    u_xlat16_2.xyz = _cOverride.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_1.x = (-_Gloss) + 1.0;
    u_xlat16_26 = (-u_xlat16_1.x) * 0.699999988 + 1.70000005;
    u_xlat16_26 = u_xlat16_1.x * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * 6.0;
    u_xlat16_3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat6.xyz = vec3(u_xlat25) * u_xlat5.xyz;
    u_xlat16_4.xyz = u_xlat5.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_27 = dot(u_xlat6.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat16_1.xyz) * (-vec3(u_xlat16_27)) + (-u_xlat6.xyz);
    u_xlat16_25 = (-u_xlat16_27) + 1.0;
    u_xlat10_0 = textureLod(unity_SpecCube0, u_xlat1.xyz, u_xlat16_26);
    u_xlat16_26 = u_xlat10_0.w + -1.0;
    u_xlat16_26 = unity_SpecCube0_HDR.w * u_xlat16_26 + 1.0;
    u_xlat16_26 = u_xlat16_26 * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.xyz = min(max(u_xlat16_7.xyz, 0.0), 1.0);
#else
    u_xlat16_7.xyz = clamp(u_xlat16_7.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vec3(u_xlat16_25) * u_xlat16_7.xyz;
    u_xlat16_26 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_4.xyz = vec3(u_xlat16_26) * u_xlat16_4.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_1.x = log2(u_xlat16_26);
    u_xlat16_9 = _Gloss * 128.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_3.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(_Spec) + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CrackTex_ST;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat25;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
mediump float u_xlat16_27;
void main()
{
    u_xlat16_0.x = _cKeyf.w + _cKeyf.w;
    u_xlat16_8.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_8.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_26 = vs_TEXCOORD4.x + _FresnelBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * _FresnelPinch;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_26) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_0.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat10_1.xy = texture(_CrackTex, vs_TEXCOORD3.xy).xy;
    u_xlatb1.xzw = greaterThanEqual(u_xlat10_1.xxxx, u_xlat16_3.xxyz).xzw;
    u_xlat16_3.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_3.y = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.w) ? float(2.0) : float(0.0);
    u_xlat16_26 = u_xlat10_1.y * u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.75);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xxx + vec3(u_xlat16_26);
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _cOverride.xyz;
    u_xlat16_2.xyz = _cOverride.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_1.x = (-_Gloss) + 1.0;
    u_xlat16_26 = (-u_xlat16_1.x) * 0.699999988 + 1.70000005;
    u_xlat16_26 = u_xlat16_1.x * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * 6.0;
    u_xlat16_3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat6.xyz = vec3(u_xlat25) * u_xlat5.xyz;
    u_xlat16_4.xyz = u_xlat5.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_27 = dot(u_xlat6.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat16_1.xyz) * (-vec3(u_xlat16_27)) + (-u_xlat6.xyz);
    u_xlat16_25 = (-u_xlat16_27) + 1.0;
    u_xlat10_0 = textureLod(unity_SpecCube0, u_xlat1.xyz, u_xlat16_26);
    u_xlat16_26 = u_xlat10_0.w + -1.0;
    u_xlat16_26 = unity_SpecCube0_HDR.w * u_xlat16_26 + 1.0;
    u_xlat16_26 = u_xlat16_26 * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.xyz = min(max(u_xlat16_7.xyz, 0.0), 1.0);
#else
    u_xlat16_7.xyz = clamp(u_xlat16_7.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vec3(u_xlat16_25) * u_xlat16_7.xyz;
    u_xlat16_26 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_4.xyz = vec3(u_xlat16_26) * u_xlat16_4.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_1.x = log2(u_xlat16_26);
    u_xlat16_9 = _Gloss * 128.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_3.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(_Spec) + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CrackTex_ST;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat25;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
mediump float u_xlat16_27;
void main()
{
    u_xlat16_0.x = _cKeyf.w + _cKeyf.w;
    u_xlat16_8.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_8.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_26 = vs_TEXCOORD4.x + _FresnelBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * _FresnelPinch;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_26) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_0.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat10_1.xy = texture(_CrackTex, vs_TEXCOORD3.xy).xy;
    u_xlatb1.xzw = greaterThanEqual(u_xlat10_1.xxxx, u_xlat16_3.xxyz).xzw;
    u_xlat16_3.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_3.y = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.w) ? float(2.0) : float(0.0);
    u_xlat16_26 = u_xlat10_1.y * u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.75);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xxx + vec3(u_xlat16_26);
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _cOverride.xyz;
    u_xlat16_2.xyz = _cOverride.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_1.x = (-_Gloss) + 1.0;
    u_xlat16_26 = (-u_xlat16_1.x) * 0.699999988 + 1.70000005;
    u_xlat16_26 = u_xlat16_1.x * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * 6.0;
    u_xlat16_3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat6.xyz = vec3(u_xlat25) * u_xlat5.xyz;
    u_xlat16_4.xyz = u_xlat5.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_27 = dot(u_xlat6.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat16_1.xyz) * (-vec3(u_xlat16_27)) + (-u_xlat6.xyz);
    u_xlat16_25 = (-u_xlat16_27) + 1.0;
    u_xlat10_0 = textureLod(unity_SpecCube0, u_xlat1.xyz, u_xlat16_26);
    u_xlat16_26 = u_xlat10_0.w + -1.0;
    u_xlat16_26 = unity_SpecCube0_HDR.w * u_xlat16_26 + 1.0;
    u_xlat16_26 = u_xlat16_26 * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.xyz = min(max(u_xlat16_7.xyz, 0.0), 1.0);
#else
    u_xlat16_7.xyz = clamp(u_xlat16_7.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vec3(u_xlat16_25) * u_xlat16_7.xyz;
    u_xlat16_26 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_4.xyz = vec3(u_xlat16_26) * u_xlat16_4.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_1.x = log2(u_xlat16_26);
    u_xlat16_9 = _Gloss * 128.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_3.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(_Spec) + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CrackTex_ST;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat25;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
mediump float u_xlat16_27;
void main()
{
    u_xlat16_0.x = _cKeyf.w + _cKeyf.w;
    u_xlat16_8.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_8.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_26 = vs_TEXCOORD4.x + _FresnelBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * _FresnelPinch;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_26) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_0.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat10_1.xy = texture(_CrackTex, vs_TEXCOORD3.xy).xy;
    u_xlatb1.xzw = greaterThanEqual(u_xlat10_1.xxxx, u_xlat16_3.xxyz).xzw;
    u_xlat16_3.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_3.y = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat16_3.z = (u_xlatb1.w) ? float(2.0) : float(0.0);
    u_xlat16_26 = u_xlat10_1.y * u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.75);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xxx + vec3(u_xlat16_26);
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _cOverride.xyz;
    u_xlat16_2.xyz = _cOverride.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_1.x = (-_Gloss) + 1.0;
    u_xlat16_26 = (-u_xlat16_1.x) * 0.699999988 + 1.70000005;
    u_xlat16_26 = u_xlat16_1.x * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * 6.0;
    u_xlat16_3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat6.xyz = vec3(u_xlat25) * u_xlat5.xyz;
    u_xlat16_4.xyz = u_xlat5.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_27 = dot(u_xlat6.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat16_1.xyz) * (-vec3(u_xlat16_27)) + (-u_xlat6.xyz);
    u_xlat16_25 = (-u_xlat16_27) + 1.0;
    u_xlat10_0 = textureLod(unity_SpecCube0, u_xlat1.xyz, u_xlat16_26);
    u_xlat16_26 = u_xlat10_0.w + -1.0;
    u_xlat16_26 = unity_SpecCube0_HDR.w * u_xlat16_26 + 1.0;
    u_xlat16_26 = u_xlat16_26 * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.xyz = min(max(u_xlat16_7.xyz, 0.0), 1.0);
#else
    u_xlat16_7.xyz = clamp(u_xlat16_7.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vec3(u_xlat16_25) * u_xlat16_7.xyz;
    u_xlat16_26 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_4.xyz = vec3(u_xlat16_26) * u_xlat16_4.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_1.x = log2(u_xlat16_26);
    u_xlat16_9 = _Gloss * 128.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_3.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(_Spec) + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
}
}
}
}