Shader "Hidden/Internal-GUIRoundedRect" {
Properties {
_MainTex ("Texture", any) = "white" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 62409
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 hlslcc_mtx4x4unity_GUIClipTextureMatrix[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * u_xlat0.ww + u_xlat0.xy;
    u_xlat2.xy = u_xlat0.yy * hlslcc_mtx4x4unity_GUIClipTextureMatrix[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_GUIClipTextureMatrix[0].xy * u_xlat0.xx + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy + hlslcc_mtx4x4unity_GUIClipTextureMatrix[3].xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _CornerRadiuses[4];
uniform 	float _BorderWidths[4];
uniform 	float _Rect[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GUIClipTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
bvec3 u_xlatb6;
float u_xlat7;
bool u_xlatb7;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
ivec2 u_xlati13;
bvec2 u_xlatb13;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = _BorderWidths[0] + _BorderWidths[2];
    u_xlat0 = (-u_xlat0) + _Rect[2];
    u_xlat6.x = _BorderWidths[0] + _Rect[0];
    u_xlat0 = u_xlat0 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vs_TEXCOORD2.x>=u_xlat6.x);
#else
    u_xlatb6.x = vs_TEXCOORD2.x>=u_xlat6.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0>=vs_TEXCOORD2.x);
#else
    u_xlatb0 = u_xlat0>=vs_TEXCOORD2.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb6.x;
    u_xlat6.x = _BorderWidths[1] + _Rect[1];
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD2.y>=u_xlat6.x);
#else
    u_xlatb12 = vs_TEXCOORD2.y>=u_xlat6.x;
#endif
    u_xlatb0 = u_xlatb12 && u_xlatb0;
    u_xlat12 = _BorderWidths[1] + _BorderWidths[3];
    u_xlat12 = (-u_xlat12) + _Rect[3];
    u_xlat6.x = u_xlat12 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(u_xlat6.x>=vs_TEXCOORD2.y);
#else
    u_xlatb6.x = u_xlat6.x>=vs_TEXCOORD2.y;
#endif
    u_xlatb0 = u_xlatb6.x && u_xlatb0;
    u_xlat1.x = _BorderWidths[0];
    u_xlat2.x = _BorderWidths[2];
    u_xlat6.x = vs_TEXCOORD2.x + (-_Rect[0]);
    u_xlat6.x = (-_Rect[2]) * 0.5 + u_xlat6.x;
    u_xlat12 = _Rect[0] + _Rect[2];
    u_xlat18 = vs_TEXCOORD2.y + (-_Rect[1]);
    u_xlat6.z = (-_Rect[3]) * 0.5 + u_xlat18;
    u_xlatb6.xz = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xxzz).xz;
    u_xlati13.xy = (u_xlatb6.z) ? ivec2(0, 1) : ivec2(3, 2);
    u_xlati13.x = (u_xlatb6.x) ? u_xlati13.x : u_xlati13.y;
    u_xlat2.y = u_xlat12 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat1.y = _Rect[0] + _CornerRadiuses[u_xlati13.x];
    u_xlat2.xy = (u_xlatb6.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat15.x = _BorderWidths[1];
    u_xlat16.x = _BorderWidths[3];
    u_xlat12 = _Rect[1] + _Rect[3];
    u_xlat16.y = u_xlat12 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat15.y = _Rect[1] + _CornerRadiuses[u_xlati13.x];
    u_xlat2.zw = (u_xlatb6.z) ? u_xlat15.xy : u_xlat16.xy;
    u_xlat1.xy = (-u_xlat2.xz) + vec2(_CornerRadiuses[u_xlati13.x]);
    u_xlat12 = u_xlat1.x / u_xlat1.y;
    u_xlat3.xy = vec2((-u_xlat2.y) + vs_TEXCOORD2.x, (-u_xlat2.w) + vs_TEXCOORD2.y);
    u_xlat3.z = u_xlat12 * u_xlat3.y;
    u_xlat12 = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat19 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat13 = u_xlat19 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = (-u_xlat1.x) + u_xlat12;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1.xyxx).xy;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    u_xlat7 = dFdx(vs_TEXCOORD2.x);
    u_xlat7 = float(1.0) / abs(u_xlat7);
    u_xlat12 = u_xlat12 * u_xlat7 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat13 * u_xlat7 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb1.x) ? u_xlat12 : 1.0;
    u_xlatb1.xz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xxzx).xz;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlat12 = u_xlatb1.x ? u_xlat12 : float(0.0);
    u_xlat1.x = u_xlatb1.x ? u_xlat7 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.x==0.0);
#else
    u_xlatb7 = u_xlat1.x==0.0;
#endif
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat12 = (u_xlatb7) ? u_xlat12 : u_xlat1.x;
    u_xlatb1.xy = greaterThanEqual(u_xlat2.ywyy, vs_TEXCOORD2.xyxx).xy;
    u_xlatb13.xy = greaterThanEqual(vs_TEXCOORD2.xyxy, u_xlat2.ywyw).xy;
    u_xlatb6.x = (u_xlatb6.x) ? u_xlatb1.x : u_xlatb13.x;
    u_xlatb6.z = (u_xlatb6.z) ? u_xlatb1.y : u_xlatb13.y;
    u_xlatb6.x = u_xlatb6.z && u_xlatb6.x;
    u_xlat12 = (u_xlatb6.x) ? u_xlat12 : 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat12 = u_xlat12 * u_xlat1.w;
    u_xlat0 = (u_xlatb0) ? 0.0 : u_xlat12;
    u_xlat16_5 = (u_xlatb6.x) ? u_xlat12 : u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_BorderWidths[0]);
#else
    u_xlatb0 = 0.0<_BorderWidths[0];
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[1]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[1];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[2]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[2];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[3]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[3];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
    u_xlat0 = (u_xlatb0) ? u_xlat16_5 : 1.0;
    u_xlat0 = u_xlat0 * u_xlat12;
    u_xlat10_6 = texture(_GUIClipTexture, vs_TEXCOORD1.xy).w;
    u_xlat1.w = u_xlat10_6 * u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 hlslcc_mtx4x4unity_GUIClipTextureMatrix[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * u_xlat0.ww + u_xlat0.xy;
    u_xlat2.xy = u_xlat0.yy * hlslcc_mtx4x4unity_GUIClipTextureMatrix[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_GUIClipTextureMatrix[0].xy * u_xlat0.xx + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy + hlslcc_mtx4x4unity_GUIClipTextureMatrix[3].xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _CornerRadiuses[4];
uniform 	float _BorderWidths[4];
uniform 	float _Rect[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GUIClipTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
bvec3 u_xlatb6;
float u_xlat7;
bool u_xlatb7;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
ivec2 u_xlati13;
bvec2 u_xlatb13;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = _BorderWidths[0] + _BorderWidths[2];
    u_xlat0 = (-u_xlat0) + _Rect[2];
    u_xlat6.x = _BorderWidths[0] + _Rect[0];
    u_xlat0 = u_xlat0 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vs_TEXCOORD2.x>=u_xlat6.x);
#else
    u_xlatb6.x = vs_TEXCOORD2.x>=u_xlat6.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0>=vs_TEXCOORD2.x);
#else
    u_xlatb0 = u_xlat0>=vs_TEXCOORD2.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb6.x;
    u_xlat6.x = _BorderWidths[1] + _Rect[1];
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD2.y>=u_xlat6.x);
#else
    u_xlatb12 = vs_TEXCOORD2.y>=u_xlat6.x;
#endif
    u_xlatb0 = u_xlatb12 && u_xlatb0;
    u_xlat12 = _BorderWidths[1] + _BorderWidths[3];
    u_xlat12 = (-u_xlat12) + _Rect[3];
    u_xlat6.x = u_xlat12 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(u_xlat6.x>=vs_TEXCOORD2.y);
#else
    u_xlatb6.x = u_xlat6.x>=vs_TEXCOORD2.y;
#endif
    u_xlatb0 = u_xlatb6.x && u_xlatb0;
    u_xlat1.x = _BorderWidths[0];
    u_xlat2.x = _BorderWidths[2];
    u_xlat6.x = vs_TEXCOORD2.x + (-_Rect[0]);
    u_xlat6.x = (-_Rect[2]) * 0.5 + u_xlat6.x;
    u_xlat12 = _Rect[0] + _Rect[2];
    u_xlat18 = vs_TEXCOORD2.y + (-_Rect[1]);
    u_xlat6.z = (-_Rect[3]) * 0.5 + u_xlat18;
    u_xlatb6.xz = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xxzz).xz;
    u_xlati13.xy = (u_xlatb6.z) ? ivec2(0, 1) : ivec2(3, 2);
    u_xlati13.x = (u_xlatb6.x) ? u_xlati13.x : u_xlati13.y;
    u_xlat2.y = u_xlat12 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat1.y = _Rect[0] + _CornerRadiuses[u_xlati13.x];
    u_xlat2.xy = (u_xlatb6.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat15.x = _BorderWidths[1];
    u_xlat16.x = _BorderWidths[3];
    u_xlat12 = _Rect[1] + _Rect[3];
    u_xlat16.y = u_xlat12 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat15.y = _Rect[1] + _CornerRadiuses[u_xlati13.x];
    u_xlat2.zw = (u_xlatb6.z) ? u_xlat15.xy : u_xlat16.xy;
    u_xlat1.xy = (-u_xlat2.xz) + vec2(_CornerRadiuses[u_xlati13.x]);
    u_xlat12 = u_xlat1.x / u_xlat1.y;
    u_xlat3.xy = vec2((-u_xlat2.y) + vs_TEXCOORD2.x, (-u_xlat2.w) + vs_TEXCOORD2.y);
    u_xlat3.z = u_xlat12 * u_xlat3.y;
    u_xlat12 = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat19 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat13 = u_xlat19 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = (-u_xlat1.x) + u_xlat12;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1.xyxx).xy;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    u_xlat7 = dFdx(vs_TEXCOORD2.x);
    u_xlat7 = float(1.0) / abs(u_xlat7);
    u_xlat12 = u_xlat12 * u_xlat7 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat13 * u_xlat7 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb1.x) ? u_xlat12 : 1.0;
    u_xlatb1.xz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xxzx).xz;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlat12 = u_xlatb1.x ? u_xlat12 : float(0.0);
    u_xlat1.x = u_xlatb1.x ? u_xlat7 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.x==0.0);
#else
    u_xlatb7 = u_xlat1.x==0.0;
#endif
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat12 = (u_xlatb7) ? u_xlat12 : u_xlat1.x;
    u_xlatb1.xy = greaterThanEqual(u_xlat2.ywyy, vs_TEXCOORD2.xyxx).xy;
    u_xlatb13.xy = greaterThanEqual(vs_TEXCOORD2.xyxy, u_xlat2.ywyw).xy;
    u_xlatb6.x = (u_xlatb6.x) ? u_xlatb1.x : u_xlatb13.x;
    u_xlatb6.z = (u_xlatb6.z) ? u_xlatb1.y : u_xlatb13.y;
    u_xlatb6.x = u_xlatb6.z && u_xlatb6.x;
    u_xlat12 = (u_xlatb6.x) ? u_xlat12 : 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat12 = u_xlat12 * u_xlat1.w;
    u_xlat0 = (u_xlatb0) ? 0.0 : u_xlat12;
    u_xlat16_5 = (u_xlatb6.x) ? u_xlat12 : u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_BorderWidths[0]);
#else
    u_xlatb0 = 0.0<_BorderWidths[0];
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[1]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[1];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[2]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[2];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[3]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[3];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
    u_xlat0 = (u_xlatb0) ? u_xlat16_5 : 1.0;
    u_xlat0 = u_xlat0 * u_xlat12;
    u_xlat10_6 = texture(_GUIClipTexture, vs_TEXCOORD1.xy).w;
    u_xlat1.w = u_xlat10_6 * u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 hlslcc_mtx4x4unity_GUIClipTextureMatrix[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * u_xlat0.ww + u_xlat0.xy;
    u_xlat2.xy = u_xlat0.yy * hlslcc_mtx4x4unity_GUIClipTextureMatrix[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_GUIClipTextureMatrix[0].xy * u_xlat0.xx + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy + hlslcc_mtx4x4unity_GUIClipTextureMatrix[3].xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _CornerRadiuses[4];
uniform 	float _BorderWidths[4];
uniform 	float _Rect[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GUIClipTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
bvec3 u_xlatb6;
float u_xlat7;
bool u_xlatb7;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
ivec2 u_xlati13;
bvec2 u_xlatb13;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = _BorderWidths[0] + _BorderWidths[2];
    u_xlat0 = (-u_xlat0) + _Rect[2];
    u_xlat6.x = _BorderWidths[0] + _Rect[0];
    u_xlat0 = u_xlat0 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vs_TEXCOORD2.x>=u_xlat6.x);
#else
    u_xlatb6.x = vs_TEXCOORD2.x>=u_xlat6.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0>=vs_TEXCOORD2.x);
#else
    u_xlatb0 = u_xlat0>=vs_TEXCOORD2.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb6.x;
    u_xlat6.x = _BorderWidths[1] + _Rect[1];
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD2.y>=u_xlat6.x);
#else
    u_xlatb12 = vs_TEXCOORD2.y>=u_xlat6.x;
#endif
    u_xlatb0 = u_xlatb12 && u_xlatb0;
    u_xlat12 = _BorderWidths[1] + _BorderWidths[3];
    u_xlat12 = (-u_xlat12) + _Rect[3];
    u_xlat6.x = u_xlat12 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(u_xlat6.x>=vs_TEXCOORD2.y);
#else
    u_xlatb6.x = u_xlat6.x>=vs_TEXCOORD2.y;
#endif
    u_xlatb0 = u_xlatb6.x && u_xlatb0;
    u_xlat1.x = _BorderWidths[0];
    u_xlat2.x = _BorderWidths[2];
    u_xlat6.x = vs_TEXCOORD2.x + (-_Rect[0]);
    u_xlat6.x = (-_Rect[2]) * 0.5 + u_xlat6.x;
    u_xlat12 = _Rect[0] + _Rect[2];
    u_xlat18 = vs_TEXCOORD2.y + (-_Rect[1]);
    u_xlat6.z = (-_Rect[3]) * 0.5 + u_xlat18;
    u_xlatb6.xz = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xxzz).xz;
    u_xlati13.xy = (u_xlatb6.z) ? ivec2(0, 1) : ivec2(3, 2);
    u_xlati13.x = (u_xlatb6.x) ? u_xlati13.x : u_xlati13.y;
    u_xlat2.y = u_xlat12 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat1.y = _Rect[0] + _CornerRadiuses[u_xlati13.x];
    u_xlat2.xy = (u_xlatb6.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat15.x = _BorderWidths[1];
    u_xlat16.x = _BorderWidths[3];
    u_xlat12 = _Rect[1] + _Rect[3];
    u_xlat16.y = u_xlat12 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat15.y = _Rect[1] + _CornerRadiuses[u_xlati13.x];
    u_xlat2.zw = (u_xlatb6.z) ? u_xlat15.xy : u_xlat16.xy;
    u_xlat1.xy = (-u_xlat2.xz) + vec2(_CornerRadiuses[u_xlati13.x]);
    u_xlat12 = u_xlat1.x / u_xlat1.y;
    u_xlat3.xy = vec2((-u_xlat2.y) + vs_TEXCOORD2.x, (-u_xlat2.w) + vs_TEXCOORD2.y);
    u_xlat3.z = u_xlat12 * u_xlat3.y;
    u_xlat12 = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat19 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat13 = u_xlat19 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = (-u_xlat1.x) + u_xlat12;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1.xyxx).xy;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    u_xlat7 = dFdx(vs_TEXCOORD2.x);
    u_xlat7 = float(1.0) / abs(u_xlat7);
    u_xlat12 = u_xlat12 * u_xlat7 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat13 * u_xlat7 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb1.x) ? u_xlat12 : 1.0;
    u_xlatb1.xz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xxzx).xz;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlat12 = u_xlatb1.x ? u_xlat12 : float(0.0);
    u_xlat1.x = u_xlatb1.x ? u_xlat7 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.x==0.0);
#else
    u_xlatb7 = u_xlat1.x==0.0;
#endif
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat12 = (u_xlatb7) ? u_xlat12 : u_xlat1.x;
    u_xlatb1.xy = greaterThanEqual(u_xlat2.ywyy, vs_TEXCOORD2.xyxx).xy;
    u_xlatb13.xy = greaterThanEqual(vs_TEXCOORD2.xyxy, u_xlat2.ywyw).xy;
    u_xlatb6.x = (u_xlatb6.x) ? u_xlatb1.x : u_xlatb13.x;
    u_xlatb6.z = (u_xlatb6.z) ? u_xlatb1.y : u_xlatb13.y;
    u_xlatb6.x = u_xlatb6.z && u_xlatb6.x;
    u_xlat12 = (u_xlatb6.x) ? u_xlat12 : 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat12 = u_xlat12 * u_xlat1.w;
    u_xlat0 = (u_xlatb0) ? 0.0 : u_xlat12;
    u_xlat16_5 = (u_xlatb6.x) ? u_xlat12 : u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_BorderWidths[0]);
#else
    u_xlatb0 = 0.0<_BorderWidths[0];
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[1]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[1];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[2]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[2];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[3]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[3];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
    u_xlat0 = (u_xlatb0) ? u_xlat16_5 : 1.0;
    u_xlat0 = u_xlat0 * u_xlat12;
    u_xlat10_6 = texture(_GUIClipTexture, vs_TEXCOORD1.xy).w;
    u_xlat1.w = u_xlat10_6 * u_xlat0;
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
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 77836
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 hlslcc_mtx4x4unity_GUIClipTextureMatrix[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * u_xlat0.ww + u_xlat0.xy;
    u_xlat2.xy = u_xlat0.yy * hlslcc_mtx4x4unity_GUIClipTextureMatrix[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_GUIClipTextureMatrix[0].xy * u_xlat0.xx + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy + hlslcc_mtx4x4unity_GUIClipTextureMatrix[3].xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _CornerRadiuses[4];
uniform 	float _BorderWidths[4];
uniform 	float _Rect[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GUIClipTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
bvec3 u_xlatb6;
float u_xlat7;
bool u_xlatb7;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
ivec2 u_xlati13;
bvec2 u_xlatb13;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = _BorderWidths[0] + _BorderWidths[2];
    u_xlat0 = (-u_xlat0) + _Rect[2];
    u_xlat6.x = _BorderWidths[0] + _Rect[0];
    u_xlat0 = u_xlat0 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vs_TEXCOORD2.x>=u_xlat6.x);
#else
    u_xlatb6.x = vs_TEXCOORD2.x>=u_xlat6.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0>=vs_TEXCOORD2.x);
#else
    u_xlatb0 = u_xlat0>=vs_TEXCOORD2.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb6.x;
    u_xlat6.x = _BorderWidths[1] + _Rect[1];
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD2.y>=u_xlat6.x);
#else
    u_xlatb12 = vs_TEXCOORD2.y>=u_xlat6.x;
#endif
    u_xlatb0 = u_xlatb12 && u_xlatb0;
    u_xlat12 = _BorderWidths[1] + _BorderWidths[3];
    u_xlat12 = (-u_xlat12) + _Rect[3];
    u_xlat6.x = u_xlat12 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(u_xlat6.x>=vs_TEXCOORD2.y);
#else
    u_xlatb6.x = u_xlat6.x>=vs_TEXCOORD2.y;
#endif
    u_xlatb0 = u_xlatb6.x && u_xlatb0;
    u_xlat1.x = _BorderWidths[0];
    u_xlat2.x = _BorderWidths[2];
    u_xlat6.x = vs_TEXCOORD2.x + (-_Rect[0]);
    u_xlat6.x = (-_Rect[2]) * 0.5 + u_xlat6.x;
    u_xlat12 = _Rect[0] + _Rect[2];
    u_xlat18 = vs_TEXCOORD2.y + (-_Rect[1]);
    u_xlat6.z = (-_Rect[3]) * 0.5 + u_xlat18;
    u_xlatb6.xz = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xxzz).xz;
    u_xlati13.xy = (u_xlatb6.z) ? ivec2(0, 1) : ivec2(3, 2);
    u_xlati13.x = (u_xlatb6.x) ? u_xlati13.x : u_xlati13.y;
    u_xlat2.y = u_xlat12 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat1.y = _Rect[0] + _CornerRadiuses[u_xlati13.x];
    u_xlat2.xy = (u_xlatb6.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat15.x = _BorderWidths[1];
    u_xlat16.x = _BorderWidths[3];
    u_xlat12 = _Rect[1] + _Rect[3];
    u_xlat16.y = u_xlat12 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat15.y = _Rect[1] + _CornerRadiuses[u_xlati13.x];
    u_xlat2.zw = (u_xlatb6.z) ? u_xlat15.xy : u_xlat16.xy;
    u_xlat1.xy = (-u_xlat2.xz) + vec2(_CornerRadiuses[u_xlati13.x]);
    u_xlat12 = u_xlat1.x / u_xlat1.y;
    u_xlat3.xy = vec2((-u_xlat2.y) + vs_TEXCOORD2.x, (-u_xlat2.w) + vs_TEXCOORD2.y);
    u_xlat3.z = u_xlat12 * u_xlat3.y;
    u_xlat12 = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat19 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat13 = u_xlat19 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = (-u_xlat1.x) + u_xlat12;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1.xyxx).xy;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    u_xlat7 = dFdx(vs_TEXCOORD2.x);
    u_xlat7 = float(1.0) / abs(u_xlat7);
    u_xlat12 = u_xlat12 * u_xlat7 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat13 * u_xlat7 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb1.x) ? u_xlat12 : 1.0;
    u_xlatb1.xz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xxzx).xz;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlat12 = u_xlatb1.x ? u_xlat12 : float(0.0);
    u_xlat1.x = u_xlatb1.x ? u_xlat7 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.x==0.0);
#else
    u_xlatb7 = u_xlat1.x==0.0;
#endif
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat12 = (u_xlatb7) ? u_xlat12 : u_xlat1.x;
    u_xlatb1.xy = greaterThanEqual(u_xlat2.ywyy, vs_TEXCOORD2.xyxx).xy;
    u_xlatb13.xy = greaterThanEqual(vs_TEXCOORD2.xyxy, u_xlat2.ywyw).xy;
    u_xlatb6.x = (u_xlatb6.x) ? u_xlatb1.x : u_xlatb13.x;
    u_xlatb6.z = (u_xlatb6.z) ? u_xlatb1.y : u_xlatb13.y;
    u_xlatb6.x = u_xlatb6.z && u_xlatb6.x;
    u_xlat12 = (u_xlatb6.x) ? u_xlat12 : 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat12 = u_xlat12 * u_xlat1.w;
    u_xlat0 = (u_xlatb0) ? 0.0 : u_xlat12;
    u_xlat16_5 = (u_xlatb6.x) ? u_xlat12 : u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_BorderWidths[0]);
#else
    u_xlatb0 = 0.0<_BorderWidths[0];
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[1]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[1];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[2]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[2];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[3]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[3];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
    u_xlat0 = (u_xlatb0) ? u_xlat16_5 : 1.0;
    u_xlat0 = u_xlat0 * u_xlat12;
    u_xlat10_6 = texture(_GUIClipTexture, vs_TEXCOORD1.xy).w;
    u_xlat1.w = u_xlat10_6 * u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 hlslcc_mtx4x4unity_GUIClipTextureMatrix[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * u_xlat0.ww + u_xlat0.xy;
    u_xlat2.xy = u_xlat0.yy * hlslcc_mtx4x4unity_GUIClipTextureMatrix[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_GUIClipTextureMatrix[0].xy * u_xlat0.xx + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy + hlslcc_mtx4x4unity_GUIClipTextureMatrix[3].xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _CornerRadiuses[4];
uniform 	float _BorderWidths[4];
uniform 	float _Rect[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GUIClipTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
bvec3 u_xlatb6;
float u_xlat7;
bool u_xlatb7;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
ivec2 u_xlati13;
bvec2 u_xlatb13;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = _BorderWidths[0] + _BorderWidths[2];
    u_xlat0 = (-u_xlat0) + _Rect[2];
    u_xlat6.x = _BorderWidths[0] + _Rect[0];
    u_xlat0 = u_xlat0 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vs_TEXCOORD2.x>=u_xlat6.x);
#else
    u_xlatb6.x = vs_TEXCOORD2.x>=u_xlat6.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0>=vs_TEXCOORD2.x);
#else
    u_xlatb0 = u_xlat0>=vs_TEXCOORD2.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb6.x;
    u_xlat6.x = _BorderWidths[1] + _Rect[1];
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD2.y>=u_xlat6.x);
#else
    u_xlatb12 = vs_TEXCOORD2.y>=u_xlat6.x;
#endif
    u_xlatb0 = u_xlatb12 && u_xlatb0;
    u_xlat12 = _BorderWidths[1] + _BorderWidths[3];
    u_xlat12 = (-u_xlat12) + _Rect[3];
    u_xlat6.x = u_xlat12 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(u_xlat6.x>=vs_TEXCOORD2.y);
#else
    u_xlatb6.x = u_xlat6.x>=vs_TEXCOORD2.y;
#endif
    u_xlatb0 = u_xlatb6.x && u_xlatb0;
    u_xlat1.x = _BorderWidths[0];
    u_xlat2.x = _BorderWidths[2];
    u_xlat6.x = vs_TEXCOORD2.x + (-_Rect[0]);
    u_xlat6.x = (-_Rect[2]) * 0.5 + u_xlat6.x;
    u_xlat12 = _Rect[0] + _Rect[2];
    u_xlat18 = vs_TEXCOORD2.y + (-_Rect[1]);
    u_xlat6.z = (-_Rect[3]) * 0.5 + u_xlat18;
    u_xlatb6.xz = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xxzz).xz;
    u_xlati13.xy = (u_xlatb6.z) ? ivec2(0, 1) : ivec2(3, 2);
    u_xlati13.x = (u_xlatb6.x) ? u_xlati13.x : u_xlati13.y;
    u_xlat2.y = u_xlat12 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat1.y = _Rect[0] + _CornerRadiuses[u_xlati13.x];
    u_xlat2.xy = (u_xlatb6.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat15.x = _BorderWidths[1];
    u_xlat16.x = _BorderWidths[3];
    u_xlat12 = _Rect[1] + _Rect[3];
    u_xlat16.y = u_xlat12 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat15.y = _Rect[1] + _CornerRadiuses[u_xlati13.x];
    u_xlat2.zw = (u_xlatb6.z) ? u_xlat15.xy : u_xlat16.xy;
    u_xlat1.xy = (-u_xlat2.xz) + vec2(_CornerRadiuses[u_xlati13.x]);
    u_xlat12 = u_xlat1.x / u_xlat1.y;
    u_xlat3.xy = vec2((-u_xlat2.y) + vs_TEXCOORD2.x, (-u_xlat2.w) + vs_TEXCOORD2.y);
    u_xlat3.z = u_xlat12 * u_xlat3.y;
    u_xlat12 = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat19 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat13 = u_xlat19 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = (-u_xlat1.x) + u_xlat12;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1.xyxx).xy;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    u_xlat7 = dFdx(vs_TEXCOORD2.x);
    u_xlat7 = float(1.0) / abs(u_xlat7);
    u_xlat12 = u_xlat12 * u_xlat7 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat13 * u_xlat7 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb1.x) ? u_xlat12 : 1.0;
    u_xlatb1.xz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xxzx).xz;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlat12 = u_xlatb1.x ? u_xlat12 : float(0.0);
    u_xlat1.x = u_xlatb1.x ? u_xlat7 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.x==0.0);
#else
    u_xlatb7 = u_xlat1.x==0.0;
#endif
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat12 = (u_xlatb7) ? u_xlat12 : u_xlat1.x;
    u_xlatb1.xy = greaterThanEqual(u_xlat2.ywyy, vs_TEXCOORD2.xyxx).xy;
    u_xlatb13.xy = greaterThanEqual(vs_TEXCOORD2.xyxy, u_xlat2.ywyw).xy;
    u_xlatb6.x = (u_xlatb6.x) ? u_xlatb1.x : u_xlatb13.x;
    u_xlatb6.z = (u_xlatb6.z) ? u_xlatb1.y : u_xlatb13.y;
    u_xlatb6.x = u_xlatb6.z && u_xlatb6.x;
    u_xlat12 = (u_xlatb6.x) ? u_xlat12 : 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat12 = u_xlat12 * u_xlat1.w;
    u_xlat0 = (u_xlatb0) ? 0.0 : u_xlat12;
    u_xlat16_5 = (u_xlatb6.x) ? u_xlat12 : u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_BorderWidths[0]);
#else
    u_xlatb0 = 0.0<_BorderWidths[0];
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[1]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[1];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[2]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[2];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[3]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[3];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
    u_xlat0 = (u_xlatb0) ? u_xlat16_5 : 1.0;
    u_xlat0 = u_xlat0 * u_xlat12;
    u_xlat10_6 = texture(_GUIClipTexture, vs_TEXCOORD1.xy).w;
    u_xlat1.w = u_xlat10_6 * u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 hlslcc_mtx4x4unity_GUIClipTextureMatrix[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * u_xlat0.ww + u_xlat0.xy;
    u_xlat2.xy = u_xlat0.yy * hlslcc_mtx4x4unity_GUIClipTextureMatrix[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_GUIClipTextureMatrix[0].xy * u_xlat0.xx + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy + hlslcc_mtx4x4unity_GUIClipTextureMatrix[3].xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _CornerRadiuses[4];
uniform 	float _BorderWidths[4];
uniform 	float _Rect[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GUIClipTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
bvec3 u_xlatb6;
float u_xlat7;
bool u_xlatb7;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
ivec2 u_xlati13;
bvec2 u_xlatb13;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = _BorderWidths[0] + _BorderWidths[2];
    u_xlat0 = (-u_xlat0) + _Rect[2];
    u_xlat6.x = _BorderWidths[0] + _Rect[0];
    u_xlat0 = u_xlat0 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vs_TEXCOORD2.x>=u_xlat6.x);
#else
    u_xlatb6.x = vs_TEXCOORD2.x>=u_xlat6.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0>=vs_TEXCOORD2.x);
#else
    u_xlatb0 = u_xlat0>=vs_TEXCOORD2.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb6.x;
    u_xlat6.x = _BorderWidths[1] + _Rect[1];
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD2.y>=u_xlat6.x);
#else
    u_xlatb12 = vs_TEXCOORD2.y>=u_xlat6.x;
#endif
    u_xlatb0 = u_xlatb12 && u_xlatb0;
    u_xlat12 = _BorderWidths[1] + _BorderWidths[3];
    u_xlat12 = (-u_xlat12) + _Rect[3];
    u_xlat6.x = u_xlat12 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(u_xlat6.x>=vs_TEXCOORD2.y);
#else
    u_xlatb6.x = u_xlat6.x>=vs_TEXCOORD2.y;
#endif
    u_xlatb0 = u_xlatb6.x && u_xlatb0;
    u_xlat1.x = _BorderWidths[0];
    u_xlat2.x = _BorderWidths[2];
    u_xlat6.x = vs_TEXCOORD2.x + (-_Rect[0]);
    u_xlat6.x = (-_Rect[2]) * 0.5 + u_xlat6.x;
    u_xlat12 = _Rect[0] + _Rect[2];
    u_xlat18 = vs_TEXCOORD2.y + (-_Rect[1]);
    u_xlat6.z = (-_Rect[3]) * 0.5 + u_xlat18;
    u_xlatb6.xz = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xxzz).xz;
    u_xlati13.xy = (u_xlatb6.z) ? ivec2(0, 1) : ivec2(3, 2);
    u_xlati13.x = (u_xlatb6.x) ? u_xlati13.x : u_xlati13.y;
    u_xlat2.y = u_xlat12 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat1.y = _Rect[0] + _CornerRadiuses[u_xlati13.x];
    u_xlat2.xy = (u_xlatb6.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat15.x = _BorderWidths[1];
    u_xlat16.x = _BorderWidths[3];
    u_xlat12 = _Rect[1] + _Rect[3];
    u_xlat16.y = u_xlat12 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat15.y = _Rect[1] + _CornerRadiuses[u_xlati13.x];
    u_xlat2.zw = (u_xlatb6.z) ? u_xlat15.xy : u_xlat16.xy;
    u_xlat1.xy = (-u_xlat2.xz) + vec2(_CornerRadiuses[u_xlati13.x]);
    u_xlat12 = u_xlat1.x / u_xlat1.y;
    u_xlat3.xy = vec2((-u_xlat2.y) + vs_TEXCOORD2.x, (-u_xlat2.w) + vs_TEXCOORD2.y);
    u_xlat3.z = u_xlat12 * u_xlat3.y;
    u_xlat12 = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat19 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat13 = u_xlat19 + (-_CornerRadiuses[u_xlati13.x]);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat12 = (-u_xlat1.x) + u_xlat12;
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1.xyxx).xy;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    u_xlat7 = dFdx(vs_TEXCOORD2.x);
    u_xlat7 = float(1.0) / abs(u_xlat7);
    u_xlat12 = u_xlat12 * u_xlat7 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat13 * u_xlat7 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb1.x) ? u_xlat12 : 1.0;
    u_xlatb1.xz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xxzx).xz;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlat12 = u_xlatb1.x ? u_xlat12 : float(0.0);
    u_xlat1.x = u_xlatb1.x ? u_xlat7 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat1.x==0.0);
#else
    u_xlatb7 = u_xlat1.x==0.0;
#endif
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat12 = (u_xlatb7) ? u_xlat12 : u_xlat1.x;
    u_xlatb1.xy = greaterThanEqual(u_xlat2.ywyy, vs_TEXCOORD2.xyxx).xy;
    u_xlatb13.xy = greaterThanEqual(vs_TEXCOORD2.xyxy, u_xlat2.ywyw).xy;
    u_xlatb6.x = (u_xlatb6.x) ? u_xlatb1.x : u_xlatb13.x;
    u_xlatb6.z = (u_xlatb6.z) ? u_xlatb1.y : u_xlatb13.y;
    u_xlatb6.x = u_xlatb6.z && u_xlatb6.x;
    u_xlat12 = (u_xlatb6.x) ? u_xlat12 : 1.0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat12 = u_xlat12 * u_xlat1.w;
    u_xlat0 = (u_xlatb0) ? 0.0 : u_xlat12;
    u_xlat16_5 = (u_xlatb6.x) ? u_xlat12 : u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_BorderWidths[0]);
#else
    u_xlatb0 = 0.0<_BorderWidths[0];
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[1]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[1];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[2]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[2];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.0<_BorderWidths[3]);
#else
    u_xlatb6.x = 0.0<_BorderWidths[3];
#endif
    u_xlatb0 = u_xlatb6.x || u_xlatb0;
    u_xlat0 = (u_xlatb0) ? u_xlat16_5 : 1.0;
    u_xlat0 = u_xlat0 * u_xlat12;
    u_xlat10_6 = texture(_GUIClipTexture, vs_TEXCOORD1.xy).w;
    u_xlat1.w = u_xlat10_6 * u_xlat0;
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
Fallback "Hidden/Internal-GUITextureClip"
}