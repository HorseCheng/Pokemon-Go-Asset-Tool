Shader "Holo/Effects/Particles/Colorized Alpha" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 54420
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat10_2.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xyz = u_xlat10_2.xxx * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_9 = u_xlat10_2.x * u_xlat10_2.x;
    u_xlat16_9 = u_xlat10_2.x * u_xlat16_9;
    SV_Target0.w = u_xlat10_2.y * vs_COLOR0.w;
    SV_Target0.xyz = vec3(u_xlat16_9) * u_xlat16_1.xyz + u_xlat16_0.xyz;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat10_2.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xyz = u_xlat10_2.xxx * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_9 = u_xlat10_2.x * u_xlat10_2.x;
    u_xlat16_9 = u_xlat10_2.x * u_xlat16_9;
    SV_Target0.w = u_xlat10_2.y * vs_COLOR0.w;
    SV_Target0.xyz = vec3(u_xlat16_9) * u_xlat16_1.xyz + u_xlat16_0.xyz;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat10_2.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xyz = u_xlat10_2.xxx * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_9 = u_xlat10_2.x * u_xlat10_2.x;
    u_xlat16_9 = u_xlat10_2.x * u_xlat16_9;
    SV_Target0.w = u_xlat10_2.y * vs_COLOR0.w;
    SV_Target0.xyz = vec3(u_xlat16_9) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat10_2.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xyz = u_xlat10_2.xxx * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_9 = u_xlat10_2.x * u_xlat10_2.x;
    u_xlat16_9 = u_xlat10_2.x * u_xlat16_9;
    SV_Target0.w = u_xlat10_2.y * vs_COLOR0.w;
    SV_Target0.xyz = vec3(u_xlat16_9) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat10_2.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xyz = u_xlat10_2.xxx * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_9 = u_xlat10_2.x * u_xlat10_2.x;
    u_xlat16_9 = u_xlat10_2.x * u_xlat16_9;
    SV_Target0.w = u_xlat10_2.y * vs_COLOR0.w;
    SV_Target0.xyz = vec3(u_xlat16_9) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat10_2.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xyz = u_xlat10_2.xxx * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_9 = u_xlat10_2.x * u_xlat10_2.x;
    u_xlat16_9 = u_xlat10_2.x * u_xlat16_9;
    SV_Target0.w = u_xlat10_2.y * vs_COLOR0.w;
    SV_Target0.xyz = vec3(u_xlat16_9) * u_xlat16_1.xyz + u_xlat16_0.xyz;
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