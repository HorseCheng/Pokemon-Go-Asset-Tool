Shader "Niantic/UI/ImageRoundCorner" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Corner ("Corner", Float) = 0.1
_Feather ("Feather", Float) = 0.01
_Width ("Image Width", Float) = 586
_Height ("Image Height", Float) = 374
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
  GpuProgramID 60313
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
uniform 	vec4 _ClipRect;
uniform 	float _Corner;
uniform 	float _Feather;
uniform 	float _Width;
uniform 	float _Height;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat6;
bvec2 u_xlatb6;
vec2 u_xlat7;
void main()
{
    u_xlat0 = _Feather + 1.0;
    u_xlat3.x = (-_Feather) + 1.0;
    u_xlat0 = (-u_xlat3.x) + u_xlat0;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat6.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.xy = -abs(u_xlat6.xy) * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat1.x = _Width / _Height;
    u_xlat1.y = u_xlat1.x * _Corner;
    u_xlat1.x = _Corner;
    u_xlat7.xy = (-u_xlat6.xy) + u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xy = min(max(u_xlat7.xy, 0.0), 1.0);
#else
    u_xlat7.xy = clamp(u_xlat7.xy, 0.0, 1.0);
#endif
    u_xlatb6.xy = greaterThanEqual(u_xlat1.xyxy, u_xlat6.xyxy).xy;
    u_xlat1.xy = u_xlat7.xy / u_xlat1.xy;
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat3.x = (-u_xlat3.x) + u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb6.xy));
    u_xlat3.x = min(u_xlat3.y, u_xlat3.x);
    u_xlat6.x = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat6.x;
    u_xlat0 = u_xlat3.x * (-u_xlat0) + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat0 = u_xlat0 * u_xlat1.w;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ClipRect;
uniform 	float _Corner;
uniform 	float _Feather;
uniform 	float _Width;
uniform 	float _Height;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat6;
bvec2 u_xlatb6;
vec2 u_xlat7;
void main()
{
    u_xlat0 = _Feather + 1.0;
    u_xlat3.x = (-_Feather) + 1.0;
    u_xlat0 = (-u_xlat3.x) + u_xlat0;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat6.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.xy = -abs(u_xlat6.xy) * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat1.x = _Width / _Height;
    u_xlat1.y = u_xlat1.x * _Corner;
    u_xlat1.x = _Corner;
    u_xlat7.xy = (-u_xlat6.xy) + u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xy = min(max(u_xlat7.xy, 0.0), 1.0);
#else
    u_xlat7.xy = clamp(u_xlat7.xy, 0.0, 1.0);
#endif
    u_xlatb6.xy = greaterThanEqual(u_xlat1.xyxy, u_xlat6.xyxy).xy;
    u_xlat1.xy = u_xlat7.xy / u_xlat1.xy;
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat3.x = (-u_xlat3.x) + u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb6.xy));
    u_xlat3.x = min(u_xlat3.y, u_xlat3.x);
    u_xlat6.x = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat6.x;
    u_xlat0 = u_xlat3.x * (-u_xlat0) + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat0 = u_xlat0 * u_xlat1.w;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ClipRect;
uniform 	float _Corner;
uniform 	float _Feather;
uniform 	float _Width;
uniform 	float _Height;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat6;
bvec2 u_xlatb6;
vec2 u_xlat7;
void main()
{
    u_xlat0 = _Feather + 1.0;
    u_xlat3.x = (-_Feather) + 1.0;
    u_xlat0 = (-u_xlat3.x) + u_xlat0;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat6.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.xy = -abs(u_xlat6.xy) * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat1.x = _Width / _Height;
    u_xlat1.y = u_xlat1.x * _Corner;
    u_xlat1.x = _Corner;
    u_xlat7.xy = (-u_xlat6.xy) + u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xy = min(max(u_xlat7.xy, 0.0), 1.0);
#else
    u_xlat7.xy = clamp(u_xlat7.xy, 0.0, 1.0);
#endif
    u_xlatb6.xy = greaterThanEqual(u_xlat1.xyxy, u_xlat6.xyxy).xy;
    u_xlat1.xy = u_xlat7.xy / u_xlat1.xy;
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat3.x = (-u_xlat3.x) + u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb6.xy));
    u_xlat3.x = min(u_xlat3.y, u_xlat3.x);
    u_xlat6.x = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat6.x;
    u_xlat0 = u_xlat3.x * (-u_xlat0) + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat0 = u_xlat0 * u_xlat1.w;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0;
    SV_Target0 = u_xlat1;
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