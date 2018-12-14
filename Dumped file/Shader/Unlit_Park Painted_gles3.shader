Shader "Unlit/Park Painted" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_TintColor ("Tint", Color) = (1,1,1,1)
_AddColor ("Additive", Color) = (0,0,0,0)
_Saturation ("Saturation", Range(0, 1)) = 1
}
SubShader {
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Geometry+1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 43546
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _Saturation;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = (-_Saturation) + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = dot(u_xlat10_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat10_1.xyz) + vec3(u_xlat16_2);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat10_1.xyz;
    SV_Target0.w = u_xlat10_1.w * _TintColor.w;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _Saturation;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = (-_Saturation) + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = dot(u_xlat10_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat10_1.xyz) + vec3(u_xlat16_2);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat10_1.xyz;
    SV_Target0.w = u_xlat10_1.w * _TintColor.w;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _Saturation;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = (-_Saturation) + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = dot(u_xlat10_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat10_1.xyz) + vec3(u_xlat16_2);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat10_1.xyz;
    SV_Target0.w = u_xlat10_1.w * _TintColor.w;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _Saturation;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = (-_Saturation) + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = dot(u_xlat10_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat10_1.xyz) + vec3(u_xlat16_2);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat10_1.xyz;
    SV_Target0.w = u_xlat10_1.w * _TintColor.w;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _Saturation;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = (-_Saturation) + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = dot(u_xlat10_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat10_1.xyz) + vec3(u_xlat16_2);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat10_1.xyz;
    SV_Target0.w = u_xlat10_1.w * _TintColor.w;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _Saturation;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = (-_Saturation) + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = dot(u_xlat10_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_3.xyz = (-u_xlat10_1.xyz) + vec3(u_xlat16_2);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat10_1.xyz;
    SV_Target0.w = u_xlat10_1.w * _TintColor.w;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
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