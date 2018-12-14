Shader "Niantic/Gym Arena/Turf" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_TextureScale ("Texture Scale", Float) = 0.01
_AdditiveRamp ("1D Gradient Ramp (RGB) - Additive", 2D) = "black" { }
_MultiplyRamp ("1D Gradient Ramp (RGB) - Multiply", 2D) = "white" { }
_NearDist ("Near Distance", Float) = 100
_FarDist ("Far Distance", Float) = 250
_OffsetFactor ("Z Offset Factor", Float) = 0
_OffsetUnits ("Z Offset Units", Float) = 0
}
SubShader {
 LOD 150
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 150
  Tags { "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 41500
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _TextureScale;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xy = u_xlat0.xz * vec2(vec2(_TextureScale, _TextureScale));
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + (-_NearDist);
    u_xlat16_3 = (-_NearDist) + _FarDist;
    u_xlat0.z = u_xlat12 / u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AdditiveRamp;
uniform lowp sampler2D _MultiplyRamp;
in mediump vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_AdditiveRamp, vs_TEXCOORD0.zz);
    u_xlat16_1 = u_xlat10_1 + u_xlat10_2;
    u_xlat10_2 = texture(_MultiplyRamp, vs_TEXCOORD0.zz);
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat16_1.w * u_xlat10_2.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
}
}
}
}