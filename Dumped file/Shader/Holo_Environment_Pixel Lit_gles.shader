Shader "Holo/Environment/Pixel Lit" {
Properties {
[KeywordEnum(Opaque, Cutout)] _Render ("Rendering Mode", Float) = 0
[KeywordEnum(Off, Diffuse)] _ColorMode ("Color Modifier Mode", Float) = 0
_Color ("    Color", Color) = (1,1,1,1)
[KeywordEnum(Off, Diffuse)] _VertexMode ("Vertex Color Mode", Float) = 1
_MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit)] _BaseAlpha ("    Alpha Mode", Float) = 0
_AlphaTestRef ("    Alpha Cutoff", Range(0, 1)) = 0.5
[Toggle(BRB_RAMP)] _RampEnable ("Use Toon Ramp", Float) = 0
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
[Toggle(BRB_LIGHTING_TWOSIDED)] _LightingDoubleSided ("    Two-sided lighting", Float) = 0
[Toggle(BRB_FX_DISABLE)] _FX ("Ignore FX Color", Float) = 0
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  Cull Off
  GpuProgramID 171
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2)).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (tmpvar_4 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ramp_21;
  lowp vec4 ldn_22;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_23;
  tmpvar_23 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_22 = tmpvar_23;
  ldn_22.w = ((ldn_22.x * 0.5) + 0.5);
  mediump vec4 tmpvar_24;
  tmpvar_24 = ldn_22.wwww;
  ramp_21 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((ramp_21.xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2)).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (tmpvar_4 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ramp_21;
  lowp vec4 ldn_22;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_23;
  tmpvar_23 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_22 = tmpvar_23;
  ldn_22.w = ((ldn_22.x * 0.5) + 0.5);
  mediump vec4 tmpvar_24;
  tmpvar_24 = ldn_22.wwww;
  ramp_21 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((ramp_21.xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2)).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (tmpvar_4 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ramp_21;
  lowp vec4 ldn_22;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_23;
  tmpvar_23 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_22 = tmpvar_23;
  ldn_22.w = ((ldn_22.x * 0.5) + 0.5);
  mediump vec4 tmpvar_24;
  tmpvar_24 = ldn_22.wwww;
  ramp_21 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((ramp_21.xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2)).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (tmpvar_4 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ramp_21;
  lowp vec4 ldn_22;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_23;
  tmpvar_23 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_22 = tmpvar_23;
  ldn_22.w = ((ldn_22.x * 0.5) + 0.5);
  mediump vec4 tmpvar_24;
  tmpvar_24 = ldn_22.wwww;
  ramp_21 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((ramp_21.xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2)).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (tmpvar_4 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ramp_21;
  lowp vec4 ldn_22;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_23;
  tmpvar_23 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_22 = tmpvar_23;
  ldn_22.w = ((ldn_22.x * 0.5) + 0.5);
  mediump vec4 tmpvar_24;
  tmpvar_24 = ldn_22.wwww;
  ramp_21 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((ramp_21.xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2)).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (tmpvar_4 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ramp_21;
  lowp vec4 ldn_22;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_23;
  tmpvar_23 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_22 = tmpvar_23;
  ldn_22.w = ((ldn_22.x * 0.5) + 0.5);
  mediump vec4 tmpvar_24;
  tmpvar_24 = ldn_22.wwww;
  ramp_21 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((ramp_21.xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3)).z);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_5.w = exp2((-(tmpvar_4) * tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_7));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (tmpvar_5 * _EnvironmentColor);
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  tmpvar_6.x = 1.0;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_3 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_4.xyz;
  mediump vec3 vlight_12;
  mediump vec4 c_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = c_13.xyz;
  tmpvar_15.w = tmpvar_6.w;
  tmpvar_8 = tmpvar_15;
  tmpvar_9 = c_13.w;
  highp vec3 tmpvar_16;
  tmpvar_16 = tmpvar_6.xyz;
  vlight_12 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vlight_12;
  tmpvar_10 = tmpvar_17;
  tmpvar_11.w = c_13.w;
  tmpvar_4 = tmpvar_11;
  mediump float realtimeShadowAttenuation_18;
  highp vec4 v_19;
  v_19.x = unity_MatrixV[0].z;
  v_19.y = unity_MatrixV[1].z;
  v_19.z = unity_MatrixV[2].z;
  v_19.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_19.xyz), sqrt(dot (tmpvar_20, tmpvar_20)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_21 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_24;
  highp vec4 shadowCoord_25;
  shadowCoord_25 = (unity_WorldToShadow[0] * tmpvar_23);
  highp float lightShadowDataX_26;
  mediump float tmpvar_27;
  tmpvar_27 = _LightShadowData.x;
  lightShadowDataX_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = max (float((texture2D (_ShadowMapTexture, shadowCoord_25.xy).x > shadowCoord_25.z)), lightShadowDataX_26);
  tmpvar_24 = tmpvar_28;
  realtimeShadowAttenuation_18 = tmpvar_24;
  mediump float tmpvar_29;
  tmpvar_29 = clamp ((realtimeShadowAttenuation_18 + tmpvar_21), 0.0, 1.0);
  atten_2 = tmpvar_29;
  mediump vec4 tmpvar_30;
  lowp vec3 tmpvar_31;
  mediump vec3 lightDir_32;
  lightDir_32 = lightDir_5;
  mediump float atten_33;
  atten_33 = atten_2;
  lowp vec3 color_34;
  lowp vec4 ramp_35;
  lowp vec4 ldn_36;
  tmpvar_31 = normalize(tmpvar_3);
  mediump vec4 tmpvar_37;
  tmpvar_37 = vec4(dot (tmpvar_31, lightDir_32));
  ldn_36 = tmpvar_37;
  ldn_36.w = ((ldn_36.x * 0.5) + 0.5);
  lowp float tmpvar_38;
  tmpvar_38 = abs(ldn_36.x);
  mediump vec4 tmpvar_39;
  tmpvar_39 = mix (ldn_36.wwww, (ldn_36.wwww * atten_33), vec4(tmpvar_38));
  ramp_35 = tmpvar_39;
  lowp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = ((ramp_35.xyz * _LightColor0.xyz) + tmpvar_10.xyz);
  mediump vec3 tmpvar_41;
  tmpvar_41 = (tmpvar_8.xyz * tmpvar_40.xyz);
  color_34 = tmpvar_41;
  lowp vec4 tmpvar_42;
  tmpvar_42.xyz = color_34;
  tmpvar_42.w = tmpvar_9;
  tmpvar_30 = tmpvar_42;
  c_1 = tmpvar_30;
  lowp vec4 color_43;
  color_43.w = c_1.w;
  highp vec3 tmpvar_44;
  tmpvar_44 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_43.xyz = tmpvar_44;
  c_1.xyz = color_43.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3)).z);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_5.w = exp2((-(tmpvar_4) * tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_7));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (tmpvar_5 * _EnvironmentColor);
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  tmpvar_6.x = 1.0;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_3 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_4.xyz;
  mediump vec3 vlight_12;
  mediump vec4 c_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = c_13.xyz;
  tmpvar_15.w = tmpvar_6.w;
  tmpvar_8 = tmpvar_15;
  tmpvar_9 = c_13.w;
  highp vec3 tmpvar_16;
  tmpvar_16 = tmpvar_6.xyz;
  vlight_12 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vlight_12;
  tmpvar_10 = tmpvar_17;
  tmpvar_11.w = c_13.w;
  tmpvar_4 = tmpvar_11;
  mediump float realtimeShadowAttenuation_18;
  highp vec4 v_19;
  v_19.x = unity_MatrixV[0].z;
  v_19.y = unity_MatrixV[1].z;
  v_19.z = unity_MatrixV[2].z;
  v_19.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_19.xyz), sqrt(dot (tmpvar_20, tmpvar_20)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_21 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_24;
  highp vec4 shadowCoord_25;
  shadowCoord_25 = (unity_WorldToShadow[0] * tmpvar_23);
  highp float lightShadowDataX_26;
  mediump float tmpvar_27;
  tmpvar_27 = _LightShadowData.x;
  lightShadowDataX_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = max (float((texture2D (_ShadowMapTexture, shadowCoord_25.xy).x > shadowCoord_25.z)), lightShadowDataX_26);
  tmpvar_24 = tmpvar_28;
  realtimeShadowAttenuation_18 = tmpvar_24;
  mediump float tmpvar_29;
  tmpvar_29 = clamp ((realtimeShadowAttenuation_18 + tmpvar_21), 0.0, 1.0);
  atten_2 = tmpvar_29;
  mediump vec4 tmpvar_30;
  lowp vec3 tmpvar_31;
  mediump vec3 lightDir_32;
  lightDir_32 = lightDir_5;
  mediump float atten_33;
  atten_33 = atten_2;
  lowp vec3 color_34;
  lowp vec4 ramp_35;
  lowp vec4 ldn_36;
  tmpvar_31 = normalize(tmpvar_3);
  mediump vec4 tmpvar_37;
  tmpvar_37 = vec4(dot (tmpvar_31, lightDir_32));
  ldn_36 = tmpvar_37;
  ldn_36.w = ((ldn_36.x * 0.5) + 0.5);
  lowp float tmpvar_38;
  tmpvar_38 = abs(ldn_36.x);
  mediump vec4 tmpvar_39;
  tmpvar_39 = mix (ldn_36.wwww, (ldn_36.wwww * atten_33), vec4(tmpvar_38));
  ramp_35 = tmpvar_39;
  lowp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = ((ramp_35.xyz * _LightColor0.xyz) + tmpvar_10.xyz);
  mediump vec3 tmpvar_41;
  tmpvar_41 = (tmpvar_8.xyz * tmpvar_40.xyz);
  color_34 = tmpvar_41;
  lowp vec4 tmpvar_42;
  tmpvar_42.xyz = color_34;
  tmpvar_42.w = tmpvar_9;
  tmpvar_30 = tmpvar_42;
  c_1 = tmpvar_30;
  lowp vec4 color_43;
  color_43.w = c_1.w;
  highp vec3 tmpvar_44;
  tmpvar_44 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_43.xyz = tmpvar_44;
  c_1.xyz = color_43.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3)).z);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_5.w = exp2((-(tmpvar_4) * tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_7));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (tmpvar_5 * _EnvironmentColor);
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  tmpvar_6.x = 1.0;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_3 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_4.xyz;
  mediump vec3 vlight_12;
  mediump vec4 c_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = c_13.xyz;
  tmpvar_15.w = tmpvar_6.w;
  tmpvar_8 = tmpvar_15;
  tmpvar_9 = c_13.w;
  highp vec3 tmpvar_16;
  tmpvar_16 = tmpvar_6.xyz;
  vlight_12 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vlight_12;
  tmpvar_10 = tmpvar_17;
  tmpvar_11.w = c_13.w;
  tmpvar_4 = tmpvar_11;
  mediump float realtimeShadowAttenuation_18;
  highp vec4 v_19;
  v_19.x = unity_MatrixV[0].z;
  v_19.y = unity_MatrixV[1].z;
  v_19.z = unity_MatrixV[2].z;
  v_19.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_19.xyz), sqrt(dot (tmpvar_20, tmpvar_20)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_21 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_24;
  highp vec4 shadowCoord_25;
  shadowCoord_25 = (unity_WorldToShadow[0] * tmpvar_23);
  highp float lightShadowDataX_26;
  mediump float tmpvar_27;
  tmpvar_27 = _LightShadowData.x;
  lightShadowDataX_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = max (float((texture2D (_ShadowMapTexture, shadowCoord_25.xy).x > shadowCoord_25.z)), lightShadowDataX_26);
  tmpvar_24 = tmpvar_28;
  realtimeShadowAttenuation_18 = tmpvar_24;
  mediump float tmpvar_29;
  tmpvar_29 = clamp ((realtimeShadowAttenuation_18 + tmpvar_21), 0.0, 1.0);
  atten_2 = tmpvar_29;
  mediump vec4 tmpvar_30;
  lowp vec3 tmpvar_31;
  mediump vec3 lightDir_32;
  lightDir_32 = lightDir_5;
  mediump float atten_33;
  atten_33 = atten_2;
  lowp vec3 color_34;
  lowp vec4 ramp_35;
  lowp vec4 ldn_36;
  tmpvar_31 = normalize(tmpvar_3);
  mediump vec4 tmpvar_37;
  tmpvar_37 = vec4(dot (tmpvar_31, lightDir_32));
  ldn_36 = tmpvar_37;
  ldn_36.w = ((ldn_36.x * 0.5) + 0.5);
  lowp float tmpvar_38;
  tmpvar_38 = abs(ldn_36.x);
  mediump vec4 tmpvar_39;
  tmpvar_39 = mix (ldn_36.wwww, (ldn_36.wwww * atten_33), vec4(tmpvar_38));
  ramp_35 = tmpvar_39;
  lowp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = ((ramp_35.xyz * _LightColor0.xyz) + tmpvar_10.xyz);
  mediump vec3 tmpvar_41;
  tmpvar_41 = (tmpvar_8.xyz * tmpvar_40.xyz);
  color_34 = tmpvar_41;
  lowp vec4 tmpvar_42;
  tmpvar_42.xyz = color_34;
  tmpvar_42.w = tmpvar_9;
  tmpvar_30 = tmpvar_42;
  c_1 = tmpvar_30;
  lowp vec4 color_43;
  color_43.w = c_1.w;
  highp vec3 tmpvar_44;
  tmpvar_44 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_43.xyz = tmpvar_44;
  c_1.xyz = color_43.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3)).z);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_5.w = exp2((-(tmpvar_4) * tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_7));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (tmpvar_5 * _EnvironmentColor);
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  tmpvar_6.x = 1.0;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_3 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_4.xyz;
  mediump vec3 vlight_12;
  mediump vec4 c_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = c_13.xyz;
  tmpvar_15.w = tmpvar_6.w;
  tmpvar_8 = tmpvar_15;
  tmpvar_9 = c_13.w;
  highp vec3 tmpvar_16;
  tmpvar_16 = tmpvar_6.xyz;
  vlight_12 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vlight_12;
  tmpvar_10 = tmpvar_17;
  tmpvar_11.w = c_13.w;
  tmpvar_4 = tmpvar_11;
  mediump float realtimeShadowAttenuation_18;
  highp vec4 v_19;
  v_19.x = unity_MatrixV[0].z;
  v_19.y = unity_MatrixV[1].z;
  v_19.z = unity_MatrixV[2].z;
  v_19.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_19.xyz), sqrt(dot (tmpvar_20, tmpvar_20)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_21 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_24;
  highp vec4 shadowCoord_25;
  shadowCoord_25 = (unity_WorldToShadow[0] * tmpvar_23);
  highp float lightShadowDataX_26;
  mediump float tmpvar_27;
  tmpvar_27 = _LightShadowData.x;
  lightShadowDataX_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = max (float((texture2D (_ShadowMapTexture, shadowCoord_25.xy).x > shadowCoord_25.z)), lightShadowDataX_26);
  tmpvar_24 = tmpvar_28;
  realtimeShadowAttenuation_18 = tmpvar_24;
  mediump float tmpvar_29;
  tmpvar_29 = clamp ((realtimeShadowAttenuation_18 + tmpvar_21), 0.0, 1.0);
  atten_2 = tmpvar_29;
  mediump vec4 tmpvar_30;
  lowp vec3 tmpvar_31;
  mediump vec3 lightDir_32;
  lightDir_32 = lightDir_5;
  mediump float atten_33;
  atten_33 = atten_2;
  lowp vec3 color_34;
  lowp vec4 ramp_35;
  lowp vec4 ldn_36;
  tmpvar_31 = normalize(tmpvar_3);
  mediump vec4 tmpvar_37;
  tmpvar_37 = vec4(dot (tmpvar_31, lightDir_32));
  ldn_36 = tmpvar_37;
  ldn_36.w = ((ldn_36.x * 0.5) + 0.5);
  lowp float tmpvar_38;
  tmpvar_38 = abs(ldn_36.x);
  mediump vec4 tmpvar_39;
  tmpvar_39 = mix (ldn_36.wwww, (ldn_36.wwww * atten_33), vec4(tmpvar_38));
  ramp_35 = tmpvar_39;
  lowp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = ((ramp_35.xyz * _LightColor0.xyz) + tmpvar_10.xyz);
  mediump vec3 tmpvar_41;
  tmpvar_41 = (tmpvar_8.xyz * tmpvar_40.xyz);
  color_34 = tmpvar_41;
  lowp vec4 tmpvar_42;
  tmpvar_42.xyz = color_34;
  tmpvar_42.w = tmpvar_9;
  tmpvar_30 = tmpvar_42;
  c_1 = tmpvar_30;
  lowp vec4 color_43;
  color_43.w = c_1.w;
  highp vec3 tmpvar_44;
  tmpvar_44 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_43.xyz = tmpvar_44;
  c_1.xyz = color_43.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3)).z);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_5.w = exp2((-(tmpvar_4) * tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_7));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (tmpvar_5 * _EnvironmentColor);
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  tmpvar_6.x = 1.0;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_3 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_4.xyz;
  mediump vec3 vlight_12;
  mediump vec4 c_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = c_13.xyz;
  tmpvar_15.w = tmpvar_6.w;
  tmpvar_8 = tmpvar_15;
  tmpvar_9 = c_13.w;
  highp vec3 tmpvar_16;
  tmpvar_16 = tmpvar_6.xyz;
  vlight_12 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vlight_12;
  tmpvar_10 = tmpvar_17;
  tmpvar_11.w = c_13.w;
  tmpvar_4 = tmpvar_11;
  mediump float realtimeShadowAttenuation_18;
  highp vec4 v_19;
  v_19.x = unity_MatrixV[0].z;
  v_19.y = unity_MatrixV[1].z;
  v_19.z = unity_MatrixV[2].z;
  v_19.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_19.xyz), sqrt(dot (tmpvar_20, tmpvar_20)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_21 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_24;
  highp vec4 shadowCoord_25;
  shadowCoord_25 = (unity_WorldToShadow[0] * tmpvar_23);
  highp float lightShadowDataX_26;
  mediump float tmpvar_27;
  tmpvar_27 = _LightShadowData.x;
  lightShadowDataX_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = max (float((texture2D (_ShadowMapTexture, shadowCoord_25.xy).x > shadowCoord_25.z)), lightShadowDataX_26);
  tmpvar_24 = tmpvar_28;
  realtimeShadowAttenuation_18 = tmpvar_24;
  mediump float tmpvar_29;
  tmpvar_29 = clamp ((realtimeShadowAttenuation_18 + tmpvar_21), 0.0, 1.0);
  atten_2 = tmpvar_29;
  mediump vec4 tmpvar_30;
  lowp vec3 tmpvar_31;
  mediump vec3 lightDir_32;
  lightDir_32 = lightDir_5;
  mediump float atten_33;
  atten_33 = atten_2;
  lowp vec3 color_34;
  lowp vec4 ramp_35;
  lowp vec4 ldn_36;
  tmpvar_31 = normalize(tmpvar_3);
  mediump vec4 tmpvar_37;
  tmpvar_37 = vec4(dot (tmpvar_31, lightDir_32));
  ldn_36 = tmpvar_37;
  ldn_36.w = ((ldn_36.x * 0.5) + 0.5);
  lowp float tmpvar_38;
  tmpvar_38 = abs(ldn_36.x);
  mediump vec4 tmpvar_39;
  tmpvar_39 = mix (ldn_36.wwww, (ldn_36.wwww * atten_33), vec4(tmpvar_38));
  ramp_35 = tmpvar_39;
  lowp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = ((ramp_35.xyz * _LightColor0.xyz) + tmpvar_10.xyz);
  mediump vec3 tmpvar_41;
  tmpvar_41 = (tmpvar_8.xyz * tmpvar_40.xyz);
  color_34 = tmpvar_41;
  lowp vec4 tmpvar_42;
  tmpvar_42.xyz = color_34;
  tmpvar_42.w = tmpvar_9;
  tmpvar_30 = tmpvar_42;
  c_1 = tmpvar_30;
  lowp vec4 color_43;
  color_43.w = c_1.w;
  highp vec3 tmpvar_44;
  tmpvar_44 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_43.xyz = tmpvar_44;
  c_1.xyz = color_43.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3)).z);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_5.w = exp2((-(tmpvar_4) * tmpvar_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_7));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = (tmpvar_5 * _EnvironmentColor);
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  tmpvar_6.x = 1.0;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_3 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_4.xyz;
  mediump vec3 vlight_12;
  mediump vec4 c_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = c_13.xyz;
  tmpvar_15.w = tmpvar_6.w;
  tmpvar_8 = tmpvar_15;
  tmpvar_9 = c_13.w;
  highp vec3 tmpvar_16;
  tmpvar_16 = tmpvar_6.xyz;
  vlight_12 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vlight_12;
  tmpvar_10 = tmpvar_17;
  tmpvar_11.w = c_13.w;
  tmpvar_4 = tmpvar_11;
  mediump float realtimeShadowAttenuation_18;
  highp vec4 v_19;
  v_19.x = unity_MatrixV[0].z;
  v_19.y = unity_MatrixV[1].z;
  v_19.z = unity_MatrixV[2].z;
  v_19.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_19.xyz), sqrt(dot (tmpvar_20, tmpvar_20)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_21 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = xlv_TEXCOORD2;
  lowp float tmpvar_24;
  highp vec4 shadowCoord_25;
  shadowCoord_25 = (unity_WorldToShadow[0] * tmpvar_23);
  highp float lightShadowDataX_26;
  mediump float tmpvar_27;
  tmpvar_27 = _LightShadowData.x;
  lightShadowDataX_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = max (float((texture2D (_ShadowMapTexture, shadowCoord_25.xy).x > shadowCoord_25.z)), lightShadowDataX_26);
  tmpvar_24 = tmpvar_28;
  realtimeShadowAttenuation_18 = tmpvar_24;
  mediump float tmpvar_29;
  tmpvar_29 = clamp ((realtimeShadowAttenuation_18 + tmpvar_21), 0.0, 1.0);
  atten_2 = tmpvar_29;
  mediump vec4 tmpvar_30;
  lowp vec3 tmpvar_31;
  mediump vec3 lightDir_32;
  lightDir_32 = lightDir_5;
  mediump float atten_33;
  atten_33 = atten_2;
  lowp vec3 color_34;
  lowp vec4 ramp_35;
  lowp vec4 ldn_36;
  tmpvar_31 = normalize(tmpvar_3);
  mediump vec4 tmpvar_37;
  tmpvar_37 = vec4(dot (tmpvar_31, lightDir_32));
  ldn_36 = tmpvar_37;
  ldn_36.w = ((ldn_36.x * 0.5) + 0.5);
  lowp float tmpvar_38;
  tmpvar_38 = abs(ldn_36.x);
  mediump vec4 tmpvar_39;
  tmpvar_39 = mix (ldn_36.wwww, (ldn_36.wwww * atten_33), vec4(tmpvar_38));
  ramp_35 = tmpvar_39;
  lowp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = ((ramp_35.xyz * _LightColor0.xyz) + tmpvar_10.xyz);
  mediump vec3 tmpvar_41;
  tmpvar_41 = (tmpvar_8.xyz * tmpvar_40.xyz);
  color_34 = tmpvar_41;
  lowp vec4 tmpvar_42;
  tmpvar_42.xyz = color_34;
  tmpvar_42.w = tmpvar_9;
  tmpvar_30 = tmpvar_42;
  c_1 = tmpvar_30;
  lowp vec4 color_43;
  color_43.w = c_1.w;
  highp vec3 tmpvar_44;
  tmpvar_44 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_43.xyz = tmpvar_44;
  c_1.xyz = color_43.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  LOD 200
  Tags { "LIGHTMODE" = "SHADOWCASTER" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  Cull Off
  GpuProgramID 101125
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2)).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_4 * _EnvironmentColor);
  highp vec4 tmpvar_6;
  highp vec4 wPos_7;
  wPos_7 = tmpvar_5;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_8;
    tmpvar_8[0] = unity_WorldToObject[0].xyz;
    tmpvar_8[1] = unity_WorldToObject[1].xyz;
    tmpvar_8[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = normalize((_glesNormal * tmpvar_8));
    highp float tmpvar_10;
    tmpvar_10 = dot (tmpvar_9, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_5.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_7.xyz = (tmpvar_5.xyz - (tmpvar_9 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_10 * tmpvar_10)))
    )));
  };
  tmpvar_6 = (unity_MatrixVP * wPos_7);
  highp vec4 clipPos_11;
  clipPos_11.xyw = tmpvar_6.xyw;
  clipPos_11.z = (tmpvar_6.z + clamp ((unity_LightShadowBias.x / tmpvar_6.w), 0.0, 1.0));
  clipPos_11.z = mix (clipPos_11.z, max (clipPos_11.z, -(tmpvar_6.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_11;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2)).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_4 * _EnvironmentColor);
  highp vec4 tmpvar_6;
  highp vec4 wPos_7;
  wPos_7 = tmpvar_5;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_8;
    tmpvar_8[0] = unity_WorldToObject[0].xyz;
    tmpvar_8[1] = unity_WorldToObject[1].xyz;
    tmpvar_8[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = normalize((_glesNormal * tmpvar_8));
    highp float tmpvar_10;
    tmpvar_10 = dot (tmpvar_9, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_5.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_7.xyz = (tmpvar_5.xyz - (tmpvar_9 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_10 * tmpvar_10)))
    )));
  };
  tmpvar_6 = (unity_MatrixVP * wPos_7);
  highp vec4 clipPos_11;
  clipPos_11.xyw = tmpvar_6.xyw;
  clipPos_11.z = (tmpvar_6.z + clamp ((unity_LightShadowBias.x / tmpvar_6.w), 0.0, 1.0));
  clipPos_11.z = mix (clipPos_11.z, max (clipPos_11.z, -(tmpvar_6.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_11;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2)).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_4 * _EnvironmentColor);
  highp vec4 tmpvar_6;
  highp vec4 wPos_7;
  wPos_7 = tmpvar_5;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_8;
    tmpvar_8[0] = unity_WorldToObject[0].xyz;
    tmpvar_8[1] = unity_WorldToObject[1].xyz;
    tmpvar_8[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = normalize((_glesNormal * tmpvar_8));
    highp float tmpvar_10;
    tmpvar_10 = dot (tmpvar_9, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_5.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_7.xyz = (tmpvar_5.xyz - (tmpvar_9 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_10 * tmpvar_10)))
    )));
  };
  tmpvar_6 = (unity_MatrixVP * wPos_7);
  highp vec4 clipPos_11;
  clipPos_11.xyw = tmpvar_6.xyw;
  clipPos_11.z = (tmpvar_6.z + clamp ((unity_LightShadowBias.x / tmpvar_6.w), 0.0, 1.0));
  clipPos_11.z = mix (clipPos_11.z, max (clipPos_11.z, -(tmpvar_6.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_11;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2)).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD1 = (tmpvar_4 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2)).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD1 = (tmpvar_4 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2)).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD1 = (tmpvar_4 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
}
CustomEditor "CustomMaterialInspector"
}