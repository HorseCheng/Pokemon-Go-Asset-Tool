Shader "Niantic/Combat/FillFromBaseToTop" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_UnfillColor ("Unfilled Color", Color) = (1,1,1,1)
_UnfillOuter ("Unfilled Outer", Range(0, 1)) = 0.5
_UnfilledOuterFeather ("Unfilled Outer Feather", Float) = 0.1
_UnfilledOuterThickness ("Unfilled Outer Thickness", Float) = 0.1
_FillAmt ("Fill Amount", Range(0, 1)) = 0
_TimerFillValue ("Attack Wait Fill Value", Range(0, 1)) = 0
_ScreenExtends ("Extends of Icon on Screen", Vector) = (0,0,1,1)
}
SubShader {
 Tags { "QUEUE" = "Transparent+100" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+100" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 34379
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UnfillColor;
uniform 	float _UnfillOuter;
uniform 	float _UnfilledOuterFeather;
uniform 	float _UnfilledOuterThickness;
uniform 	float _FillAmt;
uniform 	float _TimerFillValue;
uniform 	vec4 _ScreenExtends;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
float u_xlat3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat6;
bvec2 u_xlatb6;
bool u_xlatb7;
float u_xlat9;
void main()
{
    u_xlat0.xyz = vec3(vs_TEXCOORD1.y + (-_ScreenExtends.y), vs_TEXCOORD1.x + (-_ScreenExtends.x), vs_TEXCOORD1.y + (-_ScreenExtends.y));
    u_xlat0.xyz = vec3(u_xlat0.x / _ScreenExtends.w, u_xlat0.y / _ScreenExtends.z, u_xlat0.z / _ScreenExtends.w);
    u_xlat0.xyz = (-u_xlat0.xyz) + vec3(0.99000001, 0.5, 0.5);
    u_xlat9 = max(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat9 = float(1.0) / u_xlat9;
    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat9 = u_xlat9 * u_xlat1.x;
    u_xlat1.x = u_xlat9 * u_xlat9;
    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat9 * u_xlat1.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(abs(u_xlat0.z)<abs(u_xlat0.y));
#else
    u_xlatb7 = abs(u_xlat0.z)<abs(u_xlat0.y);
#endif
    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
    u_xlat9 = u_xlat9 * u_xlat1.x + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat0.z)<u_xlat0.z);
#else
    u_xlatb1 = (-u_xlat0.z)<u_xlat0.z;
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat9 = u_xlat9 + u_xlat1.x;
    u_xlat1.x = min((-u_xlat0.z), (-u_xlat0.y));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlat4 = max((-u_xlat0.z), (-u_xlat0.y));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlatb1 = u_xlatb4 && u_xlatb1;
    u_xlat9 = (u_xlatb1) ? (-u_xlat9) : u_xlat9;
    u_xlat9 = u_xlat9 + 3.14159274;
    u_xlat9 = u_xlat9 * 0.159154937;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.y = !!(_TimerFillValue>=u_xlat9);
#else
    u_xlatb6.y = _TimerFillValue>=u_xlat9;
#endif
    u_xlat0.x = (-u_xlat0.x) + _FillAmt;
    u_xlat3 = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlat3 = sqrt(u_xlat3);
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat6.x = (-_UnfilledOuterFeather) + _UnfilledOuterThickness;
    u_xlat3 = (-u_xlat6.x) + u_xlat3;
    u_xlat1.x = _UnfilledOuterFeather + _UnfilledOuterThickness;
    u_xlat6.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat3 = u_xlat6.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat3 * -2.0 + 3.0;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat6.x;
    u_xlat6.x = _UnfillOuter + -1.0;
    u_xlat6.x = u_xlat3 * u_xlat6.x + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat10_1.xyz * _UnfillColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) * u_xlat6.xxx + u_xlat10_1.xyz;
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(_FillAmt>=1.0);
#else
    u_xlatb6.x = _FillAmt>=1.0;
#endif
    u_xlat6.xy = mix(vec2(0.0, 0.0), vec2(1.0, 0.200000003), vec2(u_xlatb6.xy));
    u_xlat3 = u_xlat6.x * u_xlat3;
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat6.yyy + u_xlat1.xyz;
    u_xlat3 = (-_UnfillColor.w) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _UnfillColor.w;
    SV_Target0.w = min(u_xlat0.x, u_xlat10_1.w);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UnfillColor;
uniform 	float _UnfillOuter;
uniform 	float _UnfilledOuterFeather;
uniform 	float _UnfilledOuterThickness;
uniform 	float _FillAmt;
uniform 	float _TimerFillValue;
uniform 	vec4 _ScreenExtends;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
float u_xlat3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat6;
bvec2 u_xlatb6;
bool u_xlatb7;
float u_xlat9;
void main()
{
    u_xlat0.xyz = vec3(vs_TEXCOORD1.y + (-_ScreenExtends.y), vs_TEXCOORD1.x + (-_ScreenExtends.x), vs_TEXCOORD1.y + (-_ScreenExtends.y));
    u_xlat0.xyz = vec3(u_xlat0.x / _ScreenExtends.w, u_xlat0.y / _ScreenExtends.z, u_xlat0.z / _ScreenExtends.w);
    u_xlat0.xyz = (-u_xlat0.xyz) + vec3(0.99000001, 0.5, 0.5);
    u_xlat9 = max(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat9 = float(1.0) / u_xlat9;
    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat9 = u_xlat9 * u_xlat1.x;
    u_xlat1.x = u_xlat9 * u_xlat9;
    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat9 * u_xlat1.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(abs(u_xlat0.z)<abs(u_xlat0.y));
#else
    u_xlatb7 = abs(u_xlat0.z)<abs(u_xlat0.y);
#endif
    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
    u_xlat9 = u_xlat9 * u_xlat1.x + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat0.z)<u_xlat0.z);
#else
    u_xlatb1 = (-u_xlat0.z)<u_xlat0.z;
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat9 = u_xlat9 + u_xlat1.x;
    u_xlat1.x = min((-u_xlat0.z), (-u_xlat0.y));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlat4 = max((-u_xlat0.z), (-u_xlat0.y));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlatb1 = u_xlatb4 && u_xlatb1;
    u_xlat9 = (u_xlatb1) ? (-u_xlat9) : u_xlat9;
    u_xlat9 = u_xlat9 + 3.14159274;
    u_xlat9 = u_xlat9 * 0.159154937;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.y = !!(_TimerFillValue>=u_xlat9);
#else
    u_xlatb6.y = _TimerFillValue>=u_xlat9;
#endif
    u_xlat0.x = (-u_xlat0.x) + _FillAmt;
    u_xlat3 = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlat3 = sqrt(u_xlat3);
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat6.x = (-_UnfilledOuterFeather) + _UnfilledOuterThickness;
    u_xlat3 = (-u_xlat6.x) + u_xlat3;
    u_xlat1.x = _UnfilledOuterFeather + _UnfilledOuterThickness;
    u_xlat6.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat3 = u_xlat6.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat3 * -2.0 + 3.0;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat6.x;
    u_xlat6.x = _UnfillOuter + -1.0;
    u_xlat6.x = u_xlat3 * u_xlat6.x + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat10_1.xyz * _UnfillColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) * u_xlat6.xxx + u_xlat10_1.xyz;
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(_FillAmt>=1.0);
#else
    u_xlatb6.x = _FillAmt>=1.0;
#endif
    u_xlat6.xy = mix(vec2(0.0, 0.0), vec2(1.0, 0.200000003), vec2(u_xlatb6.xy));
    u_xlat3 = u_xlat6.x * u_xlat3;
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat6.yyy + u_xlat1.xyz;
    u_xlat3 = (-_UnfillColor.w) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _UnfillColor.w;
    SV_Target0.w = min(u_xlat0.x, u_xlat10_1.w);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UnfillColor;
uniform 	float _UnfillOuter;
uniform 	float _UnfilledOuterFeather;
uniform 	float _UnfilledOuterThickness;
uniform 	float _FillAmt;
uniform 	float _TimerFillValue;
uniform 	vec4 _ScreenExtends;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
float u_xlat3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat6;
bvec2 u_xlatb6;
bool u_xlatb7;
float u_xlat9;
void main()
{
    u_xlat0.xyz = vec3(vs_TEXCOORD1.y + (-_ScreenExtends.y), vs_TEXCOORD1.x + (-_ScreenExtends.x), vs_TEXCOORD1.y + (-_ScreenExtends.y));
    u_xlat0.xyz = vec3(u_xlat0.x / _ScreenExtends.w, u_xlat0.y / _ScreenExtends.z, u_xlat0.z / _ScreenExtends.w);
    u_xlat0.xyz = (-u_xlat0.xyz) + vec3(0.99000001, 0.5, 0.5);
    u_xlat9 = max(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat9 = float(1.0) / u_xlat9;
    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat9 = u_xlat9 * u_xlat1.x;
    u_xlat1.x = u_xlat9 * u_xlat9;
    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat9 * u_xlat1.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(abs(u_xlat0.z)<abs(u_xlat0.y));
#else
    u_xlatb7 = abs(u_xlat0.z)<abs(u_xlat0.y);
#endif
    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
    u_xlat9 = u_xlat9 * u_xlat1.x + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat0.z)<u_xlat0.z);
#else
    u_xlatb1 = (-u_xlat0.z)<u_xlat0.z;
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat9 = u_xlat9 + u_xlat1.x;
    u_xlat1.x = min((-u_xlat0.z), (-u_xlat0.y));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlat4 = max((-u_xlat0.z), (-u_xlat0.y));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlatb1 = u_xlatb4 && u_xlatb1;
    u_xlat9 = (u_xlatb1) ? (-u_xlat9) : u_xlat9;
    u_xlat9 = u_xlat9 + 3.14159274;
    u_xlat9 = u_xlat9 * 0.159154937;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.y = !!(_TimerFillValue>=u_xlat9);
#else
    u_xlatb6.y = _TimerFillValue>=u_xlat9;
#endif
    u_xlat0.x = (-u_xlat0.x) + _FillAmt;
    u_xlat3 = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlat3 = sqrt(u_xlat3);
    u_xlat0.x = u_xlat0.x * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat6.x = (-_UnfilledOuterFeather) + _UnfilledOuterThickness;
    u_xlat3 = (-u_xlat6.x) + u_xlat3;
    u_xlat1.x = _UnfilledOuterFeather + _UnfilledOuterThickness;
    u_xlat6.x = (-u_xlat6.x) + u_xlat1.x;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat3 = u_xlat6.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat3 * -2.0 + 3.0;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat6.x;
    u_xlat6.x = _UnfillOuter + -1.0;
    u_xlat6.x = u_xlat3 * u_xlat6.x + 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat10_1.xyz * _UnfillColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) * u_xlat6.xxx + u_xlat10_1.xyz;
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(_FillAmt>=1.0);
#else
    u_xlatb6.x = _FillAmt>=1.0;
#endif
    u_xlat6.xy = mix(vec2(0.0, 0.0), vec2(1.0, 0.200000003), vec2(u_xlatb6.xy));
    u_xlat3 = u_xlat6.x * u_xlat3;
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat6.yyy + u_xlat1.xyz;
    u_xlat3 = (-_UnfillColor.w) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _UnfillColor.w;
    SV_Target0.w = min(u_xlat0.x, u_xlat10_1.w);
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
Fallback "Diffuse"
}