Shader "Hidden/FrameDebuggerRenderTargetDisplay" {
Properties {
_MainTex ("", any) = "white" { }
}
SubShader {
 Tags { "ForceSupported" = "true" }
 Pass {
  Tags { "ForceSupported" = "true" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 52480
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Channels;
uniform 	mediump vec4 _Levels;
uniform highp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
bool u_xlatb2;
mediump float u_xlat16_4;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat0 + (-_Levels.xxxx);
    u_xlat16_1 = (-_Levels.x) + _Levels.y;
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * _Channels;
    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_4==1.0);
#else
    u_xlatb2 = u_xlat16_4==1.0;
#endif
    SV_Target0 = (bool(u_xlatb2)) ? vec4(u_xlat16_1) : u_xlat16_0;
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
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Channels;
uniform 	mediump vec4 _Levels;
uniform highp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
bool u_xlatb2;
mediump float u_xlat16_4;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat0 + (-_Levels.xxxx);
    u_xlat16_1 = (-_Levels.x) + _Levels.y;
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * _Channels;
    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_4==1.0);
#else
    u_xlatb2 = u_xlat16_4==1.0;
#endif
    SV_Target0 = (bool(u_xlatb2)) ? vec4(u_xlat16_1) : u_xlat16_0;
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
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Channels;
uniform 	mediump vec4 _Levels;
uniform highp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
bool u_xlatb2;
mediump float u_xlat16_4;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat0 + (-_Levels.xxxx);
    u_xlat16_1 = (-_Levels.x) + _Levels.y;
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * _Channels;
    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_4==1.0);
#else
    u_xlatb2 = u_xlat16_4==1.0;
#endif
    SV_Target0 = (bool(u_xlatb2)) ? vec4(u_xlat16_1) : u_xlat16_0;
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
 Pass {
  Tags { "ForceSupported" = "true" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 86592
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Channels;
uniform 	mediump vec4 _Levels;
uniform highp samplerCube _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
bool u_xlatb2;
mediump float u_xlat16_4;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xyz);
    u_xlat16_0 = u_xlat0 + (-_Levels.xxxx);
    u_xlat16_1 = (-_Levels.x) + _Levels.y;
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * _Channels;
    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_4==1.0);
#else
    u_xlatb2 = u_xlat16_4==1.0;
#endif
    SV_Target0 = (bool(u_xlatb2)) ? vec4(u_xlat16_1) : u_xlat16_0;
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
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Channels;
uniform 	mediump vec4 _Levels;
uniform highp samplerCube _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
bool u_xlatb2;
mediump float u_xlat16_4;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xyz);
    u_xlat16_0 = u_xlat0 + (-_Levels.xxxx);
    u_xlat16_1 = (-_Levels.x) + _Levels.y;
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * _Channels;
    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_4==1.0);
#else
    u_xlatb2 = u_xlat16_4==1.0;
#endif
    SV_Target0 = (bool(u_xlatb2)) ? vec4(u_xlat16_1) : u_xlat16_0;
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
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Channels;
uniform 	mediump vec4 _Levels;
uniform highp samplerCube _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
bool u_xlatb2;
mediump float u_xlat16_4;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xyz);
    u_xlat16_0 = u_xlat0 + (-_Levels.xxxx);
    u_xlat16_1 = (-_Levels.x) + _Levels.y;
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * _Channels;
    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_4==1.0);
#else
    u_xlatb2 = u_xlat16_4==1.0;
#endif
    SV_Target0 = (bool(u_xlatb2)) ? vec4(u_xlat16_1) : u_xlat16_0;
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
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 154206
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Channels;
uniform 	mediump vec4 _Levels;
uniform lowp sampler2DArray _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
bool u_xlatb2;
mediump float u_xlat16_4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xyz);
    u_xlat16_0 = u_xlat10_0 + (-_Levels.xxxx);
    u_xlat16_1 = (-_Levels.x) + _Levels.y;
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * _Channels;
    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_4==1.0);
#else
    u_xlatb2 = u_xlat16_4==1.0;
#endif
    SV_Target0 = (bool(u_xlatb2)) ? vec4(u_xlat16_1) : u_xlat16_0;
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
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Channels;
uniform 	mediump vec4 _Levels;
uniform lowp sampler2DArray _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
bool u_xlatb2;
mediump float u_xlat16_4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xyz);
    u_xlat16_0 = u_xlat10_0 + (-_Levels.xxxx);
    u_xlat16_1 = (-_Levels.x) + _Levels.y;
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * _Channels;
    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_4==1.0);
#else
    u_xlatb2 = u_xlat16_4==1.0;
#endif
    SV_Target0 = (bool(u_xlatb2)) ? vec4(u_xlat16_1) : u_xlat16_0;
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
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Channels;
uniform 	mediump vec4 _Levels;
uniform lowp sampler2DArray _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
bool u_xlatb2;
mediump float u_xlat16_4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xyz);
    u_xlat16_0 = u_xlat10_0 + (-_Levels.xxxx);
    u_xlat16_1 = (-_Levels.x) + _Levels.y;
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * _Channels;
    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_4==1.0);
#else
    u_xlatb2 = u_xlat16_4==1.0;
#endif
    SV_Target0 = (bool(u_xlatb2)) ? vec4(u_xlat16_1) : u_xlat16_0;
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