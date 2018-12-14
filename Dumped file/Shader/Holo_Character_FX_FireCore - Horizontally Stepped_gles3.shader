Shader "Holo/Character/FX/FireCore - Horizontally Stepped" {
Properties {
_MainTex ("Combo (R=A1 G=A2)", 2D) = "black" { }
_FPS ("FPS", Float) = 15
_Step ("Step", Float) = 0
_Offset ("Depth Offset", Float) = 0
_Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare Function", Float) = 8
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 2
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 62295
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Step;
uniform 	mediump float _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat0.zw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.w + -1.0;
    u_xlat1.x = ceil(u_xlat1.x);
    u_xlat6 = u_xlat0.w + u_xlat1.x;
    u_xlat6 = max(u_xlat6, 0.0500000007);
    u_xlat0.y = min(u_xlat6, 0.949999988);
    u_xlat6 = _Time.y * _FPS;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = u_xlat6 * _Step;
    u_xlat6 = fract(u_xlat6);
    u_xlat0.x = u_xlat6 + u_xlat0.z;
    vs_TEXCOORD0 = u_xlat0.xyzy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
lowp float u_xlat10_1;
float u_xlat2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).y;
    u_xlat2 = u_xlat10_0 * u_xlat10_1 + -0.5;
    u_xlat16_0 = u_xlat10_1 * u_xlat10_0;
    SV_Target0.w = u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2<0.0);
#else
    u_xlatb0 = u_xlat2<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vec3(1.0, 0.5, 0.0);
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Step;
uniform 	mediump float _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat0.zw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.w + -1.0;
    u_xlat1.x = ceil(u_xlat1.x);
    u_xlat6 = u_xlat0.w + u_xlat1.x;
    u_xlat6 = max(u_xlat6, 0.0500000007);
    u_xlat0.y = min(u_xlat6, 0.949999988);
    u_xlat6 = _Time.y * _FPS;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = u_xlat6 * _Step;
    u_xlat6 = fract(u_xlat6);
    u_xlat0.x = u_xlat6 + u_xlat0.z;
    vs_TEXCOORD0 = u_xlat0.xyzy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
lowp float u_xlat10_1;
float u_xlat2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).y;
    u_xlat2 = u_xlat10_0 * u_xlat10_1 + -0.5;
    u_xlat16_0 = u_xlat10_1 * u_xlat10_0;
    SV_Target0.w = u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2<0.0);
#else
    u_xlatb0 = u_xlat2<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vec3(1.0, 0.5, 0.0);
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Step;
uniform 	mediump float _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat0.zw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.w + -1.0;
    u_xlat1.x = ceil(u_xlat1.x);
    u_xlat6 = u_xlat0.w + u_xlat1.x;
    u_xlat6 = max(u_xlat6, 0.0500000007);
    u_xlat0.y = min(u_xlat6, 0.949999988);
    u_xlat6 = _Time.y * _FPS;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = u_xlat6 * _Step;
    u_xlat6 = fract(u_xlat6);
    u_xlat0.x = u_xlat6 + u_xlat0.z;
    vs_TEXCOORD0 = u_xlat0.xyzy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
lowp float u_xlat10_1;
float u_xlat2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).y;
    u_xlat2 = u_xlat10_0 * u_xlat10_1 + -0.5;
    u_xlat16_0 = u_xlat10_1 * u_xlat10_0;
    SV_Target0.w = u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2<0.0);
#else
    u_xlatb0 = u_xlat2<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vec3(1.0, 0.5, 0.0);
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