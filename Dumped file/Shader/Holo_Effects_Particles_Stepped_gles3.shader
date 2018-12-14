Shader "Holo/Effects/Particles/Stepped" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
_AlphaMultiplier ("Alpha Multiplier", Float) = 1
_ShadowSaturation ("Shadow Oversaturation", Range(0, 1)) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 5603
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
uniform 	mediump float _AlphaMultiplier;
uniform 	mediump float _ShadowSaturation;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz + (-vs_COLOR0.xyz);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = (-u_xlat10_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ShadowSaturation, _ShadowSaturation, _ShadowSaturation));
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz + vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.00999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat10_1.w>=u_xlat16_3);
#else
    u_xlatb0 = u_xlat10_1.w>=u_xlat16_3;
#endif
    u_xlat4 = vs_COLOR0.w * _AlphaMultiplier;
    SV_Target0.w = (u_xlatb0) ? u_xlat4 : 0.0;
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
uniform 	mediump float _AlphaMultiplier;
uniform 	mediump float _ShadowSaturation;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz + (-vs_COLOR0.xyz);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = (-u_xlat10_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ShadowSaturation, _ShadowSaturation, _ShadowSaturation));
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz + vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.00999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat10_1.w>=u_xlat16_3);
#else
    u_xlatb0 = u_xlat10_1.w>=u_xlat16_3;
#endif
    u_xlat4 = vs_COLOR0.w * _AlphaMultiplier;
    SV_Target0.w = (u_xlatb0) ? u_xlat4 : 0.0;
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
uniform 	mediump float _AlphaMultiplier;
uniform 	mediump float _ShadowSaturation;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz + (-vs_COLOR0.xyz);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = (-u_xlat10_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ShadowSaturation, _ShadowSaturation, _ShadowSaturation));
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz + vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.00999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat10_1.w>=u_xlat16_3);
#else
    u_xlatb0 = u_xlat10_1.w>=u_xlat16_3;
#endif
    u_xlat4 = vs_COLOR0.w * _AlphaMultiplier;
    SV_Target0.w = (u_xlatb0) ? u_xlat4 : 0.0;
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
uniform 	mediump float _AlphaMultiplier;
uniform 	mediump float _ShadowSaturation;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz + (-vs_COLOR0.xyz);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = (-u_xlat10_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ShadowSaturation, _ShadowSaturation, _ShadowSaturation));
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz + vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.00999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat10_1.w>=u_xlat16_3);
#else
    u_xlatb0 = u_xlat10_1.w>=u_xlat16_3;
#endif
    u_xlat4 = vs_COLOR0.w * _AlphaMultiplier;
    SV_Target0.w = (u_xlatb0) ? u_xlat4 : 0.0;
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
uniform 	mediump float _AlphaMultiplier;
uniform 	mediump float _ShadowSaturation;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz + (-vs_COLOR0.xyz);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = (-u_xlat10_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ShadowSaturation, _ShadowSaturation, _ShadowSaturation));
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz + vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.00999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat10_1.w>=u_xlat16_3);
#else
    u_xlatb0 = u_xlat10_1.w>=u_xlat16_3;
#endif
    u_xlat4 = vs_COLOR0.w * _AlphaMultiplier;
    SV_Target0.w = (u_xlatb0) ? u_xlat4 : 0.0;
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
uniform 	mediump float _AlphaMultiplier;
uniform 	mediump float _ShadowSaturation;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz + (-vs_COLOR0.xyz);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = (-u_xlat10_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ShadowSaturation, _ShadowSaturation, _ShadowSaturation));
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz + vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.00999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat10_1.w>=u_xlat16_3);
#else
    u_xlatb0 = u_xlat10_1.w>=u_xlat16_3;
#endif
    u_xlat4 = vs_COLOR0.w * _AlphaMultiplier;
    SV_Target0.w = (u_xlatb0) ? u_xlat4 : 0.0;
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