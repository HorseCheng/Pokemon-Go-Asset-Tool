Shader "Hidden/Internal-CombineDepthNormals" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 249
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _CameraNormalsTexture_ST;
in highp vec4 in_POSITION0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNormalsTexture_ST.xy + _CameraNormalsTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CameraNormalsTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
bool u_xlatb3;
float u_xlat4;
void main()
{
    u_xlat10_0.xyz = texture(_CameraNormalsTexture, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_0.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat16_0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat16_0.zzz + u_xlat0.xyw;
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat0.xy = u_xlat0.xy / vec2(u_xlat4);
    u_xlat0.xy = u_xlat0.xy * vec2(0.281262308, 0.281262308) + vec2(0.5, 0.5);
    u_xlat1.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat1.x = _ZBufferParams.x * u_xlat1.x + _ZBufferParams.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.x<0.999984622);
#else
    u_xlatb3 = u_xlat1.x<0.999984622;
#endif
    u_xlat1.xz = u_xlat1.xx * vec2(1.0, 255.0);
    u_xlat1.xz = fract(u_xlat1.xz);
    u_xlat0.z = (-u_xlat1.z) * 0.00392156886 + u_xlat1.x;
    u_xlat0.w = u_xlat1.z;
    u_xlat0 = (bool(u_xlatb3)) ? u_xlat0 : vec4(0.5, 0.5, 1.0, 1.0);
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
uniform 	vec4 _CameraNormalsTexture_ST;
in highp vec4 in_POSITION0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNormalsTexture_ST.xy + _CameraNormalsTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CameraNormalsTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
bool u_xlatb3;
float u_xlat4;
void main()
{
    u_xlat10_0.xyz = texture(_CameraNormalsTexture, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_0.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat16_0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat16_0.zzz + u_xlat0.xyw;
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat0.xy = u_xlat0.xy / vec2(u_xlat4);
    u_xlat0.xy = u_xlat0.xy * vec2(0.281262308, 0.281262308) + vec2(0.5, 0.5);
    u_xlat1.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat1.x = _ZBufferParams.x * u_xlat1.x + _ZBufferParams.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.x<0.999984622);
#else
    u_xlatb3 = u_xlat1.x<0.999984622;
#endif
    u_xlat1.xz = u_xlat1.xx * vec2(1.0, 255.0);
    u_xlat1.xz = fract(u_xlat1.xz);
    u_xlat0.z = (-u_xlat1.z) * 0.00392156886 + u_xlat1.x;
    u_xlat0.w = u_xlat1.z;
    u_xlat0 = (bool(u_xlatb3)) ? u_xlat0 : vec4(0.5, 0.5, 1.0, 1.0);
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
uniform 	vec4 _CameraNormalsTexture_ST;
in highp vec4 in_POSITION0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNormalsTexture_ST.xy + _CameraNormalsTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CameraNormalsTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
bool u_xlatb3;
float u_xlat4;
void main()
{
    u_xlat10_0.xyz = texture(_CameraNormalsTexture, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_0.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat16_0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat16_0.zzz + u_xlat0.xyw;
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat0.xy = u_xlat0.xy / vec2(u_xlat4);
    u_xlat0.xy = u_xlat0.xy * vec2(0.281262308, 0.281262308) + vec2(0.5, 0.5);
    u_xlat1.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat1.x = _ZBufferParams.x * u_xlat1.x + _ZBufferParams.y;
    u_xlat1.x = float(1.0) / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat1.x<0.999984622);
#else
    u_xlatb3 = u_xlat1.x<0.999984622;
#endif
    u_xlat1.xz = u_xlat1.xx * vec2(1.0, 255.0);
    u_xlat1.xz = fract(u_xlat1.xz);
    u_xlat0.z = (-u_xlat1.z) * 0.00392156886 + u_xlat1.x;
    u_xlat0.w = u_xlat1.z;
    u_xlat0 = (bool(u_xlatb3)) ? u_xlat0 : vec4(0.5, 0.5, 1.0, 1.0);
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