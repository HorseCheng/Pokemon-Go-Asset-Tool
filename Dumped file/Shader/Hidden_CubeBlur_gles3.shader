Shader "Hidden/CubeBlur" {
Properties {
_MainTex ("Main", Cube) = "" { }
_Texel ("Texel", Float) = 0.0078125
_Level ("Level", Float) = 0
_Scale ("Scale", Float) = 1
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 25931
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Level;
uniform 	mediump float _Texel;
uniform 	mediump float _Scale;
uniform lowp samplerCube _MainTex;
in mediump vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_7;
mediump vec4 u_xlat16_8;
lowp vec4 u_xlat10_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec4 u_xlat16_12;
lowp vec4 u_xlat10_12;
mediump vec4 u_xlat16_13;
lowp vec4 u_xlat10_13;
mediump vec4 u_xlat16_14;
lowp vec4 u_xlat10_14;
mediump vec4 u_xlat16_15;
lowp vec4 u_xlat10_15;
mediump vec3 u_xlat16_16;
mediump vec3 u_xlat16_17;
mediump float u_xlat16_34;
mediump float u_xlat16_51;
mediump float u_xlat16_53;
void main()
{
    u_xlat16_0.x = _Scale;
    u_xlat16_0.y = float(3.0);
    u_xlat16_0.z = float(5.0);
    u_xlatb1.xyz = equal(abs(vs_TEXCOORD0.xyzx), vec4(1.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat16_2.x = (u_xlatb1.x) ? vs_TEXCOORD0.x : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? vs_TEXCOORD0.y : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? vs_TEXCOORD0.z : float(0.0);
    u_xlat16_3.xyz = -abs(u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD0.xyz;
    u_xlat16_51 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_51 = u_xlat16_51 + 1.0;
    u_xlat16_51 = sqrt(u_xlat16_51);
    u_xlat16_51 = float(1.0) / u_xlat16_51;
    u_xlat16_53 = u_xlat16_51 * u_xlat16_51;
    u_xlat16_3.x = u_xlat16_51 * u_xlat16_53;
    u_xlat16_3.yz = u_xlat16_3.xx * vec2(vec2(_Scale, _Scale));
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_0.zzz * u_xlat16_0.xyz;
    u_xlat16_4.xyz = u_xlat16_2.zxy * vec3(vec3(_Texel, _Texel, _Texel));
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) * vec3(1.5, 1.5, 1.5) + vs_TEXCOORD0.xyz;
    u_xlat16_6.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + u_xlat16_5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_6.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_7.xyz = min(u_xlat16_7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + (-u_xlat16_7.xyz);
    u_xlat16_51 = max(abs(u_xlat16_6.y), abs(u_xlat16_6.x));
    u_xlat16_51 = max(abs(u_xlat16_6.z), u_xlat16_51);
    u_xlat16_6.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat10_1 = textureLod(_MainTex, u_xlat16_6.xyz, _Level);
    u_xlat16_1 = max(u_xlat10_1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(1.5, 1.5, 1.5) + vs_TEXCOORD0.xyz;
    u_xlat16_7.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + u_xlat16_6.xyz;
    u_xlat16_8.xyz = max(u_xlat16_7.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_8.xyz = min(u_xlat16_8.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_51 = max(abs(u_xlat16_7.y), abs(u_xlat16_7.x));
    u_xlat16_51 = max(abs(u_xlat16_7.z), u_xlat16_51);
    u_xlat16_7.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_8.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_7.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_1 = u_xlat16_1 + u_xlat16_7;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.yyyy;
    u_xlat16_8.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + vs_TEXCOORD0.xyz;
    u_xlat16_9.xyz = max(u_xlat16_8.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-u_xlat16_9.xyz);
    u_xlat16_51 = max(abs(u_xlat16_8.y), abs(u_xlat16_8.x));
    u_xlat16_51 = max(abs(u_xlat16_8.z), u_xlat16_51);
    u_xlat16_8.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_8.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_8.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_9.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_3.xxxx * u_xlat16_7 + u_xlat16_1;
    u_xlat16_9.xyz = (-u_xlat16_4.xyz) * vec3(2.5, 2.5, 2.5) + vs_TEXCOORD0.xyz;
    u_xlat16_10.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + u_xlat16_9.xyz;
    u_xlat16_11.xyz = max(u_xlat16_10.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_11.xyz = min(u_xlat16_11.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_10.xyz = u_xlat16_10.xyz + (-u_xlat16_11.xyz);
    u_xlat16_51 = max(abs(u_xlat16_10.y), abs(u_xlat16_10.x));
    u_xlat16_51 = max(abs(u_xlat16_10.z), u_xlat16_51);
    u_xlat16_10.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_11.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_10.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * vec3(2.5, 2.5, 2.5) + vs_TEXCOORD0.xyz;
    u_xlat16_11.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + u_xlat16_10.xyz;
    u_xlat16_12.xyz = max(u_xlat16_11.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_12.xyz = min(u_xlat16_12.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_11.xyz = u_xlat16_11.xyz + (-u_xlat16_12.xyz);
    u_xlat16_51 = max(abs(u_xlat16_11.y), abs(u_xlat16_11.x));
    u_xlat16_51 = max(abs(u_xlat16_11.z), u_xlat16_51);
    u_xlat16_11.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_12.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_11.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_3.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_11.xyz = u_xlat16_0.yyy * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_0.xyz;
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + u_xlat16_10.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + u_xlat16_9.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_11.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + u_xlat16_6.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + u_xlat16_5.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_11.yyyy;
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + vs_TEXCOORD0.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_12.xyz;
    u_xlat16_12.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat16_12.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_8 = u_xlat16_8 + u_xlat16_12;
    u_xlat16_7 = u_xlat16_11.xxxx * u_xlat16_8 + u_xlat16_7;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_7;
    u_xlat16_13.xyz = max(u_xlat16_9.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_9.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_14.y), abs(u_xlat16_14.x));
    u_xlat16_51 = max(abs(u_xlat16_14.z), u_xlat16_51);
    u_xlat16_13.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_14.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_13.xyz = max(u_xlat16_10.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_10.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_14.y), abs(u_xlat16_14.x));
    u_xlat16_51 = max(abs(u_xlat16_14.z), u_xlat16_51);
    u_xlat16_13.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_14.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_12;
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_8 = u_xlat16_8 + u_xlat16_12;
    u_xlat16_1 = u_xlat16_0.zzzz * u_xlat16_8 + u_xlat16_1;
    u_xlat16_13.xyz = max(u_xlat16_5.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_5.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_14.y), abs(u_xlat16_14.x));
    u_xlat16_51 = max(abs(u_xlat16_14.z), u_xlat16_51);
    u_xlat16_13.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_14.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_13.xyz = max(u_xlat16_6.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_6.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_14.y), abs(u_xlat16_14.x));
    u_xlat16_51 = max(abs(u_xlat16_14.z), u_xlat16_51);
    u_xlat16_13.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_14.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat10_13 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_13 = max(u_xlat10_13, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_8 = u_xlat16_8 + u_xlat16_13;
    u_xlat16_8 = u_xlat16_0.yyyy * u_xlat16_8;
    u_xlat10_13 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_13 = max(u_xlat10_13, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_12 = u_xlat16_12 + u_xlat16_13;
    u_xlat16_12 = u_xlat16_0.yyyy * u_xlat16_12;
    u_xlat16_14.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + vs_TEXCOORD0.xyz;
    u_xlat16_15.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_14.xyz;
    u_xlat10_13 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_13 = max(u_xlat10_13, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_14 = textureLod(_MainTex, u_xlat16_15.xyz, _Level);
    u_xlat16_14 = max(u_xlat10_14, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_15.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + vs_TEXCOORD0.xyz;
    u_xlat16_16.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_15.xyz;
    u_xlat16_15.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_15.xyz;
    u_xlat10_15 = textureLod(_MainTex, u_xlat16_15.xyz, _Level);
    u_xlat16_15 = max(u_xlat10_15, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_13 = u_xlat16_13 + u_xlat16_15;
    u_xlat16_8 = u_xlat16_0.xxxx * u_xlat16_13 + u_xlat16_8;
    u_xlat10_13 = textureLod(_MainTex, u_xlat16_16.xyz, _Level);
    u_xlat16_13 = max(u_xlat10_13, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_13 = u_xlat16_13 + u_xlat16_14;
    u_xlat16_12 = u_xlat16_0.xxxx * u_xlat16_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_12;
    u_xlat16_1 = u_xlat16_0.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, vec3(2.0, 2.0, 2.0));
    u_xlat16_1 = u_xlat16_8 + u_xlat16_1;
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + u_xlat16_9.xyz;
    u_xlat16_9.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + u_xlat16_9.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + u_xlat16_10.xyz;
    u_xlat16_10.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + u_xlat16_10.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_11.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + u_xlat16_5.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + u_xlat16_6.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_11.yyyy;
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + vs_TEXCOORD0.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat16_16.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat16_17.xyz;
    u_xlat16_17.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_17.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_16.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_8 = u_xlat16_8 + u_xlat16_12;
    u_xlat16_7 = u_xlat16_11.xxxx * u_xlat16_8 + u_xlat16_7;
    u_xlat16_17.x = dot(u_xlat16_11.xyz, vec3(2.0, 2.0, 2.0));
    u_xlat16_1 = u_xlat16_1 + u_xlat16_7;
    u_xlat16_11.xyz = max(u_xlat16_10.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_11.xyz = min(u_xlat16_11.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_10.xyz = u_xlat16_10.xyz + (-u_xlat16_11.xyz);
    u_xlat16_34 = max(abs(u_xlat16_10.y), abs(u_xlat16_10.x));
    u_xlat16_34 = max(abs(u_xlat16_10.z), u_xlat16_34);
    u_xlat16_10.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_11.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_10.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_10.xyz = max(u_xlat16_9.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-u_xlat16_10.xyz);
    u_xlat16_34 = max(abs(u_xlat16_9.y), abs(u_xlat16_9.x));
    u_xlat16_34 = max(abs(u_xlat16_9.z), u_xlat16_34);
    u_xlat16_9.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_10.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_9.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_3.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_9.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + vs_TEXCOORD0.xyz;
    u_xlat16_10.xyz = max(u_xlat16_9.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-u_xlat16_10.xyz);
    u_xlat16_34 = max(abs(u_xlat16_9.y), abs(u_xlat16_9.x));
    u_xlat16_34 = max(abs(u_xlat16_9.z), u_xlat16_34);
    u_xlat16_9.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_10.xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_9.xyz;
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat16_9.xyz;
    u_xlat10_4 = textureLod(_MainTex, u_xlat16_4.xyz, _Level);
    u_xlat16_4 = max(u_xlat10_4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_10.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_4 = u_xlat16_4 + u_xlat16_7;
    u_xlat16_9.xyz = max(u_xlat16_6.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + (-u_xlat16_9.xyz);
    u_xlat16_34 = max(abs(u_xlat16_6.y), abs(u_xlat16_6.x));
    u_xlat16_34 = max(abs(u_xlat16_6.z), u_xlat16_34);
    u_xlat16_6.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_9.xyz;
    u_xlat10_6 = textureLod(_MainTex, u_xlat16_6.xyz, _Level);
    u_xlat16_6 = max(u_xlat10_6, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_9.xyz = max(u_xlat16_5.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz + (-u_xlat16_9.xyz);
    u_xlat16_34 = max(abs(u_xlat16_5.y), abs(u_xlat16_5.x));
    u_xlat16_34 = max(abs(u_xlat16_5.z), u_xlat16_34);
    u_xlat16_2.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_9.xyz;
    u_xlat10_2 = textureLod(_MainTex, u_xlat16_2.xyz, _Level);
    u_xlat16_2 = max(u_xlat10_2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_2 = u_xlat16_2 + u_xlat16_6;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_3.yyyy;
    u_xlat16_2 = u_xlat16_3.xxxx * u_xlat16_4 + u_xlat16_2;
    u_xlat16_34 = dot(u_xlat16_3.xyz, vec3(2.0, 2.0, 2.0));
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_51 = u_xlat16_17.x + u_xlat16_34;
    u_xlat16_0.x = u_xlat16_0.x * 2.0 + u_xlat16_51;
    u_xlat16_0.x = u_xlat16_17.x + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_34 + u_xlat16_0.x;
    SV_Target0 = u_xlat16_1 / u_xlat16_0.xxxx;
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
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Level;
uniform 	mediump float _Texel;
uniform 	mediump float _Scale;
uniform lowp samplerCube _MainTex;
in mediump vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_7;
mediump vec4 u_xlat16_8;
lowp vec4 u_xlat10_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec4 u_xlat16_12;
lowp vec4 u_xlat10_12;
mediump vec4 u_xlat16_13;
lowp vec4 u_xlat10_13;
mediump vec4 u_xlat16_14;
lowp vec4 u_xlat10_14;
mediump vec4 u_xlat16_15;
lowp vec4 u_xlat10_15;
mediump vec3 u_xlat16_16;
mediump vec3 u_xlat16_17;
mediump float u_xlat16_34;
mediump float u_xlat16_51;
mediump float u_xlat16_53;
void main()
{
    u_xlat16_0.x = _Scale;
    u_xlat16_0.y = float(3.0);
    u_xlat16_0.z = float(5.0);
    u_xlatb1.xyz = equal(abs(vs_TEXCOORD0.xyzx), vec4(1.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat16_2.x = (u_xlatb1.x) ? vs_TEXCOORD0.x : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? vs_TEXCOORD0.y : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? vs_TEXCOORD0.z : float(0.0);
    u_xlat16_3.xyz = -abs(u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD0.xyz;
    u_xlat16_51 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_51 = u_xlat16_51 + 1.0;
    u_xlat16_51 = sqrt(u_xlat16_51);
    u_xlat16_51 = float(1.0) / u_xlat16_51;
    u_xlat16_53 = u_xlat16_51 * u_xlat16_51;
    u_xlat16_3.x = u_xlat16_51 * u_xlat16_53;
    u_xlat16_3.yz = u_xlat16_3.xx * vec2(vec2(_Scale, _Scale));
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_0.zzz * u_xlat16_0.xyz;
    u_xlat16_4.xyz = u_xlat16_2.zxy * vec3(vec3(_Texel, _Texel, _Texel));
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) * vec3(1.5, 1.5, 1.5) + vs_TEXCOORD0.xyz;
    u_xlat16_6.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + u_xlat16_5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_6.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_7.xyz = min(u_xlat16_7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + (-u_xlat16_7.xyz);
    u_xlat16_51 = max(abs(u_xlat16_6.y), abs(u_xlat16_6.x));
    u_xlat16_51 = max(abs(u_xlat16_6.z), u_xlat16_51);
    u_xlat16_6.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat10_1 = textureLod(_MainTex, u_xlat16_6.xyz, _Level);
    u_xlat16_1 = max(u_xlat10_1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(1.5, 1.5, 1.5) + vs_TEXCOORD0.xyz;
    u_xlat16_7.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + u_xlat16_6.xyz;
    u_xlat16_8.xyz = max(u_xlat16_7.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_8.xyz = min(u_xlat16_8.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_51 = max(abs(u_xlat16_7.y), abs(u_xlat16_7.x));
    u_xlat16_51 = max(abs(u_xlat16_7.z), u_xlat16_51);
    u_xlat16_7.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_8.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_7.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_1 = u_xlat16_1 + u_xlat16_7;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.yyyy;
    u_xlat16_8.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + vs_TEXCOORD0.xyz;
    u_xlat16_9.xyz = max(u_xlat16_8.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-u_xlat16_9.xyz);
    u_xlat16_51 = max(abs(u_xlat16_8.y), abs(u_xlat16_8.x));
    u_xlat16_51 = max(abs(u_xlat16_8.z), u_xlat16_51);
    u_xlat16_8.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_8.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_8.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_9.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_3.xxxx * u_xlat16_7 + u_xlat16_1;
    u_xlat16_9.xyz = (-u_xlat16_4.xyz) * vec3(2.5, 2.5, 2.5) + vs_TEXCOORD0.xyz;
    u_xlat16_10.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + u_xlat16_9.xyz;
    u_xlat16_11.xyz = max(u_xlat16_10.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_11.xyz = min(u_xlat16_11.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_10.xyz = u_xlat16_10.xyz + (-u_xlat16_11.xyz);
    u_xlat16_51 = max(abs(u_xlat16_10.y), abs(u_xlat16_10.x));
    u_xlat16_51 = max(abs(u_xlat16_10.z), u_xlat16_51);
    u_xlat16_10.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_11.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_10.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * vec3(2.5, 2.5, 2.5) + vs_TEXCOORD0.xyz;
    u_xlat16_11.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + u_xlat16_10.xyz;
    u_xlat16_12.xyz = max(u_xlat16_11.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_12.xyz = min(u_xlat16_12.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_11.xyz = u_xlat16_11.xyz + (-u_xlat16_12.xyz);
    u_xlat16_51 = max(abs(u_xlat16_11.y), abs(u_xlat16_11.x));
    u_xlat16_51 = max(abs(u_xlat16_11.z), u_xlat16_51);
    u_xlat16_11.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_12.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_11.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_3.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_11.xyz = u_xlat16_0.yyy * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_0.xyz;
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + u_xlat16_10.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + u_xlat16_9.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_11.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + u_xlat16_6.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + u_xlat16_5.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_11.yyyy;
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + vs_TEXCOORD0.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_12.xyz;
    u_xlat16_12.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat16_12.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_8 = u_xlat16_8 + u_xlat16_12;
    u_xlat16_7 = u_xlat16_11.xxxx * u_xlat16_8 + u_xlat16_7;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_7;
    u_xlat16_13.xyz = max(u_xlat16_9.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_9.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_14.y), abs(u_xlat16_14.x));
    u_xlat16_51 = max(abs(u_xlat16_14.z), u_xlat16_51);
    u_xlat16_13.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_14.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_13.xyz = max(u_xlat16_10.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_10.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_14.y), abs(u_xlat16_14.x));
    u_xlat16_51 = max(abs(u_xlat16_14.z), u_xlat16_51);
    u_xlat16_13.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_14.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_12;
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_8 = u_xlat16_8 + u_xlat16_12;
    u_xlat16_1 = u_xlat16_0.zzzz * u_xlat16_8 + u_xlat16_1;
    u_xlat16_13.xyz = max(u_xlat16_5.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_5.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_14.y), abs(u_xlat16_14.x));
    u_xlat16_51 = max(abs(u_xlat16_14.z), u_xlat16_51);
    u_xlat16_13.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_14.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_13.xyz = max(u_xlat16_6.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_6.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_14.y), abs(u_xlat16_14.x));
    u_xlat16_51 = max(abs(u_xlat16_14.z), u_xlat16_51);
    u_xlat16_13.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_14.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat10_13 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_13 = max(u_xlat10_13, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_8 = u_xlat16_8 + u_xlat16_13;
    u_xlat16_8 = u_xlat16_0.yyyy * u_xlat16_8;
    u_xlat10_13 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_13 = max(u_xlat10_13, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_12 = u_xlat16_12 + u_xlat16_13;
    u_xlat16_12 = u_xlat16_0.yyyy * u_xlat16_12;
    u_xlat16_14.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + vs_TEXCOORD0.xyz;
    u_xlat16_15.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_14.xyz;
    u_xlat10_13 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_13 = max(u_xlat10_13, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_14 = textureLod(_MainTex, u_xlat16_15.xyz, _Level);
    u_xlat16_14 = max(u_xlat10_14, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_15.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + vs_TEXCOORD0.xyz;
    u_xlat16_16.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_15.xyz;
    u_xlat16_15.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_15.xyz;
    u_xlat10_15 = textureLod(_MainTex, u_xlat16_15.xyz, _Level);
    u_xlat16_15 = max(u_xlat10_15, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_13 = u_xlat16_13 + u_xlat16_15;
    u_xlat16_8 = u_xlat16_0.xxxx * u_xlat16_13 + u_xlat16_8;
    u_xlat10_13 = textureLod(_MainTex, u_xlat16_16.xyz, _Level);
    u_xlat16_13 = max(u_xlat10_13, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_13 = u_xlat16_13 + u_xlat16_14;
    u_xlat16_12 = u_xlat16_0.xxxx * u_xlat16_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_12;
    u_xlat16_1 = u_xlat16_0.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, vec3(2.0, 2.0, 2.0));
    u_xlat16_1 = u_xlat16_8 + u_xlat16_1;
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + u_xlat16_9.xyz;
    u_xlat16_9.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + u_xlat16_9.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + u_xlat16_10.xyz;
    u_xlat16_10.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + u_xlat16_10.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_11.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + u_xlat16_5.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + u_xlat16_6.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_11.yyyy;
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + vs_TEXCOORD0.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat16_16.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat16_17.xyz;
    u_xlat16_17.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_17.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_16.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_8 = u_xlat16_8 + u_xlat16_12;
    u_xlat16_7 = u_xlat16_11.xxxx * u_xlat16_8 + u_xlat16_7;
    u_xlat16_17.x = dot(u_xlat16_11.xyz, vec3(2.0, 2.0, 2.0));
    u_xlat16_1 = u_xlat16_1 + u_xlat16_7;
    u_xlat16_11.xyz = max(u_xlat16_10.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_11.xyz = min(u_xlat16_11.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_10.xyz = u_xlat16_10.xyz + (-u_xlat16_11.xyz);
    u_xlat16_34 = max(abs(u_xlat16_10.y), abs(u_xlat16_10.x));
    u_xlat16_34 = max(abs(u_xlat16_10.z), u_xlat16_34);
    u_xlat16_10.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_11.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_10.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_10.xyz = max(u_xlat16_9.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-u_xlat16_10.xyz);
    u_xlat16_34 = max(abs(u_xlat16_9.y), abs(u_xlat16_9.x));
    u_xlat16_34 = max(abs(u_xlat16_9.z), u_xlat16_34);
    u_xlat16_9.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_10.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_9.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_3.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_9.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + vs_TEXCOORD0.xyz;
    u_xlat16_10.xyz = max(u_xlat16_9.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-u_xlat16_10.xyz);
    u_xlat16_34 = max(abs(u_xlat16_9.y), abs(u_xlat16_9.x));
    u_xlat16_34 = max(abs(u_xlat16_9.z), u_xlat16_34);
    u_xlat16_9.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_10.xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_9.xyz;
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat16_9.xyz;
    u_xlat10_4 = textureLod(_MainTex, u_xlat16_4.xyz, _Level);
    u_xlat16_4 = max(u_xlat10_4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_10.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_4 = u_xlat16_4 + u_xlat16_7;
    u_xlat16_9.xyz = max(u_xlat16_6.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + (-u_xlat16_9.xyz);
    u_xlat16_34 = max(abs(u_xlat16_6.y), abs(u_xlat16_6.x));
    u_xlat16_34 = max(abs(u_xlat16_6.z), u_xlat16_34);
    u_xlat16_6.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_9.xyz;
    u_xlat10_6 = textureLod(_MainTex, u_xlat16_6.xyz, _Level);
    u_xlat16_6 = max(u_xlat10_6, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_9.xyz = max(u_xlat16_5.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz + (-u_xlat16_9.xyz);
    u_xlat16_34 = max(abs(u_xlat16_5.y), abs(u_xlat16_5.x));
    u_xlat16_34 = max(abs(u_xlat16_5.z), u_xlat16_34);
    u_xlat16_2.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_9.xyz;
    u_xlat10_2 = textureLod(_MainTex, u_xlat16_2.xyz, _Level);
    u_xlat16_2 = max(u_xlat10_2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_2 = u_xlat16_2 + u_xlat16_6;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_3.yyyy;
    u_xlat16_2 = u_xlat16_3.xxxx * u_xlat16_4 + u_xlat16_2;
    u_xlat16_34 = dot(u_xlat16_3.xyz, vec3(2.0, 2.0, 2.0));
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_51 = u_xlat16_17.x + u_xlat16_34;
    u_xlat16_0.x = u_xlat16_0.x * 2.0 + u_xlat16_51;
    u_xlat16_0.x = u_xlat16_17.x + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_34 + u_xlat16_0.x;
    SV_Target0 = u_xlat16_1 / u_xlat16_0.xxxx;
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
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Level;
uniform 	mediump float _Texel;
uniform 	mediump float _Scale;
uniform lowp samplerCube _MainTex;
in mediump vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_7;
mediump vec4 u_xlat16_8;
lowp vec4 u_xlat10_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec4 u_xlat16_12;
lowp vec4 u_xlat10_12;
mediump vec4 u_xlat16_13;
lowp vec4 u_xlat10_13;
mediump vec4 u_xlat16_14;
lowp vec4 u_xlat10_14;
mediump vec4 u_xlat16_15;
lowp vec4 u_xlat10_15;
mediump vec3 u_xlat16_16;
mediump vec3 u_xlat16_17;
mediump float u_xlat16_34;
mediump float u_xlat16_51;
mediump float u_xlat16_53;
void main()
{
    u_xlat16_0.x = _Scale;
    u_xlat16_0.y = float(3.0);
    u_xlat16_0.z = float(5.0);
    u_xlatb1.xyz = equal(abs(vs_TEXCOORD0.xyzx), vec4(1.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat16_2.x = (u_xlatb1.x) ? vs_TEXCOORD0.x : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? vs_TEXCOORD0.y : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? vs_TEXCOORD0.z : float(0.0);
    u_xlat16_3.xyz = -abs(u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD0.xyz;
    u_xlat16_51 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_51 = u_xlat16_51 + 1.0;
    u_xlat16_51 = sqrt(u_xlat16_51);
    u_xlat16_51 = float(1.0) / u_xlat16_51;
    u_xlat16_53 = u_xlat16_51 * u_xlat16_51;
    u_xlat16_3.x = u_xlat16_51 * u_xlat16_53;
    u_xlat16_3.yz = u_xlat16_3.xx * vec2(vec2(_Scale, _Scale));
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_0.zzz * u_xlat16_0.xyz;
    u_xlat16_4.xyz = u_xlat16_2.zxy * vec3(vec3(_Texel, _Texel, _Texel));
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) * vec3(1.5, 1.5, 1.5) + vs_TEXCOORD0.xyz;
    u_xlat16_6.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + u_xlat16_5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_6.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_7.xyz = min(u_xlat16_7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + (-u_xlat16_7.xyz);
    u_xlat16_51 = max(abs(u_xlat16_6.y), abs(u_xlat16_6.x));
    u_xlat16_51 = max(abs(u_xlat16_6.z), u_xlat16_51);
    u_xlat16_6.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat10_1 = textureLod(_MainTex, u_xlat16_6.xyz, _Level);
    u_xlat16_1 = max(u_xlat10_1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(1.5, 1.5, 1.5) + vs_TEXCOORD0.xyz;
    u_xlat16_7.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + u_xlat16_6.xyz;
    u_xlat16_8.xyz = max(u_xlat16_7.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_8.xyz = min(u_xlat16_8.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_51 = max(abs(u_xlat16_7.y), abs(u_xlat16_7.x));
    u_xlat16_51 = max(abs(u_xlat16_7.z), u_xlat16_51);
    u_xlat16_7.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_8.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_7.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_1 = u_xlat16_1 + u_xlat16_7;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.yyyy;
    u_xlat16_8.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + vs_TEXCOORD0.xyz;
    u_xlat16_9.xyz = max(u_xlat16_8.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-u_xlat16_9.xyz);
    u_xlat16_51 = max(abs(u_xlat16_8.y), abs(u_xlat16_8.x));
    u_xlat16_51 = max(abs(u_xlat16_8.z), u_xlat16_51);
    u_xlat16_8.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_8.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_8.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_9.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_3.xxxx * u_xlat16_7 + u_xlat16_1;
    u_xlat16_9.xyz = (-u_xlat16_4.xyz) * vec3(2.5, 2.5, 2.5) + vs_TEXCOORD0.xyz;
    u_xlat16_10.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + u_xlat16_9.xyz;
    u_xlat16_11.xyz = max(u_xlat16_10.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_11.xyz = min(u_xlat16_11.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_10.xyz = u_xlat16_10.xyz + (-u_xlat16_11.xyz);
    u_xlat16_51 = max(abs(u_xlat16_10.y), abs(u_xlat16_10.x));
    u_xlat16_51 = max(abs(u_xlat16_10.z), u_xlat16_51);
    u_xlat16_10.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_11.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_10.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * vec3(2.5, 2.5, 2.5) + vs_TEXCOORD0.xyz;
    u_xlat16_11.xyz = (-u_xlat16_4.zxy) * vec3(2.5, 2.5, 2.5) + u_xlat16_10.xyz;
    u_xlat16_12.xyz = max(u_xlat16_11.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_12.xyz = min(u_xlat16_12.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_11.xyz = u_xlat16_11.xyz + (-u_xlat16_12.xyz);
    u_xlat16_51 = max(abs(u_xlat16_11.y), abs(u_xlat16_11.x));
    u_xlat16_51 = max(abs(u_xlat16_11.z), u_xlat16_51);
    u_xlat16_11.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_12.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_11.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_3.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_11.xyz = u_xlat16_0.yyy * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_0.xyz;
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + u_xlat16_10.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + u_xlat16_9.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_11.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + u_xlat16_6.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + u_xlat16_5.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_11.yyyy;
    u_xlat16_12.xyz = (-u_xlat16_4.zxy) * vec3(1.5, 1.5, 1.5) + vs_TEXCOORD0.xyz;
    u_xlat16_13.xyz = max(u_xlat16_12.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_12.y), abs(u_xlat16_12.x));
    u_xlat16_51 = max(abs(u_xlat16_12.z), u_xlat16_51);
    u_xlat16_12.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_12.xyz;
    u_xlat16_12.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat16_12.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_12.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_8 = u_xlat16_8 + u_xlat16_12;
    u_xlat16_7 = u_xlat16_11.xxxx * u_xlat16_8 + u_xlat16_7;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_7;
    u_xlat16_13.xyz = max(u_xlat16_9.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_9.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_14.y), abs(u_xlat16_14.x));
    u_xlat16_51 = max(abs(u_xlat16_14.z), u_xlat16_51);
    u_xlat16_13.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_14.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_13.xyz = max(u_xlat16_10.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_10.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_14.y), abs(u_xlat16_14.x));
    u_xlat16_51 = max(abs(u_xlat16_14.z), u_xlat16_51);
    u_xlat16_13.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_14.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_12;
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_8 = u_xlat16_8 + u_xlat16_12;
    u_xlat16_1 = u_xlat16_0.zzzz * u_xlat16_8 + u_xlat16_1;
    u_xlat16_13.xyz = max(u_xlat16_5.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_5.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_14.y), abs(u_xlat16_14.x));
    u_xlat16_51 = max(abs(u_xlat16_14.z), u_xlat16_51);
    u_xlat16_13.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_14.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_13.xyz = max(u_xlat16_6.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_13.xyz = min(u_xlat16_13.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_6.xyz + (-u_xlat16_13.xyz);
    u_xlat16_51 = max(abs(u_xlat16_14.y), abs(u_xlat16_14.x));
    u_xlat16_51 = max(abs(u_xlat16_14.z), u_xlat16_51);
    u_xlat16_13.xyz = (-vec3(u_xlat16_51)) * u_xlat16_2.xyz + u_xlat16_13.xyz;
    u_xlat16_14.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat16_13.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_13.xyz;
    u_xlat10_13 = textureLod(_MainTex, u_xlat16_13.xyz, _Level);
    u_xlat16_13 = max(u_xlat10_13, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_8 = u_xlat16_8 + u_xlat16_13;
    u_xlat16_8 = u_xlat16_0.yyyy * u_xlat16_8;
    u_xlat10_13 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_13 = max(u_xlat10_13, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_12 = u_xlat16_12 + u_xlat16_13;
    u_xlat16_12 = u_xlat16_0.yyyy * u_xlat16_12;
    u_xlat16_14.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + vs_TEXCOORD0.xyz;
    u_xlat16_15.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_14.xyz;
    u_xlat10_13 = textureLod(_MainTex, u_xlat16_14.xyz, _Level);
    u_xlat16_13 = max(u_xlat10_13, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_14 = textureLod(_MainTex, u_xlat16_15.xyz, _Level);
    u_xlat16_14 = max(u_xlat10_14, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_15.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + vs_TEXCOORD0.xyz;
    u_xlat16_16.xyz = (-u_xlat16_4.zxy) * vec3(0.5, 0.5, 0.5) + u_xlat16_15.xyz;
    u_xlat16_15.xyz = u_xlat16_4.zxy * vec3(0.5, 0.5, 0.5) + u_xlat16_15.xyz;
    u_xlat10_15 = textureLod(_MainTex, u_xlat16_15.xyz, _Level);
    u_xlat16_15 = max(u_xlat10_15, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_13 = u_xlat16_13 + u_xlat16_15;
    u_xlat16_8 = u_xlat16_0.xxxx * u_xlat16_13 + u_xlat16_8;
    u_xlat10_13 = textureLod(_MainTex, u_xlat16_16.xyz, _Level);
    u_xlat16_13 = max(u_xlat10_13, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_13 = u_xlat16_13 + u_xlat16_14;
    u_xlat16_12 = u_xlat16_0.xxxx * u_xlat16_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_12;
    u_xlat16_1 = u_xlat16_0.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, vec3(2.0, 2.0, 2.0));
    u_xlat16_1 = u_xlat16_8 + u_xlat16_1;
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + u_xlat16_9.xyz;
    u_xlat16_9.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + u_xlat16_9.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + u_xlat16_10.xyz;
    u_xlat16_10.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + u_xlat16_10.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_11.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + u_xlat16_5.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + u_xlat16_6.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_11.yyyy;
    u_xlat16_17.xyz = u_xlat16_4.zxy * vec3(1.5, 1.5, 1.5) + vs_TEXCOORD0.xyz;
    u_xlat16_16.xyz = max(u_xlat16_17.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_16.xyz = min(u_xlat16_16.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_17.xyz = u_xlat16_17.xyz + (-u_xlat16_16.xyz);
    u_xlat16_17.x = max(abs(u_xlat16_17.y), abs(u_xlat16_17.x));
    u_xlat16_17.x = max(abs(u_xlat16_17.z), u_xlat16_17.x);
    u_xlat16_17.xyz = (-u_xlat16_17.xxx) * u_xlat16_2.xyz + u_xlat16_16.xyz;
    u_xlat16_16.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat16_17.xyz;
    u_xlat16_17.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_17.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_17.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_12 = textureLod(_MainTex, u_xlat16_16.xyz, _Level);
    u_xlat16_12 = max(u_xlat10_12, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_8 = u_xlat16_8 + u_xlat16_12;
    u_xlat16_7 = u_xlat16_11.xxxx * u_xlat16_8 + u_xlat16_7;
    u_xlat16_17.x = dot(u_xlat16_11.xyz, vec3(2.0, 2.0, 2.0));
    u_xlat16_1 = u_xlat16_1 + u_xlat16_7;
    u_xlat16_11.xyz = max(u_xlat16_10.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_11.xyz = min(u_xlat16_11.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_10.xyz = u_xlat16_10.xyz + (-u_xlat16_11.xyz);
    u_xlat16_34 = max(abs(u_xlat16_10.y), abs(u_xlat16_10.x));
    u_xlat16_34 = max(abs(u_xlat16_10.z), u_xlat16_34);
    u_xlat16_10.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_11.xyz;
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_10.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_10.xyz = max(u_xlat16_9.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-u_xlat16_10.xyz);
    u_xlat16_34 = max(abs(u_xlat16_9.y), abs(u_xlat16_9.x));
    u_xlat16_34 = max(abs(u_xlat16_9.z), u_xlat16_34);
    u_xlat16_9.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_10.xyz;
    u_xlat10_8 = textureLod(_MainTex, u_xlat16_9.xyz, _Level);
    u_xlat16_8 = max(u_xlat10_8, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_7 = u_xlat16_7 + u_xlat16_8;
    u_xlat16_1 = u_xlat16_3.zzzz * u_xlat16_7 + u_xlat16_1;
    u_xlat16_9.xyz = u_xlat16_4.zxy * vec3(2.5, 2.5, 2.5) + vs_TEXCOORD0.xyz;
    u_xlat16_10.xyz = max(u_xlat16_9.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-u_xlat16_10.xyz);
    u_xlat16_34 = max(abs(u_xlat16_9.y), abs(u_xlat16_9.x));
    u_xlat16_34 = max(abs(u_xlat16_9.z), u_xlat16_34);
    u_xlat16_9.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_10.xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_9.xyz;
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * vec3(0.5, 0.5, 0.5) + u_xlat16_9.xyz;
    u_xlat10_4 = textureLod(_MainTex, u_xlat16_4.xyz, _Level);
    u_xlat16_4 = max(u_xlat10_4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat10_7 = textureLod(_MainTex, u_xlat16_10.xyz, _Level);
    u_xlat16_7 = max(u_xlat10_7, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_4 = u_xlat16_4 + u_xlat16_7;
    u_xlat16_9.xyz = max(u_xlat16_6.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + (-u_xlat16_9.xyz);
    u_xlat16_34 = max(abs(u_xlat16_6.y), abs(u_xlat16_6.x));
    u_xlat16_34 = max(abs(u_xlat16_6.z), u_xlat16_34);
    u_xlat16_6.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_9.xyz;
    u_xlat10_6 = textureLod(_MainTex, u_xlat16_6.xyz, _Level);
    u_xlat16_6 = max(u_xlat10_6, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_9.xyz = max(u_xlat16_5.xyz, vec3(-1.0, -1.0, -1.0));
    u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz + (-u_xlat16_9.xyz);
    u_xlat16_34 = max(abs(u_xlat16_5.y), abs(u_xlat16_5.x));
    u_xlat16_34 = max(abs(u_xlat16_5.z), u_xlat16_34);
    u_xlat16_2.xyz = (-vec3(u_xlat16_34)) * u_xlat16_2.xyz + u_xlat16_9.xyz;
    u_xlat10_2 = textureLod(_MainTex, u_xlat16_2.xyz, _Level);
    u_xlat16_2 = max(u_xlat10_2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_2 = u_xlat16_2 + u_xlat16_6;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_3.yyyy;
    u_xlat16_2 = u_xlat16_3.xxxx * u_xlat16_4 + u_xlat16_2;
    u_xlat16_34 = dot(u_xlat16_3.xyz, vec3(2.0, 2.0, 2.0));
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_51 = u_xlat16_17.x + u_xlat16_34;
    u_xlat16_0.x = u_xlat16_0.x * 2.0 + u_xlat16_51;
    u_xlat16_0.x = u_xlat16_17.x + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_34 + u_xlat16_0.x;
    SV_Target0 = u_xlat16_1 / u_xlat16_0.xxxx;
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
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 97250
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Level;
uniform lowp samplerCube _MainTex;
in mediump vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = textureLod(_MainTex, vs_TEXCOORD0.xyz, _Level);
    SV_Target0 = u_xlat10_0;
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
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Level;
uniform lowp samplerCube _MainTex;
in mediump vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = textureLod(_MainTex, vs_TEXCOORD0.xyz, _Level);
    SV_Target0 = u_xlat10_0;
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
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Level;
uniform lowp samplerCube _MainTex;
in mediump vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = textureLod(_MainTex, vs_TEXCOORD0.xyz, _Level);
    SV_Target0 = u_xlat10_0;
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