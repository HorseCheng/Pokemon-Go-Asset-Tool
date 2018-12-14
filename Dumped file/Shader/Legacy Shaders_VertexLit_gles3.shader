Shader "Legacy Shaders/VertexLit" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_SpecColor ("Spec Color", Color) = (1,1,1,1)
_Emission ("Emissive Color", Color) = (0,0,0,0)
_Shininess ("Shininess", Range(0.01, 1)) = 0.7
_MainTex ("Base (RGB)", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "Vertex" "RenderType" = "Opaque" }
  GpuProgramID 144514
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat36;
int u_xlati37;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_44 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_44 = max(u_xlat16_44, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_44) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(0.0<u_xlat16_44);
#else
        u_xlatb2 = 0.0<u_xlat16_44;
#endif
        if(u_xlatb2){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat36) + unity_LightPosition[u_xlati_loop_1].xyz;
            u_xlat16_44 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = inversesqrt(u_xlat16_44);
            u_xlat16_11.xyz = vec3(u_xlat16_44) * u_xlat16_11.xyz;
            u_xlat16_44 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = max(u_xlat16_44, 0.0);
            u_xlat16_44 = log2(u_xlat16_44);
            u_xlat16_44 = u_xlat16_43 * u_xlat16_44;
            u_xlat16_44 = exp2(u_xlat16_44);
            u_xlat16_44 = min(u_xlat16_44, 1.0);
            u_xlat16_44 = u_xlat16_44 * 0.5;
            u_xlat16_9.xyz = vec3(u_xlat16_44) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
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
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat36;
int u_xlati37;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_44 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_44 = max(u_xlat16_44, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_44) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(0.0<u_xlat16_44);
#else
        u_xlatb2 = 0.0<u_xlat16_44;
#endif
        if(u_xlatb2){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat36) + unity_LightPosition[u_xlati_loop_1].xyz;
            u_xlat16_44 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = inversesqrt(u_xlat16_44);
            u_xlat16_11.xyz = vec3(u_xlat16_44) * u_xlat16_11.xyz;
            u_xlat16_44 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = max(u_xlat16_44, 0.0);
            u_xlat16_44 = log2(u_xlat16_44);
            u_xlat16_44 = u_xlat16_43 * u_xlat16_44;
            u_xlat16_44 = exp2(u_xlat16_44);
            u_xlat16_44 = min(u_xlat16_44, 1.0);
            u_xlat16_44 = u_xlat16_44 * 0.5;
            u_xlat16_9.xyz = vec3(u_xlat16_44) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
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
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat36;
int u_xlati37;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_44 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_44 = max(u_xlat16_44, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_44) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(0.0<u_xlat16_44);
#else
        u_xlatb2 = 0.0<u_xlat16_44;
#endif
        if(u_xlatb2){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat36) + unity_LightPosition[u_xlati_loop_1].xyz;
            u_xlat16_44 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = inversesqrt(u_xlat16_44);
            u_xlat16_11.xyz = vec3(u_xlat16_44) * u_xlat16_11.xyz;
            u_xlat16_44 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = max(u_xlat16_44, 0.0);
            u_xlat16_44 = log2(u_xlat16_44);
            u_xlat16_44 = u_xlat16_43 * u_xlat16_44;
            u_xlat16_44 = exp2(u_xlat16_44);
            u_xlat16_44 = min(u_xlat16_44, 1.0);
            u_xlat16_44 = u_xlat16_44 * 0.5;
            u_xlat16_9.xyz = vec3(u_xlat16_44) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
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
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
bool u_xlatb15;
bool u_xlatb27;
float u_xlat36;
int u_xlati37;
float u_xlat38;
bool u_xlatb38;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat38 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat3.x = unity_LightAtten[u_xlati_loop_1].z * u_xlat38 + 1.0;
        u_xlat3.x = float(1.0) / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(0.0!=unity_LightPosition[u_xlati_loop_1].w);
#else
        u_xlatb15 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(unity_LightAtten[u_xlati_loop_1].w<u_xlat38);
#else
        u_xlatb27 = unity_LightAtten[u_xlati_loop_1].w<u_xlat38;
#endif
        u_xlatb15 = u_xlatb27 && u_xlatb15;
        u_xlat38 = max(u_xlat38, 9.99999997e-07);
        u_xlat38 = inversesqrt(u_xlat38);
        u_xlat2.xyz = vec3(u_xlat38) * u_xlat2.xyz;
        u_xlat38 = u_xlat3.x * 0.5;
        u_xlat16_44 = (u_xlatb15) ? 0.0 : u_xlat38;
        u_xlat16_45 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_45 = max(u_xlat16_45, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_45) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb38 = !!(0.0<u_xlat16_45);
#else
        u_xlatb38 = 0.0<u_xlat16_45;
#endif
        if(u_xlatb38){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat36) + u_xlat2.xyz;
            u_xlat16_45 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = inversesqrt(u_xlat16_45);
            u_xlat16_11.xyz = vec3(u_xlat16_45) * u_xlat16_11.xyz;
            u_xlat16_45 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = max(u_xlat16_45, 0.0);
            u_xlat16_45 = log2(u_xlat16_45);
            u_xlat16_45 = u_xlat16_43 * u_xlat16_45;
            u_xlat16_45 = exp2(u_xlat16_45);
            u_xlat16_45 = min(u_xlat16_45, 1.0);
            u_xlat16_45 = u_xlat16_44 * u_xlat16_45;
            u_xlat16_9.xyz = vec3(u_xlat16_45) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = vec3(u_xlat16_44) * u_xlat16_10.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
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
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
bool u_xlatb15;
bool u_xlatb27;
float u_xlat36;
int u_xlati37;
float u_xlat38;
bool u_xlatb38;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat38 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat3.x = unity_LightAtten[u_xlati_loop_1].z * u_xlat38 + 1.0;
        u_xlat3.x = float(1.0) / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(0.0!=unity_LightPosition[u_xlati_loop_1].w);
#else
        u_xlatb15 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(unity_LightAtten[u_xlati_loop_1].w<u_xlat38);
#else
        u_xlatb27 = unity_LightAtten[u_xlati_loop_1].w<u_xlat38;
#endif
        u_xlatb15 = u_xlatb27 && u_xlatb15;
        u_xlat38 = max(u_xlat38, 9.99999997e-07);
        u_xlat38 = inversesqrt(u_xlat38);
        u_xlat2.xyz = vec3(u_xlat38) * u_xlat2.xyz;
        u_xlat38 = u_xlat3.x * 0.5;
        u_xlat16_44 = (u_xlatb15) ? 0.0 : u_xlat38;
        u_xlat16_45 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_45 = max(u_xlat16_45, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_45) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb38 = !!(0.0<u_xlat16_45);
#else
        u_xlatb38 = 0.0<u_xlat16_45;
#endif
        if(u_xlatb38){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat36) + u_xlat2.xyz;
            u_xlat16_45 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = inversesqrt(u_xlat16_45);
            u_xlat16_11.xyz = vec3(u_xlat16_45) * u_xlat16_11.xyz;
            u_xlat16_45 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = max(u_xlat16_45, 0.0);
            u_xlat16_45 = log2(u_xlat16_45);
            u_xlat16_45 = u_xlat16_43 * u_xlat16_45;
            u_xlat16_45 = exp2(u_xlat16_45);
            u_xlat16_45 = min(u_xlat16_45, 1.0);
            u_xlat16_45 = u_xlat16_44 * u_xlat16_45;
            u_xlat16_9.xyz = vec3(u_xlat16_45) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = vec3(u_xlat16_44) * u_xlat16_10.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
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
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
bool u_xlatb15;
bool u_xlatb27;
float u_xlat36;
int u_xlati37;
float u_xlat38;
bool u_xlatb38;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat38 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat3.x = unity_LightAtten[u_xlati_loop_1].z * u_xlat38 + 1.0;
        u_xlat3.x = float(1.0) / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(0.0!=unity_LightPosition[u_xlati_loop_1].w);
#else
        u_xlatb15 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(unity_LightAtten[u_xlati_loop_1].w<u_xlat38);
#else
        u_xlatb27 = unity_LightAtten[u_xlati_loop_1].w<u_xlat38;
#endif
        u_xlatb15 = u_xlatb27 && u_xlatb15;
        u_xlat38 = max(u_xlat38, 9.99999997e-07);
        u_xlat38 = inversesqrt(u_xlat38);
        u_xlat2.xyz = vec3(u_xlat38) * u_xlat2.xyz;
        u_xlat38 = u_xlat3.x * 0.5;
        u_xlat16_44 = (u_xlatb15) ? 0.0 : u_xlat38;
        u_xlat16_45 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_45 = max(u_xlat16_45, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_45) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb38 = !!(0.0<u_xlat16_45);
#else
        u_xlatb38 = 0.0<u_xlat16_45;
#endif
        if(u_xlatb38){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat36) + u_xlat2.xyz;
            u_xlat16_45 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = inversesqrt(u_xlat16_45);
            u_xlat16_11.xyz = vec3(u_xlat16_45) * u_xlat16_11.xyz;
            u_xlat16_45 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = max(u_xlat16_45, 0.0);
            u_xlat16_45 = log2(u_xlat16_45);
            u_xlat16_45 = u_xlat16_43 * u_xlat16_45;
            u_xlat16_45 = exp2(u_xlat16_45);
            u_xlat16_45 = min(u_xlat16_45, 1.0);
            u_xlat16_45 = u_xlat16_44 * u_xlat16_45;
            u_xlat16_9.xyz = vec3(u_xlat16_45) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = vec3(u_xlat16_44) * u_xlat16_10.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
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
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
bool u_xlatb15;
bool u_xlatb27;
float u_xlat36;
int u_xlati37;
float u_xlat38;
bool u_xlatb38;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat38 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat3.x = unity_LightAtten[u_xlati_loop_1].z * u_xlat38 + 1.0;
        u_xlat3.x = float(1.0) / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(0.0!=unity_LightPosition[u_xlati_loop_1].w);
#else
        u_xlatb15 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(unity_LightAtten[u_xlati_loop_1].w<u_xlat38);
#else
        u_xlatb27 = unity_LightAtten[u_xlati_loop_1].w<u_xlat38;
#endif
        u_xlatb15 = u_xlatb27 && u_xlatb15;
        u_xlat16_44 = (u_xlatb15) ? 0.0 : u_xlat3.x;
        u_xlat38 = max(u_xlat38, 9.99999997e-07);
        u_xlat38 = inversesqrt(u_xlat38);
        u_xlat2.xyz = vec3(u_xlat38) * u_xlat2.xyz;
        u_xlat38 = dot(u_xlat2.xyz, unity_SpotDirection[u_xlati_loop_1].xyz);
        u_xlat38 = max(u_xlat38, 0.0);
        u_xlat16_45 = u_xlat38 + (-unity_LightAtten[u_xlati_loop_1].x);
        u_xlat16_45 = u_xlat16_45 * unity_LightAtten[u_xlati_loop_1].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_45 = min(max(u_xlat16_45, 0.0), 1.0);
#else
        u_xlat16_45 = clamp(u_xlat16_45, 0.0, 1.0);
#endif
        u_xlat16_44 = u_xlat16_44 * u_xlat16_45;
        u_xlat16_44 = u_xlat16_44 * 0.5;
        u_xlat16_45 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_45 = max(u_xlat16_45, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_45) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb38 = !!(0.0<u_xlat16_45);
#else
        u_xlatb38 = 0.0<u_xlat16_45;
#endif
        if(u_xlatb38){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat36) + u_xlat2.xyz;
            u_xlat16_45 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = inversesqrt(u_xlat16_45);
            u_xlat16_11.xyz = vec3(u_xlat16_45) * u_xlat16_11.xyz;
            u_xlat16_45 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = max(u_xlat16_45, 0.0);
            u_xlat16_45 = log2(u_xlat16_45);
            u_xlat16_45 = u_xlat16_43 * u_xlat16_45;
            u_xlat16_45 = exp2(u_xlat16_45);
            u_xlat16_45 = min(u_xlat16_45, 1.0);
            u_xlat16_45 = u_xlat16_44 * u_xlat16_45;
            u_xlat16_9.xyz = vec3(u_xlat16_45) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = vec3(u_xlat16_44) * u_xlat16_10.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
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
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
bool u_xlatb15;
bool u_xlatb27;
float u_xlat36;
int u_xlati37;
float u_xlat38;
bool u_xlatb38;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat38 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat3.x = unity_LightAtten[u_xlati_loop_1].z * u_xlat38 + 1.0;
        u_xlat3.x = float(1.0) / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(0.0!=unity_LightPosition[u_xlati_loop_1].w);
#else
        u_xlatb15 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(unity_LightAtten[u_xlati_loop_1].w<u_xlat38);
#else
        u_xlatb27 = unity_LightAtten[u_xlati_loop_1].w<u_xlat38;
#endif
        u_xlatb15 = u_xlatb27 && u_xlatb15;
        u_xlat16_44 = (u_xlatb15) ? 0.0 : u_xlat3.x;
        u_xlat38 = max(u_xlat38, 9.99999997e-07);
        u_xlat38 = inversesqrt(u_xlat38);
        u_xlat2.xyz = vec3(u_xlat38) * u_xlat2.xyz;
        u_xlat38 = dot(u_xlat2.xyz, unity_SpotDirection[u_xlati_loop_1].xyz);
        u_xlat38 = max(u_xlat38, 0.0);
        u_xlat16_45 = u_xlat38 + (-unity_LightAtten[u_xlati_loop_1].x);
        u_xlat16_45 = u_xlat16_45 * unity_LightAtten[u_xlati_loop_1].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_45 = min(max(u_xlat16_45, 0.0), 1.0);
#else
        u_xlat16_45 = clamp(u_xlat16_45, 0.0, 1.0);
#endif
        u_xlat16_44 = u_xlat16_44 * u_xlat16_45;
        u_xlat16_44 = u_xlat16_44 * 0.5;
        u_xlat16_45 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_45 = max(u_xlat16_45, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_45) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb38 = !!(0.0<u_xlat16_45);
#else
        u_xlatb38 = 0.0<u_xlat16_45;
#endif
        if(u_xlatb38){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat36) + u_xlat2.xyz;
            u_xlat16_45 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = inversesqrt(u_xlat16_45);
            u_xlat16_11.xyz = vec3(u_xlat16_45) * u_xlat16_11.xyz;
            u_xlat16_45 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = max(u_xlat16_45, 0.0);
            u_xlat16_45 = log2(u_xlat16_45);
            u_xlat16_45 = u_xlat16_43 * u_xlat16_45;
            u_xlat16_45 = exp2(u_xlat16_45);
            u_xlat16_45 = min(u_xlat16_45, 1.0);
            u_xlat16_45 = u_xlat16_44 * u_xlat16_45;
            u_xlat16_9.xyz = vec3(u_xlat16_45) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = vec3(u_xlat16_44) * u_xlat16_10.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
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
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
bool u_xlatb15;
bool u_xlatb27;
float u_xlat36;
int u_xlati37;
float u_xlat38;
bool u_xlatb38;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat2.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat38 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat3.x = unity_LightAtten[u_xlati_loop_1].z * u_xlat38 + 1.0;
        u_xlat3.x = float(1.0) / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(0.0!=unity_LightPosition[u_xlati_loop_1].w);
#else
        u_xlatb15 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(unity_LightAtten[u_xlati_loop_1].w<u_xlat38);
#else
        u_xlatb27 = unity_LightAtten[u_xlati_loop_1].w<u_xlat38;
#endif
        u_xlatb15 = u_xlatb27 && u_xlatb15;
        u_xlat16_44 = (u_xlatb15) ? 0.0 : u_xlat3.x;
        u_xlat38 = max(u_xlat38, 9.99999997e-07);
        u_xlat38 = inversesqrt(u_xlat38);
        u_xlat2.xyz = vec3(u_xlat38) * u_xlat2.xyz;
        u_xlat38 = dot(u_xlat2.xyz, unity_SpotDirection[u_xlati_loop_1].xyz);
        u_xlat38 = max(u_xlat38, 0.0);
        u_xlat16_45 = u_xlat38 + (-unity_LightAtten[u_xlati_loop_1].x);
        u_xlat16_45 = u_xlat16_45 * unity_LightAtten[u_xlati_loop_1].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_45 = min(max(u_xlat16_45, 0.0), 1.0);
#else
        u_xlat16_45 = clamp(u_xlat16_45, 0.0, 1.0);
#endif
        u_xlat16_44 = u_xlat16_44 * u_xlat16_45;
        u_xlat16_44 = u_xlat16_44 * 0.5;
        u_xlat16_45 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_45 = max(u_xlat16_45, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_45) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb38 = !!(0.0<u_xlat16_45);
#else
        u_xlatb38 = 0.0<u_xlat16_45;
#endif
        if(u_xlatb38){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat36) + u_xlat2.xyz;
            u_xlat16_45 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = inversesqrt(u_xlat16_45);
            u_xlat16_11.xyz = vec3(u_xlat16_45) * u_xlat16_11.xyz;
            u_xlat16_45 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = max(u_xlat16_45, 0.0);
            u_xlat16_45 = log2(u_xlat16_45);
            u_xlat16_45 = u_xlat16_43 * u_xlat16_45;
            u_xlat16_45 = exp2(u_xlat16_45);
            u_xlat16_45 = min(u_xlat16_45, 1.0);
            u_xlat16_45 = u_xlat16_44 * u_xlat16_45;
            u_xlat16_9.xyz = vec3(u_xlat16_45) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = vec3(u_xlat16_44) * u_xlat16_10.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
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
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
bool u_xlatb14;
float u_xlat36;
float u_xlat37;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat37 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_44 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_44 = max(u_xlat16_44, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_44) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(0.0<u_xlat16_44);
#else
        u_xlatb14 = 0.0<u_xlat16_44;
#endif
        if(u_xlatb14){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat37) + unity_LightPosition[u_xlati_loop_1].xyz;
            u_xlat16_44 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = inversesqrt(u_xlat16_44);
            u_xlat16_11.xyz = vec3(u_xlat16_44) * u_xlat16_11.xyz;
            u_xlat16_44 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = max(u_xlat16_44, 0.0);
            u_xlat16_44 = log2(u_xlat16_44);
            u_xlat16_44 = u_xlat16_43 * u_xlat16_44;
            u_xlat16_44 = exp2(u_xlat16_44);
            u_xlat16_44 = min(u_xlat16_44, 1.0);
            u_xlat16_44 = u_xlat16_44 * 0.5;
            u_xlat16_9.xyz = vec3(u_xlat16_44) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = sqrt(u_xlat36);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
bool u_xlatb14;
float u_xlat36;
float u_xlat37;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat37 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_44 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_44 = max(u_xlat16_44, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_44) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(0.0<u_xlat16_44);
#else
        u_xlatb14 = 0.0<u_xlat16_44;
#endif
        if(u_xlatb14){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat37) + unity_LightPosition[u_xlati_loop_1].xyz;
            u_xlat16_44 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = inversesqrt(u_xlat16_44);
            u_xlat16_11.xyz = vec3(u_xlat16_44) * u_xlat16_11.xyz;
            u_xlat16_44 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = max(u_xlat16_44, 0.0);
            u_xlat16_44 = log2(u_xlat16_44);
            u_xlat16_44 = u_xlat16_43 * u_xlat16_44;
            u_xlat16_44 = exp2(u_xlat16_44);
            u_xlat16_44 = min(u_xlat16_44, 1.0);
            u_xlat16_44 = u_xlat16_44 * 0.5;
            u_xlat16_9.xyz = vec3(u_xlat16_44) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = sqrt(u_xlat36);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
bool u_xlatb14;
float u_xlat36;
float u_xlat37;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat37 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_44 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_44 = max(u_xlat16_44, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_44) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(0.0<u_xlat16_44);
#else
        u_xlatb14 = 0.0<u_xlat16_44;
#endif
        if(u_xlatb14){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat37) + unity_LightPosition[u_xlati_loop_1].xyz;
            u_xlat16_44 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = inversesqrt(u_xlat16_44);
            u_xlat16_11.xyz = vec3(u_xlat16_44) * u_xlat16_11.xyz;
            u_xlat16_44 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = max(u_xlat16_44, 0.0);
            u_xlat16_44 = log2(u_xlat16_44);
            u_xlat16_44 = u_xlat16_43 * u_xlat16_44;
            u_xlat16_44 = exp2(u_xlat16_44);
            u_xlat16_44 = min(u_xlat16_44, 1.0);
            u_xlat16_44 = u_xlat16_44 * 0.5;
            u_xlat16_9.xyz = vec3(u_xlat16_44) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = sqrt(u_xlat36);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat14;
bool u_xlatb14;
float u_xlat15;
bool u_xlatb27;
float u_xlat36;
float u_xlat37;
bool u_xlatb39;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat37 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat14.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat3.x = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat15 = unity_LightAtten[u_xlati_loop_1].z * u_xlat3.x + 1.0;
        u_xlat15 = float(1.0) / u_xlat15;
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(0.0!=unity_LightPosition[u_xlati_loop_1].w);
#else
        u_xlatb27 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb39 = !!(unity_LightAtten[u_xlati_loop_1].w<u_xlat3.x);
#else
        u_xlatb39 = unity_LightAtten[u_xlati_loop_1].w<u_xlat3.x;
#endif
        u_xlatb27 = u_xlatb39 && u_xlatb27;
        u_xlat3.x = max(u_xlat3.x, 9.99999997e-07);
        u_xlat3.x = inversesqrt(u_xlat3.x);
        u_xlat14.xyz = u_xlat14.xyz * u_xlat3.xxx;
        u_xlat3.x = u_xlat15 * 0.5;
        u_xlat16_44 = (u_xlatb27) ? 0.0 : u_xlat3.x;
        u_xlat16_45 = dot(u_xlat1.xyz, u_xlat14.xyz);
        u_xlat16_45 = max(u_xlat16_45, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_45) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb3 = !!(0.0<u_xlat16_45);
#else
        u_xlatb3 = 0.0<u_xlat16_45;
#endif
        if(u_xlatb3){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat37) + u_xlat14.xyz;
            u_xlat16_45 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = inversesqrt(u_xlat16_45);
            u_xlat16_11.xyz = vec3(u_xlat16_45) * u_xlat16_11.xyz;
            u_xlat16_45 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = max(u_xlat16_45, 0.0);
            u_xlat16_45 = log2(u_xlat16_45);
            u_xlat16_45 = u_xlat16_43 * u_xlat16_45;
            u_xlat16_45 = exp2(u_xlat16_45);
            u_xlat16_45 = min(u_xlat16_45, 1.0);
            u_xlat16_45 = u_xlat16_44 * u_xlat16_45;
            u_xlat16_9.xyz = vec3(u_xlat16_45) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = vec3(u_xlat16_44) * u_xlat16_10.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = sqrt(u_xlat36);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat14;
bool u_xlatb14;
float u_xlat15;
bool u_xlatb27;
float u_xlat36;
float u_xlat37;
bool u_xlatb39;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat37 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat14.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat3.x = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat15 = unity_LightAtten[u_xlati_loop_1].z * u_xlat3.x + 1.0;
        u_xlat15 = float(1.0) / u_xlat15;
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(0.0!=unity_LightPosition[u_xlati_loop_1].w);
#else
        u_xlatb27 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb39 = !!(unity_LightAtten[u_xlati_loop_1].w<u_xlat3.x);
#else
        u_xlatb39 = unity_LightAtten[u_xlati_loop_1].w<u_xlat3.x;
#endif
        u_xlatb27 = u_xlatb39 && u_xlatb27;
        u_xlat3.x = max(u_xlat3.x, 9.99999997e-07);
        u_xlat3.x = inversesqrt(u_xlat3.x);
        u_xlat14.xyz = u_xlat14.xyz * u_xlat3.xxx;
        u_xlat3.x = u_xlat15 * 0.5;
        u_xlat16_44 = (u_xlatb27) ? 0.0 : u_xlat3.x;
        u_xlat16_45 = dot(u_xlat1.xyz, u_xlat14.xyz);
        u_xlat16_45 = max(u_xlat16_45, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_45) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb3 = !!(0.0<u_xlat16_45);
#else
        u_xlatb3 = 0.0<u_xlat16_45;
#endif
        if(u_xlatb3){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat37) + u_xlat14.xyz;
            u_xlat16_45 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = inversesqrt(u_xlat16_45);
            u_xlat16_11.xyz = vec3(u_xlat16_45) * u_xlat16_11.xyz;
            u_xlat16_45 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = max(u_xlat16_45, 0.0);
            u_xlat16_45 = log2(u_xlat16_45);
            u_xlat16_45 = u_xlat16_43 * u_xlat16_45;
            u_xlat16_45 = exp2(u_xlat16_45);
            u_xlat16_45 = min(u_xlat16_45, 1.0);
            u_xlat16_45 = u_xlat16_44 * u_xlat16_45;
            u_xlat16_9.xyz = vec3(u_xlat16_45) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = vec3(u_xlat16_44) * u_xlat16_10.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = sqrt(u_xlat36);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat14;
bool u_xlatb14;
float u_xlat15;
bool u_xlatb27;
float u_xlat36;
float u_xlat37;
bool u_xlatb39;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat37 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat14.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat3.x = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat15 = unity_LightAtten[u_xlati_loop_1].z * u_xlat3.x + 1.0;
        u_xlat15 = float(1.0) / u_xlat15;
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(0.0!=unity_LightPosition[u_xlati_loop_1].w);
#else
        u_xlatb27 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb39 = !!(unity_LightAtten[u_xlati_loop_1].w<u_xlat3.x);
#else
        u_xlatb39 = unity_LightAtten[u_xlati_loop_1].w<u_xlat3.x;
#endif
        u_xlatb27 = u_xlatb39 && u_xlatb27;
        u_xlat3.x = max(u_xlat3.x, 9.99999997e-07);
        u_xlat3.x = inversesqrt(u_xlat3.x);
        u_xlat14.xyz = u_xlat14.xyz * u_xlat3.xxx;
        u_xlat3.x = u_xlat15 * 0.5;
        u_xlat16_44 = (u_xlatb27) ? 0.0 : u_xlat3.x;
        u_xlat16_45 = dot(u_xlat1.xyz, u_xlat14.xyz);
        u_xlat16_45 = max(u_xlat16_45, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_45) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb3 = !!(0.0<u_xlat16_45);
#else
        u_xlatb3 = 0.0<u_xlat16_45;
#endif
        if(u_xlatb3){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat37) + u_xlat14.xyz;
            u_xlat16_45 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = inversesqrt(u_xlat16_45);
            u_xlat16_11.xyz = vec3(u_xlat16_45) * u_xlat16_11.xyz;
            u_xlat16_45 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = max(u_xlat16_45, 0.0);
            u_xlat16_45 = log2(u_xlat16_45);
            u_xlat16_45 = u_xlat16_43 * u_xlat16_45;
            u_xlat16_45 = exp2(u_xlat16_45);
            u_xlat16_45 = min(u_xlat16_45, 1.0);
            u_xlat16_45 = u_xlat16_44 * u_xlat16_45;
            u_xlat16_9.xyz = vec3(u_xlat16_45) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = vec3(u_xlat16_44) * u_xlat16_10.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = sqrt(u_xlat36);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat14;
bool u_xlatb14;
float u_xlat15;
bool u_xlatb27;
float u_xlat36;
float u_xlat37;
bool u_xlatb39;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat37 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat14.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat3.x = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat15 = unity_LightAtten[u_xlati_loop_1].z * u_xlat3.x + 1.0;
        u_xlat15 = float(1.0) / u_xlat15;
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(0.0!=unity_LightPosition[u_xlati_loop_1].w);
#else
        u_xlatb27 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb39 = !!(unity_LightAtten[u_xlati_loop_1].w<u_xlat3.x);
#else
        u_xlatb39 = unity_LightAtten[u_xlati_loop_1].w<u_xlat3.x;
#endif
        u_xlatb27 = u_xlatb39 && u_xlatb27;
        u_xlat16_44 = (u_xlatb27) ? 0.0 : u_xlat15;
        u_xlat3.x = max(u_xlat3.x, 9.99999997e-07);
        u_xlat3.x = inversesqrt(u_xlat3.x);
        u_xlat14.xyz = u_xlat14.xyz * u_xlat3.xxx;
        u_xlat3.x = dot(u_xlat14.xyz, unity_SpotDirection[u_xlati_loop_1].xyz);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat16_45 = u_xlat3.x + (-unity_LightAtten[u_xlati_loop_1].x);
        u_xlat16_45 = u_xlat16_45 * unity_LightAtten[u_xlati_loop_1].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_45 = min(max(u_xlat16_45, 0.0), 1.0);
#else
        u_xlat16_45 = clamp(u_xlat16_45, 0.0, 1.0);
#endif
        u_xlat16_44 = u_xlat16_44 * u_xlat16_45;
        u_xlat16_44 = u_xlat16_44 * 0.5;
        u_xlat16_45 = dot(u_xlat1.xyz, u_xlat14.xyz);
        u_xlat16_45 = max(u_xlat16_45, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_45) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb3 = !!(0.0<u_xlat16_45);
#else
        u_xlatb3 = 0.0<u_xlat16_45;
#endif
        if(u_xlatb3){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat37) + u_xlat14.xyz;
            u_xlat16_45 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = inversesqrt(u_xlat16_45);
            u_xlat16_11.xyz = vec3(u_xlat16_45) * u_xlat16_11.xyz;
            u_xlat16_45 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = max(u_xlat16_45, 0.0);
            u_xlat16_45 = log2(u_xlat16_45);
            u_xlat16_45 = u_xlat16_43 * u_xlat16_45;
            u_xlat16_45 = exp2(u_xlat16_45);
            u_xlat16_45 = min(u_xlat16_45, 1.0);
            u_xlat16_45 = u_xlat16_44 * u_xlat16_45;
            u_xlat16_9.xyz = vec3(u_xlat16_45) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = vec3(u_xlat16_44) * u_xlat16_10.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = sqrt(u_xlat36);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat14;
bool u_xlatb14;
float u_xlat15;
bool u_xlatb27;
float u_xlat36;
float u_xlat37;
bool u_xlatb39;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat37 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat14.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat3.x = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat15 = unity_LightAtten[u_xlati_loop_1].z * u_xlat3.x + 1.0;
        u_xlat15 = float(1.0) / u_xlat15;
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(0.0!=unity_LightPosition[u_xlati_loop_1].w);
#else
        u_xlatb27 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb39 = !!(unity_LightAtten[u_xlati_loop_1].w<u_xlat3.x);
#else
        u_xlatb39 = unity_LightAtten[u_xlati_loop_1].w<u_xlat3.x;
#endif
        u_xlatb27 = u_xlatb39 && u_xlatb27;
        u_xlat16_44 = (u_xlatb27) ? 0.0 : u_xlat15;
        u_xlat3.x = max(u_xlat3.x, 9.99999997e-07);
        u_xlat3.x = inversesqrt(u_xlat3.x);
        u_xlat14.xyz = u_xlat14.xyz * u_xlat3.xxx;
        u_xlat3.x = dot(u_xlat14.xyz, unity_SpotDirection[u_xlati_loop_1].xyz);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat16_45 = u_xlat3.x + (-unity_LightAtten[u_xlati_loop_1].x);
        u_xlat16_45 = u_xlat16_45 * unity_LightAtten[u_xlati_loop_1].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_45 = min(max(u_xlat16_45, 0.0), 1.0);
#else
        u_xlat16_45 = clamp(u_xlat16_45, 0.0, 1.0);
#endif
        u_xlat16_44 = u_xlat16_44 * u_xlat16_45;
        u_xlat16_44 = u_xlat16_44 * 0.5;
        u_xlat16_45 = dot(u_xlat1.xyz, u_xlat14.xyz);
        u_xlat16_45 = max(u_xlat16_45, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_45) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb3 = !!(0.0<u_xlat16_45);
#else
        u_xlatb3 = 0.0<u_xlat16_45;
#endif
        if(u_xlatb3){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat37) + u_xlat14.xyz;
            u_xlat16_45 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = inversesqrt(u_xlat16_45);
            u_xlat16_11.xyz = vec3(u_xlat16_45) * u_xlat16_11.xyz;
            u_xlat16_45 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = max(u_xlat16_45, 0.0);
            u_xlat16_45 = log2(u_xlat16_45);
            u_xlat16_45 = u_xlat16_43 * u_xlat16_45;
            u_xlat16_45 = exp2(u_xlat16_45);
            u_xlat16_45 = min(u_xlat16_45, 1.0);
            u_xlat16_45 = u_xlat16_44 * u_xlat16_45;
            u_xlat16_9.xyz = vec3(u_xlat16_45) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = vec3(u_xlat16_44) * u_xlat16_10.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = sqrt(u_xlat36);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat14;
bool u_xlatb14;
float u_xlat15;
bool u_xlatb27;
float u_xlat36;
float u_xlat37;
bool u_xlatb39;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat37 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat14.xyz = (-u_xlat0.xyz) * unity_LightPosition[u_xlati_loop_1].www + unity_LightPosition[u_xlati_loop_1].xyz;
        u_xlat3.x = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat15 = unity_LightAtten[u_xlati_loop_1].z * u_xlat3.x + 1.0;
        u_xlat15 = float(1.0) / u_xlat15;
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(0.0!=unity_LightPosition[u_xlati_loop_1].w);
#else
        u_xlatb27 = 0.0!=unity_LightPosition[u_xlati_loop_1].w;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb39 = !!(unity_LightAtten[u_xlati_loop_1].w<u_xlat3.x);
#else
        u_xlatb39 = unity_LightAtten[u_xlati_loop_1].w<u_xlat3.x;
#endif
        u_xlatb27 = u_xlatb39 && u_xlatb27;
        u_xlat16_44 = (u_xlatb27) ? 0.0 : u_xlat15;
        u_xlat3.x = max(u_xlat3.x, 9.99999997e-07);
        u_xlat3.x = inversesqrt(u_xlat3.x);
        u_xlat14.xyz = u_xlat14.xyz * u_xlat3.xxx;
        u_xlat3.x = dot(u_xlat14.xyz, unity_SpotDirection[u_xlati_loop_1].xyz);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat16_45 = u_xlat3.x + (-unity_LightAtten[u_xlati_loop_1].x);
        u_xlat16_45 = u_xlat16_45 * unity_LightAtten[u_xlati_loop_1].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_45 = min(max(u_xlat16_45, 0.0), 1.0);
#else
        u_xlat16_45 = clamp(u_xlat16_45, 0.0, 1.0);
#endif
        u_xlat16_44 = u_xlat16_44 * u_xlat16_45;
        u_xlat16_44 = u_xlat16_44 * 0.5;
        u_xlat16_45 = dot(u_xlat1.xyz, u_xlat14.xyz);
        u_xlat16_45 = max(u_xlat16_45, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_45) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb3 = !!(0.0<u_xlat16_45);
#else
        u_xlatb3 = 0.0<u_xlat16_45;
#endif
        if(u_xlatb3){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat37) + u_xlat14.xyz;
            u_xlat16_45 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = inversesqrt(u_xlat16_45);
            u_xlat16_11.xyz = vec3(u_xlat16_45) * u_xlat16_11.xyz;
            u_xlat16_45 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_45 = max(u_xlat16_45, 0.0);
            u_xlat16_45 = log2(u_xlat16_45);
            u_xlat16_45 = u_xlat16_43 * u_xlat16_45;
            u_xlat16_45 = exp2(u_xlat16_45);
            u_xlat16_45 = min(u_xlat16_45, 1.0);
            u_xlat16_45 = u_xlat16_44 * u_xlat16_45;
            u_xlat16_9.xyz = vec3(u_xlat16_45) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = vec3(u_xlat16_44) * u_xlat16_10.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = sqrt(u_xlat36);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
}
}
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "VertexLM" "RenderType" = "Opaque" }
  GpuProgramID 8257
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_Lightmap_ST;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_TEXCOORD1;
in highp vec3 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_Lightmap_ST.xy + unity_Lightmap_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
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
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_Lightmap_ST;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_TEXCOORD1;
in highp vec3 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_Lightmap_ST.xy + unity_Lightmap_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
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
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_Lightmap_ST;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_TEXCOORD1;
in highp vec3 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_Lightmap_ST.xy + unity_Lightmap_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_Lightmap_ST;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_TEXCOORD1;
in highp vec3 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_Lightmap_ST.xy + unity_Lightmap_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat1.x;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD3) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_Lightmap_ST;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_TEXCOORD1;
in highp vec3 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_Lightmap_ST.xy + unity_Lightmap_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat1.x;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD3) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_Lightmap_ST;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_TEXCOORD1;
in highp vec3 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_Lightmap_ST.xy + unity_Lightmap_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat1.x;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD3) * u_xlat16_1.xyz + unity_FogColor.xyz;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  LOD 100
  Tags { "LIGHTMODE" = "SHADOWCASTER" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 118440
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
}
}