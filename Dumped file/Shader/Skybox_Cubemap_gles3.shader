Shader "Skybox/Cubemap" {
Properties {
_Tint ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_Exposure ("Exposure", Range(0, 8)) = 1
_Rotation ("Rotation", Range(0, 360)) = 0
_Tex ("Cubemap   (HDR)", Cube) = "grey" { }
}
SubShader {
 Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
  ZWrite Off
  Cull Off
  GpuProgramID 32916
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Rotation;
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
    u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xyz = in_POSITION0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Tex_HDR;
uniform 	mediump vec4 _Tint;
uniform 	mediump float _Exposure;
uniform lowp samplerCube _Tex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Tex, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = _Tex_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Tex_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
    SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	float _Rotation;
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
    u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xyz = in_POSITION0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Tex_HDR;
uniform 	mediump vec4 _Tint;
uniform 	mediump float _Exposure;
uniform lowp samplerCube _Tex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Tex, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = _Tex_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Tex_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
    SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	float _Rotation;
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
    u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xyz = in_POSITION0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Tex_HDR;
uniform 	mediump vec4 _Tint;
uniform 	mediump float _Exposure;
uniform lowp samplerCube _Tex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_Tex, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = _Tex_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Tex_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
    SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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