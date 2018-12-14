Shader "Hidden/VideoDecode" {
Properties {
_MainTex ("_MainTex (A)", 2D) = "black" { }
_SecondTex ("_SecondTex (A)", 2D) = "black" { }
_ThirdTex ("_ThirdTex (A)", 2D) = "black" { }
}
SubShader {
 Pass {
  Name "YCBCR_TO_RGB1"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 28028
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_StereoEyeIndex;
uniform 	vec4 _RightEyeUVOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4 = float(unity_StereoEyeIndex);
    vs_TEXCOORD0.xy = vec2(u_xlat4) * _RightEyeUVOffset.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
uniform lowp sampler2D _ThirdTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_2;
mediump float u_xlat16_3;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0 = texture(_SecondTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1.xy = vec2(u_xlat10_0) * vec2(0.390625, 1.984375);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1.x = u_xlat10_0 * 1.15625 + (-u_xlat16_1.x);
    u_xlat16_3 = u_xlat10_0 * 1.15625 + u_xlat16_1.y;
    SV_Target0.z = u_xlat16_3 + -1.06861997;
    u_xlat10_2 = texture(_ThirdTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1.x = (-u_xlat10_2) * 0.8125 + u_xlat16_1.x;
    u_xlat16_3 = u_xlat10_2 * 1.59375;
    u_xlat16_1.y = u_xlat10_0 * 1.15625 + u_xlat16_3;
    SV_Target0.xy = u_xlat16_1.yx + vec2(-0.872539997, 0.531369984);
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
uniform 	int unity_StereoEyeIndex;
uniform 	vec4 _RightEyeUVOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4 = float(unity_StereoEyeIndex);
    vs_TEXCOORD0.xy = vec2(u_xlat4) * _RightEyeUVOffset.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
uniform lowp sampler2D _ThirdTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_2;
mediump float u_xlat16_3;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0 = texture(_SecondTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1.xy = vec2(u_xlat10_0) * vec2(0.390625, 1.984375);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1.x = u_xlat10_0 * 1.15625 + (-u_xlat16_1.x);
    u_xlat16_3 = u_xlat10_0 * 1.15625 + u_xlat16_1.y;
    SV_Target0.z = u_xlat16_3 + -1.06861997;
    u_xlat10_2 = texture(_ThirdTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1.x = (-u_xlat10_2) * 0.8125 + u_xlat16_1.x;
    u_xlat16_3 = u_xlat10_2 * 1.59375;
    u_xlat16_1.y = u_xlat10_0 * 1.15625 + u_xlat16_3;
    SV_Target0.xy = u_xlat16_1.yx + vec2(-0.872539997, 0.531369984);
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
uniform 	int unity_StereoEyeIndex;
uniform 	vec4 _RightEyeUVOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4 = float(unity_StereoEyeIndex);
    vs_TEXCOORD0.xy = vec2(u_xlat4) * _RightEyeUVOffset.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
uniform lowp sampler2D _ThirdTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
mediump vec2 u_xlat16_1;
lowp float u_xlat10_2;
mediump float u_xlat16_3;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0 = texture(_SecondTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1.xy = vec2(u_xlat10_0) * vec2(0.390625, 1.984375);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1.x = u_xlat10_0 * 1.15625 + (-u_xlat16_1.x);
    u_xlat16_3 = u_xlat10_0 * 1.15625 + u_xlat16_1.y;
    SV_Target0.z = u_xlat16_3 + -1.06861997;
    u_xlat10_2 = texture(_ThirdTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1.x = (-u_xlat10_2) * 0.8125 + u_xlat16_1.x;
    u_xlat16_3 = u_xlat10_2 * 1.59375;
    u_xlat16_1.y = u_xlat10_0 * 1.15625 + u_xlat16_3;
    SV_Target0.xy = u_xlat16_1.yx + vec2(-0.872539997, 0.531369984);
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
  Name "YCBCRA_TO_RGBAFULL"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 113027
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_StereoEyeIndex;
uniform 	vec4 _RightEyeUVOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4 = float(unity_StereoEyeIndex);
    vs_TEXCOORD0.xy = vec2(u_xlat4) * _RightEyeUVOffset.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
uniform lowp sampler2D _ThirdTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_3;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    SV_Target0.w = u_xlat10_0;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0);
    u_xlat10_4 = texture(_SecondTex, u_xlat0.xy).w;
    u_xlat16_1.xy = vec2(u_xlat10_4) * vec2(0.390625, 1.984375);
    u_xlat10_4 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat10_0 = texture(_ThirdTex, u_xlat0.xy).w;
    u_xlat16_1.x = u_xlat10_4 * 1.15625 + (-u_xlat16_1.x);
    u_xlat16_3 = u_xlat10_4 * 1.15625 + u_xlat16_1.y;
    SV_Target0.z = u_xlat16_3 + -1.06861997;
    u_xlat16_1.x = (-u_xlat10_0) * 0.8125 + u_xlat16_1.x;
    u_xlat16_3 = u_xlat10_0 * 1.59375;
    u_xlat16_1.y = u_xlat10_4 * 1.15625 + u_xlat16_3;
    SV_Target0.xy = u_xlat16_1.yx + vec2(-0.872539997, 0.531369984);
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
uniform 	int unity_StereoEyeIndex;
uniform 	vec4 _RightEyeUVOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4 = float(unity_StereoEyeIndex);
    vs_TEXCOORD0.xy = vec2(u_xlat4) * _RightEyeUVOffset.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
uniform lowp sampler2D _ThirdTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_3;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    SV_Target0.w = u_xlat10_0;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0);
    u_xlat10_4 = texture(_SecondTex, u_xlat0.xy).w;
    u_xlat16_1.xy = vec2(u_xlat10_4) * vec2(0.390625, 1.984375);
    u_xlat10_4 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat10_0 = texture(_ThirdTex, u_xlat0.xy).w;
    u_xlat16_1.x = u_xlat10_4 * 1.15625 + (-u_xlat16_1.x);
    u_xlat16_3 = u_xlat10_4 * 1.15625 + u_xlat16_1.y;
    SV_Target0.z = u_xlat16_3 + -1.06861997;
    u_xlat16_1.x = (-u_xlat10_0) * 0.8125 + u_xlat16_1.x;
    u_xlat16_3 = u_xlat10_0 * 1.59375;
    u_xlat16_1.y = u_xlat10_4 * 1.15625 + u_xlat16_3;
    SV_Target0.xy = u_xlat16_1.yx + vec2(-0.872539997, 0.531369984);
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
uniform 	int unity_StereoEyeIndex;
uniform 	vec4 _RightEyeUVOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4 = float(unity_StereoEyeIndex);
    vs_TEXCOORD0.xy = vec2(u_xlat4) * _RightEyeUVOffset.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
uniform lowp sampler2D _ThirdTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_3;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    SV_Target0.w = u_xlat10_0;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0);
    u_xlat10_4 = texture(_SecondTex, u_xlat0.xy).w;
    u_xlat16_1.xy = vec2(u_xlat10_4) * vec2(0.390625, 1.984375);
    u_xlat10_4 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat10_0 = texture(_ThirdTex, u_xlat0.xy).w;
    u_xlat16_1.x = u_xlat10_4 * 1.15625 + (-u_xlat16_1.x);
    u_xlat16_3 = u_xlat10_4 * 1.15625 + u_xlat16_1.y;
    SV_Target0.z = u_xlat16_3 + -1.06861997;
    u_xlat16_1.x = (-u_xlat10_0) * 0.8125 + u_xlat16_1.x;
    u_xlat16_3 = u_xlat10_0 * 1.59375;
    u_xlat16_1.y = u_xlat10_4 * 1.15625 + u_xlat16_3;
    SV_Target0.xy = u_xlat16_1.yx + vec2(-0.872539997, 0.531369984);
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
  Name "YCBCRA_TO_RGBA"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 142939
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_StereoEyeIndex;
uniform 	vec4 _RightEyeUVOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4 = float(unity_StereoEyeIndex);
    vs_TEXCOORD0.xy = vec2(u_xlat4) * _RightEyeUVOffset.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
uniform lowp sampler2D _ThirdTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_3;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_1.x = u_xlat10_0 + -0.0627449974;
    SV_Target0.w = u_xlat16_1.x * 1.15625;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0);
    u_xlat10_4 = texture(_SecondTex, u_xlat0.xy).w;
    u_xlat16_1.xy = vec2(u_xlat10_4) * vec2(0.390625, 1.984375);
    u_xlat10_4 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat10_0 = texture(_ThirdTex, u_xlat0.xy).w;
    u_xlat16_1.x = u_xlat10_4 * 1.15625 + (-u_xlat16_1.x);
    u_xlat16_3 = u_xlat10_4 * 1.15625 + u_xlat16_1.y;
    SV_Target0.z = u_xlat16_3 + -1.06861997;
    u_xlat16_1.x = (-u_xlat10_0) * 0.8125 + u_xlat16_1.x;
    u_xlat16_3 = u_xlat10_0 * 1.59375;
    u_xlat16_1.y = u_xlat10_4 * 1.15625 + u_xlat16_3;
    SV_Target0.xy = u_xlat16_1.yx + vec2(-0.872539997, 0.531369984);
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
uniform 	int unity_StereoEyeIndex;
uniform 	vec4 _RightEyeUVOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4 = float(unity_StereoEyeIndex);
    vs_TEXCOORD0.xy = vec2(u_xlat4) * _RightEyeUVOffset.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
uniform lowp sampler2D _ThirdTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_3;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_1.x = u_xlat10_0 + -0.0627449974;
    SV_Target0.w = u_xlat16_1.x * 1.15625;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0);
    u_xlat10_4 = texture(_SecondTex, u_xlat0.xy).w;
    u_xlat16_1.xy = vec2(u_xlat10_4) * vec2(0.390625, 1.984375);
    u_xlat10_4 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat10_0 = texture(_ThirdTex, u_xlat0.xy).w;
    u_xlat16_1.x = u_xlat10_4 * 1.15625 + (-u_xlat16_1.x);
    u_xlat16_3 = u_xlat10_4 * 1.15625 + u_xlat16_1.y;
    SV_Target0.z = u_xlat16_3 + -1.06861997;
    u_xlat16_1.x = (-u_xlat10_0) * 0.8125 + u_xlat16_1.x;
    u_xlat16_3 = u_xlat10_0 * 1.59375;
    u_xlat16_1.y = u_xlat10_4 * 1.15625 + u_xlat16_3;
    SV_Target0.xy = u_xlat16_1.yx + vec2(-0.872539997, 0.531369984);
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
uniform 	int unity_StereoEyeIndex;
uniform 	vec4 _RightEyeUVOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4 = float(unity_StereoEyeIndex);
    vs_TEXCOORD0.xy = vec2(u_xlat4) * _RightEyeUVOffset.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
uniform lowp sampler2D _ThirdTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_3;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_1.x = u_xlat10_0 + -0.0627449974;
    SV_Target0.w = u_xlat16_1.x * 1.15625;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0);
    u_xlat10_4 = texture(_SecondTex, u_xlat0.xy).w;
    u_xlat16_1.xy = vec2(u_xlat10_4) * vec2(0.390625, 1.984375);
    u_xlat10_4 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat10_0 = texture(_ThirdTex, u_xlat0.xy).w;
    u_xlat16_1.x = u_xlat10_4 * 1.15625 + (-u_xlat16_1.x);
    u_xlat16_3 = u_xlat10_4 * 1.15625 + u_xlat16_1.y;
    SV_Target0.z = u_xlat16_3 + -1.06861997;
    u_xlat16_1.x = (-u_xlat10_0) * 0.8125 + u_xlat16_1.x;
    u_xlat16_3 = u_xlat10_0 * 1.59375;
    u_xlat16_1.y = u_xlat10_4 * 1.15625 + u_xlat16_3;
    SV_Target0.xy = u_xlat16_1.yx + vec2(-0.872539997, 0.531369984);
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
  Name "COMPOSITE_RGBA_TO_RGBA"
  Cull Off
  GpuProgramID 238344
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_StereoEyeIndex;
uniform 	vec4 _RightEyeUVOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4 = float(unity_StereoEyeIndex);
    vs_TEXCOORD0.xy = vec2(u_xlat4) * _RightEyeUVOffset.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaParam;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.w = u_xlat0.w * _AlphaParam;
    SV_Target0 = u_xlat0;
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
uniform 	int unity_StereoEyeIndex;
uniform 	vec4 _RightEyeUVOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4 = float(unity_StereoEyeIndex);
    vs_TEXCOORD0.xy = vec2(u_xlat4) * _RightEyeUVOffset.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaParam;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.w = u_xlat0.w * _AlphaParam;
    SV_Target0 = u_xlat0;
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
uniform 	int unity_StereoEyeIndex;
uniform 	vec4 _RightEyeUVOffset;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4 = float(unity_StereoEyeIndex);
    vs_TEXCOORD0.xy = vec2(u_xlat4) * _RightEyeUVOffset.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaParam;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.w = u_xlat0.w * _AlphaParam;
    SV_Target0 = u_xlat0;
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
  Name "FLIP_RGBA_TO_RGBA"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 288062
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaParam;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.w = u_xlat0.w * _AlphaParam;
    SV_Target0 = u_xlat0;
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
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaParam;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.w = u_xlat0.w * _AlphaParam;
    SV_Target0 = u_xlat0;
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
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaParam;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.w = u_xlat0.w * _AlphaParam;
    SV_Target0 = u_xlat0;
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
  Name "FLIP_RGBASPLIT_TO_RGBA"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 375129
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0);
    u_xlat0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat0.w = texture(_MainTex, u_xlat1.xy).y;
    SV_Target0 = u_xlat0;
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
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0);
    u_xlat0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat0.w = texture(_MainTex, u_xlat1.xy).y;
    SV_Target0 = u_xlat0;
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
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0);
    u_xlat0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat0.w = texture(_MainTex, u_xlat1.xy).y;
    SV_Target0 = u_xlat0;
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
  Name "FLIP_SEMIPLANARYCBCR_TO_RGB1"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 440144
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
lowp float u_xlat10_3;
int u_xlati3;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
bool u_xlatb6;
int u_xlati9;
bool u_xlatb9;
void main()
{
    u_xlat0 = _MainTex_TexelSize.z + -0.5;
    u_xlat3 = vs_TEXCOORD0.x * u_xlat0 + 0.5;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat3 = floor(u_xlat3);
    u_xlat6 = u_xlat3 * 0.5;
    u_xlati3 = int(u_xlat3);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat6>=(-u_xlat6));
#else
    u_xlatb9 = u_xlat6>=(-u_xlat6);
#endif
    u_xlat6 = fract(abs(u_xlat6));
    u_xlat6 = (u_xlatb9) ? u_xlat6 : (-u_xlat6);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6==0.0);
#else
    u_xlatb6 = u_xlat6==0.0;
#endif
    u_xlati9 = u_xlati3 + -1;
    u_xlati3 = (u_xlatb6) ? u_xlati3 : u_xlati9;
    u_xlati6 = u_xlati3 + 1;
    u_xlat3 = float(u_xlati3);
    u_xlat1.x = u_xlat0 * u_xlat3;
    u_xlat3 = float(u_xlati6);
    u_xlat1.z = u_xlat0 * u_xlat3;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat10_0 = texture(_SecondTex, u_xlat1.zw).w;
    u_xlat10_3 = texture(_SecondTex, u_xlat1.xy).w;
    u_xlat16_2.xy = vec2(u_xlat10_3) * vec2(0.390625, 1.984375);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_2.x = u_xlat10_3 * 1.15625 + (-u_xlat16_2.x);
    u_xlat16_5 = u_xlat10_3 * 1.15625 + u_xlat16_2.y;
    SV_Target0.z = u_xlat16_5 + -1.06861997;
    u_xlat16_2.x = (-u_xlat10_0) * 0.8125 + u_xlat16_2.x;
    u_xlat16_5 = u_xlat10_0 * 1.59375;
    u_xlat16_2.y = u_xlat10_3 * 1.15625 + u_xlat16_5;
    SV_Target0.xy = u_xlat16_2.yx + vec2(-0.872539997, 0.531369984);
    SV_Target0.w = 1.0;
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
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
lowp float u_xlat10_3;
int u_xlati3;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
bool u_xlatb6;
int u_xlati9;
bool u_xlatb9;
void main()
{
    u_xlat0 = _MainTex_TexelSize.z + -0.5;
    u_xlat3 = vs_TEXCOORD0.x * u_xlat0 + 0.5;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat3 = floor(u_xlat3);
    u_xlat6 = u_xlat3 * 0.5;
    u_xlati3 = int(u_xlat3);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat6>=(-u_xlat6));
#else
    u_xlatb9 = u_xlat6>=(-u_xlat6);
#endif
    u_xlat6 = fract(abs(u_xlat6));
    u_xlat6 = (u_xlatb9) ? u_xlat6 : (-u_xlat6);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6==0.0);
#else
    u_xlatb6 = u_xlat6==0.0;
#endif
    u_xlati9 = u_xlati3 + -1;
    u_xlati3 = (u_xlatb6) ? u_xlati3 : u_xlati9;
    u_xlati6 = u_xlati3 + 1;
    u_xlat3 = float(u_xlati3);
    u_xlat1.x = u_xlat0 * u_xlat3;
    u_xlat3 = float(u_xlati6);
    u_xlat1.z = u_xlat0 * u_xlat3;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat10_0 = texture(_SecondTex, u_xlat1.zw).w;
    u_xlat10_3 = texture(_SecondTex, u_xlat1.xy).w;
    u_xlat16_2.xy = vec2(u_xlat10_3) * vec2(0.390625, 1.984375);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_2.x = u_xlat10_3 * 1.15625 + (-u_xlat16_2.x);
    u_xlat16_5 = u_xlat10_3 * 1.15625 + u_xlat16_2.y;
    SV_Target0.z = u_xlat16_5 + -1.06861997;
    u_xlat16_2.x = (-u_xlat10_0) * 0.8125 + u_xlat16_2.x;
    u_xlat16_5 = u_xlat10_0 * 1.59375;
    u_xlat16_2.y = u_xlat10_3 * 1.15625 + u_xlat16_5;
    SV_Target0.xy = u_xlat16_2.yx + vec2(-0.872539997, 0.531369984);
    SV_Target0.w = 1.0;
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
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
lowp float u_xlat10_3;
int u_xlati3;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
bool u_xlatb6;
int u_xlati9;
bool u_xlatb9;
void main()
{
    u_xlat0 = _MainTex_TexelSize.z + -0.5;
    u_xlat3 = vs_TEXCOORD0.x * u_xlat0 + 0.5;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat3 = floor(u_xlat3);
    u_xlat6 = u_xlat3 * 0.5;
    u_xlati3 = int(u_xlat3);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat6>=(-u_xlat6));
#else
    u_xlatb9 = u_xlat6>=(-u_xlat6);
#endif
    u_xlat6 = fract(abs(u_xlat6));
    u_xlat6 = (u_xlatb9) ? u_xlat6 : (-u_xlat6);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6==0.0);
#else
    u_xlatb6 = u_xlat6==0.0;
#endif
    u_xlati9 = u_xlati3 + -1;
    u_xlati3 = (u_xlatb6) ? u_xlati3 : u_xlati9;
    u_xlati6 = u_xlati3 + 1;
    u_xlat3 = float(u_xlati3);
    u_xlat1.x = u_xlat0 * u_xlat3;
    u_xlat3 = float(u_xlati6);
    u_xlat1.z = u_xlat0 * u_xlat3;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat10_0 = texture(_SecondTex, u_xlat1.zw).w;
    u_xlat10_3 = texture(_SecondTex, u_xlat1.xy).w;
    u_xlat16_2.xy = vec2(u_xlat10_3) * vec2(0.390625, 1.984375);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_2.x = u_xlat10_3 * 1.15625 + (-u_xlat16_2.x);
    u_xlat16_5 = u_xlat10_3 * 1.15625 + u_xlat16_2.y;
    SV_Target0.z = u_xlat16_5 + -1.06861997;
    u_xlat16_2.x = (-u_xlat10_0) * 0.8125 + u_xlat16_2.x;
    u_xlat16_5 = u_xlat10_0 * 1.59375;
    u_xlat16_2.y = u_xlat10_3 * 1.15625 + u_xlat16_5;
    SV_Target0.xy = u_xlat16_2.yx + vec2(-0.872539997, 0.531369984);
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
}
}
 Pass {
  Name "FLIP_SEMIPLANARYCBCRA_TO_RGBA"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 487501
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
int u_xlati3;
mediump float u_xlat16_5;
lowp float u_xlat10_6;
float u_xlat9;
int u_xlati9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.z + -0.5;
    u_xlat3.xyz = vs_TEXCOORD0.xxy * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = u_xlat3.x * u_xlat0.x + 0.5;
    u_xlat0.x = 2.0 / u_xlat0.x;
    u_xlat10_6 = texture(_MainTex, u_xlat3.yz).w;
    u_xlat3.x = floor(u_xlat3.x);
    u_xlat9 = u_xlat3.x * 0.5;
    u_xlati3 = int(u_xlat3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb1 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat9 = fract(abs(u_xlat9));
    u_xlat9 = (u_xlatb1) ? u_xlat9 : (-u_xlat9);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9==0.0);
#else
    u_xlatb9 = u_xlat9==0.0;
#endif
    u_xlati1 = u_xlati3 + -1;
    u_xlati3 = (u_xlatb9) ? u_xlati3 : u_xlati1;
    u_xlati9 = u_xlati3 + 1;
    u_xlat3.x = float(u_xlati3);
    u_xlat1.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = float(u_xlati9);
    u_xlat1.z = u_xlat0.x * u_xlat3.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat10_0 = texture(_SecondTex, u_xlat1.zw).w;
    u_xlat10_3 = texture(_SecondTex, u_xlat1.xy).w;
    u_xlat16_2.xy = vec2(u_xlat10_3) * vec2(0.390625, 1.984375);
    u_xlat16_2.x = u_xlat10_6 * 1.15625 + (-u_xlat16_2.x);
    u_xlat16_5 = u_xlat10_6 * 1.15625 + u_xlat16_2.y;
    SV_Target0.z = u_xlat16_5 + -1.06861997;
    u_xlat16_2.x = (-u_xlat10_0) * 0.8125 + u_xlat16_2.x;
    u_xlat16_5 = u_xlat10_0 * 1.59375;
    u_xlat16_2.y = u_xlat10_6 * 1.15625 + u_xlat16_5;
    SV_Target0.xy = u_xlat16_2.yx + vec2(-0.872539997, 0.531369984);
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_2.x = u_xlat10_0 + -0.0627449974;
    SV_Target0.w = u_xlat16_2.x * 1.15625;
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
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
int u_xlati3;
mediump float u_xlat16_5;
lowp float u_xlat10_6;
float u_xlat9;
int u_xlati9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.z + -0.5;
    u_xlat3.xyz = vs_TEXCOORD0.xxy * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = u_xlat3.x * u_xlat0.x + 0.5;
    u_xlat0.x = 2.0 / u_xlat0.x;
    u_xlat10_6 = texture(_MainTex, u_xlat3.yz).w;
    u_xlat3.x = floor(u_xlat3.x);
    u_xlat9 = u_xlat3.x * 0.5;
    u_xlati3 = int(u_xlat3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb1 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat9 = fract(abs(u_xlat9));
    u_xlat9 = (u_xlatb1) ? u_xlat9 : (-u_xlat9);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9==0.0);
#else
    u_xlatb9 = u_xlat9==0.0;
#endif
    u_xlati1 = u_xlati3 + -1;
    u_xlati3 = (u_xlatb9) ? u_xlati3 : u_xlati1;
    u_xlati9 = u_xlati3 + 1;
    u_xlat3.x = float(u_xlati3);
    u_xlat1.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = float(u_xlati9);
    u_xlat1.z = u_xlat0.x * u_xlat3.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat10_0 = texture(_SecondTex, u_xlat1.zw).w;
    u_xlat10_3 = texture(_SecondTex, u_xlat1.xy).w;
    u_xlat16_2.xy = vec2(u_xlat10_3) * vec2(0.390625, 1.984375);
    u_xlat16_2.x = u_xlat10_6 * 1.15625 + (-u_xlat16_2.x);
    u_xlat16_5 = u_xlat10_6 * 1.15625 + u_xlat16_2.y;
    SV_Target0.z = u_xlat16_5 + -1.06861997;
    u_xlat16_2.x = (-u_xlat10_0) * 0.8125 + u_xlat16_2.x;
    u_xlat16_5 = u_xlat10_0 * 1.59375;
    u_xlat16_2.y = u_xlat10_6 * 1.15625 + u_xlat16_5;
    SV_Target0.xy = u_xlat16_2.yx + vec2(-0.872539997, 0.531369984);
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_2.x = u_xlat10_0 + -0.0627449974;
    SV_Target0.w = u_xlat16_2.x * 1.15625;
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
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
int u_xlati3;
mediump float u_xlat16_5;
lowp float u_xlat10_6;
float u_xlat9;
int u_xlati9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.z + -0.5;
    u_xlat3.xyz = vs_TEXCOORD0.xxy * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = u_xlat3.x * u_xlat0.x + 0.5;
    u_xlat0.x = 2.0 / u_xlat0.x;
    u_xlat10_6 = texture(_MainTex, u_xlat3.yz).w;
    u_xlat3.x = floor(u_xlat3.x);
    u_xlat9 = u_xlat3.x * 0.5;
    u_xlati3 = int(u_xlat3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb1 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat9 = fract(abs(u_xlat9));
    u_xlat9 = (u_xlatb1) ? u_xlat9 : (-u_xlat9);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9==0.0);
#else
    u_xlatb9 = u_xlat9==0.0;
#endif
    u_xlati1 = u_xlati3 + -1;
    u_xlati3 = (u_xlatb9) ? u_xlati3 : u_xlati1;
    u_xlati9 = u_xlati3 + 1;
    u_xlat3.x = float(u_xlati3);
    u_xlat1.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = float(u_xlati9);
    u_xlat1.z = u_xlat0.x * u_xlat3.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat10_0 = texture(_SecondTex, u_xlat1.zw).w;
    u_xlat10_3 = texture(_SecondTex, u_xlat1.xy).w;
    u_xlat16_2.xy = vec2(u_xlat10_3) * vec2(0.390625, 1.984375);
    u_xlat16_2.x = u_xlat10_6 * 1.15625 + (-u_xlat16_2.x);
    u_xlat16_5 = u_xlat10_6 * 1.15625 + u_xlat16_2.y;
    SV_Target0.z = u_xlat16_5 + -1.06861997;
    u_xlat16_2.x = (-u_xlat10_0) * 0.8125 + u_xlat16_2.x;
    u_xlat16_5 = u_xlat10_0 * 1.59375;
    u_xlat16_2.y = u_xlat10_6 * 1.15625 + u_xlat16_5;
    SV_Target0.xy = u_xlat16_2.yx + vec2(-0.872539997, 0.531369984);
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_2.x = u_xlat10_0 + -0.0627449974;
    SV_Target0.w = u_xlat16_2.x * 1.15625;
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
  Name "FLIP_NV12_TO_RGB1"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 586429
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
lowp float u_xlat10_1;
lowp vec2 u_xlat10_2;
void main()
{
    u_xlat0.w = 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat1.x = u_xlat10_1 + -0.0625;
    u_xlat10_2.xy = texture(_SecondTex, vs_TEXCOORD0.xy).xy;
    u_xlat1.yz = u_xlat10_2.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(vec2(1.16439998, 1.79270005), u_xlat1.xz);
    u_xlat0.y = dot(vec3(1.16439998, -0.213300005, -0.532899976), u_xlat1.xyz);
    u_xlat0.z = dot(vec2(1.16439998, 2.11240005), u_xlat1.xy);
    SV_Target0 = u_xlat0;
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
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
lowp float u_xlat10_1;
lowp vec2 u_xlat10_2;
void main()
{
    u_xlat0.w = 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat1.x = u_xlat10_1 + -0.0625;
    u_xlat10_2.xy = texture(_SecondTex, vs_TEXCOORD0.xy).xy;
    u_xlat1.yz = u_xlat10_2.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(vec2(1.16439998, 1.79270005), u_xlat1.xz);
    u_xlat0.y = dot(vec3(1.16439998, -0.213300005, -0.532899976), u_xlat1.xyz);
    u_xlat0.z = dot(vec2(1.16439998, 2.11240005), u_xlat1.xy);
    SV_Target0 = u_xlat0;
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
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
lowp float u_xlat10_1;
lowp vec2 u_xlat10_2;
void main()
{
    u_xlat0.w = 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat1.x = u_xlat10_1 + -0.0625;
    u_xlat10_2.xy = texture(_SecondTex, vs_TEXCOORD0.xy).xy;
    u_xlat1.yz = u_xlat10_2.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(vec2(1.16439998, 1.79270005), u_xlat1.xz);
    u_xlat0.y = dot(vec3(1.16439998, -0.213300005, -0.532899976), u_xlat1.xyz);
    u_xlat0.z = dot(vec2(1.16439998, 2.11240005), u_xlat1.xy);
    SV_Target0 = u_xlat0;
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
  Name "FLIP_NV12_TO_RGBA"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 632801
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_3;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat10_0.x = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_1.x = u_xlat10_0.x + -0.0627449974;
    SV_Target0.w = u_xlat16_1.x * 1.15625;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0);
    u_xlat10_4 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat10_0.xy = texture(_SecondTex, u_xlat0.xy).xy;
    u_xlat16_1.xyz = u_xlat10_0.yxx * vec3(1.59375, 0.390625, 1.984375);
    u_xlat16_3 = u_xlat10_4 * 1.15625 + (-u_xlat16_1.y);
    u_xlat16_1.xz = vec2(u_xlat10_4) * vec2(1.15625, 1.15625) + u_xlat16_1.xz;
    SV_Target0.xz = u_xlat16_1.xz + vec2(-0.872539997, -1.06861997);
    u_xlat16_1.x = (-u_xlat10_0.y) * 0.8125 + u_xlat16_3;
    SV_Target0.y = u_xlat16_1.x + 0.531369984;
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
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_3;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat10_0.x = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_1.x = u_xlat10_0.x + -0.0627449974;
    SV_Target0.w = u_xlat16_1.x * 1.15625;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0);
    u_xlat10_4 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat10_0.xy = texture(_SecondTex, u_xlat0.xy).xy;
    u_xlat16_1.xyz = u_xlat10_0.yxx * vec3(1.59375, 0.390625, 1.984375);
    u_xlat16_3 = u_xlat10_4 * 1.15625 + (-u_xlat16_1.y);
    u_xlat16_1.xz = vec2(u_xlat10_4) * vec2(1.15625, 1.15625) + u_xlat16_1.xz;
    SV_Target0.xz = u_xlat16_1.xz + vec2(-0.872539997, -1.06861997);
    u_xlat16_1.x = (-u_xlat10_0.y) * 0.8125 + u_xlat16_3;
    SV_Target0.y = u_xlat16_1.x + 0.531369984;
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
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecondTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_3;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0) + vec2(0.5, 0.0);
    u_xlat10_0.x = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_1.x = u_xlat10_0.x + -0.0627449974;
    SV_Target0.w = u_xlat16_1.x * 1.15625;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 1.0);
    u_xlat10_4 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat10_0.xy = texture(_SecondTex, u_xlat0.xy).xy;
    u_xlat16_1.xyz = u_xlat10_0.yxx * vec3(1.59375, 0.390625, 1.984375);
    u_xlat16_3 = u_xlat10_4 * 1.15625 + (-u_xlat16_1.y);
    u_xlat16_1.xz = vec2(u_xlat10_4) * vec2(1.15625, 1.15625) + u_xlat16_1.xz;
    SV_Target0.xz = u_xlat16_1.xz + vec2(-0.872539997, -1.06861997);
    u_xlat16_1.x = (-u_xlat10_0.y) * 0.8125 + u_xlat16_3;
    SV_Target0.y = u_xlat16_1.x + 0.531369984;
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