Shader "Holo/Environment/Pixel Lit" {
Properties {
[KeywordEnum(Opaque, Cutout)] _Render ("Rendering Mode", Float) = 0
[KeywordEnum(Off, Diffuse)] _ColorMode ("Color Modifier Mode", Float) = 0
_Color ("    Color", Color) = (1,1,1,1)
[KeywordEnum(Off, Diffuse)] _VertexMode ("Vertex Color Mode", Float) = 1
_MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit)] _BaseAlpha ("    Alpha Mode", Float) = 0
_AlphaTestRef ("    Alpha Cutoff", Range(0, 1)) = 0.5
[Toggle(BRB_RAMP)] _RampEnable ("Use Toon Ramp", Float) = 0
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
[Toggle(BRB_LIGHTING_TWOSIDED)] _LightingDoubleSided ("    Two-sided lighting", Float) = 0
[Toggle(BRB_FX_DISABLE)] _FX ("Ignore FX Color", Float) = 0
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  Cull Off
  GpuProgramID 171
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD3 = u_xlat0 * _EnvironmentColor;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1 = u_xlat16_0.x * 0.5 + 0.5;
    u_xlat16_0.xyz = vec3(u_xlat16_1) * _LightColor0.xyz + vec3(1.0, 0.0, 0.0);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-vs_TEXCOORD3.xyz);
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat1.xyz + vs_TEXCOORD3.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD3 = u_xlat0 * _EnvironmentColor;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1 = u_xlat16_0.x * 0.5 + 0.5;
    u_xlat16_0.xyz = vec3(u_xlat16_1) * _LightColor0.xyz + vec3(1.0, 0.0, 0.0);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-vs_TEXCOORD3.xyz);
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat1.xyz + vs_TEXCOORD3.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD3 = u_xlat0 * _EnvironmentColor;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1 = u_xlat16_0.x * 0.5 + 0.5;
    u_xlat16_0.xyz = vec3(u_xlat16_1) * _LightColor0.xyz + vec3(1.0, 0.0, 0.0);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-vs_TEXCOORD3.xyz);
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat1.xyz + vs_TEXCOORD3.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD3 = u_xlat0 * _EnvironmentColor;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1 = u_xlat16_0.x * 0.5 + 0.5;
    u_xlat16_0.xyz = vec3(u_xlat16_1) * _LightColor0.xyz + vec3(1.0, 0.0, 0.0);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-vs_TEXCOORD3.xyz);
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat1.xyz + vs_TEXCOORD3.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD3 = u_xlat0 * _EnvironmentColor;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1 = u_xlat16_0.x * 0.5 + 0.5;
    u_xlat16_0.xyz = vec3(u_xlat16_1) * _LightColor0.xyz + vec3(1.0, 0.0, 0.0);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-vs_TEXCOORD3.xyz);
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat1.xyz + vs_TEXCOORD3.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD3 = u_xlat0 * _EnvironmentColor;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_1 = u_xlat16_0.x * 0.5 + 0.5;
    u_xlat16_0.xyz = vec3(u_xlat16_1) * _LightColor0.xyz + vec3(1.0, 0.0, 0.0);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-vs_TEXCOORD3.xyz);
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat1.xyz + vs_TEXCOORD3.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD3 = u_xlat0 * _EnvironmentColor;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
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
    u_xlat3.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
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
    u_xlat16_5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_5.x = dot(u_xlat16_5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_0 = u_xlat16_5.x * 0.5 + 0.5;
    u_xlat16_2.x = u_xlat16_0 * u_xlat16_2.x + (-u_xlat16_0);
    u_xlat16_2.x = abs(u_xlat16_5.x) * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz + vec3(1.0, 0.0, 0.0);
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz + (-vs_TEXCOORD3.xyz);
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD3 = u_xlat0 * _EnvironmentColor;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
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
    u_xlat3.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
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
    u_xlat16_5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_5.x = dot(u_xlat16_5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_0 = u_xlat16_5.x * 0.5 + 0.5;
    u_xlat16_2.x = u_xlat16_0 * u_xlat16_2.x + (-u_xlat16_0);
    u_xlat16_2.x = abs(u_xlat16_5.x) * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz + vec3(1.0, 0.0, 0.0);
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz + (-vs_TEXCOORD3.xyz);
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD3 = u_xlat0 * _EnvironmentColor;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
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
    u_xlat3.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
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
    u_xlat16_5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_5.x = dot(u_xlat16_5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_0 = u_xlat16_5.x * 0.5 + 0.5;
    u_xlat16_2.x = u_xlat16_0 * u_xlat16_2.x + (-u_xlat16_0);
    u_xlat16_2.x = abs(u_xlat16_5.x) * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz + vec3(1.0, 0.0, 0.0);
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz + (-vs_TEXCOORD3.xyz);
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD3 = u_xlat0 * _EnvironmentColor;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
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
    u_xlat3.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
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
    u_xlat16_5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_5.x = dot(u_xlat16_5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_0 = u_xlat16_5.x * 0.5 + 0.5;
    u_xlat16_2.x = u_xlat16_0 * u_xlat16_2.x + (-u_xlat16_0);
    u_xlat16_2.x = abs(u_xlat16_5.x) * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz + vec3(1.0, 0.0, 0.0);
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz + (-vs_TEXCOORD3.xyz);
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD3 = u_xlat0 * _EnvironmentColor;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
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
    u_xlat3.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
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
    u_xlat16_5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_5.x = dot(u_xlat16_5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_0 = u_xlat16_5.x * 0.5 + 0.5;
    u_xlat16_2.x = u_xlat16_0 * u_xlat16_2.x + (-u_xlat16_0);
    u_xlat16_2.x = abs(u_xlat16_5.x) * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz + vec3(1.0, 0.0, 0.0);
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz + (-vs_TEXCOORD3.xyz);
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD3 = u_xlat0 * _EnvironmentColor;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
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
    u_xlat3.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
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
    u_xlat16_5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * vs_TEXCOORD1.xyz;
    u_xlat16_5.x = dot(u_xlat16_5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_0 = u_xlat16_5.x * 0.5 + 0.5;
    u_xlat16_2.x = u_xlat16_0 * u_xlat16_2.x + (-u_xlat16_0);
    u_xlat16_2.x = abs(u_xlat16_5.x) * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz + vec3(1.0, 0.0, 0.0);
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz + (-vs_TEXCOORD3.xyz);
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
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
  LOD 200
  Tags { "LIGHTMODE" = "SHADOWCASTER" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  Cull Off
  GpuProgramID 101125
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb12 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat2.xyz;
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
    u_xlat8 = u_xlat0.z + u_xlat2.x;
    u_xlat2.x = max((-u_xlat0.w), u_xlat8);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat8) + u_xlat2.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat8;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD1 = u_xlat0 * _EnvironmentColor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb12 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat2.xyz;
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
    u_xlat8 = u_xlat0.z + u_xlat2.x;
    u_xlat2.x = max((-u_xlat0.w), u_xlat8);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat8) + u_xlat2.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat8;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD1 = u_xlat0 * _EnvironmentColor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb12 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat2.xyz;
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
    u_xlat8 = u_xlat0.z + u_xlat2.x;
    u_xlat2.x = max((-u_xlat0.w), u_xlat8);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat8) + u_xlat2.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat8;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD1 = u_xlat0 * _EnvironmentColor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD1 = u_xlat0 * _EnvironmentColor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD1 = u_xlat0 * _EnvironmentColor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _EnvironmentColor;
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    vs_TEXCOORD1 = u_xlat0 * _EnvironmentColor;
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