Shader "Niantic/Combat/CombatShields" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
[Header(REFLECTION)] _ReflectTex ("Reflection Texture", 2D) = "white" { }
_ReflectStrength ("Reflection Strength", Range(0, 1)) = 0.5
_RefScale ("Reflection Scale", Range(0, 3)) = 1
[Header(PARALLAX)] _Parallax1 ("Parallax 1", Vector) = (1,1,2,2)
_Opacity ("Opacity", Range(0, 1)) = 1
_GradCenterWorld ("Gradient Center World Position", Vector) = (0,0,0,0)
_GradColorTop ("Top Gradient Color", Color) = (1,1,1,1)
_GradColorBottom ("Bottom Gradient Color", Color) = (0,0,0,1)
_GradScale ("Gradient Scale", Range(0.001, 1)) = 1
_GradVerticalOffset ("Gradient Offset", Range(-100, 100)) = 1
_SideBrightness ("Side Brightness", Range(0, 1)) = 0.5
_NoiseBrightness ("Noise Brightness", Range(0, 10)) = 1
_NoiseSpeed ("Noise Speed", Vector) = (1,1,0,0)
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 19886
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Parallax1;
uniform 	vec2 _NoiseSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_normal0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.xx * _NoiseSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD2.xy = _Time.xx * (-_NoiseSpeed.xy) + u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xy = (-u_xlat0.xy) + _WorldSpaceCameraPos.xy;
    u_xlat0.xy = (-u_xlat0.xy);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat9 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat0.z = u_xlat9 * _Parallax1.z;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat9 = u_xlat9 + u_xlat9;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * (-vec3(u_xlat9)) + u_xlat0.xyz;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    vs_normal0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReflectStrength;
uniform 	float _Opacity;
uniform 	vec4 _GradCenterWorld;
uniform 	mediump vec4 _GradColorTop;
uniform 	mediump vec4 _GradColorBottom;
uniform 	float _GradScale;
uniform 	float _GradVerticalOffset;
uniform 	float _SideBrightness;
uniform 	float _NoiseBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_normal0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump float u_xlat16_2;
lowp vec3 u_xlat10_3;
float u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.y + (-_GradCenterWorld.y);
    u_xlat4 = float(1.0) / _GradScale;
    u_xlat0.x = u_xlat0.x * u_xlat4 + _GradVerticalOffset;
    u_xlat0.x = u_xlat0.x + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _GradColorTop.xyz + (-_GradColorBottom.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradColorBottom.xyz;
    u_xlat10_12 = texture(_MainTex, vs_TEXCOORD1.xy).z;
    u_xlat10_1.x = texture(_MainTex, vs_TEXCOORD2.xy).z;
    u_xlat16_2 = u_xlat10_12 * u_xlat10_1.x;
    u_xlat5.x = u_xlat16_2 * _NoiseBrightness;
    u_xlat5.xyz = u_xlat0.xyz * u_xlat5.xxx;
    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyw;
    u_xlat0.xyz = u_xlat10_3.xxx * u_xlat0.xyz + u_xlat5.xyz;
    u_xlat5.x = u_xlat10_3.y * _SideBrightness;
    u_xlat12 = u_xlat10_12 * u_xlat5.x;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat10_1.xxx + u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + vec3(0.5, 0.5, 0.0);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vs_TEXCOORD5.xy + vec2(0.5, 0.5);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat1.xy;
    u_xlat10_1.xyz = texture(_ReflectTex, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectStrength) + u_xlat0.xyz;
    u_xlat1.x = abs(vs_normal0.y) + abs(vs_normal0.z);
    u_xlat1.x = u_xlat1.x * _Opacity;
    u_xlat1.x = u_xlat1.x * 0.5;
    u_xlat0.w = u_xlat10_3.z * _Opacity + u_xlat1.x;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Parallax1;
uniform 	vec2 _NoiseSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_normal0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.xx * _NoiseSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD2.xy = _Time.xx * (-_NoiseSpeed.xy) + u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xy = (-u_xlat0.xy) + _WorldSpaceCameraPos.xy;
    u_xlat0.xy = (-u_xlat0.xy);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat9 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat0.z = u_xlat9 * _Parallax1.z;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat9 = u_xlat9 + u_xlat9;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * (-vec3(u_xlat9)) + u_xlat0.xyz;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    vs_normal0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReflectStrength;
uniform 	float _Opacity;
uniform 	vec4 _GradCenterWorld;
uniform 	mediump vec4 _GradColorTop;
uniform 	mediump vec4 _GradColorBottom;
uniform 	float _GradScale;
uniform 	float _GradVerticalOffset;
uniform 	float _SideBrightness;
uniform 	float _NoiseBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_normal0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump float u_xlat16_2;
lowp vec3 u_xlat10_3;
float u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.y + (-_GradCenterWorld.y);
    u_xlat4 = float(1.0) / _GradScale;
    u_xlat0.x = u_xlat0.x * u_xlat4 + _GradVerticalOffset;
    u_xlat0.x = u_xlat0.x + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _GradColorTop.xyz + (-_GradColorBottom.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradColorBottom.xyz;
    u_xlat10_12 = texture(_MainTex, vs_TEXCOORD1.xy).z;
    u_xlat10_1.x = texture(_MainTex, vs_TEXCOORD2.xy).z;
    u_xlat16_2 = u_xlat10_12 * u_xlat10_1.x;
    u_xlat5.x = u_xlat16_2 * _NoiseBrightness;
    u_xlat5.xyz = u_xlat0.xyz * u_xlat5.xxx;
    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyw;
    u_xlat0.xyz = u_xlat10_3.xxx * u_xlat0.xyz + u_xlat5.xyz;
    u_xlat5.x = u_xlat10_3.y * _SideBrightness;
    u_xlat12 = u_xlat10_12 * u_xlat5.x;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat10_1.xxx + u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + vec3(0.5, 0.5, 0.0);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vs_TEXCOORD5.xy + vec2(0.5, 0.5);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat1.xy;
    u_xlat10_1.xyz = texture(_ReflectTex, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectStrength) + u_xlat0.xyz;
    u_xlat1.x = abs(vs_normal0.y) + abs(vs_normal0.z);
    u_xlat1.x = u_xlat1.x * _Opacity;
    u_xlat1.x = u_xlat1.x * 0.5;
    u_xlat0.w = u_xlat10_3.z * _Opacity + u_xlat1.x;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Parallax1;
uniform 	vec2 _NoiseSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_normal0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.xx * _NoiseSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD2.xy = _Time.xx * (-_NoiseSpeed.xy) + u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xy = (-u_xlat0.xy) + _WorldSpaceCameraPos.xy;
    u_xlat0.xy = (-u_xlat0.xy);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat9 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat0.z = u_xlat9 * _Parallax1.z;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat9 = u_xlat9 + u_xlat9;
    vs_TEXCOORD5.xyz = u_xlat1.xyz * (-vec3(u_xlat9)) + u_xlat0.xyz;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    vs_normal0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReflectStrength;
uniform 	float _Opacity;
uniform 	vec4 _GradCenterWorld;
uniform 	mediump vec4 _GradColorTop;
uniform 	mediump vec4 _GradColorBottom;
uniform 	float _GradScale;
uniform 	float _GradVerticalOffset;
uniform 	float _SideBrightness;
uniform 	float _NoiseBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_normal0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump float u_xlat16_2;
lowp vec3 u_xlat10_3;
float u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.y + (-_GradCenterWorld.y);
    u_xlat4 = float(1.0) / _GradScale;
    u_xlat0.x = u_xlat0.x * u_xlat4 + _GradVerticalOffset;
    u_xlat0.x = u_xlat0.x + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _GradColorTop.xyz + (-_GradColorBottom.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _GradColorBottom.xyz;
    u_xlat10_12 = texture(_MainTex, vs_TEXCOORD1.xy).z;
    u_xlat10_1.x = texture(_MainTex, vs_TEXCOORD2.xy).z;
    u_xlat16_2 = u_xlat10_12 * u_xlat10_1.x;
    u_xlat5.x = u_xlat16_2 * _NoiseBrightness;
    u_xlat5.xyz = u_xlat0.xyz * u_xlat5.xxx;
    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyw;
    u_xlat0.xyz = u_xlat10_3.xxx * u_xlat0.xyz + u_xlat5.xyz;
    u_xlat5.x = u_xlat10_3.y * _SideBrightness;
    u_xlat12 = u_xlat10_12 * u_xlat5.x;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat10_1.xxx + u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + vec3(0.5, 0.5, 0.0);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vs_TEXCOORD5.xy + vec2(0.5, 0.5);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat1.xy;
    u_xlat10_1.xyz = texture(_ReflectTex, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * vec3(_ReflectStrength) + u_xlat0.xyz;
    u_xlat1.x = abs(vs_normal0.y) + abs(vs_normal0.z);
    u_xlat1.x = u_xlat1.x * _Opacity;
    u_xlat1.x = u_xlat1.x * 0.5;
    u_xlat0.w = u_xlat10_3.z * _Opacity + u_xlat1.x;
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