Shader "Holo/Character/FX/FireStencil" {
Properties {
_Color1 ("Color1", Color) = (1,1,0,0.5)
_Color2 ("Color2", Color) = (1,0.282353,0,0)
_MainTex ("Combo (R=A1,G=A2,B=Mask)", 2D) = "black" { }
_TilingRG ("Tiling for R(.xy) and G(.zw) channels", Vector) = (1,1,1,1)
_Vspeed ("Vspeed ", Range(0, 10)) = 1
_Vmultiply ("Vmultiply", Range(0, 10)) = 1.5
_Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare Function", Float) = 3
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Geometry+2" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Geometry+2" "RenderType" = "Opaque" }
  GpuProgramID 57911
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = vec2(_Time.y * _TilingRG.y, _Time.y * _TilingRG.w);
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat4.y * _TilingRG.w;
    vs_TEXCOORD1.w = (-u_xlat0.y) * _Vmultiply + u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat4.y * _TilingRG.y + (-u_xlat0.x);
    vs_TEXCOORD1.xz = u_xlat4.xx * _TilingRG.xz;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat10_2.x = texture(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat16_0 = _Color1.w * u_xlat10_0 + u_xlat10_2.x;
    u_xlat10_2.xy = texture(_MainTex, vs_TEXCOORD0.xy).zw;
    u_xlat16_0 = u_xlat10_2.x + u_xlat16_0;
    u_xlat16_1.x = u_xlat10_2.y + _Color2.w;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1.x;
    u_xlat16_1.xyz = _Color1.xyz + (-_Color2.xyz);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz + _Color2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = vec2(_Time.y * _TilingRG.y, _Time.y * _TilingRG.w);
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat4.y * _TilingRG.w;
    vs_TEXCOORD1.w = (-u_xlat0.y) * _Vmultiply + u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat4.y * _TilingRG.y + (-u_xlat0.x);
    vs_TEXCOORD1.xz = u_xlat4.xx * _TilingRG.xz;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat10_2.x = texture(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat16_0 = _Color1.w * u_xlat10_0 + u_xlat10_2.x;
    u_xlat10_2.xy = texture(_MainTex, vs_TEXCOORD0.xy).zw;
    u_xlat16_0 = u_xlat10_2.x + u_xlat16_0;
    u_xlat16_1.x = u_xlat10_2.y + _Color2.w;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1.x;
    u_xlat16_1.xyz = _Color1.xyz + (-_Color2.xyz);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz + _Color2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = vec2(_Time.y * _TilingRG.y, _Time.y * _TilingRG.w);
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat4.y * _TilingRG.w;
    vs_TEXCOORD1.w = (-u_xlat0.y) * _Vmultiply + u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat4.y * _TilingRG.y + (-u_xlat0.x);
    vs_TEXCOORD1.xz = u_xlat4.xx * _TilingRG.xz;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat10_2.x = texture(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat16_0 = _Color1.w * u_xlat10_0 + u_xlat10_2.x;
    u_xlat10_2.xy = texture(_MainTex, vs_TEXCOORD0.xy).zw;
    u_xlat16_0 = u_xlat10_2.x + u_xlat16_0;
    u_xlat16_1.x = u_xlat10_2.y + _Color2.w;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1.x;
    u_xlat16_1.xyz = _Color1.xyz + (-_Color2.xyz);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz + _Color2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "BRB_CHAR_FX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = vec2(_Time.y * _TilingRG.y, _Time.y * _TilingRG.w);
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat4.y * _TilingRG.w;
    vs_TEXCOORD1.w = (-u_xlat0.y) * _Vmultiply + u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat4.y * _TilingRG.y + (-u_xlat0.x);
    vs_TEXCOORD1.xz = u_xlat4.xx * _TilingRG.xz;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat10_2.x = texture(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat16_0 = _Color1.w * u_xlat10_0 + u_xlat10_2.x;
    u_xlat10_2.xy = texture(_MainTex, vs_TEXCOORD0.xy).zw;
    u_xlat16_0 = u_xlat10_2.x + u_xlat16_0;
    u_xlat16_1.x = u_xlat10_2.y + _Color2.w;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1.x;
    u_xlat16_1.xyz = _Color1.xyz + (-_Color2.xyz);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz + _Color2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "BRB_CHAR_FX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = vec2(_Time.y * _TilingRG.y, _Time.y * _TilingRG.w);
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat4.y * _TilingRG.w;
    vs_TEXCOORD1.w = (-u_xlat0.y) * _Vmultiply + u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat4.y * _TilingRG.y + (-u_xlat0.x);
    vs_TEXCOORD1.xz = u_xlat4.xx * _TilingRG.xz;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat10_2.x = texture(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat16_0 = _Color1.w * u_xlat10_0 + u_xlat10_2.x;
    u_xlat10_2.xy = texture(_MainTex, vs_TEXCOORD0.xy).zw;
    u_xlat16_0 = u_xlat10_2.x + u_xlat16_0;
    u_xlat16_1.x = u_xlat10_2.y + _Color2.w;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1.x;
    u_xlat16_1.xyz = _Color1.xyz + (-_Color2.xyz);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz + _Color2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "BRB_CHAR_FX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = vec2(_Time.y * _TilingRG.y, _Time.y * _TilingRG.w);
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat4.y * _TilingRG.w;
    vs_TEXCOORD1.w = (-u_xlat0.y) * _Vmultiply + u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat4.y * _TilingRG.y + (-u_xlat0.x);
    vs_TEXCOORD1.xz = u_xlat4.xx * _TilingRG.xz;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat10_2.x = texture(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat16_0 = _Color1.w * u_xlat10_0 + u_xlat10_2.x;
    u_xlat10_2.xy = texture(_MainTex, vs_TEXCOORD0.xy).zw;
    u_xlat16_0 = u_xlat10_2.x + u_xlat16_0;
    u_xlat16_1.x = u_xlat10_2.y + _Color2.w;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1.x;
    u_xlat16_1.xyz = _Color1.xyz + (-_Color2.xyz);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz + _Color2.xyz;
    SV_Target0.w = 1.0;
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
Keywords { "BRB_CHAR_FX" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "BRB_CHAR_FX" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "BRB_CHAR_FX" }
""
}
}
}
}
CustomEditor "CustomMaterialInspector"
}