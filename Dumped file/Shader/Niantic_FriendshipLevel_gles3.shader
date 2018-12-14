Shader "Niantic/FriendshipLevel" {
Properties {
_Antialias ("Antialias Strength", Float) = 0.04
_NumHearts ("Number of Hearts", Float) = 4
_CircleSize ("Circle Size", Range(0, 1)) = 0.8
_Progress ("Progress", Range(0, 1)) = 0.5
_HeartbeatIntensity ("Heartbeat Intensity", Float) = 0.005
_HeartbeatSpeed ("Heartbeat Speed", Float) = 3
_BackgroundColor ("Background Color", Color) = (1,1,1,0)
_CircleFullColor ("Circle Full Color", Color) = (1,0.65,0.66,1)
_CircleProgressColor ("Circle Progress Color", Color) = (0.97,0.4,0.98,1)
_CircleNoProgressColor ("Circle No Progress Color", Color) = (0.5,0.5,0.5,1)
_HeartFullColor ("Heart Full Color", Color) = (1,1,1,1)
_HeartUnfullColor ("Heart Unfull Color", Color) = (0.82,0.82,0.82,1)
_MainTex ("Texture", 2D) = "white" { }
_TextureHeight ("Texture Height", Float) = 0
_Stencil ("Stencil ID", Float) = 0
_StencilComp ("Stencil Comparison", Float) = 8
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 5337
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat0);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumHearts;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _HeartFullColor;
uniform 	vec4 _HeartUnfullColor;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumHearts);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati16 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati16 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = max((-u_xlati5), u_xlati5);
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = vec4(u_xlat2.z * u_xlat2.z, u_xlat2.w * u_xlat2.w, u_xlat2.z * u_xlat2.z, u_xlat2.w * u_xlat2.w);
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.xw = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xw));
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _HeartFullColor + (-_HeartUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _HeartUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat0);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumHearts;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _HeartFullColor;
uniform 	vec4 _HeartUnfullColor;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumHearts);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati16 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati16 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = max((-u_xlati5), u_xlati5);
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = vec4(u_xlat2.z * u_xlat2.z, u_xlat2.w * u_xlat2.w, u_xlat2.z * u_xlat2.z, u_xlat2.w * u_xlat2.w);
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.xw = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xw));
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _HeartFullColor + (-_HeartUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _HeartUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat0);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumHearts;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _HeartFullColor;
uniform 	vec4 _HeartUnfullColor;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumHearts);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati16 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati16 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = max((-u_xlati5), u_xlati5);
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = vec4(u_xlat2.z * u_xlat2.z, u_xlat2.w * u_xlat2.w, u_xlat2.z * u_xlat2.z, u_xlat2.w * u_xlat2.w);
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.xw = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xw));
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _HeartFullColor + (-_HeartUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _HeartUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
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
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat0);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumHearts;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _HeartFullColor;
uniform 	vec4 _HeartUnfullColor;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumHearts);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati16 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati16 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = max((-u_xlati5), u_xlati5);
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = vec4(u_xlat2.z * u_xlat2.z, u_xlat2.w * u_xlat2.w, u_xlat2.z * u_xlat2.z, u_xlat2.w * u_xlat2.w);
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.xw = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xw));
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _HeartFullColor + (-_HeartUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _HeartUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
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
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat0);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumHearts;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _HeartFullColor;
uniform 	vec4 _HeartUnfullColor;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumHearts);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati16 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati16 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = max((-u_xlati5), u_xlati5);
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = vec4(u_xlat2.z * u_xlat2.z, u_xlat2.w * u_xlat2.w, u_xlat2.z * u_xlat2.z, u_xlat2.w * u_xlat2.w);
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.xw = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xw));
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _HeartFullColor + (-_HeartUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _HeartUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
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
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat0);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumHearts;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _HeartFullColor;
uniform 	vec4 _HeartUnfullColor;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumHearts);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati16 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati16 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = max((-u_xlati5), u_xlati5);
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = vec4(u_xlat2.z * u_xlat2.z, u_xlat2.w * u_xlat2.w, u_xlat2.z * u_xlat2.z, u_xlat2.w * u_xlat2.w);
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.xw = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xw));
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _HeartFullColor + (-_HeartUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _HeartUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
}
}
}
}