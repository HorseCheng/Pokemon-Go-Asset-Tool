Shader "Unlit/BadgeShader/UI" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_MaskTex ("Mask Texture", 2D) = "white" { }
_WarpTex ("Warp Texture", 2D) = "bump" { }
_WarpStrength ("Warp Strength", Float) = 1
_BlendTex ("Blend Texture", 2D) = "black" { }
_Blend ("Blend Amount", Range(0, 1)) = 1
_AdditiveTex ("Additive Texture (Blend)", 2D) = "black" { }
_AdditiveBlend ("Additive Blend Amount", Range(0, 1)) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "DEFAULT"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 61811
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MaskTex_ST;
uniform 	vec4 _WarpTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
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
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _WarpStrength;
uniform 	mediump float _Blend;
uniform 	mediump float _AdditiveBlend;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _BlendTex;
uniform lowp sampler2D _AdditiveTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_3.xy = texture(_WarpTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy + vec2(-0.5, -0.5);
    u_xlat3.xy = u_xlat16_3.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_3.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_3.xxxx * u_xlat16_1;
    u_xlat10_3.x = texture(_MaskTex, vs_TEXCOORD2.xy).x;
    u_xlat16_2.x = u_xlat10_3.x * u_xlat16_1.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    SV_Target0.w = u_xlat0.x;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(vec3(_Blend, _Blend, _Blend)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_AdditiveTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_AdditiveBlend, _AdditiveBlend, _AdditiveBlend)) + u_xlat16_2.xyz;
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
uniform 	vec4 _MaskTex_ST;
uniform 	vec4 _WarpTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
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
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _WarpStrength;
uniform 	mediump float _Blend;
uniform 	mediump float _AdditiveBlend;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _BlendTex;
uniform lowp sampler2D _AdditiveTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_3.xy = texture(_WarpTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy + vec2(-0.5, -0.5);
    u_xlat3.xy = u_xlat16_3.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_3.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_3.xxxx * u_xlat16_1;
    u_xlat10_3.x = texture(_MaskTex, vs_TEXCOORD2.xy).x;
    u_xlat16_2.x = u_xlat10_3.x * u_xlat16_1.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    SV_Target0.w = u_xlat0.x;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(vec3(_Blend, _Blend, _Blend)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_AdditiveTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_AdditiveBlend, _AdditiveBlend, _AdditiveBlend)) + u_xlat16_2.xyz;
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
uniform 	vec4 _MaskTex_ST;
uniform 	vec4 _WarpTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
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
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _WarpStrength;
uniform 	mediump float _Blend;
uniform 	mediump float _AdditiveBlend;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _BlendTex;
uniform lowp sampler2D _AdditiveTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec2 u_xlat10_3;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_3.xy = texture(_WarpTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_3.xy = u_xlat10_3.xy + vec2(-0.5, -0.5);
    u_xlat3.xy = u_xlat16_3.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_3.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_3.xxxx * u_xlat16_1;
    u_xlat10_3.x = texture(_MaskTex, vs_TEXCOORD2.xy).x;
    u_xlat16_2.x = u_xlat10_3.x * u_xlat16_1.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    SV_Target0.w = u_xlat0.x;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(vec3(_Blend, _Blend, _Blend)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_AdditiveTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_AdditiveBlend, _AdditiveBlend, _AdditiveBlend)) + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MaskTex_ST;
uniform 	vec4 _WarpTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
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
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _WarpStrength;
uniform 	mediump float _Blend;
uniform 	mediump float _AdditiveBlend;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _BlendTex;
uniform lowp sampler2D _AdditiveTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.xxxx;
    u_xlat10_1.x = texture(_MaskTex, vs_TEXCOORD2.xy).x;
    u_xlat16_2.x = u_xlat16_0.w * u_xlat10_1.x;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = vec2(u_xlat1.z * u_xlat1.x, u_xlat1.w * u_xlat1.y);
    u_xlat9 = u_xlat1.y * u_xlat1.x;
    u_xlat16_5 = u_xlat16_2.x * u_xlat9 + -0.00100000005;
    u_xlat9 = u_xlat9 * u_xlat16_2.x;
    SV_Target0.w = u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_5<0.0);
#else
    u_xlatb9 = u_xlat16_5<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(vec3(_Blend, _Blend, _Blend)) + u_xlat16_0.xyz;
    u_xlat10_0.xyz = texture(_AdditiveTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_AdditiveBlend, _AdditiveBlend, _AdditiveBlend)) + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MaskTex_ST;
uniform 	vec4 _WarpTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
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
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _WarpStrength;
uniform 	mediump float _Blend;
uniform 	mediump float _AdditiveBlend;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _BlendTex;
uniform lowp sampler2D _AdditiveTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.xxxx;
    u_xlat10_1.x = texture(_MaskTex, vs_TEXCOORD2.xy).x;
    u_xlat16_2.x = u_xlat16_0.w * u_xlat10_1.x;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = vec2(u_xlat1.z * u_xlat1.x, u_xlat1.w * u_xlat1.y);
    u_xlat9 = u_xlat1.y * u_xlat1.x;
    u_xlat16_5 = u_xlat16_2.x * u_xlat9 + -0.00100000005;
    u_xlat9 = u_xlat9 * u_xlat16_2.x;
    SV_Target0.w = u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_5<0.0);
#else
    u_xlatb9 = u_xlat16_5<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(vec3(_Blend, _Blend, _Blend)) + u_xlat16_0.xyz;
    u_xlat10_0.xyz = texture(_AdditiveTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_AdditiveBlend, _AdditiveBlend, _AdditiveBlend)) + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MaskTex_ST;
uniform 	vec4 _WarpTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
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
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _WarpStrength;
uniform 	mediump float _Blend;
uniform 	mediump float _AdditiveBlend;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _BlendTex;
uniform lowp sampler2D _AdditiveTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_0.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.xxxx;
    u_xlat10_1.x = texture(_MaskTex, vs_TEXCOORD2.xy).x;
    u_xlat16_2.x = u_xlat16_0.w * u_xlat10_1.x;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = vec2(u_xlat1.z * u_xlat1.x, u_xlat1.w * u_xlat1.y);
    u_xlat9 = u_xlat1.y * u_xlat1.x;
    u_xlat16_5 = u_xlat16_2.x * u_xlat9 + -0.00100000005;
    u_xlat9 = u_xlat9 * u_xlat16_2.x;
    SV_Target0.w = u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_5<0.0);
#else
    u_xlatb9 = u_xlat16_5<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(vec3(_Blend, _Blend, _Blend)) + u_xlat16_0.xyz;
    u_xlat10_0.xyz = texture(_AdditiveTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vec3(vec3(_AdditiveBlend, _AdditiveBlend, _AdditiveBlend)) + u_xlat16_2.xyz;
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
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
}
}
}
}