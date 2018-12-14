Shader "Niantic/PowerBar" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_TintColor ("Tint Color", Color) = (1,0.7,0.5,1)
_PulseColor ("Pulse Color", Color) = (1,0.9,0.7,1)
_WidthColor ("Width Color", Color) = (1,1,1,1)
_BackGroundColor ("Background Color", Color) = (0.2,0.2,0.2,0.4)
_Width ("Width", Range(0, 1)) = 0.1
_Ratio ("BarRatio", Range(0, 1)) = 0.2
_Progress ("Progress", Range(0, 1)) = 0.5
_Tilt ("Tilt", Range(0, 0.3)) = 0.1
_Gap ("Gap", Range(0, 0.2)) = 0.1
_BarCount ("BarCount", Range(1, 3)) = 3
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 966
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Width;
uniform 	float _Ratio;
uniform 	float _Progress;
uniform 	float _Tilt;
uniform 	float _Gap;
uniform 	int _BarCount;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _PulseColor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat3;
float u_xlat6;
bool u_xlatb6;
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
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.w = 0.0;
    u_xlat0.x = (-_Tilt) + 1.0;
    vs_TEXCOORD0.x = in_TEXCOORD0.x / u_xlat0.x;
    u_xlat0.z = _Ratio / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_PulseColor.w>=0.5);
#else
    u_xlatb6 = _PulseColor.w>=0.5;
#endif
    u_xlat0.x = float(_BarCount);
    u_xlat1.xy = u_xlat0.zx * vec2(_Width, _Progress);
    u_xlat3 = floor(u_xlat1.y);
    u_xlat6 = u_xlatb6 ? u_xlat3 : float(0.0);
    vs_TEXCOORD0.z = u_xlat6 / u_xlat0.x;
    u_xlat6 = u_xlat0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6>=1.0);
#else
    u_xlatb6 = u_xlat6>=1.0;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat0.y = u_xlat6 * _Gap;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD1.w = u_xlat1.x * u_xlat0.x + u_xlat0.y;
    u_xlat0.x = _Time.y * 5.0;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat1 = (-_PulseColor) + vec4(1.0, 1.0, 1.0, 1.0);
    vs_TEXCOORD2 = u_xlat0.xxxx * u_xlat1 + _PulseColor;
    vs_COLOR0 = in_COLOR0 * _TintColor;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Width;
uniform 	float _Progress;
uniform 	float _Tilt;
uniform 	mediump vec4 _WidthColor;
uniform 	mediump vec4 _BackGroundColor;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bvec2 u_xlatb3;
bool u_xlatb5;
mediump float u_xlat16_8;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.y = vs_TEXCOORD0.y + -0.5;
    u_xlat1.x = (-_Tilt) * vs_TEXCOORD0.y + vs_TEXCOORD0.x;
    u_xlat16_8 = u_xlat1.x * vs_TEXCOORD1.x;
    u_xlat16_8 = trunc(u_xlat16_8);
    u_xlat16_12 = vs_TEXCOORD1.x * u_xlat1.x + (-u_xlat16_8);
    u_xlat16_0.x = u_xlat16_12 + -0.5;
    u_xlat16_0.xy = -abs(u_xlat16_0.xy) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(vs_TEXCOORD1.w>=u_xlat16_0.x);
#else
    u_xlatb2.x = vs_TEXCOORD1.w>=u_xlat16_0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.y = !!(_Width>=u_xlat16_0.y);
#else
    u_xlatb2.y = _Width>=u_xlat16_0.y;
#endif
    u_xlat16_0.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_0.y = (u_xlatb2.y) ? float(1.0) : float(0.0);
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_2 = _WidthColor + (-_BackGroundColor);
    u_xlat16_2 = u_xlat16_0.xxxx * u_xlat16_2 + _BackGroundColor;
    u_xlat16_3 = (-u_xlat16_2) + vs_COLOR0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Progress>=u_xlat1.x);
#else
    u_xlatb5 = _Progress>=u_xlat1.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vs_TEXCOORD0.z>=u_xlat1.x);
#else
    u_xlatb1 = vs_TEXCOORD0.z>=u_xlat1.x;
#endif
    u_xlat16_0.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat1.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat1 = u_xlat1.xxxx * u_xlat16_3 + u_xlat16_2;
    u_xlat3.xyz = (-u_xlat1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat16_0.xxx * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat16_0.x = (-vs_TEXCOORD1.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat16_12>=u_xlat16_0.x);
#else
    u_xlatb3.x = u_xlat16_12>=u_xlat16_0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.y = !!(vs_TEXCOORD1.y>=u_xlat16_12);
#else
    u_xlatb3.y = vs_TEXCOORD1.y>=u_xlat16_12;
#endif
    u_xlat16_0.x = (u_xlatb3.y) ? float(1.0) : float(0.0);
    u_xlat16_0.y = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_1 = u_xlat16_0.xxxx * (-u_xlat1) + u_xlat1;
    u_xlat16_0.x = vs_TEXCOORD1.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat16_0.x>=u_xlat16_8);
#else
    u_xlatb3.x = u_xlat16_0.x>=u_xlat16_8;
#endif
    u_xlat16_0.x = (u_xlatb3.x) ? 1.0 : 0.0;
    SV_Target0 = u_xlat16_0.xxxx * u_xlat16_1;
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
uniform 	float _Width;
uniform 	float _Ratio;
uniform 	float _Progress;
uniform 	float _Tilt;
uniform 	float _Gap;
uniform 	int _BarCount;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _PulseColor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat3;
float u_xlat6;
bool u_xlatb6;
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
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.w = 0.0;
    u_xlat0.x = (-_Tilt) + 1.0;
    vs_TEXCOORD0.x = in_TEXCOORD0.x / u_xlat0.x;
    u_xlat0.z = _Ratio / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_PulseColor.w>=0.5);
#else
    u_xlatb6 = _PulseColor.w>=0.5;
#endif
    u_xlat0.x = float(_BarCount);
    u_xlat1.xy = u_xlat0.zx * vec2(_Width, _Progress);
    u_xlat3 = floor(u_xlat1.y);
    u_xlat6 = u_xlatb6 ? u_xlat3 : float(0.0);
    vs_TEXCOORD0.z = u_xlat6 / u_xlat0.x;
    u_xlat6 = u_xlat0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6>=1.0);
#else
    u_xlatb6 = u_xlat6>=1.0;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat0.y = u_xlat6 * _Gap;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD1.w = u_xlat1.x * u_xlat0.x + u_xlat0.y;
    u_xlat0.x = _Time.y * 5.0;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat1 = (-_PulseColor) + vec4(1.0, 1.0, 1.0, 1.0);
    vs_TEXCOORD2 = u_xlat0.xxxx * u_xlat1 + _PulseColor;
    vs_COLOR0 = in_COLOR0 * _TintColor;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Width;
uniform 	float _Progress;
uniform 	float _Tilt;
uniform 	mediump vec4 _WidthColor;
uniform 	mediump vec4 _BackGroundColor;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bvec2 u_xlatb3;
bool u_xlatb5;
mediump float u_xlat16_8;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.y = vs_TEXCOORD0.y + -0.5;
    u_xlat1.x = (-_Tilt) * vs_TEXCOORD0.y + vs_TEXCOORD0.x;
    u_xlat16_8 = u_xlat1.x * vs_TEXCOORD1.x;
    u_xlat16_8 = trunc(u_xlat16_8);
    u_xlat16_12 = vs_TEXCOORD1.x * u_xlat1.x + (-u_xlat16_8);
    u_xlat16_0.x = u_xlat16_12 + -0.5;
    u_xlat16_0.xy = -abs(u_xlat16_0.xy) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(vs_TEXCOORD1.w>=u_xlat16_0.x);
#else
    u_xlatb2.x = vs_TEXCOORD1.w>=u_xlat16_0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.y = !!(_Width>=u_xlat16_0.y);
#else
    u_xlatb2.y = _Width>=u_xlat16_0.y;
#endif
    u_xlat16_0.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_0.y = (u_xlatb2.y) ? float(1.0) : float(0.0);
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_2 = _WidthColor + (-_BackGroundColor);
    u_xlat16_2 = u_xlat16_0.xxxx * u_xlat16_2 + _BackGroundColor;
    u_xlat16_3 = (-u_xlat16_2) + vs_COLOR0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Progress>=u_xlat1.x);
#else
    u_xlatb5 = _Progress>=u_xlat1.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vs_TEXCOORD0.z>=u_xlat1.x);
#else
    u_xlatb1 = vs_TEXCOORD0.z>=u_xlat1.x;
#endif
    u_xlat16_0.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat1.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat1 = u_xlat1.xxxx * u_xlat16_3 + u_xlat16_2;
    u_xlat3.xyz = (-u_xlat1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat16_0.xxx * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat16_0.x = (-vs_TEXCOORD1.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat16_12>=u_xlat16_0.x);
#else
    u_xlatb3.x = u_xlat16_12>=u_xlat16_0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.y = !!(vs_TEXCOORD1.y>=u_xlat16_12);
#else
    u_xlatb3.y = vs_TEXCOORD1.y>=u_xlat16_12;
#endif
    u_xlat16_0.x = (u_xlatb3.y) ? float(1.0) : float(0.0);
    u_xlat16_0.y = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_1 = u_xlat16_0.xxxx * (-u_xlat1) + u_xlat1;
    u_xlat16_0.x = vs_TEXCOORD1.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat16_0.x>=u_xlat16_8);
#else
    u_xlatb3.x = u_xlat16_0.x>=u_xlat16_8;
#endif
    u_xlat16_0.x = (u_xlatb3.x) ? 1.0 : 0.0;
    SV_Target0 = u_xlat16_0.xxxx * u_xlat16_1;
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
uniform 	float _Width;
uniform 	float _Ratio;
uniform 	float _Progress;
uniform 	float _Tilt;
uniform 	float _Gap;
uniform 	int _BarCount;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _PulseColor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat3;
float u_xlat6;
bool u_xlatb6;
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
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.w = 0.0;
    u_xlat0.x = (-_Tilt) + 1.0;
    vs_TEXCOORD0.x = in_TEXCOORD0.x / u_xlat0.x;
    u_xlat0.z = _Ratio / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_PulseColor.w>=0.5);
#else
    u_xlatb6 = _PulseColor.w>=0.5;
#endif
    u_xlat0.x = float(_BarCount);
    u_xlat1.xy = u_xlat0.zx * vec2(_Width, _Progress);
    u_xlat3 = floor(u_xlat1.y);
    u_xlat6 = u_xlatb6 ? u_xlat3 : float(0.0);
    vs_TEXCOORD0.z = u_xlat6 / u_xlat0.x;
    u_xlat6 = u_xlat0.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6>=1.0);
#else
    u_xlatb6 = u_xlat6>=1.0;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat0.y = u_xlat6 * _Gap;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD1.w = u_xlat1.x * u_xlat0.x + u_xlat0.y;
    u_xlat0.x = _Time.y * 5.0;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat1 = (-_PulseColor) + vec4(1.0, 1.0, 1.0, 1.0);
    vs_TEXCOORD2 = u_xlat0.xxxx * u_xlat1 + _PulseColor;
    vs_COLOR0 = in_COLOR0 * _TintColor;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Width;
uniform 	float _Progress;
uniform 	float _Tilt;
uniform 	mediump vec4 _WidthColor;
uniform 	mediump vec4 _BackGroundColor;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bvec2 u_xlatb3;
bool u_xlatb5;
mediump float u_xlat16_8;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.y = vs_TEXCOORD0.y + -0.5;
    u_xlat1.x = (-_Tilt) * vs_TEXCOORD0.y + vs_TEXCOORD0.x;
    u_xlat16_8 = u_xlat1.x * vs_TEXCOORD1.x;
    u_xlat16_8 = trunc(u_xlat16_8);
    u_xlat16_12 = vs_TEXCOORD1.x * u_xlat1.x + (-u_xlat16_8);
    u_xlat16_0.x = u_xlat16_12 + -0.5;
    u_xlat16_0.xy = -abs(u_xlat16_0.xy) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(vs_TEXCOORD1.w>=u_xlat16_0.x);
#else
    u_xlatb2.x = vs_TEXCOORD1.w>=u_xlat16_0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.y = !!(_Width>=u_xlat16_0.y);
#else
    u_xlatb2.y = _Width>=u_xlat16_0.y;
#endif
    u_xlat16_0.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_0.y = (u_xlatb2.y) ? float(1.0) : float(0.0);
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_2 = _WidthColor + (-_BackGroundColor);
    u_xlat16_2 = u_xlat16_0.xxxx * u_xlat16_2 + _BackGroundColor;
    u_xlat16_3 = (-u_xlat16_2) + vs_COLOR0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Progress>=u_xlat1.x);
#else
    u_xlatb5 = _Progress>=u_xlat1.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vs_TEXCOORD0.z>=u_xlat1.x);
#else
    u_xlatb1 = vs_TEXCOORD0.z>=u_xlat1.x;
#endif
    u_xlat16_0.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat1.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat1 = u_xlat1.xxxx * u_xlat16_3 + u_xlat16_2;
    u_xlat3.xyz = (-u_xlat1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat16_0.xxx * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat16_0.x = (-vs_TEXCOORD1.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat16_12>=u_xlat16_0.x);
#else
    u_xlatb3.x = u_xlat16_12>=u_xlat16_0.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.y = !!(vs_TEXCOORD1.y>=u_xlat16_12);
#else
    u_xlatb3.y = vs_TEXCOORD1.y>=u_xlat16_12;
#endif
    u_xlat16_0.x = (u_xlatb3.y) ? float(1.0) : float(0.0);
    u_xlat16_0.y = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_1 = u_xlat16_0.xxxx * (-u_xlat1) + u_xlat1;
    u_xlat16_0.x = vs_TEXCOORD1.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat16_0.x>=u_xlat16_8);
#else
    u_xlatb3.x = u_xlat16_0.x>=u_xlat16_8;
#endif
    u_xlat16_0.x = (u_xlatb3.x) ? 1.0 : 0.0;
    SV_Target0 = u_xlat16_0.xxxx * u_xlat16_1;
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