Shader "Sprites/Mask" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_AlphaTex ("External Alpha", 2D) = "white" { }
_Cutoff ("Mask alpha cutoff", Range(0, 1)) = 0
_Color ("Tint", Color) = (1,1,1,0.2)
_EnableExternalAlpha ("Enable External Alpha", Float) = 0
[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 59372
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = _Color;
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
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = _Color;
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
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ETC1_EXTERNAL_ALPHA" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _EnableExternalAlpha;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
lowp float u_xlat10_2;
void main()
{
    u_xlat10_0 = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = (-u_xlat10_2) + u_xlat10_0;
    u_xlat0 = _EnableExternalAlpha * u_xlat16_0 + u_xlat10_2;
    u_xlat16_1 = u_xlat0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ETC1_EXTERNAL_ALPHA" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _EnableExternalAlpha;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
lowp float u_xlat10_2;
void main()
{
    u_xlat10_0 = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = (-u_xlat10_2) + u_xlat10_0;
    u_xlat0 = _EnableExternalAlpha * u_xlat16_0 + u_xlat10_2;
    u_xlat16_1 = u_xlat0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ETC1_EXTERNAL_ALPHA" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _EnableExternalAlpha;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
lowp float u_xlat10_2;
void main()
{
    u_xlat10_0 = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = (-u_xlat10_2) + u_xlat10_0;
    u_xlat0 = _EnableExternalAlpha * u_xlat16_0 + u_xlat10_2;
    u_xlat16_1 = u_xlat0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _EnableExternalAlpha;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
lowp float u_xlat10_2;
void main()
{
    u_xlat10_0 = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = (-u_xlat10_2) + u_xlat10_0;
    u_xlat0 = _EnableExternalAlpha * u_xlat16_0 + u_xlat10_2;
    u_xlat16_1 = u_xlat0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _EnableExternalAlpha;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
lowp float u_xlat10_2;
void main()
{
    u_xlat10_0 = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = (-u_xlat10_2) + u_xlat10_0;
    u_xlat0 = _EnableExternalAlpha * u_xlat16_0 + u_xlat10_2;
    u_xlat16_1 = u_xlat0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _EnableExternalAlpha;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
lowp float u_xlat10_2;
void main()
{
    u_xlat10_0 = texture(_AlphaTex, vs_TEXCOORD0.xy).x;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = (-u_xlat10_2) + u_xlat10_0;
    u_xlat0 = _EnableExternalAlpha * u_xlat16_0 + u_xlat10_2;
    u_xlat16_1 = u_xlat0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = _Color;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "ETC1_EXTERNAL_ALPHA" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ETC1_EXTERNAL_ALPHA" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ETC1_EXTERNAL_ALPHA" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PIXELSNAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PIXELSNAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PIXELSNAP_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
""
}
}
}
}
}