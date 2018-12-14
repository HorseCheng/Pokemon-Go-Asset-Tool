Shader "Niantic/Progressbar" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Ratio ("Element Ratio", Float) = 0.1
_Progress ("Progress", Range(0, 1)) = 0.5
_ProgressSteps ("Progress Steps", Float) = 8
_GapWidth ("Gap Width", Float) = 0.05
_ProgressColor ("Progress Color", Color) = (0.2,0.83,0.2,1)
_BackgroundColor ("Background Color", Color) = (1,1,1,1)
_GapColor ("Gap Color", Color) = (0.7,0.7,0.7,1)
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "DEFAULT"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 54618
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Ratio;
uniform 	float _Progress;
uniform 	float _ProgressSteps;
uniform 	float _GapWidth;
uniform 	mediump vec4 _ProgressColor;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _GapColor;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
float u_xlat5;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x * _ProgressSteps;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat0.x = -abs(u_xlat0.x) + 0.5;
    u_xlat2.x = _ProgressSteps * _GapWidth;
    u_xlat0.x = (-u_xlat2.x) * 0.100000001 + u_xlat0.x;
    u_xlat2.x = u_xlat2.x * 0.100000001;
    u_xlat2.x = float(1.0) / (-u_xlat2.x);
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD0.x>=_Progress);
#else
    u_xlatb2 = vs_TEXCOORD0.x>=_Progress;
#endif
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_ProgressColor.xyz) + _BackgroundColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _ProgressColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _GapColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = -abs(u_xlat1.x) + 0.5;
    u_xlat3 = u_xlat1.y * u_xlat1.y;
    u_xlat5 = _Ratio * 0.5 + (-u_xlat1.x);
    u_xlat5 = u_xlat5 / _Ratio;
    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.25>=u_xlat3);
#else
    u_xlatb3 = 0.25>=u_xlat3;
#endif
    u_xlat5 = _Ratio * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat5>=u_xlat1.x);
#else
    u_xlatb1 = u_xlat5>=u_xlat1.x;
#endif
    u_xlat1.x = (u_xlatb1) ? 0.0 : 1.0;
    u_xlat0.w = (u_xlatb3) ? 1.0 : u_xlat1.x;
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Ratio;
uniform 	float _Progress;
uniform 	float _ProgressSteps;
uniform 	float _GapWidth;
uniform 	mediump vec4 _ProgressColor;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _GapColor;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
float u_xlat5;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x * _ProgressSteps;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat0.x = -abs(u_xlat0.x) + 0.5;
    u_xlat2.x = _ProgressSteps * _GapWidth;
    u_xlat0.x = (-u_xlat2.x) * 0.100000001 + u_xlat0.x;
    u_xlat2.x = u_xlat2.x * 0.100000001;
    u_xlat2.x = float(1.0) / (-u_xlat2.x);
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD0.x>=_Progress);
#else
    u_xlatb2 = vs_TEXCOORD0.x>=_Progress;
#endif
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_ProgressColor.xyz) + _BackgroundColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _ProgressColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _GapColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = -abs(u_xlat1.x) + 0.5;
    u_xlat3 = u_xlat1.y * u_xlat1.y;
    u_xlat5 = _Ratio * 0.5 + (-u_xlat1.x);
    u_xlat5 = u_xlat5 / _Ratio;
    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.25>=u_xlat3);
#else
    u_xlatb3 = 0.25>=u_xlat3;
#endif
    u_xlat5 = _Ratio * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat5>=u_xlat1.x);
#else
    u_xlatb1 = u_xlat5>=u_xlat1.x;
#endif
    u_xlat1.x = (u_xlatb1) ? 0.0 : 1.0;
    u_xlat0.w = (u_xlatb3) ? 1.0 : u_xlat1.x;
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Ratio;
uniform 	float _Progress;
uniform 	float _ProgressSteps;
uniform 	float _GapWidth;
uniform 	mediump vec4 _ProgressColor;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _GapColor;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
float u_xlat5;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x * _ProgressSteps;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat0.x = -abs(u_xlat0.x) + 0.5;
    u_xlat2.x = _ProgressSteps * _GapWidth;
    u_xlat0.x = (-u_xlat2.x) * 0.100000001 + u_xlat0.x;
    u_xlat2.x = u_xlat2.x * 0.100000001;
    u_xlat2.x = float(1.0) / (-u_xlat2.x);
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD0.x>=_Progress);
#else
    u_xlatb2 = vs_TEXCOORD0.x>=_Progress;
#endif
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_ProgressColor.xyz) + _BackgroundColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _ProgressColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _GapColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = -abs(u_xlat1.x) + 0.5;
    u_xlat3 = u_xlat1.y * u_xlat1.y;
    u_xlat5 = _Ratio * 0.5 + (-u_xlat1.x);
    u_xlat5 = u_xlat5 / _Ratio;
    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.25>=u_xlat3);
#else
    u_xlatb3 = 0.25>=u_xlat3;
#endif
    u_xlat5 = _Ratio * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat5>=u_xlat1.x);
#else
    u_xlatb1 = u_xlat5>=u_xlat1.x;
#endif
    u_xlat1.x = (u_xlatb1) ? 0.0 : 1.0;
    u_xlat0.w = (u_xlatb3) ? 1.0 : u_xlat1.x;
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
}
}