Shader "Holo/Effects/Unlit Dissolve" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_DisolveTex ("Dissolve Texture", 2D) = "white" { }
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
[Toggle] _ZWrite ("Z Write", Float) = 1
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "TransparentCutout" }
 Pass {
  Tags { "QUEUE" = "Transparent" "RenderType" = "TransparentCutout" }
  ZWrite Off
  Cull Off
  GpuProgramID 52001
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _DisolveTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD0.xy * _DisolveTex_ST.xy + _DisolveTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _DisolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.x = texture(_DisolveTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = dot(u_xlat10_0.xx, vs_COLOR0.ww);
    u_xlat16_0 = u_xlat16_0 + vs_COLOR0.w;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat16_1 * u_xlat10_0.w;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _DisolveTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD0.xy * _DisolveTex_ST.xy + _DisolveTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _DisolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.x = texture(_DisolveTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = dot(u_xlat10_0.xx, vs_COLOR0.ww);
    u_xlat16_0 = u_xlat16_0 + vs_COLOR0.w;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat16_1 * u_xlat10_0.w;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _DisolveTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD0.xy * _DisolveTex_ST.xy + _DisolveTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _DisolveTex;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.x = texture(_DisolveTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = dot(u_xlat10_0.xx, vs_COLOR0.ww);
    u_xlat16_0 = u_xlat16_0 + vs_COLOR0.w;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat16_1 * u_xlat10_0.w;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
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