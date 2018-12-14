Shader "Hidden/LuminanceBakeShader" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_RampTex ("Ramp", 2D) = "white" { }
_MaskTex ("Mask", 2D) = "black" { }
_TintColorOne ("Red Channel Tint", Color) = (0.5,0.5,0.5,0.5)
_TintColorTwo ("Green Channel Tint", Color) = (0.5,0.5,0.5,0.5)
_TintColorThree ("Blue Channel Tint", Color) = (0.5,0.5,0.5,0.5)
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 43463
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColorOne;
uniform 	mediump vec4 _TintColorTwo;
uniform 	mediump vec4 _TintColorThree;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _RampTex;
uniform lowp sampler2D _MaskTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.y = 0.5;
    u_xlat0.xw = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    SV_Target0.w = u_xlat0.w;
    u_xlat10_0.xyz = texture(_RampTex, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * _TintColorOne.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat10_0.xyz);
    u_xlat10_2.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _TintColorTwo.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _TintColorThree.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat16_1.xyz);
    SV_Target0.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColorOne;
uniform 	mediump vec4 _TintColorTwo;
uniform 	mediump vec4 _TintColorThree;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _RampTex;
uniform lowp sampler2D _MaskTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.y = 0.5;
    u_xlat0.xw = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    SV_Target0.w = u_xlat0.w;
    u_xlat10_0.xyz = texture(_RampTex, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * _TintColorOne.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat10_0.xyz);
    u_xlat10_2.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _TintColorTwo.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _TintColorThree.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat16_1.xyz);
    SV_Target0.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz + u_xlat16_1.xyz;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColorOne;
uniform 	mediump vec4 _TintColorTwo;
uniform 	mediump vec4 _TintColorThree;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _RampTex;
uniform lowp sampler2D _MaskTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.y = 0.5;
    u_xlat0.xw = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    SV_Target0.w = u_xlat0.w;
    u_xlat10_0.xyz = texture(_RampTex, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * _TintColorOne.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat10_0.xyz);
    u_xlat10_2.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _TintColorTwo.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_2.yyy * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _TintColorThree.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat16_1.xyz);
    SV_Target0.xyz = u_xlat10_2.zzz * u_xlat16_3.xyz + u_xlat16_1.xyz;
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