Shader "Niantic/QRcode" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_QRColor ("QR Color", Color) = (0.2,0.83,0.2,1)
_LogoTex ("Logo Texture", 2D) = "white" { }
_LogoScale ("Logo Scale", Float) = 8
_QRPixelCount ("QR Pixel Count", Float) = 42.7
_QRPixelOffset ("QR Pixel Offset", Vector) = (0,0,0,0)
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
  GpuProgramID 61443
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
uniform 	mediump vec4 _QRColor;
uniform 	float _LogoScale;
uniform 	float _QRPixelCount;
uniform 	vec4 _QRPixelOffset;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LogoTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
lowp vec4 u_xlat10_4;
vec2 u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + _QRPixelOffset.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_QRPixelCount, _QRPixelCount));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat10.xy * vec2(_LogoScale);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat0.y = sqrt(u_xlat1.x);
    u_xlat0.xy = u_xlat0.xy + vec2(-0.449999988, -0.449999988);
    u_xlat0.xy = u_xlat0.xy * vec2(5.00000048, 9.99999809);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat0.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
    u_xlat0.xy = (-u_xlat1.xy) * u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat1.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5>=u_xlat1.x);
#else
    u_xlatb1 = 0.5>=u_xlat1.x;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = min(u_xlat0.x, u_xlat1.x);
    u_xlat16_2 = _QRColor + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = u_xlat0.xxxx * u_xlat16_2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = u_xlat1.xxxx * u_xlat16_2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = (-u_xlat3) + u_xlat1;
    u_xlat2.xy = abs(u_xlat10.xy);
    u_xlat0.xz = vec2(_LogoScale) * u_xlat10.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat10_4 = texture(_LogoTex, u_xlat0.xz);
    u_xlat2.zw = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlatb2 = greaterThanEqual(u_xlat2, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat0.x = u_xlat2.y * u_xlat2.x;
    u_xlat10.x = (-u_xlat2.z) * u_xlat2.w + 1.0;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    u_xlat2 = (-u_xlat1) + u_xlat10_4;
    u_xlat0 = u_xlat0.yyyy * u_xlat2 + u_xlat1;
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
uniform 	mediump vec4 _QRColor;
uniform 	float _LogoScale;
uniform 	float _QRPixelCount;
uniform 	vec4 _QRPixelOffset;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LogoTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
lowp vec4 u_xlat10_4;
vec2 u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + _QRPixelOffset.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_QRPixelCount, _QRPixelCount));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat10.xy * vec2(_LogoScale);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat0.y = sqrt(u_xlat1.x);
    u_xlat0.xy = u_xlat0.xy + vec2(-0.449999988, -0.449999988);
    u_xlat0.xy = u_xlat0.xy * vec2(5.00000048, 9.99999809);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat0.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
    u_xlat0.xy = (-u_xlat1.xy) * u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat1.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5>=u_xlat1.x);
#else
    u_xlatb1 = 0.5>=u_xlat1.x;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = min(u_xlat0.x, u_xlat1.x);
    u_xlat16_2 = _QRColor + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = u_xlat0.xxxx * u_xlat16_2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = u_xlat1.xxxx * u_xlat16_2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = (-u_xlat3) + u_xlat1;
    u_xlat2.xy = abs(u_xlat10.xy);
    u_xlat0.xz = vec2(_LogoScale) * u_xlat10.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat10_4 = texture(_LogoTex, u_xlat0.xz);
    u_xlat2.zw = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlatb2 = greaterThanEqual(u_xlat2, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat0.x = u_xlat2.y * u_xlat2.x;
    u_xlat10.x = (-u_xlat2.z) * u_xlat2.w + 1.0;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    u_xlat2 = (-u_xlat1) + u_xlat10_4;
    u_xlat0 = u_xlat0.yyyy * u_xlat2 + u_xlat1;
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
uniform 	mediump vec4 _QRColor;
uniform 	float _LogoScale;
uniform 	float _QRPixelCount;
uniform 	vec4 _QRPixelOffset;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LogoTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
lowp vec4 u_xlat10_4;
vec2 u_xlat10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + _QRPixelOffset.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_QRPixelCount, _QRPixelCount));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat10.xy * vec2(_LogoScale);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat0.y = sqrt(u_xlat1.x);
    u_xlat0.xy = u_xlat0.xy + vec2(-0.449999988, -0.449999988);
    u_xlat0.xy = u_xlat0.xy * vec2(5.00000048, 9.99999809);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat0.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
    u_xlat0.xy = (-u_xlat1.xy) * u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat1.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5>=u_xlat1.x);
#else
    u_xlatb1 = 0.5>=u_xlat1.x;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = min(u_xlat0.x, u_xlat1.x);
    u_xlat16_2 = _QRColor + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = u_xlat0.xxxx * u_xlat16_2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = u_xlat1.xxxx * u_xlat16_2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = (-u_xlat3) + u_xlat1;
    u_xlat2.xy = abs(u_xlat10.xy);
    u_xlat0.xz = vec2(_LogoScale) * u_xlat10.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat10_4 = texture(_LogoTex, u_xlat0.xz);
    u_xlat2.zw = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlatb2 = greaterThanEqual(u_xlat2, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat0.x = u_xlat2.y * u_xlat2.x;
    u_xlat10.x = (-u_xlat2.z) * u_xlat2.w + 1.0;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat1 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    u_xlat2 = (-u_xlat1) + u_xlat10_4;
    u_xlat0 = u_xlat0.yyyy * u_xlat2 + u_xlat1;
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