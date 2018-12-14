Shader "Holo/Distort" {
Properties {
_Color ("    Color", Color) = (1,1,1,1)
_RefractionAmount ("Refraction Amount", Float) = 100
}
SubShader {
 LOD 400
 Tags { "QUEUE" = "Transparent" "RenderType" = "Opaque" }
 GrabPass {
}
 Pass {
  Name "FORWARD"
  LOD 400
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
  GpuProgramID 5065
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _RefractionAmount;
uniform 	vec2 _GrabTexture_TexelSize;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD0.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].yxz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xzy * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xzy;
    u_xlat1.y = u_xlat3.x;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat4.xyz;
    u_xlat1.z = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat3.x = u_xlat0.z;
    u_xlat0.y = u_xlat3.z;
    u_xlat0.z = u_xlat4.y;
    u_xlat3.z = u_xlat4.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_5.xy = u_xlat0.zz * u_xlat0.xy;
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(_RefractionAmount);
    u_xlat16_5.xy = u_xlat16_5.xy * in_COLOR0.ww;
    u_xlat0.xy = u_xlat16_5.xy * _GrabTexture_TexelSize.xy;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GrabTexture;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat16_1.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.xy = -abs(u_xlat16_1.xy) + vec2(0.5, 0.5);
    u_xlat16_1.xy = u_xlat16_1.xy + u_xlat16_1.xy;
    u_xlat16_1.xy = max(u_xlat16_1.xy, vec2(0.0, 0.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_5.xy = u_xlat16_1.xy * u_xlat16_1.xy;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_5.xy;
    u_xlat16_1.xy = (-u_xlat16_1.xy) * u_xlat16_5.xy + vec2(1.0, 1.0);
    u_xlat16_4.xy = vs_TEXCOORD3.xy / vs_TEXCOORD2.ww;
    u_xlat1.xy = (-u_xlat16_4.xy) * u_xlat16_1.xy + u_xlat16_0.xy;
    u_xlat10_0 = texture(_GrabTexture, u_xlat1.xy);
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _RefractionAmount;
uniform 	vec2 _GrabTexture_TexelSize;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD0.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].yxz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xzy * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xzy;
    u_xlat1.y = u_xlat3.x;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat4.xyz;
    u_xlat1.z = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat3.x = u_xlat0.z;
    u_xlat0.y = u_xlat3.z;
    u_xlat0.z = u_xlat4.y;
    u_xlat3.z = u_xlat4.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_5.xy = u_xlat0.zz * u_xlat0.xy;
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(_RefractionAmount);
    u_xlat16_5.xy = u_xlat16_5.xy * in_COLOR0.ww;
    u_xlat0.xy = u_xlat16_5.xy * _GrabTexture_TexelSize.xy;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GrabTexture;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat16_1.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.xy = -abs(u_xlat16_1.xy) + vec2(0.5, 0.5);
    u_xlat16_1.xy = u_xlat16_1.xy + u_xlat16_1.xy;
    u_xlat16_1.xy = max(u_xlat16_1.xy, vec2(0.0, 0.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_5.xy = u_xlat16_1.xy * u_xlat16_1.xy;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_5.xy;
    u_xlat16_1.xy = (-u_xlat16_1.xy) * u_xlat16_5.xy + vec2(1.0, 1.0);
    u_xlat16_4.xy = vs_TEXCOORD3.xy / vs_TEXCOORD2.ww;
    u_xlat1.xy = (-u_xlat16_4.xy) * u_xlat16_1.xy + u_xlat16_0.xy;
    u_xlat10_0 = texture(_GrabTexture, u_xlat1.xy);
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _RefractionAmount;
uniform 	vec2 _GrabTexture_TexelSize;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD0.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].yxz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xzy * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xzy;
    u_xlat1.y = u_xlat3.x;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat4.xyz;
    u_xlat1.z = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat3.x = u_xlat0.z;
    u_xlat0.y = u_xlat3.z;
    u_xlat0.z = u_xlat4.y;
    u_xlat3.z = u_xlat4.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_5.xy = u_xlat0.zz * u_xlat0.xy;
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(_RefractionAmount);
    u_xlat16_5.xy = u_xlat16_5.xy * in_COLOR0.ww;
    u_xlat0.xy = u_xlat16_5.xy * _GrabTexture_TexelSize.xy;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GrabTexture;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat16_1.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.xy = -abs(u_xlat16_1.xy) + vec2(0.5, 0.5);
    u_xlat16_1.xy = u_xlat16_1.xy + u_xlat16_1.xy;
    u_xlat16_1.xy = max(u_xlat16_1.xy, vec2(0.0, 0.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_5.xy = u_xlat16_1.xy * u_xlat16_1.xy;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_5.xy;
    u_xlat16_1.xy = (-u_xlat16_1.xy) * u_xlat16_5.xy + vec2(1.0, 1.0);
    u_xlat16_4.xy = vs_TEXCOORD3.xy / vs_TEXCOORD2.ww;
    u_xlat1.xy = (-u_xlat16_4.xy) * u_xlat16_1.xy + u_xlat16_0.xy;
    u_xlat10_0 = texture(_GrabTexture, u_xlat1.xy);
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _RefractionAmount;
uniform 	vec2 _GrabTexture_TexelSize;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD0.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].yxz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xzy * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xzy;
    u_xlat1.y = u_xlat3.x;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat4.xyz;
    u_xlat1.z = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat3.x = u_xlat0.z;
    u_xlat0.y = u_xlat3.z;
    u_xlat0.z = u_xlat4.y;
    u_xlat3.z = u_xlat4.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_5.xy = u_xlat0.zz * u_xlat0.xy;
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(_RefractionAmount);
    u_xlat16_5.xy = u_xlat16_5.xy * in_COLOR0.ww;
    u_xlat0.xy = u_xlat16_5.xy * _GrabTexture_TexelSize.xy;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GrabTexture;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat16_1.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.xy = -abs(u_xlat16_1.xy) + vec2(0.5, 0.5);
    u_xlat16_1.xy = u_xlat16_1.xy + u_xlat16_1.xy;
    u_xlat16_1.xy = max(u_xlat16_1.xy, vec2(0.0, 0.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_5.xy = u_xlat16_1.xy * u_xlat16_1.xy;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_5.xy;
    u_xlat16_1.xy = (-u_xlat16_1.xy) * u_xlat16_5.xy + vec2(1.0, 1.0);
    u_xlat16_4.xy = vs_TEXCOORD3.xy / vs_TEXCOORD2.ww;
    u_xlat1.xy = (-u_xlat16_4.xy) * u_xlat16_1.xy + u_xlat16_0.xy;
    u_xlat10_0 = texture(_GrabTexture, u_xlat1.xy);
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _RefractionAmount;
uniform 	vec2 _GrabTexture_TexelSize;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD0.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].yxz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xzy * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xzy;
    u_xlat1.y = u_xlat3.x;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat4.xyz;
    u_xlat1.z = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat3.x = u_xlat0.z;
    u_xlat0.y = u_xlat3.z;
    u_xlat0.z = u_xlat4.y;
    u_xlat3.z = u_xlat4.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_5.xy = u_xlat0.zz * u_xlat0.xy;
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(_RefractionAmount);
    u_xlat16_5.xy = u_xlat16_5.xy * in_COLOR0.ww;
    u_xlat0.xy = u_xlat16_5.xy * _GrabTexture_TexelSize.xy;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GrabTexture;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat16_1.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.xy = -abs(u_xlat16_1.xy) + vec2(0.5, 0.5);
    u_xlat16_1.xy = u_xlat16_1.xy + u_xlat16_1.xy;
    u_xlat16_1.xy = max(u_xlat16_1.xy, vec2(0.0, 0.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_5.xy = u_xlat16_1.xy * u_xlat16_1.xy;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_5.xy;
    u_xlat16_1.xy = (-u_xlat16_1.xy) * u_xlat16_5.xy + vec2(1.0, 1.0);
    u_xlat16_4.xy = vs_TEXCOORD3.xy / vs_TEXCOORD2.ww;
    u_xlat1.xy = (-u_xlat16_4.xy) * u_xlat16_1.xy + u_xlat16_0.xy;
    u_xlat10_0 = texture(_GrabTexture, u_xlat1.xy);
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _RefractionAmount;
uniform 	vec2 _GrabTexture_TexelSize;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat18 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * in_NORMAL0.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD0.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].yxz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xzy * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xzy;
    u_xlat1.y = u_xlat3.x;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat4.xyz;
    u_xlat1.z = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat3.x = u_xlat0.z;
    u_xlat0.y = u_xlat3.z;
    u_xlat0.z = u_xlat4.y;
    u_xlat3.z = u_xlat4.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_5.xy = u_xlat0.zz * u_xlat0.xy;
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(_RefractionAmount);
    u_xlat16_5.xy = u_xlat16_5.xy * in_COLOR0.ww;
    u_xlat0.xy = u_xlat16_5.xy * _GrabTexture_TexelSize.xy;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GrabTexture;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat16_1.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.xy = -abs(u_xlat16_1.xy) + vec2(0.5, 0.5);
    u_xlat16_1.xy = u_xlat16_1.xy + u_xlat16_1.xy;
    u_xlat16_1.xy = max(u_xlat16_1.xy, vec2(0.0, 0.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_5.xy = u_xlat16_1.xy * u_xlat16_1.xy;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_5.xy;
    u_xlat16_1.xy = (-u_xlat16_1.xy) * u_xlat16_5.xy + vec2(1.0, 1.0);
    u_xlat16_4.xy = vs_TEXCOORD3.xy / vs_TEXCOORD2.ww;
    u_xlat1.xy = (-u_xlat16_4.xy) * u_xlat16_1.xy + u_xlat16_0.xy;
    u_xlat10_0 = texture(_GrabTexture, u_xlat1.xy);
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = u_xlat10_0.w;
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
}
}
}
CustomEditor "CustomMaterialInspector"
}