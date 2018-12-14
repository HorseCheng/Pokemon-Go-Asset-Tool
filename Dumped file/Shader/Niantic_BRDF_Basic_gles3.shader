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
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
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
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
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
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_3.x * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_3.x * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_3.x * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat15 = (-_Amount_Wrap) + 1.0;
    u_xlat15 = u_xlat16_3 * _Amount_Wrap + u_xlat15;
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat15;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat15 = (-_Amount_Wrap) + 1.0;
    u_xlat15 = u_xlat16_3 * _Amount_Wrap + u_xlat15;
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat15;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat15 = (-_Amount_Wrap) + 1.0;
    u_xlat15 = u_xlat16_3 * _Amount_Wrap + u_xlat15;
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat15;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat22 = (-_Amount_Wrap) + 1.0;
    u_xlat22 = u_xlat16_4 * _Amount_Wrap + u_xlat22;
    u_xlat16_4 = u_xlat16_4 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_4 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat22;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_5.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat22 = (-_Amount_Wrap) + 1.0;
    u_xlat22 = u_xlat16_4 * _Amount_Wrap + u_xlat22;
    u_xlat16_4 = u_xlat16_4 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_4 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat22;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_5.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat22 = (-_Amount_Wrap) + 1.0;
    u_xlat22 = u_xlat16_4 * _Amount_Wrap + u_xlat22;
    u_xlat16_4 = u_xlat16_4 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_4 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat22;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_5.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = (-_Amount_Wrap) + 1.0;
    u_xlat21 = u_xlat16_4 * _Amount_Wrap + u_xlat21;
    u_xlat16_4 = u_xlat16_4 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_4 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat21;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = (-_Amount_Wrap) + 1.0;
    u_xlat21 = u_xlat16_4 * _Amount_Wrap + u_xlat21;
    u_xlat16_4 = u_xlat16_4 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_4 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat21;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = (-_Amount_Wrap) + 1.0;
    u_xlat21 = u_xlat16_4 * _Amount_Wrap + u_xlat21;
    u_xlat16_4 = u_xlat16_4 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_4 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat21;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_3.x * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_3.x * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_3.x * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat15 = (-_Amount_Wrap) + 1.0;
    u_xlat15 = u_xlat16_3 * _Amount_Wrap + u_xlat15;
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat15;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat15 = (-_Amount_Wrap) + 1.0;
    u_xlat15 = u_xlat16_3 * _Amount_Wrap + u_xlat15;
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat15;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat15 = (-_Amount_Wrap) + 1.0;
    u_xlat15 = u_xlat16_3 * _Amount_Wrap + u_xlat15;
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat15;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat22 = (-_Amount_Wrap) + 1.0;
    u_xlat22 = u_xlat16_4 * _Amount_Wrap + u_xlat22;
    u_xlat16_4 = u_xlat16_4 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_4 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat22;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_5.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat22 = (-_Amount_Wrap) + 1.0;
    u_xlat22 = u_xlat16_4 * _Amount_Wrap + u_xlat22;
    u_xlat16_4 = u_xlat16_4 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_4 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat22;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_5.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat22 = (-_Amount_Wrap) + 1.0;
    u_xlat22 = u_xlat16_4 * _Amount_Wrap + u_xlat22;
    u_xlat16_4 = u_xlat16_4 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_4 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat22;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_5.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_3.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = (-_Amount_Wrap) + 1.0;
    u_xlat21 = u_xlat16_4 * _Amount_Wrap + u_xlat21;
    u_xlat16_4 = u_xlat16_4 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_4 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat21;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = (-_Amount_Wrap) + 1.0;
    u_xlat21 = u_xlat16_4 * _Amount_Wrap + u_xlat21;
    u_xlat16_4 = u_xlat16_4 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_4 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat21;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = (-_Amount_Wrap) + 1.0;
    u_xlat21 = u_xlat16_4 * _Amount_Wrap + u_xlat21;
    u_xlat16_4 = u_xlat16_4 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_4 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat21;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + _vAmOc.xyz;
    u_xlat16_1.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_1.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_16 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_0.xyz = _cOverride.www * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat1.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat1.x = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_15 = (-_LightShadowData.x) + 1.0;
    u_xlat16_15 = u_xlat10_6 * u_xlat16_15 + _LightShadowData.x;
    u_xlat16_15 = u_xlat1.x + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_15) * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cTint.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat16 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
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
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).w;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).w;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).w;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat0.x;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cTint;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat16_1.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
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
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat0.x;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cTint;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat16_1.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
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
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat0.x;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cTint;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat16_1.xyz = _LightColor0.xyz * _cTint.xyz;
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).w;
    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat9 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).w;
    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat9 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).w;
    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat9 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat2;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
    u_xlat2 = texture(_LightTextureB0, vec2(u_xlat6)).w;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat2;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
    u_xlat2 = texture(_LightTextureB0, vec2(u_xlat6)).w;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat2;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
    u_xlat2 = texture(_LightTextureB0, vec2(u_xlat6)).w;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat0.x;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat0.x;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat0.x;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).w;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_1.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).w;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_1.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).w;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_1.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat0.x;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cTint;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
    u_xlat16_2.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat1.xxx;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat0.x;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cTint;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
    u_xlat16_2.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat1.xxx;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat0.x;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cTint;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
    u_xlat16_2.xyz = _LightColor0.xyz * _cTint.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat1.xxx;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).w;
    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat9 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat0.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).w;
    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat9 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat0.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).w;
    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat9 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_11 = max(u_xlat16_11, 0.0);
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat0.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat2;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
    u_xlat2 = texture(_LightTextureB0, vec2(u_xlat6)).w;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_1.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat2;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
    u_xlat2 = texture(_LightTextureB0, vec2(u_xlat6)).w;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_1.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat3;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat2;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
    u_xlat2 = texture(_LightTextureB0, vec2(u_xlat6)).w;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, u_xlat0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_1.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat0.x;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_1.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat0.x;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_1.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_2 * _Amount_Wrap + u_xlat0.x;
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat0.x;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _cTint;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _cTint.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_1.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
""
}
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
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
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
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat3;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    SV_Target0.xyz = _cTint.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_1.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vs_COLOR0.www * u_xlat16_1.xyz + _vAmOc.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_1.xyz = _cOverride.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat3;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    SV_Target0.xyz = _cTint.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_1.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vs_COLOR0.www * u_xlat16_1.xyz + _vAmOc.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_1.xyz = _cOverride.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = (-_Amount_Wrap) + 1.0;
    u_xlat3 = u_xlat0.x * _Amount_Wrap + u_xlat3;
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.z = u_xlat3;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    SV_Target0.xyz = _cTint.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_1.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vs_COLOR0.www * u_xlat16_1.xyz + _vAmOc.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_1.xyz = _cOverride.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat6;
float u_xlat15;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6 = (-_Amount_Wrap) + 1.0;
    u_xlat6 = u_xlat1.x * _Amount_Wrap + u_xlat6;
    u_xlat16_3.x = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.z = u_xlat6;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    SV_Target0.xyz = _cTint.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_1.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vs_COLOR0.www * u_xlat16_1.xyz + _vAmOc.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_1.xyz = _cOverride.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat6;
float u_xlat15;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6 = (-_Amount_Wrap) + 1.0;
    u_xlat6 = u_xlat1.x * _Amount_Wrap + u_xlat6;
    u_xlat16_3.x = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.z = u_xlat6;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    SV_Target0.xyz = _cTint.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_1.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vs_COLOR0.www * u_xlat16_1.xyz + _vAmOc.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_1.xyz = _cOverride.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat6;
float u_xlat15;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6 = (-_Amount_Wrap) + 1.0;
    u_xlat6 = u_xlat1.x * _Amount_Wrap + u_xlat6;
    u_xlat16_3.x = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.z = u_xlat6;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    SV_Target0.xyz = _cTint.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_1.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vs_COLOR0.www * u_xlat16_1.xyz + _vAmOc.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    u_xlat16_1.xyz = _cOverride.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat6;
float u_xlat15;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6 = (-_Amount_Wrap) + 1.0;
    u_xlat6 = u_xlat1.x * _Amount_Wrap + u_xlat6;
    u_xlat16_3.x = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.z = u_xlat6;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    SV_Target0.xyz = _cTint.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_1.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vs_COLOR0.www * u_xlat16_1.xyz + _vAmOc.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    SV_Target3.xyz = _cOverride.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat6;
float u_xlat15;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6 = (-_Amount_Wrap) + 1.0;
    u_xlat6 = u_xlat1.x * _Amount_Wrap + u_xlat6;
    u_xlat16_3.x = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.z = u_xlat6;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    SV_Target0.xyz = _cTint.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_1.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vs_COLOR0.www * u_xlat16_1.xyz + _vAmOc.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    SV_Target3.xyz = _cOverride.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat6;
float u_xlat15;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6 = (-_Amount_Wrap) + 1.0;
    u_xlat6 = u_xlat1.x * _Amount_Wrap + u_xlat6;
    u_xlat16_3.x = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.z = u_xlat6;
    vs_TEXCOORD3.w = 1.0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cTint;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    SV_Target0.xyz = _cTint.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_1.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vs_COLOR0.www * u_xlat16_1.xyz + _vAmOc.xyz;
    u_xlat16_0.x = _cRimb.w + _cRimb.w;
    u_xlat10_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = u_xlat10_2.www * _cRimb.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat10_2.xxx * _cRimt.xyz;
    u_xlat16_4.xyz = u_xlat10_2.zzz * _cKeyf.xyz;
    u_xlat16_0.x = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_15 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vs_TEXCOORD3.zzz + _cOverride.xyz;
    SV_Target3.xyz = _cOverride.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
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
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb12 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat8);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat8) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat8;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4 = (-_Amount_Wrap) + 1.0;
    u_xlat4 = u_xlat0.x * _Amount_Wrap + u_xlat4;
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat4;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb12 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat8);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat8) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat8;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4 = (-_Amount_Wrap) + 1.0;
    u_xlat4 = u_xlat0.x * _Amount_Wrap + u_xlat4;
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat4;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb12 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat8);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat8) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat8;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4 = (-_Amount_Wrap) + 1.0;
    u_xlat4 = u_xlat0.x * _Amount_Wrap + u_xlat4;
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat4;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4 = (-_Amount_Wrap) + 1.0;
    u_xlat4 = u_xlat0.x * _Amount_Wrap + u_xlat4;
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat4;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4 = (-_Amount_Wrap) + 1.0;
    u_xlat4 = u_xlat0.x * _Amount_Wrap + u_xlat4;
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat4;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4 = (-_Amount_Wrap) + 1.0;
    u_xlat4 = u_xlat0.x * _Amount_Wrap + u_xlat4;
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.z = u_xlat4;
    vs_TEXCOORD2.w = 1.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
}
}