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
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
float u_xlat16;
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
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_3.x;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat16_3.x = u_xlat16_8 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3.x * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_8 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    u_xlat16_3.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = in_COLOR0.yyy * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.xxx * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.zzz * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_2.xyz + _cAmbn.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_2.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
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
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
float u_xlat16;
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
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_3.x;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat16_3.x = u_xlat16_8 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3.x * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_8 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    u_xlat16_3.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = in_COLOR0.yyy * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.xxx * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.zzz * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_2.xyz + _cAmbn.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_2.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
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
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
float u_xlat16;
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
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_3.x;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat16_3.x = u_xlat16_8 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3.x * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_8 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    u_xlat16_3.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = in_COLOR0.yyy * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.xxx * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.zzz * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_2.xyz + _cAmbn.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_2.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_SPECULAR_VERTEX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump float _EyeMirrorOffset;
uniform 	mediump vec4 _MainTex_ST;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat22 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(in_TANGENT0.x<0.0);
#else
    u_xlatb22 = in_TANGENT0.x<0.0;
#endif
    u_xlat2.x = in_TEXCOORD0.x + (-_EyeMirrorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat2.x<0.0);
#else
    u_xlatb9 = u_xlat2.x<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlati2 = (u_xlatb2) ? -1 : 1;
    vs_TEXCOORD3.z = float(u_xlati2);
    u_xlatb22 = u_xlatb22 && u_xlatb9;
    u_xlati22 = (u_xlatb22) ? -1 : 1;
    vs_TEXCOORD3.w = float(u_xlati22);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = u_xlat2.xy;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5.x) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5.x;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5.x * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_12 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat16_5.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = in_COLOR0.yyy * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.xxx * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.zzz * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    vs_TEXCOORD5.w = in_COLOR0.w;
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat0.x = vs_TEXCOORD0.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.x = vs_TEXCOORD0.w;
    u_xlat3.y = vs_TEXCOORD1.w;
    u_xlat3.z = vs_TEXCOORD2.w;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_9.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-u_xlat16_5.xxx) + (-u_xlat4.xyz);
    u_xlat16_24 = (-u_xlat16_5.x) + 1.0;
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = log2(u_xlat16_1.x);
    u_xlat16_8 = _EyeGloss * 128.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.xyz = u_xlat16_0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_5.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_2.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD5.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_7.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(u_xlat16_24) + u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_0.xyz;
    u_xlat16_25 = u_xlat10_0.w * _EyeSpec;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_6.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_1.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_SPECULAR_VERTEX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump float _EyeMirrorOffset;
uniform 	mediump vec4 _MainTex_ST;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat22 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(in_TANGENT0.x<0.0);
#else
    u_xlatb22 = in_TANGENT0.x<0.0;
#endif
    u_xlat2.x = in_TEXCOORD0.x + (-_EyeMirrorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat2.x<0.0);
#else
    u_xlatb9 = u_xlat2.x<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlati2 = (u_xlatb2) ? -1 : 1;
    vs_TEXCOORD3.z = float(u_xlati2);
    u_xlatb22 = u_xlatb22 && u_xlatb9;
    u_xlati22 = (u_xlatb22) ? -1 : 1;
    vs_TEXCOORD3.w = float(u_xlati22);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = u_xlat2.xy;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5.x) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5.x;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5.x * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_12 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat16_5.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = in_COLOR0.yyy * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.xxx * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.zzz * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    vs_TEXCOORD5.w = in_COLOR0.w;
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat0.x = vs_TEXCOORD0.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.x = vs_TEXCOORD0.w;
    u_xlat3.y = vs_TEXCOORD1.w;
    u_xlat3.z = vs_TEXCOORD2.w;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_9.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-u_xlat16_5.xxx) + (-u_xlat4.xyz);
    u_xlat16_24 = (-u_xlat16_5.x) + 1.0;
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = log2(u_xlat16_1.x);
    u_xlat16_8 = _EyeGloss * 128.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.xyz = u_xlat16_0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_5.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_2.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD5.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_7.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(u_xlat16_24) + u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_0.xyz;
    u_xlat16_25 = u_xlat10_0.w * _EyeSpec;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_6.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_1.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_SPECULAR_VERTEX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump float _EyeMirrorOffset;
uniform 	mediump vec4 _MainTex_ST;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat22 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(in_TANGENT0.x<0.0);
#else
    u_xlatb22 = in_TANGENT0.x<0.0;
#endif
    u_xlat2.x = in_TEXCOORD0.x + (-_EyeMirrorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat2.x<0.0);
#else
    u_xlatb9 = u_xlat2.x<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlati2 = (u_xlatb2) ? -1 : 1;
    vs_TEXCOORD3.z = float(u_xlati2);
    u_xlatb22 = u_xlatb22 && u_xlatb9;
    u_xlati22 = (u_xlatb22) ? -1 : 1;
    vs_TEXCOORD3.w = float(u_xlati22);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = u_xlat2.xy;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5.x) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5.x;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5.x * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_12 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat16_5.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = in_COLOR0.yyy * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.xxx * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.zzz * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    vs_TEXCOORD5.w = in_COLOR0.w;
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat0.x = vs_TEXCOORD0.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.x = vs_TEXCOORD0.w;
    u_xlat3.y = vs_TEXCOORD1.w;
    u_xlat3.z = vs_TEXCOORD2.w;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_9.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-u_xlat16_5.xxx) + (-u_xlat4.xyz);
    u_xlat16_24 = (-u_xlat16_5.x) + 1.0;
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = log2(u_xlat16_1.x);
    u_xlat16_8 = _EyeGloss * 128.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.xyz = u_xlat16_0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_5.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_2.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD5.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_7.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(u_xlat16_24) + u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_0.xyz;
    u_xlat16_25 = u_xlat10_0.w * _EyeSpec;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_6.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_1.xyz + vs_TEXCOORD6.xyz;
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
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
float u_xlat16;
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
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_3.x;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat16_3.x = u_xlat16_8 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3.x * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_8 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    u_xlat16_3.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = in_COLOR0.yyy * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.xxx * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.zzz * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_2.xyz + _cAmbn.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_2.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
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
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
float u_xlat16;
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
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_3.x;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat16_3.x = u_xlat16_8 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3.x * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_8 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    u_xlat16_3.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = in_COLOR0.yyy * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.xxx * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.zzz * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_2.xyz + _cAmbn.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_2.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
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
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
float u_xlat16;
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
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_3.x;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat16_3.x = u_xlat16_8 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3.x * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_8 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    u_xlat16_3.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = in_COLOR0.yyy * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.xxx * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.zzz * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_2.xyz + _cAmbn.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_2.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "BRB_SPECULAR_VERTEX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump float _EyeMirrorOffset;
uniform 	mediump vec4 _MainTex_ST;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat22 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(in_TANGENT0.x<0.0);
#else
    u_xlatb22 = in_TANGENT0.x<0.0;
#endif
    u_xlat2.x = in_TEXCOORD0.x + (-_EyeMirrorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat2.x<0.0);
#else
    u_xlatb9 = u_xlat2.x<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlati2 = (u_xlatb2) ? -1 : 1;
    vs_TEXCOORD3.z = float(u_xlati2);
    u_xlatb22 = u_xlatb22 && u_xlatb9;
    u_xlati22 = (u_xlatb22) ? -1 : 1;
    vs_TEXCOORD3.w = float(u_xlati22);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = u_xlat2.xy;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5.x) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5.x;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5.x * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_12 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat16_5.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = in_COLOR0.yyy * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.xxx * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.zzz * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    vs_TEXCOORD5.w = in_COLOR0.w;
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat0.x = vs_TEXCOORD0.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.x = vs_TEXCOORD0.w;
    u_xlat3.y = vs_TEXCOORD1.w;
    u_xlat3.z = vs_TEXCOORD2.w;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_9.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-u_xlat16_5.xxx) + (-u_xlat4.xyz);
    u_xlat16_24 = (-u_xlat16_5.x) + 1.0;
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = log2(u_xlat16_1.x);
    u_xlat16_8 = _EyeGloss * 128.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.xyz = u_xlat16_0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_5.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_2.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD5.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_7.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(u_xlat16_24) + u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_0.xyz;
    u_xlat16_25 = u_xlat10_0.w * _EyeSpec;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_6.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_1.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "BRB_SPECULAR_VERTEX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump float _EyeMirrorOffset;
uniform 	mediump vec4 _MainTex_ST;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat22 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(in_TANGENT0.x<0.0);
#else
    u_xlatb22 = in_TANGENT0.x<0.0;
#endif
    u_xlat2.x = in_TEXCOORD0.x + (-_EyeMirrorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat2.x<0.0);
#else
    u_xlatb9 = u_xlat2.x<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlati2 = (u_xlatb2) ? -1 : 1;
    vs_TEXCOORD3.z = float(u_xlati2);
    u_xlatb22 = u_xlatb22 && u_xlatb9;
    u_xlati22 = (u_xlatb22) ? -1 : 1;
    vs_TEXCOORD3.w = float(u_xlati22);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = u_xlat2.xy;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5.x) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5.x;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5.x * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_12 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat16_5.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = in_COLOR0.yyy * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.xxx * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.zzz * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    vs_TEXCOORD5.w = in_COLOR0.w;
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat0.x = vs_TEXCOORD0.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.x = vs_TEXCOORD0.w;
    u_xlat3.y = vs_TEXCOORD1.w;
    u_xlat3.z = vs_TEXCOORD2.w;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_9.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-u_xlat16_5.xxx) + (-u_xlat4.xyz);
    u_xlat16_24 = (-u_xlat16_5.x) + 1.0;
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = log2(u_xlat16_1.x);
    u_xlat16_8 = _EyeGloss * 128.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.xyz = u_xlat16_0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_5.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_2.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD5.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_7.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(u_xlat16_24) + u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_0.xyz;
    u_xlat16_25 = u_xlat10_0.w * _EyeSpec;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_6.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_1.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "BRB_SPECULAR_VERTEX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump float _EyeMirrorOffset;
uniform 	mediump vec4 _MainTex_ST;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat22 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(in_TANGENT0.x<0.0);
#else
    u_xlatb22 = in_TANGENT0.x<0.0;
#endif
    u_xlat2.x = in_TEXCOORD0.x + (-_EyeMirrorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat2.x<0.0);
#else
    u_xlatb9 = u_xlat2.x<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlati2 = (u_xlatb2) ? -1 : 1;
    vs_TEXCOORD3.z = float(u_xlati2);
    u_xlatb22 = u_xlatb22 && u_xlatb9;
    u_xlati22 = (u_xlatb22) ? -1 : 1;
    vs_TEXCOORD3.w = float(u_xlati22);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = u_xlat2.xy;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5.x) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5.x;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5.x * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_12 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat16_5.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = in_COLOR0.yyy * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.xxx * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.zzz * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    vs_TEXCOORD5.w = in_COLOR0.w;
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat0.x = vs_TEXCOORD0.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.x = vs_TEXCOORD0.w;
    u_xlat3.y = vs_TEXCOORD1.w;
    u_xlat3.z = vs_TEXCOORD2.w;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_9.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-u_xlat16_5.xxx) + (-u_xlat4.xyz);
    u_xlat16_24 = (-u_xlat16_5.x) + 1.0;
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = log2(u_xlat16_1.x);
    u_xlat16_8 = _EyeGloss * 128.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.xyz = u_xlat16_0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_5.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_2.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD5.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_7.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(u_xlat16_24) + u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_0.xyz;
    u_xlat16_25 = u_xlat10_0.w * _EyeSpec;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_6.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_1.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump vec4 _CharacterColor;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
float u_xlat16;
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
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_3.x;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat16_3.x = u_xlat16_8 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3.x * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_8 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    u_xlat16_3.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = in_COLOR0.yyy * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.xxx * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.zzz * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_2.xyz + _cAmbn.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_2.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump vec4 _CharacterColor;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
float u_xlat16;
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
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_3.x;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat16_3.x = u_xlat16_8 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3.x * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_8 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    u_xlat16_3.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = in_COLOR0.yyy * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.xxx * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.zzz * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_2.xyz + _cAmbn.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_2.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump vec4 _CharacterColor;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
float u_xlat16;
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
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_3.x;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat16_3.x = u_xlat16_8 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3.x * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_8 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    u_xlat16_3.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = in_COLOR0.yyy * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.xxx * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.zzz * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_2.xyz + _cAmbn.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_2.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump float _EyeMirrorOffset;
uniform 	mediump vec4 _MainTex_ST;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat22 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(in_TANGENT0.x<0.0);
#else
    u_xlatb22 = in_TANGENT0.x<0.0;
#endif
    u_xlat2.x = in_TEXCOORD0.x + (-_EyeMirrorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat2.x<0.0);
#else
    u_xlatb9 = u_xlat2.x<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlati2 = (u_xlatb2) ? -1 : 1;
    vs_TEXCOORD3.z = float(u_xlati2);
    u_xlatb22 = u_xlatb22 && u_xlatb9;
    u_xlati22 = (u_xlatb22) ? -1 : 1;
    vs_TEXCOORD3.w = float(u_xlati22);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = u_xlat2.xy;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5.x) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5.x;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5.x * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_12 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat16_5.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = in_COLOR0.yyy * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.xxx * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.zzz * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    vs_TEXCOORD5.w = in_COLOR0.w;
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD6 = u_xlat0;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat0.x = vs_TEXCOORD0.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.x = vs_TEXCOORD0.w;
    u_xlat3.y = vs_TEXCOORD1.w;
    u_xlat3.z = vs_TEXCOORD2.w;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_9.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-u_xlat16_5.xxx) + (-u_xlat4.xyz);
    u_xlat16_24 = (-u_xlat16_5.x) + 1.0;
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = log2(u_xlat16_1.x);
    u_xlat16_8 = _EyeGloss * 128.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.xyz = u_xlat16_0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_5.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_2.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD5.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_7.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(u_xlat16_24) + u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_0.xyz;
    u_xlat16_25 = u_xlat10_0.w * _EyeSpec;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_6.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_1.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump float _EyeMirrorOffset;
uniform 	mediump vec4 _MainTex_ST;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat22 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(in_TANGENT0.x<0.0);
#else
    u_xlatb22 = in_TANGENT0.x<0.0;
#endif
    u_xlat2.x = in_TEXCOORD0.x + (-_EyeMirrorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat2.x<0.0);
#else
    u_xlatb9 = u_xlat2.x<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlati2 = (u_xlatb2) ? -1 : 1;
    vs_TEXCOORD3.z = float(u_xlati2);
    u_xlatb22 = u_xlatb22 && u_xlatb9;
    u_xlati22 = (u_xlatb22) ? -1 : 1;
    vs_TEXCOORD3.w = float(u_xlati22);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = u_xlat2.xy;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5.x) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5.x;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5.x * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_12 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat16_5.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = in_COLOR0.yyy * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.xxx * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.zzz * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    vs_TEXCOORD5.w = in_COLOR0.w;
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD6 = u_xlat0;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat0.x = vs_TEXCOORD0.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.x = vs_TEXCOORD0.w;
    u_xlat3.y = vs_TEXCOORD1.w;
    u_xlat3.z = vs_TEXCOORD2.w;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_9.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-u_xlat16_5.xxx) + (-u_xlat4.xyz);
    u_xlat16_24 = (-u_xlat16_5.x) + 1.0;
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = log2(u_xlat16_1.x);
    u_xlat16_8 = _EyeGloss * 128.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.xyz = u_xlat16_0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_5.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_2.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD5.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_7.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(u_xlat16_24) + u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_0.xyz;
    u_xlat16_25 = u_xlat10_0.w * _EyeSpec;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_6.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_1.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump float _EyeMirrorOffset;
uniform 	mediump vec4 _MainTex_ST;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat22 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(in_TANGENT0.x<0.0);
#else
    u_xlatb22 = in_TANGENT0.x<0.0;
#endif
    u_xlat2.x = in_TEXCOORD0.x + (-_EyeMirrorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat2.x<0.0);
#else
    u_xlatb9 = u_xlat2.x<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlati2 = (u_xlatb2) ? -1 : 1;
    vs_TEXCOORD3.z = float(u_xlati2);
    u_xlatb22 = u_xlatb22 && u_xlatb9;
    u_xlati22 = (u_xlatb22) ? -1 : 1;
    vs_TEXCOORD3.w = float(u_xlati22);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = u_xlat2.xy;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5.x) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5.x;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5.x * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_12 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat16_5.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = in_COLOR0.yyy * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.xxx * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.zzz * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    vs_TEXCOORD5.w = in_COLOR0.w;
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD6 = u_xlat0;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat0.x = vs_TEXCOORD0.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.x = vs_TEXCOORD0.w;
    u_xlat3.y = vs_TEXCOORD1.w;
    u_xlat3.z = vs_TEXCOORD2.w;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_9.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-u_xlat16_5.xxx) + (-u_xlat4.xyz);
    u_xlat16_24 = (-u_xlat16_5.x) + 1.0;
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = log2(u_xlat16_1.x);
    u_xlat16_8 = _EyeGloss * 128.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.xyz = u_xlat16_0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_5.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_2.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD5.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_7.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(u_xlat16_24) + u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_0.xyz;
    u_xlat16_25 = u_xlat10_0.w * _EyeSpec;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_6.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_1.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump vec4 _CharacterColor;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
float u_xlat16;
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
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_3.x;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat16_3.x = u_xlat16_8 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3.x * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_8 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    u_xlat16_3.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = in_COLOR0.yyy * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.xxx * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.zzz * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_2.xyz + _cAmbn.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_2.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump vec4 _CharacterColor;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
float u_xlat16;
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
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_3.x;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat16_3.x = u_xlat16_8 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3.x * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_8 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    u_xlat16_3.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = in_COLOR0.yyy * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.xxx * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.zzz * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_2.xyz + _cAmbn.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_2.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump vec4 _CharacterColor;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
float u_xlat16;
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
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_3.x;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat16_3.x = u_xlat16_8 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_3.x * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_8 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    u_xlat16_3.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = in_COLOR0.yyy * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.xxx * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = in_COLOR0.zzz * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_2.xyz + _cAmbn.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_2.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump float _EyeMirrorOffset;
uniform 	mediump vec4 _MainTex_ST;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat22 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(in_TANGENT0.x<0.0);
#else
    u_xlatb22 = in_TANGENT0.x<0.0;
#endif
    u_xlat2.x = in_TEXCOORD0.x + (-_EyeMirrorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat2.x<0.0);
#else
    u_xlatb9 = u_xlat2.x<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlati2 = (u_xlatb2) ? -1 : 1;
    vs_TEXCOORD3.z = float(u_xlati2);
    u_xlatb22 = u_xlatb22 && u_xlatb9;
    u_xlati22 = (u_xlatb22) ? -1 : 1;
    vs_TEXCOORD3.w = float(u_xlati22);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = u_xlat2.xy;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5.x) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5.x;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5.x * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_12 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat16_5.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = in_COLOR0.yyy * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.xxx * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.zzz * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    vs_TEXCOORD5.w = in_COLOR0.w;
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD6 = u_xlat0;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat0.x = vs_TEXCOORD0.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.x = vs_TEXCOORD0.w;
    u_xlat3.y = vs_TEXCOORD1.w;
    u_xlat3.z = vs_TEXCOORD2.w;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_9.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-u_xlat16_5.xxx) + (-u_xlat4.xyz);
    u_xlat16_24 = (-u_xlat16_5.x) + 1.0;
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = log2(u_xlat16_1.x);
    u_xlat16_8 = _EyeGloss * 128.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.xyz = u_xlat16_0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_5.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_2.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD5.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_7.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(u_xlat16_24) + u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_0.xyz;
    u_xlat16_25 = u_xlat10_0.w * _EyeSpec;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_6.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_1.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump float _EyeMirrorOffset;
uniform 	mediump vec4 _MainTex_ST;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat22 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(in_TANGENT0.x<0.0);
#else
    u_xlatb22 = in_TANGENT0.x<0.0;
#endif
    u_xlat2.x = in_TEXCOORD0.x + (-_EyeMirrorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat2.x<0.0);
#else
    u_xlatb9 = u_xlat2.x<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlati2 = (u_xlatb2) ? -1 : 1;
    vs_TEXCOORD3.z = float(u_xlati2);
    u_xlatb22 = u_xlatb22 && u_xlatb9;
    u_xlati22 = (u_xlatb22) ? -1 : 1;
    vs_TEXCOORD3.w = float(u_xlati22);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = u_xlat2.xy;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5.x) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5.x;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5.x * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_12 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat16_5.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = in_COLOR0.yyy * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.xxx * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.zzz * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    vs_TEXCOORD5.w = in_COLOR0.w;
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD6 = u_xlat0;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat0.x = vs_TEXCOORD0.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.x = vs_TEXCOORD0.w;
    u_xlat3.y = vs_TEXCOORD1.w;
    u_xlat3.z = vs_TEXCOORD2.w;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_9.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-u_xlat16_5.xxx) + (-u_xlat4.xyz);
    u_xlat16_24 = (-u_xlat16_5.x) + 1.0;
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = log2(u_xlat16_1.x);
    u_xlat16_8 = _EyeGloss * 128.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.xyz = u_xlat16_0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_5.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_2.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD5.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_7.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(u_xlat16_24) + u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_0.xyz;
    u_xlat16_25 = u_xlat10_0.w * _EyeSpec;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_6.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_1.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _vGren;
uniform 	mediump vec4 _vRedd;
uniform 	mediump vec4 _vBlue;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump float _EyeMirrorOffset;
uniform 	mediump vec4 _MainTex_ST;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat22 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(in_TANGENT0.x<0.0);
#else
    u_xlatb22 = in_TANGENT0.x<0.0;
#endif
    u_xlat2.x = in_TEXCOORD0.x + (-_EyeMirrorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat2.x<0.0);
#else
    u_xlatb9 = u_xlat2.x<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlati2 = (u_xlatb2) ? -1 : 1;
    vs_TEXCOORD3.z = float(u_xlati2);
    u_xlatb22 = u_xlatb22 && u_xlatb9;
    u_xlati22 = (u_xlatb22) ? -1 : 1;
    vs_TEXCOORD3.w = float(u_xlati22);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = u_xlat2.xy;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5.x) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5.x;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5.x = u_xlat16_12 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5.x * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_12 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat16_5.xyz = _vGren.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = in_COLOR0.yyy * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = _vRedd.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.xxx * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = _vBlue.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = in_COLOR0.zzz * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    vs_TEXCOORD5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    vs_TEXCOORD5.w = in_COLOR0.w;
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD6 = u_xlat0;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat0.x = vs_TEXCOORD0.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat3.x = vs_TEXCOORD0.w;
    u_xlat3.y = vs_TEXCOORD1.w;
    u_xlat3.z = vs_TEXCOORD2.w;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_9.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-u_xlat16_5.xxx) + (-u_xlat4.xyz);
    u_xlat16_24 = (-u_xlat16_5.x) + 1.0;
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = log2(u_xlat16_1.x);
    u_xlat16_8 = _EyeGloss * 128.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.xyz = u_xlat16_0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_5.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_2.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD5.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_7.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(u_xlat16_24) + u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_0.xyz;
    u_xlat16_25 = u_xlat10_0.w * _EyeSpec;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_6.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vs_TEXCOORD5.www * u_xlat16_6.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_1.xyz + vs_TEXCOORD6.xyz;
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_SPECULAR_VERTEX" }
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
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "BRB_CHAR_FX" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
}
}
}
}