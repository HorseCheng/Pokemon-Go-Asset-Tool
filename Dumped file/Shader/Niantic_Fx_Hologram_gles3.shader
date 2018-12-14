Shader "Niantic/Fx/Hologram" {
Properties {
_Color ("Tint Color", Color) = (1,1,1,1)
_MainTex ("Texture", 2D) = "white" { }
_ScanFrequency ("Scan Line Frequency", Float) = 1
_ScanSpeed ("Scan Line Speed", Float) = 1
_ScanMin ("Scan Strength (Minimum)", Float) = 0.7
_ScanMax ("Scan Strength (Maximum)", Float) = 1.25
_ScanColor ("Scan Color", Color) = (0.2,0.2,0.2,0.7)
_RandomOffset ("Random Offset (set by code per instance)", Vector) = (0,0,0,0)
_FlickerOffsetTime ("Flicker Offset Time", Float) = 1
_FlickerSpeed ("Flicker Speed", Float) = 10
_PhaseSpeed ("Phase Speed", Float) = 0.03
_PhaseEndBias ("Phase End Bias", Float) = 4
_PhaseInBias ("Phase In Bias", Range(0, 1)) = 0.5
}
SubShader {
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 42197
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerOffsetTime;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat3;
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
    u_xlat0 = _Time.yyyy + _RandomOffset.xyyy;
    u_xlat0 = u_xlat0 * vec4(_FlickerOffsetTime, _FlickerSpeed, _FlickerSpeed, _FlickerSpeed);
    u_xlat1.x = u_xlat0.w * _PhaseSpeed;
    u_xlat3 = u_xlat1.x * 3.4000001;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat3 = cos(u_xlat3);
    u_xlat3 = u_xlat3 * _PhaseEndBias;
    u_xlat1.x = u_xlat1.x * _PhaseEndBias + u_xlat3;
    vs_TEXCOORD1.w = u_xlat1.x + _PhaseEndBias;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD1.w = min(max(vs_TEXCOORD1.w, 0.0), 1.0);
#else
    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat0 * vec4(0.699999988, 1.70000005, 11.6999998, 9.30000019);
    u_xlat0.xy = sin(u_xlat0.xw);
    u_xlat0.z = sin(u_xlat1.z);
    u_xlat1.xyz = cos(u_xlat1.xyw);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.5);
#else
    u_xlatb0 = u_xlat0.x>=0.5;
#endif
    vs_TEXCOORD1.yz = ceil(u_xlat0.yz);
    vs_TEXCOORD1.x = u_xlatb0 ? 1.0 : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMin;
uniform 	mediump float _ScanMax;
uniform 	mediump vec4 _ScanColor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = _Time.x * _ScanSpeed;
    u_xlat0 = gl_FragCoord.y * _ScanFrequency + u_xlat0;
    u_xlat0 = sin(u_xlat0);
    u_xlat0 = max(u_xlat0, _ScanMin);
    u_xlat0 = min(u_xlat0, _ScanMax);
    u_xlat0 = max(u_xlat0, vs_TEXCOORD1.w);
    u_xlat0 = min(u_xlat0, _ScanMax);
    u_xlat16_1 = max(u_xlat0, _ScanColor.w);
    u_xlat16_4.xyz = _Color.xyz + _Color.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_4.xyz + (-_ScanColor.xyz);
    u_xlat16_2.w = u_xlat10_0.w + (-_ScanColor.w);
    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_2 + _ScanColor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerOffsetTime;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat3;
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
    u_xlat0 = _Time.yyyy + _RandomOffset.xyyy;
    u_xlat0 = u_xlat0 * vec4(_FlickerOffsetTime, _FlickerSpeed, _FlickerSpeed, _FlickerSpeed);
    u_xlat1.x = u_xlat0.w * _PhaseSpeed;
    u_xlat3 = u_xlat1.x * 3.4000001;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat3 = cos(u_xlat3);
    u_xlat3 = u_xlat3 * _PhaseEndBias;
    u_xlat1.x = u_xlat1.x * _PhaseEndBias + u_xlat3;
    vs_TEXCOORD1.w = u_xlat1.x + _PhaseEndBias;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD1.w = min(max(vs_TEXCOORD1.w, 0.0), 1.0);
#else
    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat0 * vec4(0.699999988, 1.70000005, 11.6999998, 9.30000019);
    u_xlat0.xy = sin(u_xlat0.xw);
    u_xlat0.z = sin(u_xlat1.z);
    u_xlat1.xyz = cos(u_xlat1.xyw);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.5);
#else
    u_xlatb0 = u_xlat0.x>=0.5;
#endif
    vs_TEXCOORD1.yz = ceil(u_xlat0.yz);
    vs_TEXCOORD1.x = u_xlatb0 ? 1.0 : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMin;
uniform 	mediump float _ScanMax;
uniform 	mediump vec4 _ScanColor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = _Time.x * _ScanSpeed;
    u_xlat0 = gl_FragCoord.y * _ScanFrequency + u_xlat0;
    u_xlat0 = sin(u_xlat0);
    u_xlat0 = max(u_xlat0, _ScanMin);
    u_xlat0 = min(u_xlat0, _ScanMax);
    u_xlat0 = max(u_xlat0, vs_TEXCOORD1.w);
    u_xlat0 = min(u_xlat0, _ScanMax);
    u_xlat16_1 = max(u_xlat0, _ScanColor.w);
    u_xlat16_4.xyz = _Color.xyz + _Color.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_4.xyz + (-_ScanColor.xyz);
    u_xlat16_2.w = u_xlat10_0.w + (-_ScanColor.w);
    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_2 + _ScanColor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerOffsetTime;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat3;
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
    u_xlat0 = _Time.yyyy + _RandomOffset.xyyy;
    u_xlat0 = u_xlat0 * vec4(_FlickerOffsetTime, _FlickerSpeed, _FlickerSpeed, _FlickerSpeed);
    u_xlat1.x = u_xlat0.w * _PhaseSpeed;
    u_xlat3 = u_xlat1.x * 3.4000001;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat3 = cos(u_xlat3);
    u_xlat3 = u_xlat3 * _PhaseEndBias;
    u_xlat1.x = u_xlat1.x * _PhaseEndBias + u_xlat3;
    vs_TEXCOORD1.w = u_xlat1.x + _PhaseEndBias;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD1.w = min(max(vs_TEXCOORD1.w, 0.0), 1.0);
#else
    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat0 * vec4(0.699999988, 1.70000005, 11.6999998, 9.30000019);
    u_xlat0.xy = sin(u_xlat0.xw);
    u_xlat0.z = sin(u_xlat1.z);
    u_xlat1.xyz = cos(u_xlat1.xyw);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.5);
#else
    u_xlatb0 = u_xlat0.x>=0.5;
#endif
    vs_TEXCOORD1.yz = ceil(u_xlat0.yz);
    vs_TEXCOORD1.x = u_xlatb0 ? 1.0 : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMin;
uniform 	mediump float _ScanMax;
uniform 	mediump vec4 _ScanColor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = _Time.x * _ScanSpeed;
    u_xlat0 = gl_FragCoord.y * _ScanFrequency + u_xlat0;
    u_xlat0 = sin(u_xlat0);
    u_xlat0 = max(u_xlat0, _ScanMin);
    u_xlat0 = min(u_xlat0, _ScanMax);
    u_xlat0 = max(u_xlat0, vs_TEXCOORD1.w);
    u_xlat0 = min(u_xlat0, _ScanMax);
    u_xlat16_1 = max(u_xlat0, _ScanColor.w);
    u_xlat16_4.xyz = _Color.xyz + _Color.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_4.xyz + (-_ScanColor.xyz);
    u_xlat16_2.w = u_xlat10_0.w + (-_ScanColor.w);
    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_2 + _ScanColor;
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