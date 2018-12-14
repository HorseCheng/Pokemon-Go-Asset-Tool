Shader "Hidden/ConvertTexture" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 55655
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

vec3 ImmCB_0_0_0[4];
vec2 ImmCB_0_4_2[6];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _faceIndex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
int u_xlati4;
void main()
{
	ImmCB_0_0_0[0] = vec3(0.0, 0.0, -1.0);
	ImmCB_0_0_0[1] = vec3(0.0, 0.0, 1.0);
	ImmCB_0_0_0[2] = vec3(1.0, 0.0, 0.0);
	ImmCB_0_0_0[3] = vec3(1.0, 0.0, 0.0);
	ImmCB_0_4_2[0] = vec2(0.0, -1.0);
	ImmCB_0_4_2[1] = vec2(0.0, -1.0);
	ImmCB_0_4_2[2] = vec2(1.0, 0.0);
	ImmCB_0_4_2[3] = vec2(-1.0, 0.0);
	ImmCB_0_4_2[4] = vec2(0.0, -1.0);
	ImmCB_0_4_2[5] = vec2(0.0, -1.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.x = 0.0;
    u_xlat1.z = 0.0;
    u_xlati4 = int(_faceIndex);
    u_xlat1.xy = ImmCB_0_0_0[u_xlati4].zx * ImmCB_0_4_2[u_xlati4].yx;
    u_xlat2.xz = ImmCB_0_4_2[u_xlati4].xy;
    u_xlat2.y = ImmCB_0_0_0[u_xlati4].z;
    u_xlat0.z = ImmCB_0_0_0[u_xlati4].x;
    u_xlat0.xzw = (-u_xlat2.xyz) * u_xlat0.xxz + u_xlat1.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.xz = ImmCB_0_0_0[u_xlati4].xz;
    u_xlat3.yz = ImmCB_0_4_2[u_xlati4].yx;
    u_xlat0.xyz = u_xlat2.xxx * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat3.x = 0.0;
    vs_TEXCOORD0.xyz = u_xlat2.yyy * u_xlat3.xyz + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp samplerCube _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xyz);
    SV_Target0 = u_xlat10_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

vec3 ImmCB_0_0_0[4];
vec2 ImmCB_0_4_2[6];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _faceIndex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
int u_xlati4;
void main()
{
	ImmCB_0_0_0[0] = vec3(0.0, 0.0, -1.0);
	ImmCB_0_0_0[1] = vec3(0.0, 0.0, 1.0);
	ImmCB_0_0_0[2] = vec3(1.0, 0.0, 0.0);
	ImmCB_0_0_0[3] = vec3(1.0, 0.0, 0.0);
	ImmCB_0_4_2[0] = vec2(0.0, -1.0);
	ImmCB_0_4_2[1] = vec2(0.0, -1.0);
	ImmCB_0_4_2[2] = vec2(1.0, 0.0);
	ImmCB_0_4_2[3] = vec2(-1.0, 0.0);
	ImmCB_0_4_2[4] = vec2(0.0, -1.0);
	ImmCB_0_4_2[5] = vec2(0.0, -1.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.x = 0.0;
    u_xlat1.z = 0.0;
    u_xlati4 = int(_faceIndex);
    u_xlat1.xy = ImmCB_0_0_0[u_xlati4].zx * ImmCB_0_4_2[u_xlati4].yx;
    u_xlat2.xz = ImmCB_0_4_2[u_xlati4].xy;
    u_xlat2.y = ImmCB_0_0_0[u_xlati4].z;
    u_xlat0.z = ImmCB_0_0_0[u_xlati4].x;
    u_xlat0.xzw = (-u_xlat2.xyz) * u_xlat0.xxz + u_xlat1.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.xz = ImmCB_0_0_0[u_xlati4].xz;
    u_xlat3.yz = ImmCB_0_4_2[u_xlati4].yx;
    u_xlat0.xyz = u_xlat2.xxx * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat3.x = 0.0;
    vs_TEXCOORD0.xyz = u_xlat2.yyy * u_xlat3.xyz + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp samplerCube _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xyz);
    SV_Target0 = u_xlat10_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

vec3 ImmCB_0_0_0[4];
vec2 ImmCB_0_4_2[6];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _faceIndex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
int u_xlati4;
void main()
{
	ImmCB_0_0_0[0] = vec3(0.0, 0.0, -1.0);
	ImmCB_0_0_0[1] = vec3(0.0, 0.0, 1.0);
	ImmCB_0_0_0[2] = vec3(1.0, 0.0, 0.0);
	ImmCB_0_0_0[3] = vec3(1.0, 0.0, 0.0);
	ImmCB_0_4_2[0] = vec2(0.0, -1.0);
	ImmCB_0_4_2[1] = vec2(0.0, -1.0);
	ImmCB_0_4_2[2] = vec2(1.0, 0.0);
	ImmCB_0_4_2[3] = vec2(-1.0, 0.0);
	ImmCB_0_4_2[4] = vec2(0.0, -1.0);
	ImmCB_0_4_2[5] = vec2(0.0, -1.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.x = 0.0;
    u_xlat1.z = 0.0;
    u_xlati4 = int(_faceIndex);
    u_xlat1.xy = ImmCB_0_0_0[u_xlati4].zx * ImmCB_0_4_2[u_xlati4].yx;
    u_xlat2.xz = ImmCB_0_4_2[u_xlati4].xy;
    u_xlat2.y = ImmCB_0_0_0[u_xlati4].z;
    u_xlat0.z = ImmCB_0_0_0[u_xlati4].x;
    u_xlat0.xzw = (-u_xlat2.xyz) * u_xlat0.xxz + u_xlat1.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.xz = ImmCB_0_0_0[u_xlati4].xz;
    u_xlat3.yz = ImmCB_0_4_2[u_xlati4].yx;
    u_xlat0.xyz = u_xlat2.xxx * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat3.x = 0.0;
    vs_TEXCOORD0.xyz = u_xlat2.yyy * u_xlat3.xyz + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp samplerCube _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xyz);
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