Shader "Hidden/CubeBlend" {
Properties {
_TexA ("Cubemap", Cube) = "grey" { }
_TexB ("Cubemap", Cube) = "grey" { }
_value ("Value", Range(0, 1)) = 0.5
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Background" }
  ZTest Always
  ZWrite Off
  GpuProgramID 19854
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexA_HDR;
uniform 	mediump vec4 _TexB_HDR;
uniform 	float _Level;
uniform 	float _value;
uniform lowp samplerCube _TexA;
uniform lowp samplerCube _TexB;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat10_0 = textureLod(_TexA, vs_TEXCOORD0.xyz, _Level);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = _TexA_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _TexA_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat10_0 = textureLod(_TexB, vs_TEXCOORD0.xyz, _Level);
    u_xlat16_7 = u_xlat10_0.w + -1.0;
    u_xlat16_7 = _TexB_HDR.w * u_xlat16_7 + 1.0;
    u_xlat16_7 = u_xlat16_7 * _TexB_HDR.x;
    u_xlat16_0.xyz = vec3(u_xlat16_7) * u_xlat10_0.xyz + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(vec3(_value, _value, _value)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexA_HDR;
uniform 	mediump vec4 _TexB_HDR;
uniform 	float _Level;
uniform 	float _value;
uniform lowp samplerCube _TexA;
uniform lowp samplerCube _TexB;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat10_0 = textureLod(_TexA, vs_TEXCOORD0.xyz, _Level);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = _TexA_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _TexA_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat10_0 = textureLod(_TexB, vs_TEXCOORD0.xyz, _Level);
    u_xlat16_7 = u_xlat10_0.w + -1.0;
    u_xlat16_7 = _TexB_HDR.w * u_xlat16_7 + 1.0;
    u_xlat16_7 = u_xlat16_7 * _TexB_HDR.x;
    u_xlat16_0.xyz = vec3(u_xlat16_7) * u_xlat10_0.xyz + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(vec3(_value, _value, _value)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexA_HDR;
uniform 	mediump vec4 _TexB_HDR;
uniform 	float _Level;
uniform 	float _value;
uniform lowp samplerCube _TexA;
uniform lowp samplerCube _TexB;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat10_0 = textureLod(_TexA, vs_TEXCOORD0.xyz, _Level);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = _TexA_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _TexA_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat10_0 = textureLod(_TexB, vs_TEXCOORD0.xyz, _Level);
    u_xlat16_7 = u_xlat10_0.w + -1.0;
    u_xlat16_7 = _TexB_HDR.w * u_xlat16_7 + 1.0;
    u_xlat16_7 = u_xlat16_7 * _TexB_HDR.x;
    u_xlat16_0.xyz = vec3(u_xlat16_7) * u_xlat10_0.xyz + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(vec3(_value, _value, _value)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
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
 Tags { "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Background" }
  ZTest Always
  ZWrite Off
  GpuProgramID 105093
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexA_HDR;
uniform 	mediump vec4 _TexB_HDR;
uniform 	float _Level;
uniform 	float _value;
uniform lowp samplerCube _TexA;
uniform lowp samplerCube _TexB;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat10_0 = textureLod(_TexA, vs_TEXCOORD0.xyz, _Level);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = _TexA_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _TexA_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat10_0 = textureLod(_TexB, vs_TEXCOORD0.xyz, _Level);
    u_xlat16_7 = u_xlat10_0.w + -1.0;
    u_xlat16_7 = _TexB_HDR.w * u_xlat16_7 + 1.0;
    u_xlat16_7 = u_xlat16_7 * _TexB_HDR.x;
    u_xlat16_0.xyz = vec3(u_xlat16_7) * u_xlat10_0.xyz + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(vec3(_value, _value, _value)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexA_HDR;
uniform 	mediump vec4 _TexB_HDR;
uniform 	float _Level;
uniform 	float _value;
uniform lowp samplerCube _TexA;
uniform lowp samplerCube _TexB;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat10_0 = textureLod(_TexA, vs_TEXCOORD0.xyz, _Level);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = _TexA_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _TexA_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat10_0 = textureLod(_TexB, vs_TEXCOORD0.xyz, _Level);
    u_xlat16_7 = u_xlat10_0.w + -1.0;
    u_xlat16_7 = _TexB_HDR.w * u_xlat16_7 + 1.0;
    u_xlat16_7 = u_xlat16_7 * _TexB_HDR.x;
    u_xlat16_0.xyz = vec3(u_xlat16_7) * u_xlat10_0.xyz + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(vec3(_value, _value, _value)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexA_HDR;
uniform 	mediump vec4 _TexB_HDR;
uniform 	float _Level;
uniform 	float _value;
uniform lowp samplerCube _TexA;
uniform lowp samplerCube _TexB;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat10_0 = textureLod(_TexA, vs_TEXCOORD0.xyz, _Level);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = _TexA_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _TexA_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat10_0 = textureLod(_TexB, vs_TEXCOORD0.xyz, _Level);
    u_xlat16_7 = u_xlat10_0.w + -1.0;
    u_xlat16_7 = _TexB_HDR.w * u_xlat16_7 + 1.0;
    u_xlat16_7 = u_xlat16_7 * _TexB_HDR.x;
    u_xlat16_0.xyz = vec3(u_xlat16_7) * u_xlat10_0.xyz + (-u_xlat16_1.xyz);
    u_xlat0.xyz = vec3(vec3(_value, _value, _value)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
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