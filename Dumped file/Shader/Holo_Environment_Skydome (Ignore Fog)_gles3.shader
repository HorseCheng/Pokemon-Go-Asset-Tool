Shader "Holo/Environment/Skydome (Ignore Fog)" {
Properties {
_SkyColor ("Sky Main Color", Color) = (1,1,1,1)
_HorizonColor ("Horizon Color", Color) = (1,1,1,1)
_HorizonPinch ("Horizon Pinch", Float) = 1
_HorizonHeight ("Horizon Height", Float) = 0
_FogPinch ("Fog Pinch", Float) = 1
_FogHeight ("Fog Height", Float) = 0
_StarTex ("Star Texture", 2D) = "black" { }
_StarStrength ("Star Brightness", Range(0, 1)) = 0
_StarFalloff ("Star Falloff", Float) = 5
_PanningSpeed ("Panning Speed", Float) = 0.01
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Background" }
  ZWrite Off
  GpuProgramID 26792
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _HorizonColor;
uniform 	mediump float _HorizonPinch;
uniform 	mediump float _HorizonHeight;
uniform 	mediump float _FogPinch;
uniform 	mediump float _FogHeight;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarFalloff;
uniform 	mediump float _PanningSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat1.x = _Time.x * _PanningSpeed;
    u_xlat1.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_2.xy = vec2(u_xlat0.x + float(_HorizonHeight), u_xlat0.x + float(_FogHeight));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_8 = log2(u_xlat0.x);
    u_xlat16_8 = u_xlat16_8 * _StarFalloff;
    u_xlat16_8 = exp2(u_xlat16_8);
    vs_TEXCOORD1 = (-u_xlat16_8) + 1.0;
    u_xlat16_2.xy = log2(u_xlat16_2.xy);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_HorizonPinch, _FogPinch);
    u_xlat16_2.xy = exp2(u_xlat16_2.xy);
    u_xlat16_0 = (-_SkyColor) + _HorizonColor;
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_0 + _SkyColor;
    u_xlat16_1 = (-u_xlat16_0) + unity_FogColor;
    vs_COLOR0 = u_xlat16_2.yyyy * u_xlat16_1 + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _StarStrength;
uniform lowp sampler2D _StarTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_StarTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(vs_TEXCOORD1);
    SV_Target0 = u_xlat16_0 * vec4(_StarStrength) + vs_COLOR0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _HorizonColor;
uniform 	mediump float _HorizonPinch;
uniform 	mediump float _HorizonHeight;
uniform 	mediump float _FogPinch;
uniform 	mediump float _FogHeight;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarFalloff;
uniform 	mediump float _PanningSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat1.x = _Time.x * _PanningSpeed;
    u_xlat1.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_2.xy = vec2(u_xlat0.x + float(_HorizonHeight), u_xlat0.x + float(_FogHeight));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_8 = log2(u_xlat0.x);
    u_xlat16_8 = u_xlat16_8 * _StarFalloff;
    u_xlat16_8 = exp2(u_xlat16_8);
    vs_TEXCOORD1 = (-u_xlat16_8) + 1.0;
    u_xlat16_2.xy = log2(u_xlat16_2.xy);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_HorizonPinch, _FogPinch);
    u_xlat16_2.xy = exp2(u_xlat16_2.xy);
    u_xlat16_0 = (-_SkyColor) + _HorizonColor;
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_0 + _SkyColor;
    u_xlat16_1 = (-u_xlat16_0) + unity_FogColor;
    vs_COLOR0 = u_xlat16_2.yyyy * u_xlat16_1 + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _StarStrength;
uniform lowp sampler2D _StarTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_StarTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(vs_TEXCOORD1);
    SV_Target0 = u_xlat16_0 * vec4(_StarStrength) + vs_COLOR0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _HorizonColor;
uniform 	mediump float _HorizonPinch;
uniform 	mediump float _HorizonHeight;
uniform 	mediump float _FogPinch;
uniform 	mediump float _FogHeight;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarFalloff;
uniform 	mediump float _PanningSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat1.x = _Time.x * _PanningSpeed;
    u_xlat1.y = 0.0;
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_2.xy = vec2(u_xlat0.x + float(_HorizonHeight), u_xlat0.x + float(_FogHeight));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_8 = log2(u_xlat0.x);
    u_xlat16_8 = u_xlat16_8 * _StarFalloff;
    u_xlat16_8 = exp2(u_xlat16_8);
    vs_TEXCOORD1 = (-u_xlat16_8) + 1.0;
    u_xlat16_2.xy = log2(u_xlat16_2.xy);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_HorizonPinch, _FogPinch);
    u_xlat16_2.xy = exp2(u_xlat16_2.xy);
    u_xlat16_0 = (-_SkyColor) + _HorizonColor;
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_0 + _SkyColor;
    u_xlat16_1 = (-u_xlat16_0) + unity_FogColor;
    vs_COLOR0 = u_xlat16_2.yyyy * u_xlat16_1 + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _StarStrength;
uniform lowp sampler2D _StarTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_StarTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(vs_TEXCOORD1);
    SV_Target0 = u_xlat16_0 * vec4(_StarStrength) + vs_COLOR0;
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