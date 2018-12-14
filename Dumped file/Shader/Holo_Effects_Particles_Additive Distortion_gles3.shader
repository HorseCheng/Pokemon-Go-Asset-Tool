Shader "Holo/Effects/Particles/Additive Distortion" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
_WarpTex ("Warp Texture", 2D) = "bump" { }
_WarpStrength ("Warp Strength", Float) = 1
_WarpSpeedX ("Warp X Pan Speed", Float) = 0
_WarpSpeedY ("Warp Y Pan Speed", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  Lighting On
  GpuProgramID 39907
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _WarpSpeedX;
uniform 	mediump float _WarpSpeedY;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WarpTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.xx * vec2(_WarpSpeedX, _WarpSpeedY) + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _WarpSpeedX;
uniform 	mediump float _WarpSpeedY;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WarpTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.xx * vec2(_WarpSpeedX, _WarpSpeedY) + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _WarpSpeedX;
uniform 	mediump float _WarpSpeedY;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WarpTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.xx * vec2(_WarpSpeedX, _WarpSpeedY) + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _WarpSpeedX;
uniform 	mediump float _WarpSpeedY;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WarpTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.xx * vec2(_WarpSpeedX, _WarpSpeedY) + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _WarpSpeedX;
uniform 	mediump float _WarpSpeedY;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WarpTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.xx * vec2(_WarpSpeedX, _WarpSpeedY) + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _WarpSpeedX;
uniform 	mediump float _WarpSpeedY;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WarpTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.xx * vec2(_WarpSpeedX, _WarpSpeedY) + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
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
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
}
}
}
}