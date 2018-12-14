Shader "Unlit/SpinnerShader" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_ColorA ("Color", Color) = (1,1,1,1)
_ColorB ("Color", Color) = (0,0,0,1)
}
SubShader {
 LOD 100
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 18524
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
bool u_xlatb2;
bool u_xlatb3;
vec2 u_xlat4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
#else
    u_xlatb6 = u_xlat6<(-u_xlat6);
#endif
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat4.xy = u_xlat0.xx * vec2(-55.0, 12.5600004);
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat0.x = u_xlat0.x * -49.9999733;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * 2.0 + u_xlat4.x;
    u_xlat2.y = cos(u_xlat4.y);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat2.x = (-u_xlat2.y) * 1.20000005 + u_xlat2.x;
    u_xlat4.x = (-u_xlat2.x) + 1.0;
    u_xlat1 = u_xlat4.xxxx * _ColorB;
    u_xlat1 = u_xlat2.xxxx * _ColorA + u_xlat1;
    u_xlat2.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
bool u_xlatb2;
bool u_xlatb3;
vec2 u_xlat4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
#else
    u_xlatb6 = u_xlat6<(-u_xlat6);
#endif
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat4.xy = u_xlat0.xx * vec2(-55.0, 12.5600004);
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat0.x = u_xlat0.x * -49.9999733;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * 2.0 + u_xlat4.x;
    u_xlat2.y = cos(u_xlat4.y);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat2.x = (-u_xlat2.y) * 1.20000005 + u_xlat2.x;
    u_xlat4.x = (-u_xlat2.x) + 1.0;
    u_xlat1 = u_xlat4.xxxx * _ColorB;
    u_xlat1 = u_xlat2.xxxx * _ColorA + u_xlat1;
    u_xlat2.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
bool u_xlatb2;
bool u_xlatb3;
vec2 u_xlat4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
#else
    u_xlatb6 = u_xlat6<(-u_xlat6);
#endif
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat4.xy = u_xlat0.xx * vec2(-55.0, 12.5600004);
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat0.x = u_xlat0.x * -49.9999733;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * 2.0 + u_xlat4.x;
    u_xlat2.y = cos(u_xlat4.y);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat2.x = (-u_xlat2.y) * 1.20000005 + u_xlat2.x;
    u_xlat4.x = (-u_xlat2.x) + 1.0;
    u_xlat1 = u_xlat4.xxxx * _ColorB;
    u_xlat1 = u_xlat2.xxxx * _ColorA + u_xlat1;
    u_xlat2.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    SV_Target0.w = u_xlat0.x;
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