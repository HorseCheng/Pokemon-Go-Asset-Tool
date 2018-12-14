Shader "Niantic/Rainbow" {
Properties {
_TintColor ("Tint Color", Color) = (1,1,1,1)
_Height ("Height", Float) = 10
_Width ("Width", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _ZComp ("Z Compare Function", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 44842
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.z = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat0.y;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_POSITION0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	float _Width;
uniform 	float _Height;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = (-_Width) + _Height;
    u_xlat3 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3 = sqrt(u_xlat3);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_Height);
    u_xlat3 = abs(u_xlat3) / _Width;
    u_xlat16_1 = (-u_xlat3) * u_xlat3 + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_4.x = _Width + _Width;
    u_xlat16_4.x = u_xlat0.x / u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx + vec4(-0.600000024, -0.449999988, -0.174999997, -0.159999996);
    u_xlat16_0 = u_xlat16_0 * (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * vec4(52.4616356, 32.0598869, 240.449173, 360.673737);
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0 = u_xlat16_0 * vec4(1.0, 1.0, 0.800000012, 0.200000003);
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_4.xyz = u_xlat0.xyz * vec3(1.25, 1.25, 1.25);
    u_xlat16_2 = dot(u_xlat16_4.xyz, vec3(1.0, 1.0, 1.0));
    SV_Target0.xyz = u_xlat16_4.xyz * _TintColor.xyz;
    u_xlat0.x = vs_TEXCOORD0.z / _Height;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = u_xlat0.x * 0.300000012;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    SV_Target0.w = u_xlat0.x * _TintColor.w;
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
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.z = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat0.y;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_POSITION0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	float _Width;
uniform 	float _Height;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = (-_Width) + _Height;
    u_xlat3 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3 = sqrt(u_xlat3);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_Height);
    u_xlat3 = abs(u_xlat3) / _Width;
    u_xlat16_1 = (-u_xlat3) * u_xlat3 + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_4.x = _Width + _Width;
    u_xlat16_4.x = u_xlat0.x / u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx + vec4(-0.600000024, -0.449999988, -0.174999997, -0.159999996);
    u_xlat16_0 = u_xlat16_0 * (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * vec4(52.4616356, 32.0598869, 240.449173, 360.673737);
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0 = u_xlat16_0 * vec4(1.0, 1.0, 0.800000012, 0.200000003);
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_4.xyz = u_xlat0.xyz * vec3(1.25, 1.25, 1.25);
    u_xlat16_2 = dot(u_xlat16_4.xyz, vec3(1.0, 1.0, 1.0));
    SV_Target0.xyz = u_xlat16_4.xyz * _TintColor.xyz;
    u_xlat0.x = vs_TEXCOORD0.z / _Height;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = u_xlat0.x * 0.300000012;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    SV_Target0.w = u_xlat0.x * _TintColor.w;
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
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.z = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat0.y;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_POSITION0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	float _Width;
uniform 	float _Height;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = (-_Width) + _Height;
    u_xlat3 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3 = sqrt(u_xlat3);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_Height);
    u_xlat3 = abs(u_xlat3) / _Width;
    u_xlat16_1 = (-u_xlat3) * u_xlat3 + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_4.x = _Width + _Width;
    u_xlat16_4.x = u_xlat0.x / u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx + vec4(-0.600000024, -0.449999988, -0.174999997, -0.159999996);
    u_xlat16_0 = u_xlat16_0 * (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * vec4(52.4616356, 32.0598869, 240.449173, 360.673737);
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0 = u_xlat16_0 * vec4(1.0, 1.0, 0.800000012, 0.200000003);
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_4.xyz = u_xlat0.xyz * vec3(1.25, 1.25, 1.25);
    u_xlat16_2 = dot(u_xlat16_4.xyz, vec3(1.0, 1.0, 1.0));
    SV_Target0.xyz = u_xlat16_4.xyz * _TintColor.xyz;
    u_xlat0.x = vs_TEXCOORD0.z / _Height;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = u_xlat0.x * 0.300000012;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    SV_Target0.w = u_xlat0.x * _TintColor.w;
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