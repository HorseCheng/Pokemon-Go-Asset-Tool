Shader "Holo/Effects/Particles/Stepped-Distortion" {
Properties {
_IntensityMultiplier ("Intensity Multiplier", Float) = 1
_MainTex ("Main Texture", 2D) = "white" { }
_AlphaMultiplier ("Alpha Multiplier", Float) = 1
_WarpTex ("Warp Texture", 2D) = "bump" { }
_WarpStrength ("Warp Strength", Float) = 1
_WarpSpeedX ("Warp X Pan Speed", Float) = 0
_WarpSpeedY ("Warp Y Pan Speed", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 31927
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
vec2 u_xlat4;
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
    u_xlat4.x = _Time.x * _WarpSpeedX;
    u_xlat4.y = _Time.x * _WarpSpeedY;
    vs_TEXCOORD1.xy = u_xlat4.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _IntensityMultiplier;
uniform 	mediump float _AlphaMultiplier;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
bool u_xlatb6;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1.x = (-vs_COLOR0.w) + 1.00999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat10_0.w>=u_xlat16_1.x);
#else
    u_xlatb6 = u_xlat10_0.w>=u_xlat16_1.x;
#endif
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_IntensityMultiplier);
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat0.x = vs_COLOR0.w * _AlphaMultiplier;
    SV_Target0.w = (u_xlatb6) ? u_xlat0.x : 0.0;
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
vec2 u_xlat4;
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
    u_xlat4.x = _Time.x * _WarpSpeedX;
    u_xlat4.y = _Time.x * _WarpSpeedY;
    vs_TEXCOORD1.xy = u_xlat4.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _IntensityMultiplier;
uniform 	mediump float _AlphaMultiplier;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
bool u_xlatb6;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1.x = (-vs_COLOR0.w) + 1.00999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat10_0.w>=u_xlat16_1.x);
#else
    u_xlatb6 = u_xlat10_0.w>=u_xlat16_1.x;
#endif
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_IntensityMultiplier);
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat0.x = vs_COLOR0.w * _AlphaMultiplier;
    SV_Target0.w = (u_xlatb6) ? u_xlat0.x : 0.0;
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
vec2 u_xlat4;
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
    u_xlat4.x = _Time.x * _WarpSpeedX;
    u_xlat4.y = _Time.x * _WarpSpeedY;
    vs_TEXCOORD1.xy = u_xlat4.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _IntensityMultiplier;
uniform 	mediump float _AlphaMultiplier;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
bool u_xlatb6;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1.x = (-vs_COLOR0.w) + 1.00999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat10_0.w>=u_xlat16_1.x);
#else
    u_xlatb6 = u_xlat10_0.w>=u_xlat16_1.x;
#endif
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_IntensityMultiplier);
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat0.x = vs_COLOR0.w * _AlphaMultiplier;
    SV_Target0.w = (u_xlatb6) ? u_xlat0.x : 0.0;
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
vec2 u_xlat4;
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
    u_xlat4.x = _Time.x * _WarpSpeedX;
    u_xlat4.y = _Time.x * _WarpSpeedY;
    vs_TEXCOORD1.xy = u_xlat4.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _IntensityMultiplier;
uniform 	mediump float _AlphaMultiplier;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
bool u_xlatb6;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1.x = (-vs_COLOR0.w) + 1.00999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat10_0.w>=u_xlat16_1.x);
#else
    u_xlatb6 = u_xlat10_0.w>=u_xlat16_1.x;
#endif
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_IntensityMultiplier);
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat0.x = vs_COLOR0.w * _AlphaMultiplier;
    SV_Target0.w = (u_xlatb6) ? u_xlat0.x : 0.0;
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
vec2 u_xlat4;
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
    u_xlat4.x = _Time.x * _WarpSpeedX;
    u_xlat4.y = _Time.x * _WarpSpeedY;
    vs_TEXCOORD1.xy = u_xlat4.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _IntensityMultiplier;
uniform 	mediump float _AlphaMultiplier;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
bool u_xlatb6;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1.x = (-vs_COLOR0.w) + 1.00999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat10_0.w>=u_xlat16_1.x);
#else
    u_xlatb6 = u_xlat10_0.w>=u_xlat16_1.x;
#endif
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_IntensityMultiplier);
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat0.x = vs_COLOR0.w * _AlphaMultiplier;
    SV_Target0.w = (u_xlatb6) ? u_xlat0.x : 0.0;
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
vec2 u_xlat4;
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
    u_xlat4.x = _Time.x * _WarpSpeedX;
    u_xlat4.y = _Time.x * _WarpSpeedY;
    vs_TEXCOORD1.xy = u_xlat4.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _IntensityMultiplier;
uniform 	mediump float _AlphaMultiplier;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
bool u_xlatb6;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD1.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1.x = (-vs_COLOR0.w) + 1.00999999;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat10_0.w>=u_xlat16_1.x);
#else
    u_xlatb6 = u_xlat10_0.w>=u_xlat16_1.x;
#endif
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_IntensityMultiplier);
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat0.x = vs_COLOR0.w * _AlphaMultiplier;
    SV_Target0.w = (u_xlatb6) ? u_xlat0.x : 0.0;
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