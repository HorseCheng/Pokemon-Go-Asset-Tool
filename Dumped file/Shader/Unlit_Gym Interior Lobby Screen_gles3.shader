Shader "Unlit/Gym Interior Lobby Screen" {
Properties {
_POITex ("POI Photo Texture", 2D) = "white" { }
_POIAdditive ("POI Additive Texture", 2D) = "black" { }
_AvatarTex ("Avatar Photo Texture", 2D) = "white" { }
_AvatarLerp ("Avatar Photo Lerp", Range(0, 1)) = 0
_AvatarOffset ("Avatar Photo Offset and Scale", Vector) = (0,0,1,1)
_AvatarOffsetNoiseSpeed ("Avatar Photo Offset Noise Speed", Float) = 0.1
_AvatarOffsetNoiseScale ("Avatar Photo Offset Noise Scale", Float) = 0.2
_AvatarMask ("Avatar Photo Mask", 2D) = "white" { }
_WarpTex ("Warp Texture", 2D) = "bump" { }
_WarpStrength ("Warp Strength", Float) = 1
_WarpSpeedX ("Warp X Pan Speed", Float) = 0
_WarpSpeedY ("Warp Y Pan Speed", Float) = 0
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 11899
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _POITex_ST;
uniform 	vec4 _POIAdditive_ST;
uniform 	mediump vec4 _AvatarOffset;
uniform 	mediump float _AvatarOffsetNoiseSpeed;
uniform 	mediump float _AvatarOffsetNoiseScale;
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _WarpSpeedX;
uniform 	mediump float _WarpSpeedY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat4;
vec2 u_xlat6;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _POITex_ST.xy + _POITex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _POIAdditive_ST.xy + _POIAdditive_ST.zw;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat0;
    u_xlat0.x = dot(u_xlat0, in_POSITION0);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat0.y = dot(u_xlat1, in_POSITION0);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xy = u_xlat0.xy / u_xlat1.ww;
    gl_Position = u_xlat1;
    u_xlat0.xy = u_xlat0.xy * _AvatarOffset.zw + _AvatarOffset.xy;
    u_xlat6.x = _Time.x * _AvatarOffsetNoiseSpeed;
    u_xlat1.xy = u_xlat6.xx * vec2(0.370000005, 0.970000029);
    u_xlat6.x = sin(u_xlat6.x);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat4 = cos(u_xlat1.y);
    u_xlat6.y = u_xlat4 * u_xlat1.x;
    vs_TEXCOORD3.xy = u_xlat6.xy * vec2(vec2(_AvatarOffsetNoiseScale, _AvatarOffsetNoiseScale)) + u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    vs_TEXCOORD2.xy = _Time.xx * vec2(_WarpSpeedX, _WarpSpeedY) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _AvatarLerp;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _AvatarTex;
uniform lowp sampler2D _AvatarMask;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _POIAdditive;
uniform lowp sampler2D _POITex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD2.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_POITex, u_xlat0.xy);
    u_xlat10_1 = texture(_AvatarTex, vs_TEXCOORD3.xy);
    u_xlat16_1 = (-u_xlat10_0) + u_xlat10_1;
    u_xlat10_2 = texture(_AvatarMask, vs_TEXCOORD4.xy).w;
    u_xlat16_3.x = u_xlat10_2 * _AvatarLerp;
    u_xlat16_0 = u_xlat16_3.xxxx * u_xlat16_1 + u_xlat10_0;
    u_xlat10_1 = texture(_POIAdditive, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat10_1.xyz;
    SV_Target0.xyz = u_xlat10_1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _POITex_ST;
uniform 	vec4 _POIAdditive_ST;
uniform 	mediump vec4 _AvatarOffset;
uniform 	mediump float _AvatarOffsetNoiseSpeed;
uniform 	mediump float _AvatarOffsetNoiseScale;
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _WarpSpeedX;
uniform 	mediump float _WarpSpeedY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat4;
vec2 u_xlat6;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _POITex_ST.xy + _POITex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _POIAdditive_ST.xy + _POIAdditive_ST.zw;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat0;
    u_xlat0.x = dot(u_xlat0, in_POSITION0);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat0.y = dot(u_xlat1, in_POSITION0);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xy = u_xlat0.xy / u_xlat1.ww;
    gl_Position = u_xlat1;
    u_xlat0.xy = u_xlat0.xy * _AvatarOffset.zw + _AvatarOffset.xy;
    u_xlat6.x = _Time.x * _AvatarOffsetNoiseSpeed;
    u_xlat1.xy = u_xlat6.xx * vec2(0.370000005, 0.970000029);
    u_xlat6.x = sin(u_xlat6.x);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat4 = cos(u_xlat1.y);
    u_xlat6.y = u_xlat4 * u_xlat1.x;
    vs_TEXCOORD3.xy = u_xlat6.xy * vec2(vec2(_AvatarOffsetNoiseScale, _AvatarOffsetNoiseScale)) + u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    vs_TEXCOORD2.xy = _Time.xx * vec2(_WarpSpeedX, _WarpSpeedY) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _AvatarLerp;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _AvatarTex;
uniform lowp sampler2D _AvatarMask;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _POIAdditive;
uniform lowp sampler2D _POITex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD2.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_POITex, u_xlat0.xy);
    u_xlat10_1 = texture(_AvatarTex, vs_TEXCOORD3.xy);
    u_xlat16_1 = (-u_xlat10_0) + u_xlat10_1;
    u_xlat10_2 = texture(_AvatarMask, vs_TEXCOORD4.xy).w;
    u_xlat16_3.x = u_xlat10_2 * _AvatarLerp;
    u_xlat16_0 = u_xlat16_3.xxxx * u_xlat16_1 + u_xlat10_0;
    u_xlat10_1 = texture(_POIAdditive, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat10_1.xyz;
    SV_Target0.xyz = u_xlat10_1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _POITex_ST;
uniform 	vec4 _POIAdditive_ST;
uniform 	mediump vec4 _AvatarOffset;
uniform 	mediump float _AvatarOffsetNoiseSpeed;
uniform 	mediump float _AvatarOffsetNoiseScale;
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _WarpSpeedX;
uniform 	mediump float _WarpSpeedY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat4;
vec2 u_xlat6;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _POITex_ST.xy + _POITex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _POIAdditive_ST.xy + _POIAdditive_ST.zw;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat0;
    u_xlat0.x = dot(u_xlat0, in_POSITION0);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat0.y = dot(u_xlat1, in_POSITION0);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xy = u_xlat0.xy / u_xlat1.ww;
    gl_Position = u_xlat1;
    u_xlat0.xy = u_xlat0.xy * _AvatarOffset.zw + _AvatarOffset.xy;
    u_xlat6.x = _Time.x * _AvatarOffsetNoiseSpeed;
    u_xlat1.xy = u_xlat6.xx * vec2(0.370000005, 0.970000029);
    u_xlat6.x = sin(u_xlat6.x);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat4 = cos(u_xlat1.y);
    u_xlat6.y = u_xlat4 * u_xlat1.x;
    vs_TEXCOORD3.xy = u_xlat6.xy * vec2(vec2(_AvatarOffsetNoiseScale, _AvatarOffsetNoiseScale)) + u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    vs_TEXCOORD2.xy = _Time.xx * vec2(_WarpSpeedX, _WarpSpeedY) + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _AvatarLerp;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _AvatarTex;
uniform lowp sampler2D _AvatarMask;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _POIAdditive;
uniform lowp sampler2D _POITex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0.xy = texture(_WarpTex, vs_TEXCOORD2.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_WarpStrength) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_POITex, u_xlat0.xy);
    u_xlat10_1 = texture(_AvatarTex, vs_TEXCOORD3.xy);
    u_xlat16_1 = (-u_xlat10_0) + u_xlat10_1;
    u_xlat10_2 = texture(_AvatarMask, vs_TEXCOORD4.xy).w;
    u_xlat16_3.x = u_xlat10_2 * _AvatarLerp;
    u_xlat16_0 = u_xlat16_3.xxxx * u_xlat16_1 + u_xlat10_0;
    u_xlat10_1 = texture(_POIAdditive, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat10_1.xyz;
    SV_Target0.xyz = u_xlat10_1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
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