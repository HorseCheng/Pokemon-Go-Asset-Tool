Shader "Holo/Sky/Cloudscape" {
Properties {
_HighlightColor ("Highlight Color", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_CloudShadowColor ("Shadow Color", Color) = (1,1,1,1)
_MainTex ("Main Texture", 2D) = "white" { }
_Alpha ("Alpha", Range(0, 1)) = 1
_PanSpeed ("Pan Speed", Float) = 0.1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 47794
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _PanSpeed;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
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
    u_xlat0.x = _Time.x * _PanSpeed;
    u_xlat1.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.x * in_COLOR0.x + u_xlat1.y;
    vs_TEXCOORD0.xy = u_xlat1.xz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _HighlightColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _CloudShadowColor;
uniform 	mediump float _Alpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec2 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_7;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = (-_Color.xyz) + _CloudShadowColor.xyz;
    u_xlat10_1.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_7 = (-u_xlat10_1.x) + 1.25;
    u_xlat16_9 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz + _Color.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _HighlightColor.xyz;
    u_xlat16_9 = u_xlat10_1.x * u_xlat10_1.x;
    SV_Target0.w = u_xlat10_1.y * _Alpha;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    SV_Target0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
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
uniform 	mediump float _PanSpeed;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
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
    u_xlat0.x = _Time.x * _PanSpeed;
    u_xlat1.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.x * in_COLOR0.x + u_xlat1.y;
    vs_TEXCOORD0.xy = u_xlat1.xz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _HighlightColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _CloudShadowColor;
uniform 	mediump float _Alpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec2 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_7;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = (-_Color.xyz) + _CloudShadowColor.xyz;
    u_xlat10_1.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_7 = (-u_xlat10_1.x) + 1.25;
    u_xlat16_9 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz + _Color.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _HighlightColor.xyz;
    u_xlat16_9 = u_xlat10_1.x * u_xlat10_1.x;
    SV_Target0.w = u_xlat10_1.y * _Alpha;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    SV_Target0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
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
uniform 	mediump float _PanSpeed;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
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
    u_xlat0.x = _Time.x * _PanSpeed;
    u_xlat1.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.x * in_COLOR0.x + u_xlat1.y;
    vs_TEXCOORD0.xy = u_xlat1.xz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _HighlightColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _CloudShadowColor;
uniform 	mediump float _Alpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec2 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_7;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = (-_Color.xyz) + _CloudShadowColor.xyz;
    u_xlat10_1.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_7 = (-u_xlat10_1.x) + 1.25;
    u_xlat16_9 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_7;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz + _Color.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _HighlightColor.xyz;
    u_xlat16_9 = u_xlat10_1.x * u_xlat10_1.x;
    SV_Target0.w = u_xlat10_1.y * _Alpha;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    SV_Target0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
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