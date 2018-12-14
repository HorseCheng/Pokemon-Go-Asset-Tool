Shader "Niantic/BRDF/Gym V2" {
Properties {
_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
_BlendTex ("Blend Texture (for team swap)", 2D) = "black" { }
_BlendAmount ("Texture Blend", Range(0, 1)) = 0
_Ramp2D ("BRDF Ramp", 2D) = "grey" { }
_GymBrdfAmount ("BRDF Amount", Range(0, 2)) = 1
_GymDiffuse ("Diffuse", Color) = (1,1,1,0.5)
_GymAmbient ("Ambient", Color) = (0,0,0,0.5)
_GymRimTop ("RimTop   (.a=0.5)", Color) = (1,1,0,0.5)
_GymRimBottom ("RimBottom(.a=0.5)", Color) = (0,0,1,0.5)
_GymRimMultiply ("RimLight Mult", Range(0, 2)) = 1
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 49046
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
float u_xlat16;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
float u_xlat16;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
float u_xlat16;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_5.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_5.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_5.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_5.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_5.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_5.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xyz = u_xlat0.xyz + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD7 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat16_3 * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3 * 0.899999976;
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat0.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat1);
    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD7;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 107334
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat16_2 * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "DEFERRED"
  Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
  GpuProgramID 194147
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_2 * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
float u_xlat16;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
float u_xlat16;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
float u_xlat16;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
float u_xlat16;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
float u_xlat16;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
float u_xlat16;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3.y = u_xlat16_3.x * 0.899999976;
    vs_TEXCOORD3.zw = vec2(1.0, 1.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BlendAmount;
uniform 	mediump float _GymBrdfAmount;
uniform 	mediump float _GymRimMultiply;
uniform 	mediump vec4 _GymDiffuse;
uniform 	mediump vec4 _GymAmbient;
uniform 	mediump vec4 _GymRimTop;
uniform 	mediump vec4 _GymRimBottom;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BlendTex;
in mediump vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.x = _GymRimBottom.w + _GymRimBottom.w;
    u_xlat16_1.xyz = _GymDiffuse.xyz + (-_GymAmbient.xyz);
    u_xlat10_5.xyz = texture(_Ramp2D, vs_TEXCOORD3.xy).xyw;
    u_xlat16_1.xyz = u_xlat10_5.yyy * u_xlat16_1.xyz + _GymAmbient.xyz;
    u_xlat16_2.xyz = u_xlat10_5.zzz * _GymRimBottom.xyz;
    u_xlat16_3.xyz = u_xlat10_5.xxx * _GymRimTop.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.x = _GymRimTop.w + _GymRimTop.w;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_GymRimMultiply, _GymRimMultiply, _GymRimMultiply)) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_BlendTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_4.xyz);
    u_xlat16_2.xyz = vec3(_BlendAmount) * u_xlat16_2.xyz + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_GymBrdfAmount, _GymBrdfAmount, _GymBrdfAmount));
    SV_Target3.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.zzz;
    SV_Target3.w = 1.0;
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
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE" = "SHADOWCASTER" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 261044
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb12 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat8);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat8) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat8;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb12 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat8);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat8) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat8;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb12 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat8);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat8) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat8;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
}
}