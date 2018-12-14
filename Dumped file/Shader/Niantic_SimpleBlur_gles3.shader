Shader "Niantic/SimpleBlur" {
Properties {
_MainTex ("Base (RGB)", 2D) = "" { }
_Offsets ("Texel Offsets", Vector) = (0.0035,0.0035,0.0035,0.0035)
_Kernel ("Kernel", Float) = 0.15
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 17982
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD1 = u_xlat0.zyxw;
    vs_TEXCOORD2 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat5;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat2 * _Kernel;
    u_xlat1 = u_xlat10_1 * vec4(u_xlat2);
    u_xlat5 = (-u_xlat2) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat5) * u_xlat10_0 + u_xlat1;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.zw);
    u_xlat0 = vec4(u_xlat2) * u_xlat10_1 + u_xlat0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = vec4(u_xlat2) * u_xlat10_1 + u_xlat0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat2) * u_xlat10_1 + u_xlat0;
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
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD1 = u_xlat0.zyxw;
    vs_TEXCOORD2 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat5;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat2 * _Kernel;
    u_xlat1 = u_xlat10_1 * vec4(u_xlat2);
    u_xlat5 = (-u_xlat2) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat5) * u_xlat10_0 + u_xlat1;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.zw);
    u_xlat0 = vec4(u_xlat2) * u_xlat10_1 + u_xlat0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = vec4(u_xlat2) * u_xlat10_1 + u_xlat0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat2) * u_xlat10_1 + u_xlat0;
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
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD1 = u_xlat0.zyxw;
    vs_TEXCOORD2 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat5;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat2 * _Kernel;
    u_xlat1 = u_xlat10_1 * vec4(u_xlat2);
    u_xlat5 = (-u_xlat2) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat5) * u_xlat10_0 + u_xlat1;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.zw);
    u_xlat0 = vec4(u_xlat2) * u_xlat10_1 + u_xlat0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = vec4(u_xlat2) * u_xlat10_1 + u_xlat0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat2) * u_xlat10_1 + u_xlat0;
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