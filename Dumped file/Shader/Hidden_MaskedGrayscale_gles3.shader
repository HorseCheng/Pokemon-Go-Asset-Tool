Shader "Hidden/MaskedGrayscale" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_MaskTex ("Mask (A)", 2D) = "white" { }
_MaskOffValue ("_MaskOffValue", Float) = 1
_MaskOnValue ("_MaskOnValue", Float) = 1
_RampTex ("Ramp (RGB)", 2D) = "grayscaleRamp" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 18022
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _MaskOffValue;
uniform 	mediump float _MaskOnValue;
uniform 	mediump float _RampOffset;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _RampTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_5;
void main()
{
    u_xlat10_0 = texture(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-_MaskOffValue) + _MaskOnValue;
    u_xlat16_1 = u_xlat10_0 * u_xlat16_1 + _MaskOffValue;
    u_xlat16_2.y = 0.5;
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_5 = dot(u_xlat0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_2.x = u_xlat16_5 + _RampOffset;
    u_xlat10_3.xyz = texture(_RampTex, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat10_3.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat3.xyz + u_xlat0.xyz;
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
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _MaskOffValue;
uniform 	mediump float _MaskOnValue;
uniform 	mediump float _RampOffset;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _RampTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_5;
void main()
{
    u_xlat10_0 = texture(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-_MaskOffValue) + _MaskOnValue;
    u_xlat16_1 = u_xlat10_0 * u_xlat16_1 + _MaskOffValue;
    u_xlat16_2.y = 0.5;
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_5 = dot(u_xlat0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_2.x = u_xlat16_5 + _RampOffset;
    u_xlat10_3.xyz = texture(_RampTex, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat10_3.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat3.xyz + u_xlat0.xyz;
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
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _MaskOffValue;
uniform 	mediump float _MaskOnValue;
uniform 	mediump float _RampOffset;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _RampTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_5;
void main()
{
    u_xlat10_0 = texture(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = (-_MaskOffValue) + _MaskOnValue;
    u_xlat16_1 = u_xlat10_0 * u_xlat16_1 + _MaskOffValue;
    u_xlat16_2.y = 0.5;
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_5 = dot(u_xlat0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_2.x = u_xlat16_5 + _RampOffset;
    u_xlat10_3.xyz = texture(_RampTex, u_xlat16_2.xy).xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat10_3.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat3.xyz + u_xlat0.xyz;
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