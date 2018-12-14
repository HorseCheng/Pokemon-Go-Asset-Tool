Shader "Unlit/FXSphereGlow" {
Properties {
_Color1 ("Color1", Color) = (1,0,0,1)
_Color2 ("Color2", Color) = (0,0.3793104,1,1)
[Toggle(NIANTIC_FX)] _ColorBlend ("ColorBlend", Float) = 1
_BlendPoint ("BlendPoint", Range(0, 1)) = 0.5
_AttenuationStart ("AttenuationStart", Range(0, 1)) = 1
_AttenuationEnd ("AttenuationEnd", Range(0, 1)) = 0
_Intensity ("Intensity", Range(0, 10)) = 1
_AnimInput ("AnimInput", Range(0, 5)) = 1
[Header(SORTING_AND_CULLING)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling", Float) = 2
[Toggle] _ZWrite ("Z Write", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 11436
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD0.y = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _AttenuationEnd;
uniform 	mediump float _AttenuationStart;
uniform 	mediump float _Intensity;
uniform 	mediump float _AnimInput;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y + (-_AttenuationEnd);
    u_xlat16_2 = (-_AttenuationEnd) + _AttenuationStart;
    u_xlat16_1 = u_xlat16_0.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3;
    u_xlat16_0.x = u_xlat16_1 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0.xxxx * _Color1;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity));
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.wwww;
    SV_Target0 = u_xlat16_0 * vec4(vec4(_AnimInput, _AnimInput, _AnimInput, _AnimInput));
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD0.y = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _AttenuationEnd;
uniform 	mediump float _AttenuationStart;
uniform 	mediump float _Intensity;
uniform 	mediump float _AnimInput;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y + (-_AttenuationEnd);
    u_xlat16_2 = (-_AttenuationEnd) + _AttenuationStart;
    u_xlat16_1 = u_xlat16_0.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3;
    u_xlat16_0.x = u_xlat16_1 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0.xxxx * _Color1;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity));
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.wwww;
    SV_Target0 = u_xlat16_0 * vec4(vec4(_AnimInput, _AnimInput, _AnimInput, _AnimInput));
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD0.y = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _AttenuationEnd;
uniform 	mediump float _AttenuationStart;
uniform 	mediump float _Intensity;
uniform 	mediump float _AnimInput;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y + (-_AttenuationEnd);
    u_xlat16_2 = (-_AttenuationEnd) + _AttenuationStart;
    u_xlat16_1 = u_xlat16_0.x / u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3;
    u_xlat16_0.x = u_xlat16_1 * u_xlat16_1;
    u_xlat16_0 = u_xlat16_0.xxxx * _Color1;
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity));
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.wwww;
    SV_Target0 = u_xlat16_0 * vec4(vec4(_AnimInput, _AnimInput, _AnimInput, _AnimInput));
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "NIANTIC_FX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD0.y = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _AttenuationEnd;
uniform 	mediump float _AttenuationStart;
uniform 	mediump vec4 _Color2;
uniform 	mediump float _BlendPoint;
uniform 	mediump float _Intensity;
uniform 	mediump float _AnimInput;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
mediump float u_xlat16_5;
void main()
{
    u_xlat16_0.x = max(_BlendPoint, 9.99999975e-06);
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999989986);
    u_xlat16_3 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_3 = 0.5 / u_xlat16_3;
    u_xlat16_1 = 0.5 / u_xlat16_0.x;
    u_xlat16_3 = u_xlat16_3 + (-u_xlat16_1);
    u_xlat16_1 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_1 = u_xlat16_3 * u_xlat16_1 + -0.5;
    u_xlat16_1 = u_xlat16_1 / u_xlat16_0.x;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD0.y;
    u_xlat16_4 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_1 = u_xlat16_3 * u_xlat16_4 + (-u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0 = _Color1 + (-_Color2);
    u_xlat16_0 = vec4(u_xlat16_1) * u_xlat16_0 + _Color2;
    u_xlat16_1 = vs_TEXCOORD0.y + (-_AttenuationEnd);
    u_xlat16_4 = (-_AttenuationEnd) + _AttenuationStart;
    u_xlat16_2 = u_xlat16_1 / u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_2 * -2.0 + 3.0;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_5;
    u_xlat16_1 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity));
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.wwww;
    SV_Target0 = u_xlat16_0 * vec4(vec4(_AnimInput, _AnimInput, _AnimInput, _AnimInput));
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "NIANTIC_FX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD0.y = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _AttenuationEnd;
uniform 	mediump float _AttenuationStart;
uniform 	mediump vec4 _Color2;
uniform 	mediump float _BlendPoint;
uniform 	mediump float _Intensity;
uniform 	mediump float _AnimInput;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
mediump float u_xlat16_5;
void main()
{
    u_xlat16_0.x = max(_BlendPoint, 9.99999975e-06);
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999989986);
    u_xlat16_3 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_3 = 0.5 / u_xlat16_3;
    u_xlat16_1 = 0.5 / u_xlat16_0.x;
    u_xlat16_3 = u_xlat16_3 + (-u_xlat16_1);
    u_xlat16_1 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_1 = u_xlat16_3 * u_xlat16_1 + -0.5;
    u_xlat16_1 = u_xlat16_1 / u_xlat16_0.x;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD0.y;
    u_xlat16_4 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_1 = u_xlat16_3 * u_xlat16_4 + (-u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0 = _Color1 + (-_Color2);
    u_xlat16_0 = vec4(u_xlat16_1) * u_xlat16_0 + _Color2;
    u_xlat16_1 = vs_TEXCOORD0.y + (-_AttenuationEnd);
    u_xlat16_4 = (-_AttenuationEnd) + _AttenuationStart;
    u_xlat16_2 = u_xlat16_1 / u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_2 * -2.0 + 3.0;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_5;
    u_xlat16_1 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity));
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.wwww;
    SV_Target0 = u_xlat16_0 * vec4(vec4(_AnimInput, _AnimInput, _AnimInput, _AnimInput));
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "NIANTIC_FX" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD0.y = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _AttenuationEnd;
uniform 	mediump float _AttenuationStart;
uniform 	mediump vec4 _Color2;
uniform 	mediump float _BlendPoint;
uniform 	mediump float _Intensity;
uniform 	mediump float _AnimInput;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
mediump float u_xlat16_5;
void main()
{
    u_xlat16_0.x = max(_BlendPoint, 9.99999975e-06);
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999989986);
    u_xlat16_3 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_3 = 0.5 / u_xlat16_3;
    u_xlat16_1 = 0.5 / u_xlat16_0.x;
    u_xlat16_3 = u_xlat16_3 + (-u_xlat16_1);
    u_xlat16_1 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_1 = u_xlat16_3 * u_xlat16_1 + -0.5;
    u_xlat16_1 = u_xlat16_1 / u_xlat16_0.x;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD0.y;
    u_xlat16_4 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_1 = u_xlat16_3 * u_xlat16_4 + (-u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0 = _Color1 + (-_Color2);
    u_xlat16_0 = vec4(u_xlat16_1) * u_xlat16_0 + _Color2;
    u_xlat16_1 = vs_TEXCOORD0.y + (-_AttenuationEnd);
    u_xlat16_4 = (-_AttenuationEnd) + _AttenuationStart;
    u_xlat16_2 = u_xlat16_1 / u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_2 * -2.0 + 3.0;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_5;
    u_xlat16_1 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity));
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.wwww;
    SV_Target0 = u_xlat16_0 * vec4(vec4(_AnimInput, _AnimInput, _AnimInput, _AnimInput));
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
Keywords { "NIANTIC_FX" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "NIANTIC_FX" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "NIANTIC_FX" }
""
}
}
}
}
}