Shader "Holo/Shadow Matte/Composite (for Pokedex)" {
Properties {
_ShadowColor ("Shadow Tint (RGBA)", Color) = (0,0,0,1)
_Alpha ("Alpha Out (for Pokedex)", Range(0, 1)) = 1
[KeywordEnum(Alpha_X_Ambient, RGBA)] _Multiplier ("    Clear Multiplier", Float) = 0
_Clip ("Target Clip (x min, y min, x max, y max)", Vector) = (0,0,0,0)
_Feather ("Target Feather (x min, y min, x max, y max)", Vector) = (0,0,0,0)
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("Mask X", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("Mask Y", Float) = 0
[Toggle(BRB_EYE_SHADE_DEBUG)] _EyeShadeDebug ("Debug Mask", Float) = 0
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "AlphaTest+50" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 100
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest+50" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 64987
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat14;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD0.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_3 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_7 = in_COLOR0.w * _Alpha;
    u_xlat16_11 = u_xlat16_3 * u_xlat16_7;
    vs_TEXCOORD4 = u_xlat16_3;
    vs_TEXCOORD3.w = u_xlat16_7;
    u_xlat0.x = u_xlat16_11 * _ShadowColor.w;
    u_xlat4 = (-_ShadowColor.w) * u_xlat16_11 + 1.0;
    vs_TEXCOORD3.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat4);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(1.0, 1.0, 1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat14;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD0.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_3 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_7 = in_COLOR0.w * _Alpha;
    u_xlat16_11 = u_xlat16_3 * u_xlat16_7;
    vs_TEXCOORD4 = u_xlat16_3;
    vs_TEXCOORD3.w = u_xlat16_7;
    u_xlat0.x = u_xlat16_11 * _ShadowColor.w;
    u_xlat4 = (-_ShadowColor.w) * u_xlat16_11 + 1.0;
    vs_TEXCOORD3.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat4);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(1.0, 1.0, 1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat14;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD0.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_3 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_7 = in_COLOR0.w * _Alpha;
    u_xlat16_11 = u_xlat16_3 * u_xlat16_7;
    vs_TEXCOORD4 = u_xlat16_3;
    vs_TEXCOORD3.w = u_xlat16_7;
    u_xlat0.x = u_xlat16_11 * _ShadowColor.w;
    u_xlat4 = (-_ShadowColor.w) * u_xlat16_11 + 1.0;
    vs_TEXCOORD3.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat4);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(1.0, 1.0, 1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat14;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD0.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_3 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_7 = in_COLOR0.w * _Alpha;
    u_xlat16_11 = u_xlat16_3 * u_xlat16_7;
    vs_TEXCOORD4 = u_xlat16_3;
    vs_TEXCOORD3.w = u_xlat16_7;
    u_xlat0.x = u_xlat16_11 * _ShadowColor.w;
    u_xlat4 = (-_ShadowColor.w) * u_xlat16_11 + 1.0;
    vs_TEXCOORD3.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat4);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(1.0, 1.0, 1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat14;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD0.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_3 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_7 = in_COLOR0.w * _Alpha;
    u_xlat16_11 = u_xlat16_3 * u_xlat16_7;
    vs_TEXCOORD4 = u_xlat16_3;
    vs_TEXCOORD3.w = u_xlat16_7;
    u_xlat0.x = u_xlat16_11 * _ShadowColor.w;
    u_xlat4 = (-_ShadowColor.w) * u_xlat16_11 + 1.0;
    vs_TEXCOORD3.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat4);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(1.0, 1.0, 1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat14;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD0.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_3 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_7 = in_COLOR0.w * _Alpha;
    u_xlat16_11 = u_xlat16_3 * u_xlat16_7;
    vs_TEXCOORD4 = u_xlat16_3;
    vs_TEXCOORD3.w = u_xlat16_7;
    u_xlat0.x = u_xlat16_11 * _ShadowColor.w;
    u_xlat4 = (-_ShadowColor.w) * u_xlat16_11 + 1.0;
    vs_TEXCOORD3.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat4);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(1.0, 1.0, 1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat14;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD0.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_3 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_7 = in_COLOR0.w * _Alpha;
    u_xlat16_11 = u_xlat16_3 * u_xlat16_7;
    vs_TEXCOORD4 = u_xlat16_3;
    vs_TEXCOORD3.w = u_xlat16_7;
    u_xlat0.x = u_xlat16_11 * _ShadowColor.w;
    u_xlat4 = (-_ShadowColor.w) * u_xlat16_11 + 1.0;
    vs_TEXCOORD3.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat4);
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
uniform 	mediump vec4 _Clip;
uniform 	mediump vec4 _Feather;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
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
    u_xlat16_0.xyz = u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_0.z) + 1.0;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = vs_TEXCOORD3 * vec4(u_xlat16_1) + u_xlat16_0;
    u_xlat16_1 = (-_Clip.y) + 1.0;
    u_xlat1.x = u_xlat16_1 + (-vs_TEXCOORD2.y);
    u_xlat16_4 = (-_Clip.y) + (-_Clip.w);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_2.xy = vec2(float(u_xlat16_4) * _Feather.y, float(u_xlat16_4) * _Feather.w);
    u_xlat16_2.x = u_xlat1.x / u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_8 = vs_TEXCOORD2.y + (-_Clip.w);
    u_xlat16_5 = u_xlat16_8 / u_xlat16_2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_5 * u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat14;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD0.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_3 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_7 = in_COLOR0.w * _Alpha;
    u_xlat16_11 = u_xlat16_3 * u_xlat16_7;
    vs_TEXCOORD4 = u_xlat16_3;
    vs_TEXCOORD3.w = u_xlat16_7;
    u_xlat0.x = u_xlat16_11 * _ShadowColor.w;
    u_xlat4 = (-_ShadowColor.w) * u_xlat16_11 + 1.0;
    vs_TEXCOORD3.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat4);
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
uniform 	mediump vec4 _Clip;
uniform 	mediump vec4 _Feather;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
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
    u_xlat16_0.xyz = u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_0.z) + 1.0;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = vs_TEXCOORD3 * vec4(u_xlat16_1) + u_xlat16_0;
    u_xlat16_1 = (-_Clip.y) + 1.0;
    u_xlat1.x = u_xlat16_1 + (-vs_TEXCOORD2.y);
    u_xlat16_4 = (-_Clip.y) + (-_Clip.w);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_2.xy = vec2(float(u_xlat16_4) * _Feather.y, float(u_xlat16_4) * _Feather.w);
    u_xlat16_2.x = u_xlat1.x / u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_8 = vs_TEXCOORD2.y + (-_Clip.w);
    u_xlat16_5 = u_xlat16_8 / u_xlat16_2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_5 * u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat14;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD0.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_3 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_7 = in_COLOR0.w * _Alpha;
    u_xlat16_11 = u_xlat16_3 * u_xlat16_7;
    vs_TEXCOORD4 = u_xlat16_3;
    vs_TEXCOORD3.w = u_xlat16_7;
    u_xlat0.x = u_xlat16_11 * _ShadowColor.w;
    u_xlat4 = (-_ShadowColor.w) * u_xlat16_11 + 1.0;
    vs_TEXCOORD3.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat4);
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
uniform 	mediump vec4 _Clip;
uniform 	mediump vec4 _Feather;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
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
    u_xlat16_0.xyz = u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_0.z) + 1.0;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = vs_TEXCOORD3 * vec4(u_xlat16_1) + u_xlat16_0;
    u_xlat16_1 = (-_Clip.y) + 1.0;
    u_xlat1.x = u_xlat16_1 + (-vs_TEXCOORD2.y);
    u_xlat16_4 = (-_Clip.y) + (-_Clip.w);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_2.xy = vec2(float(u_xlat16_4) * _Feather.y, float(u_xlat16_4) * _Feather.w);
    u_xlat16_2.x = u_xlat1.x / u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_8 = vs_TEXCOORD2.y + (-_Clip.w);
    u_xlat16_5 = u_xlat16_8 / u_xlat16_2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_5 * u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat14;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD0.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_3 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_7 = in_COLOR0.w * _Alpha;
    u_xlat16_11 = u_xlat16_3 * u_xlat16_7;
    vs_TEXCOORD4 = u_xlat16_3;
    vs_TEXCOORD3.w = u_xlat16_7;
    u_xlat0.x = u_xlat16_11 * _ShadowColor.w;
    u_xlat4 = (-_ShadowColor.w) * u_xlat16_11 + 1.0;
    vs_TEXCOORD3.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat4);
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
uniform 	mediump vec4 _Clip;
uniform 	mediump vec4 _Feather;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
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
    u_xlat16_0.xyz = u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_0.z) + 1.0;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = vs_TEXCOORD3 * vec4(u_xlat16_1) + u_xlat16_0;
    u_xlat16_1 = (-_Clip.y) + 1.0;
    u_xlat1.x = u_xlat16_1 + (-vs_TEXCOORD2.y);
    u_xlat16_4 = (-_Clip.y) + (-_Clip.w);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_2.xy = vec2(float(u_xlat16_4) * _Feather.y, float(u_xlat16_4) * _Feather.w);
    u_xlat16_2.x = u_xlat1.x / u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_8 = vs_TEXCOORD2.y + (-_Clip.w);
    u_xlat16_5 = u_xlat16_8 / u_xlat16_2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_5 * u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat14;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD0.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_3 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_7 = in_COLOR0.w * _Alpha;
    u_xlat16_11 = u_xlat16_3 * u_xlat16_7;
    vs_TEXCOORD4 = u_xlat16_3;
    vs_TEXCOORD3.w = u_xlat16_7;
    u_xlat0.x = u_xlat16_11 * _ShadowColor.w;
    u_xlat4 = (-_ShadowColor.w) * u_xlat16_11 + 1.0;
    vs_TEXCOORD3.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat4);
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
uniform 	mediump vec4 _Clip;
uniform 	mediump vec4 _Feather;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
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
    u_xlat16_0.xyz = u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_0.z) + 1.0;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = vs_TEXCOORD3 * vec4(u_xlat16_1) + u_xlat16_0;
    u_xlat16_1 = (-_Clip.y) + 1.0;
    u_xlat1.x = u_xlat16_1 + (-vs_TEXCOORD2.y);
    u_xlat16_4 = (-_Clip.y) + (-_Clip.w);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_2.xy = vec2(float(u_xlat16_4) * _Feather.y, float(u_xlat16_4) * _Feather.w);
    u_xlat16_2.x = u_xlat1.x / u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_8 = vs_TEXCOORD2.y + (-_Clip.w);
    u_xlat16_5 = u_xlat16_8 / u_xlat16_2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_5 * u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _ShadowColor;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat14;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD0.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat16_3 = u_xlat0.x * (-u_xlat0.x);
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_7 = in_COLOR0.w * _Alpha;
    u_xlat16_11 = u_xlat16_3 * u_xlat16_7;
    vs_TEXCOORD4 = u_xlat16_3;
    vs_TEXCOORD3.w = u_xlat16_7;
    u_xlat0.x = u_xlat16_11 * _ShadowColor.w;
    u_xlat4 = (-_ShadowColor.w) * u_xlat16_11 + 1.0;
    vs_TEXCOORD3.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat4);
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
uniform 	mediump vec4 _Clip;
uniform 	mediump vec4 _Feather;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
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
    u_xlat16_0.xyz = u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_0.z) + 1.0;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = vs_TEXCOORD3 * vec4(u_xlat16_1) + u_xlat16_0;
    u_xlat16_1 = (-_Clip.y) + 1.0;
    u_xlat1.x = u_xlat16_1 + (-vs_TEXCOORD2.y);
    u_xlat16_4 = (-_Clip.y) + (-_Clip.w);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_2.xy = vec2(float(u_xlat16_4) * _Feather.y, float(u_xlat16_4) * _Feather.w);
    u_xlat16_2.x = u_xlat1.x / u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_8 = vs_TEXCOORD2.y + (-_Clip.w);
    u_xlat16_5 = u_xlat16_8 / u_xlat16_2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_5 * u_xlat16_2.x;
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
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "AlphaTest+50" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 80856
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
    vs_TEXCOORD1.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat5);
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
    vs_TEXCOORD1.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat5);
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
    vs_TEXCOORD1.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat5);
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
    vs_TEXCOORD1.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat3);
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
    vs_TEXCOORD1.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat3);
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
    vs_TEXCOORD1.xyz = _ShadowColor.xyz * u_xlat0.xxx + vec3(u_xlat3);
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