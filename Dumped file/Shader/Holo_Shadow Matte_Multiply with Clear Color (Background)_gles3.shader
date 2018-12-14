Shader "Holo/Shadow Matte/Multiply with Clear Color (Background)" {
Properties {
_ShadowColor ("Shadow Tint (RGBA)", Color) = (0,0,0,1)
_Alpha ("Alpha Out (for Pokedex)", Range(0, 1)) = 1
[KeywordEnum(Alpha_X_Ambient, RGBA)] _Multiplier ("    Clear Multiplier", Float) = 0
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Background" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 100
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Background" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 18470
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD2.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + vec3(1.0, 1.0, 1.0);
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD2.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + vec3(1.0, 1.0, 1.0);
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD2.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + vec3(1.0, 1.0, 1.0);
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD2.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + vec3(1.0, 1.0, 1.0);
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD2.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + vec3(1.0, 1.0, 1.0);
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD2.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + vec3(1.0, 1.0, 1.0);
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD2.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_2.x = u_xlat10_3 * u_xlat16_2.x + _LightShadowData.x;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_0) + u_xlat16_2.xxx;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + u_xlat16_2.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD2.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_2.x = u_xlat10_3 * u_xlat16_2.x + _LightShadowData.x;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_0) + u_xlat16_2.xxx;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + u_xlat16_2.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD2.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_2.x = u_xlat10_3 * u_xlat16_2.x + _LightShadowData.x;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_0) + u_xlat16_2.xxx;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + u_xlat16_2.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD2.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_2.x = u_xlat10_3 * u_xlat16_2.x + _LightShadowData.x;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_0) + u_xlat16_2.xxx;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + u_xlat16_2.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD2.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_2.x = u_xlat10_3 * u_xlat16_2.x + _LightShadowData.x;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_0) + u_xlat16_2.xxx;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + u_xlat16_2.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD2.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_2.x = u_xlat10_3 * u_xlat16_2.x + _LightShadowData.x;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_0) + u_xlat16_2.xxx;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + u_xlat16_2.xyz;
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

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat6;
mediump float u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat15;
    u_xlat15 = u_xlat15 * unity_FogParams.x;
    u_xlat16_3 = u_xlat15 * (-u_xlat15);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_8 = in_COLOR0.w * _Alpha;
    u_xlat16_13 = u_xlat16_3 * u_xlat16_8;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD2.w = u_xlat16_8;
    u_xlat15 = u_xlat16_13 * _ShadowColor.w;
    u_xlat1.x = (-_ShadowColor.w) * u_xlat16_13 + 1.0;
    u_xlat6.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(u_xlat15) + u_xlat1.xxx;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + vec3(1.0, 1.0, 1.0);
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

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat6;
mediump float u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat15;
    u_xlat15 = u_xlat15 * unity_FogParams.x;
    u_xlat16_3 = u_xlat15 * (-u_xlat15);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_8 = in_COLOR0.w * _Alpha;
    u_xlat16_13 = u_xlat16_3 * u_xlat16_8;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD2.w = u_xlat16_8;
    u_xlat15 = u_xlat16_13 * _ShadowColor.w;
    u_xlat1.x = (-_ShadowColor.w) * u_xlat16_13 + 1.0;
    u_xlat6.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(u_xlat15) + u_xlat1.xxx;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + vec3(1.0, 1.0, 1.0);
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

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat6;
mediump float u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat15;
    u_xlat15 = u_xlat15 * unity_FogParams.x;
    u_xlat16_3 = u_xlat15 * (-u_xlat15);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_8 = in_COLOR0.w * _Alpha;
    u_xlat16_13 = u_xlat16_3 * u_xlat16_8;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD2.w = u_xlat16_8;
    u_xlat15 = u_xlat16_13 * _ShadowColor.w;
    u_xlat1.x = (-_ShadowColor.w) * u_xlat16_13 + 1.0;
    u_xlat6.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(u_xlat15) + u_xlat1.xxx;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + vec3(1.0, 1.0, 1.0);
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

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat6;
mediump float u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat15;
    u_xlat15 = u_xlat15 * unity_FogParams.x;
    u_xlat16_3 = u_xlat15 * (-u_xlat15);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_8 = in_COLOR0.w * _Alpha;
    u_xlat16_13 = u_xlat16_3 * u_xlat16_8;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD2.w = u_xlat16_8;
    u_xlat15 = u_xlat16_13 * _ShadowColor.w;
    u_xlat1.x = (-_ShadowColor.w) * u_xlat16_13 + 1.0;
    u_xlat6.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(u_xlat15) + u_xlat1.xxx;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + vec3(1.0, 1.0, 1.0);
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

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat6;
mediump float u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat15;
    u_xlat15 = u_xlat15 * unity_FogParams.x;
    u_xlat16_3 = u_xlat15 * (-u_xlat15);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_8 = in_COLOR0.w * _Alpha;
    u_xlat16_13 = u_xlat16_3 * u_xlat16_8;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD2.w = u_xlat16_8;
    u_xlat15 = u_xlat16_13 * _ShadowColor.w;
    u_xlat1.x = (-_ShadowColor.w) * u_xlat16_13 + 1.0;
    u_xlat6.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(u_xlat15) + u_xlat1.xxx;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + vec3(1.0, 1.0, 1.0);
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

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat6;
mediump float u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat15;
    u_xlat15 = u_xlat15 * unity_FogParams.x;
    u_xlat16_3 = u_xlat15 * (-u_xlat15);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_8 = in_COLOR0.w * _Alpha;
    u_xlat16_13 = u_xlat16_3 * u_xlat16_8;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD2.w = u_xlat16_8;
    u_xlat15 = u_xlat16_13 * _ShadowColor.w;
    u_xlat1.x = (-_ShadowColor.w) * u_xlat16_13 + 1.0;
    u_xlat6.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(u_xlat15) + u_xlat1.xxx;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + vec3(1.0, 1.0, 1.0);
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

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat6;
mediump float u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat15;
    u_xlat15 = u_xlat15 * unity_FogParams.x;
    u_xlat16_3 = u_xlat15 * (-u_xlat15);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_8 = in_COLOR0.w * _Alpha;
    u_xlat16_13 = u_xlat16_3 * u_xlat16_8;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD2.w = u_xlat16_8;
    u_xlat15 = u_xlat16_13 * _ShadowColor.w;
    u_xlat1.x = (-_ShadowColor.w) * u_xlat16_13 + 1.0;
    u_xlat6.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(u_xlat15) + u_xlat1.xxx;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_2.x = u_xlat10_3 * u_xlat16_2.x + _LightShadowData.x;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_0) + u_xlat16_2.xxx;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + u_xlat16_2.xyz;
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

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat6;
mediump float u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat15;
    u_xlat15 = u_xlat15 * unity_FogParams.x;
    u_xlat16_3 = u_xlat15 * (-u_xlat15);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_8 = in_COLOR0.w * _Alpha;
    u_xlat16_13 = u_xlat16_3 * u_xlat16_8;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD2.w = u_xlat16_8;
    u_xlat15 = u_xlat16_13 * _ShadowColor.w;
    u_xlat1.x = (-_ShadowColor.w) * u_xlat16_13 + 1.0;
    u_xlat6.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(u_xlat15) + u_xlat1.xxx;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_2.x = u_xlat10_3 * u_xlat16_2.x + _LightShadowData.x;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_0) + u_xlat16_2.xxx;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + u_xlat16_2.xyz;
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

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat6;
mediump float u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat15;
    u_xlat15 = u_xlat15 * unity_FogParams.x;
    u_xlat16_3 = u_xlat15 * (-u_xlat15);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_8 = in_COLOR0.w * _Alpha;
    u_xlat16_13 = u_xlat16_3 * u_xlat16_8;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD2.w = u_xlat16_8;
    u_xlat15 = u_xlat16_13 * _ShadowColor.w;
    u_xlat1.x = (-_ShadowColor.w) * u_xlat16_13 + 1.0;
    u_xlat6.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(u_xlat15) + u_xlat1.xxx;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_2.x = u_xlat10_3 * u_xlat16_2.x + _LightShadowData.x;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_0) + u_xlat16_2.xxx;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + u_xlat16_2.xyz;
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

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat6;
mediump float u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat15;
    u_xlat15 = u_xlat15 * unity_FogParams.x;
    u_xlat16_3 = u_xlat15 * (-u_xlat15);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_8 = in_COLOR0.w * _Alpha;
    u_xlat16_13 = u_xlat16_3 * u_xlat16_8;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD2.w = u_xlat16_8;
    u_xlat15 = u_xlat16_13 * _ShadowColor.w;
    u_xlat1.x = (-_ShadowColor.w) * u_xlat16_13 + 1.0;
    u_xlat6.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(u_xlat15) + u_xlat1.xxx;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_2.x = u_xlat10_3 * u_xlat16_2.x + _LightShadowData.x;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_0) + u_xlat16_2.xxx;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + u_xlat16_2.xyz;
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

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat6;
mediump float u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat15;
    u_xlat15 = u_xlat15 * unity_FogParams.x;
    u_xlat16_3 = u_xlat15 * (-u_xlat15);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_8 = in_COLOR0.w * _Alpha;
    u_xlat16_13 = u_xlat16_3 * u_xlat16_8;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD2.w = u_xlat16_8;
    u_xlat15 = u_xlat16_13 * _ShadowColor.w;
    u_xlat1.x = (-_ShadowColor.w) * u_xlat16_13 + 1.0;
    u_xlat6.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(u_xlat15) + u_xlat1.xxx;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_2.x = u_xlat10_3 * u_xlat16_2.x + _LightShadowData.x;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_0) + u_xlat16_2.xxx;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + u_xlat16_2.xyz;
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

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat6;
mediump float u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat15;
    u_xlat15 = u_xlat15 * unity_FogParams.x;
    u_xlat16_3 = u_xlat15 * (-u_xlat15);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_8 = in_COLOR0.w * _Alpha;
    u_xlat16_13 = u_xlat16_3 * u_xlat16_8;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD2.w = u_xlat16_8;
    u_xlat15 = u_xlat16_13 * _ShadowColor.w;
    u_xlat1.x = (-_ShadowColor.w) * u_xlat16_13 + 1.0;
    u_xlat6.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(u_xlat15) + u_xlat1.xxx;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat3.x) + u_xlat0.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_2.x = u_xlat10_3 * u_xlat16_2.x + _LightShadowData.x;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_0) + u_xlat16_2.xxx;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vs_TEXCOORD4.xyz + u_xlat16_2.xyz;
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
}
}
 Pass {
  Name "SHADOWCASTER"
  LOD 100
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Background" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 91687
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
mediump float u_xlat16_14;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) * u_xlat15 + 1.0;
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat15) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb15 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat2.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat0.z + u_xlat2.x;
    u_xlat2.x = max((-u_xlat0.w), u_xlat10);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat10) + u_xlat2.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat10;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_4 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_4 = exp2(u_xlat16_4);
    u_xlat16_9 = in_COLOR0.w * _Alpha;
    u_xlat16_14 = u_xlat16_4 * u_xlat16_9;
    vs_TEXCOORD2 = u_xlat16_4;
    vs_TEXCOORD1.w = u_xlat16_9;
    u_xlat0.x = u_xlat16_14 * _ShadowColor.w;
    u_xlat5 = (-_ShadowColor.w) * u_xlat16_14 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat5);
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

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
mediump float u_xlat16_14;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) * u_xlat15 + 1.0;
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat15) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb15 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat2.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat0.z + u_xlat2.x;
    u_xlat2.x = max((-u_xlat0.w), u_xlat10);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat10) + u_xlat2.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat10;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_4 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_4 = exp2(u_xlat16_4);
    u_xlat16_9 = in_COLOR0.w * _Alpha;
    u_xlat16_14 = u_xlat16_4 * u_xlat16_9;
    vs_TEXCOORD2 = u_xlat16_4;
    vs_TEXCOORD1.w = u_xlat16_9;
    u_xlat0.x = u_xlat16_14 * _ShadowColor.w;
    u_xlat5 = (-_ShadowColor.w) * u_xlat16_14 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat5);
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

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
mediump float u_xlat16_14;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) * u_xlat15 + 1.0;
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat15) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb15 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat2.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat0.z + u_xlat2.x;
    u_xlat2.x = max((-u_xlat0.w), u_xlat10);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat10) + u_xlat2.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat10;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_4 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_4 = exp2(u_xlat16_4);
    u_xlat16_9 = in_COLOR0.w * _Alpha;
    u_xlat16_14 = u_xlat16_4 * u_xlat16_9;
    vs_TEXCOORD2 = u_xlat16_4;
    vs_TEXCOORD1.w = u_xlat16_9;
    u_xlat0.x = u_xlat16_14 * _ShadowColor.w;
    u_xlat5 = (-_ShadowColor.w) * u_xlat16_14 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat5);
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

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = u_xlat1.xyz + (-_LightPositionRange.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD2 = u_xlat16_2;
    vs_TEXCOORD1.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
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

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = u_xlat1.xyz + (-_LightPositionRange.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD2 = u_xlat16_2;
    vs_TEXCOORD1.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
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

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 unity_AmbientEquator;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = u_xlat1.xyz + (-_LightPositionRange.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_2 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_5 = in_COLOR0.w * _Alpha;
    u_xlat16_8 = u_xlat16_2 * u_xlat16_5;
    vs_TEXCOORD2 = u_xlat16_2;
    vs_TEXCOORD1.w = u_xlat16_5;
    u_xlat0.x = u_xlat16_8 * _ShadowColor.w;
    u_xlat3 = (-_ShadowColor.w) * u_xlat16_8 + 1.0;
    u_xlat1.xyz = unity_AmbientEquator.xyz * _ShadowColor.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz * u_xlat0.xxx + vec3(u_xlat3);
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
CustomEditor "CustomMaterialInspector"
}