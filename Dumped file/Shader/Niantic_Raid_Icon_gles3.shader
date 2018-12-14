Shader "Niantic/Raid/Icon" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_AnglePerPip ("Angle Per Pip (dgr)", Float) = 27.5
[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
_RendererColor ("RendererColor", Color) = (1,1,1,1)
_Flip ("Flip", Vector) = (1,1,1,1)
_AlphaTex ("External Alpha", 2D) = "white" { }
_EnableExternalAlpha ("Enable External Alpha", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 32600
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _RendererColor;
uniform 	mediump vec4 _Color;
uniform 	float _AnglePerPip;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0.xyz = in_COLOR0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _RendererColor.xyz;
    u_xlat0.w = in_COLOR0.w;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.x = _AnglePerPip * 0.0174532942;
    vs_TEXCOORD1.yzw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat8 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = float(1.0) / u_xlat8;
    u_xlat12 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat12 = u_xlat8 * u_xlat8;
    u_xlat1.x = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat12 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat12 * u_xlat1.x + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat12 * u_xlat8;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb5 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlatb5 ? u_xlat1.x : float(0.0);
    u_xlat8 = u_xlat8 * u_xlat12 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!((-u_xlat0.y)<u_xlat0.y);
#else
    u_xlatb12 = (-u_xlat0.y)<u_xlat0.y;
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat8 = u_xlat12 + u_xlat8;
    u_xlat12 = min((-u_xlat0.y), u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb12 = u_xlat12<(-u_xlat12);
#endif
    u_xlat1.x = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb12;
    u_xlat4.x = (u_xlatb4) ? (-u_xlat8) : u_xlat8;
    u_xlat16_2.x = vs_COLOR0.w * 5.0999999;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat8 = u_xlat16_2.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat8>=(-u_xlat8));
#else
    u_xlatb12 = u_xlat8>=(-u_xlat8);
#endif
    u_xlat8 = fract(abs(u_xlat8));
    u_xlat8 = (u_xlatb12) ? u_xlat8 : (-u_xlat8);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8>=0.0500000007);
#else
    u_xlatb8 = u_xlat8>=0.0500000007;
#endif
    u_xlat8 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = vs_TEXCOORD1.x * 0.5;
    u_xlat4.x = (-u_xlat12) * u_xlat8 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x / vs_TEXCOORD1.x;
    u_xlat8 = trunc(u_xlat4.x);
    u_xlat4.x = (-u_xlat8) + u_xlat4.x;
    u_xlati8 = int(u_xlat8);
    u_xlati8 = u_xlati8 << 1;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4.x; u_xlati12 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati12 = int((0.0<u_xlat4.x) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4.x<0.0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati1 = int((u_xlat4.x<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlat4.x = abs(u_xlat4.x) + -0.5;
    u_xlati12 = (-u_xlati12) + u_xlati1;
    u_xlati8 = u_xlati12 + u_xlati8;
    u_xlat8 = float(u_xlati8);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(u_xlat8>=(-u_xlat16_2.x));
#else
    u_xlatb0.w = u_xlat8>=(-u_xlat16_2.x);
#endif
    u_xlat1.x = u_xlat16_2.x + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.z = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb0.z = u_xlat1.x>=u_xlat8;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x>=0.25);
#else
    u_xlatb1 = u_xlat0.x>=0.25;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.349999994>=u_xlat0.x);
#else
    u_xlatb5 = 0.349999994>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlat0.x * 2.0 + -0.5;
    u_xlat0.x = u_xlat0.x * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=abs(u_xlat4.x));
#else
    u_xlatb0.x = u_xlat0.x>=abs(u_xlat4.x);
#endif
    u_xlat0.xzw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb0.xzw));
    u_xlat4.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat16_3.xyz = u_xlat1.www * u_xlat16_2.xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) * u_xlat1.www + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat1;
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
uniform 	mediump vec4 _RendererColor;
uniform 	mediump vec4 _Color;
uniform 	float _AnglePerPip;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0.xyz = in_COLOR0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _RendererColor.xyz;
    u_xlat0.w = in_COLOR0.w;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.x = _AnglePerPip * 0.0174532942;
    vs_TEXCOORD1.yzw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat8 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = float(1.0) / u_xlat8;
    u_xlat12 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat12 = u_xlat8 * u_xlat8;
    u_xlat1.x = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat12 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat12 * u_xlat1.x + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat12 * u_xlat8;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb5 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlatb5 ? u_xlat1.x : float(0.0);
    u_xlat8 = u_xlat8 * u_xlat12 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!((-u_xlat0.y)<u_xlat0.y);
#else
    u_xlatb12 = (-u_xlat0.y)<u_xlat0.y;
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat8 = u_xlat12 + u_xlat8;
    u_xlat12 = min((-u_xlat0.y), u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb12 = u_xlat12<(-u_xlat12);
#endif
    u_xlat1.x = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb12;
    u_xlat4.x = (u_xlatb4) ? (-u_xlat8) : u_xlat8;
    u_xlat16_2.x = vs_COLOR0.w * 5.0999999;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat8 = u_xlat16_2.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat8>=(-u_xlat8));
#else
    u_xlatb12 = u_xlat8>=(-u_xlat8);
#endif
    u_xlat8 = fract(abs(u_xlat8));
    u_xlat8 = (u_xlatb12) ? u_xlat8 : (-u_xlat8);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8>=0.0500000007);
#else
    u_xlatb8 = u_xlat8>=0.0500000007;
#endif
    u_xlat8 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = vs_TEXCOORD1.x * 0.5;
    u_xlat4.x = (-u_xlat12) * u_xlat8 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x / vs_TEXCOORD1.x;
    u_xlat8 = trunc(u_xlat4.x);
    u_xlat4.x = (-u_xlat8) + u_xlat4.x;
    u_xlati8 = int(u_xlat8);
    u_xlati8 = u_xlati8 << 1;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4.x; u_xlati12 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati12 = int((0.0<u_xlat4.x) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4.x<0.0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati1 = int((u_xlat4.x<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlat4.x = abs(u_xlat4.x) + -0.5;
    u_xlati12 = (-u_xlati12) + u_xlati1;
    u_xlati8 = u_xlati12 + u_xlati8;
    u_xlat8 = float(u_xlati8);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(u_xlat8>=(-u_xlat16_2.x));
#else
    u_xlatb0.w = u_xlat8>=(-u_xlat16_2.x);
#endif
    u_xlat1.x = u_xlat16_2.x + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.z = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb0.z = u_xlat1.x>=u_xlat8;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x>=0.25);
#else
    u_xlatb1 = u_xlat0.x>=0.25;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.349999994>=u_xlat0.x);
#else
    u_xlatb5 = 0.349999994>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlat0.x * 2.0 + -0.5;
    u_xlat0.x = u_xlat0.x * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=abs(u_xlat4.x));
#else
    u_xlatb0.x = u_xlat0.x>=abs(u_xlat4.x);
#endif
    u_xlat0.xzw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb0.xzw));
    u_xlat4.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat16_3.xyz = u_xlat1.www * u_xlat16_2.xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) * u_xlat1.www + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat1;
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
uniform 	mediump vec4 _RendererColor;
uniform 	mediump vec4 _Color;
uniform 	float _AnglePerPip;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0.xyz = in_COLOR0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _RendererColor.xyz;
    u_xlat0.w = in_COLOR0.w;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.x = _AnglePerPip * 0.0174532942;
    vs_TEXCOORD1.yzw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
int u_xlati1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat8 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = float(1.0) / u_xlat8;
    u_xlat12 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat12 = u_xlat8 * u_xlat8;
    u_xlat1.x = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat12 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat12 * u_xlat1.x + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat12 * u_xlat8;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb5 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlatb5 ? u_xlat1.x : float(0.0);
    u_xlat8 = u_xlat8 * u_xlat12 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!((-u_xlat0.y)<u_xlat0.y);
#else
    u_xlatb12 = (-u_xlat0.y)<u_xlat0.y;
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat8 = u_xlat12 + u_xlat8;
    u_xlat12 = min((-u_xlat0.y), u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb12 = u_xlat12<(-u_xlat12);
#endif
    u_xlat1.x = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb12;
    u_xlat4.x = (u_xlatb4) ? (-u_xlat8) : u_xlat8;
    u_xlat16_2.x = vs_COLOR0.w * 5.0999999;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat8 = u_xlat16_2.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat8>=(-u_xlat8));
#else
    u_xlatb12 = u_xlat8>=(-u_xlat8);
#endif
    u_xlat8 = fract(abs(u_xlat8));
    u_xlat8 = (u_xlatb12) ? u_xlat8 : (-u_xlat8);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8>=0.0500000007);
#else
    u_xlatb8 = u_xlat8>=0.0500000007;
#endif
    u_xlat8 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = vs_TEXCOORD1.x * 0.5;
    u_xlat4.x = (-u_xlat12) * u_xlat8 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x / vs_TEXCOORD1.x;
    u_xlat8 = trunc(u_xlat4.x);
    u_xlat4.x = (-u_xlat8) + u_xlat4.x;
    u_xlati8 = int(u_xlat8);
    u_xlati8 = u_xlati8 << 1;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4.x; u_xlati12 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati12 = int((0.0<u_xlat4.x) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4.x<0.0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati1 = int((u_xlat4.x<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlat4.x = abs(u_xlat4.x) + -0.5;
    u_xlati12 = (-u_xlati12) + u_xlati1;
    u_xlati8 = u_xlati12 + u_xlati8;
    u_xlat8 = float(u_xlati8);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(u_xlat8>=(-u_xlat16_2.x));
#else
    u_xlatb0.w = u_xlat8>=(-u_xlat16_2.x);
#endif
    u_xlat1.x = u_xlat16_2.x + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.z = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb0.z = u_xlat1.x>=u_xlat8;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x>=0.25);
#else
    u_xlatb1 = u_xlat0.x>=0.25;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.349999994>=u_xlat0.x);
#else
    u_xlatb5 = 0.349999994>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlat0.x * 2.0 + -0.5;
    u_xlat0.x = u_xlat0.x * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=abs(u_xlat4.x));
#else
    u_xlatb0.x = u_xlat0.x>=abs(u_xlat4.x);
#endif
    u_xlat0.xzw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb0.xzw));
    u_xlat4.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat16_3.xyz = u_xlat1.www * u_xlat16_2.xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) * u_xlat1.www + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat1;
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