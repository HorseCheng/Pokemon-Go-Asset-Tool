Shader "Holo/Effects/DetailUVPanningFresnelWiggle" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_DetailTex ("Detail Texture", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
_PanningSpeed ("Panning Speed", Vector) = (0,0,0,0)
_FresnelScale ("Fresnel Scale", Float) = 1
_FresnelPower ("Fresnel Power", Float) = 1
_VertexNoise ("Vertex Noise", Float) = 0
_VertexSpeed ("Vertex Speed", Float) = 1
_VertexFrequency ("Vertex Frequency", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 61504
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _DetailTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump float _FresnelScale;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _VertexNoise;
uniform 	mediump float _VertexSpeed;
uniform 	mediump float _VertexFrequency;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * vec3(_VertexFrequency) + _Time.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexSpeed, _VertexSpeed, _VertexSpeed));
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexNoise, _VertexNoise, _VertexNoise));
    u_xlat0.xyz = u_xlat0.xyz * in_COLOR0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = _Time.yy * _PanningSpeed.zw + u_xlat1.xy;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * _PanningSpeed.xy + u_xlat1.xy;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelScale;
    u_xlat0.x = u_xlat0.x * in_COLOR0.w;
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat0 = u_xlat16_0 * _Color;
    SV_Target0.w = u_xlat0.w * vs_TEXCOORD2;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _DetailTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump float _FresnelScale;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _VertexNoise;
uniform 	mediump float _VertexSpeed;
uniform 	mediump float _VertexFrequency;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * vec3(_VertexFrequency) + _Time.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexSpeed, _VertexSpeed, _VertexSpeed));
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexNoise, _VertexNoise, _VertexNoise));
    u_xlat0.xyz = u_xlat0.xyz * in_COLOR0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = _Time.yy * _PanningSpeed.zw + u_xlat1.xy;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * _PanningSpeed.xy + u_xlat1.xy;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelScale;
    u_xlat0.x = u_xlat0.x * in_COLOR0.w;
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat0 = u_xlat16_0 * _Color;
    SV_Target0.w = u_xlat0.w * vs_TEXCOORD2;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _DetailTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump float _FresnelScale;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _VertexNoise;
uniform 	mediump float _VertexSpeed;
uniform 	mediump float _VertexFrequency;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * vec3(_VertexFrequency) + _Time.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexSpeed, _VertexSpeed, _VertexSpeed));
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexNoise, _VertexNoise, _VertexNoise));
    u_xlat0.xyz = u_xlat0.xyz * in_COLOR0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = _Time.yy * _PanningSpeed.zw + u_xlat1.xy;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * _PanningSpeed.xy + u_xlat1.xy;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelScale;
    u_xlat0.x = u_xlat0.x * in_COLOR0.w;
    vs_TEXCOORD2 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * u_xlat10_1;
    u_xlat0 = u_xlat16_0 * _Color;
    SV_Target0.w = u_xlat0.w * vs_TEXCOORD2;
    SV_Target0.xyz = u_xlat0.xyz;
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
}
}
}
}