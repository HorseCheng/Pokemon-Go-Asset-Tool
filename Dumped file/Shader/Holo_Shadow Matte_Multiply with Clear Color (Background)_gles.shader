Shader "Holo/Shadow Matte/Multiply with Clear Color (Background)" {
Properties {
_ShadowColor ("Shadow Tint (RGBA)", Color) = (0,0,0,1)
_Alpha ("Alpha Out (for Pokedex)", Range(0, 1)) = 1
[KeywordEnum(Alpha_X_Ambient, RGBA)] _Multiplier ("    Clear Multiplier", Float) = 0
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Background" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 100
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Background" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 18470
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = _glesColor.xyz;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_6;
  tmpvar_2.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_2.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_9));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD4);
  c_1.xyz = (c_1 + vec4(1.0, 1.0, 1.0, 0.0)).xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = _glesColor.xyz;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_6;
  tmpvar_2.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_2.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_9));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD4);
  c_1.xyz = (c_1 + vec4(1.0, 1.0, 1.0, 0.0)).xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = _glesColor.xyz;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_6;
  tmpvar_2.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_2.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_9));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD4);
  c_1.xyz = (c_1 + vec4(1.0, 1.0, 1.0, 0.0)).xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = _glesColor.xyz;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_6;
  tmpvar_2.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_2.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_9));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD4);
  c_1.xyz = (c_1 + vec4(1.0, 1.0, 1.0, 0.0)).xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = _glesColor.xyz;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_6;
  tmpvar_2.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_2.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_9));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD4);
  c_1.xyz = (c_1 + vec4(1.0, 1.0, 1.0, 0.0)).xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = _glesColor.xyz;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_6;
  tmpvar_2.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_2.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_9));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD4);
  c_1.xyz = (c_1 + vec4(1.0, 1.0, 1.0, 0.0)).xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_10));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD2.w;
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_2 = tmpvar_16;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_3.xyz * xlv_TEXCOORD4);
  mediump vec4 tmpvar_17;
  mediump float atten_18;
  atten_18 = atten_2;
  lowp vec4 col_19;
  lowp float mask_20;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - atten_18);
  mask_20 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_3.xyz;
  tmpvar_22.w = tmpvar_4;
  col_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = vec3(atten_18);
  tmpvar_17 = ((col_19 * mask_20) + tmpvar_23);
  c_1.xyz = (c_1 + tmpvar_17).xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_10));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD2.w;
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_2 = tmpvar_16;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_3.xyz * xlv_TEXCOORD4);
  mediump vec4 tmpvar_17;
  mediump float atten_18;
  atten_18 = atten_2;
  lowp vec4 col_19;
  lowp float mask_20;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - atten_18);
  mask_20 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_3.xyz;
  tmpvar_22.w = tmpvar_4;
  col_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = vec3(atten_18);
  tmpvar_17 = ((col_19 * mask_20) + tmpvar_23);
  c_1.xyz = (c_1 + tmpvar_17).xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_10));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD2.w;
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_2 = tmpvar_16;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_3.xyz * xlv_TEXCOORD4);
  mediump vec4 tmpvar_17;
  mediump float atten_18;
  atten_18 = atten_2;
  lowp vec4 col_19;
  lowp float mask_20;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - atten_18);
  mask_20 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_3.xyz;
  tmpvar_22.w = tmpvar_4;
  col_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = vec3(atten_18);
  tmpvar_17 = ((col_19 * mask_20) + tmpvar_23);
  c_1.xyz = (c_1 + tmpvar_17).xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_10));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD2.w;
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_2 = tmpvar_16;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_3.xyz * xlv_TEXCOORD4);
  mediump vec4 tmpvar_17;
  mediump float atten_18;
  atten_18 = atten_2;
  lowp vec4 col_19;
  lowp float mask_20;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - atten_18);
  mask_20 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_3.xyz;
  tmpvar_22.w = tmpvar_4;
  col_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = vec3(atten_18);
  tmpvar_17 = ((col_19 * mask_20) + tmpvar_23);
  c_1.xyz = (c_1 + tmpvar_17).xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_10));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD2.w;
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_2 = tmpvar_16;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_3.xyz * xlv_TEXCOORD4);
  mediump vec4 tmpvar_17;
  mediump float atten_18;
  atten_18 = atten_2;
  lowp vec4 col_19;
  lowp float mask_20;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - atten_18);
  mask_20 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_3.xyz;
  tmpvar_22.w = tmpvar_4;
  col_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = vec3(atten_18);
  tmpvar_17 = ((col_19 * mask_20) + tmpvar_23);
  c_1.xyz = (c_1 + tmpvar_17).xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_10));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD2.w;
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_2 = tmpvar_16;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_3.xyz * xlv_TEXCOORD4);
  mediump vec4 tmpvar_17;
  mediump float atten_18;
  atten_18 = atten_2;
  lowp vec4 col_19;
  lowp float mask_20;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - atten_18);
  mask_20 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_3.xyz;
  tmpvar_22.w = tmpvar_4;
  col_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = vec3(atten_18);
  tmpvar_17 = ((col_19 * mask_20) + tmpvar_23);
  c_1.xyz = (c_1 + tmpvar_17).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  highp vec3 lightColor0_13;
  lightColor0_13 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_14;
  lightColor1_14 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_15;
  lightColor2_15 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_16;
  lightColor3_16 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_17;
  lightAttenSq_17 = unity_4LightAtten0;
  highp vec3 col_18;
  highp vec4 ndotl_19;
  highp vec4 lengthSq_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_20 = (tmpvar_21 * tmpvar_21);
  lengthSq_20 = (lengthSq_20 + (tmpvar_22 * tmpvar_22));
  lengthSq_20 = (lengthSq_20 + (tmpvar_23 * tmpvar_23));
  highp vec4 tmpvar_24;
  tmpvar_24 = max (lengthSq_20, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_20 = tmpvar_24;
  ndotl_19 = (tmpvar_21 * tmpvar_12.x);
  ndotl_19 = (ndotl_19 + (tmpvar_22 * tmpvar_12.y));
  ndotl_19 = (ndotl_19 + (tmpvar_23 * tmpvar_12.z));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_19 * inversesqrt(tmpvar_24)));
  ndotl_19 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (1.0/((1.0 + 
    (tmpvar_24 * lightAttenSq_17)
  ))));
  col_18 = (lightColor0_13 * tmpvar_26.x);
  col_18 = (col_18 + (lightColor1_14 * tmpvar_26.y));
  col_18 = (col_18 + (lightColor2_15 * tmpvar_26.z));
  col_18 = (col_18 + (lightColor3_16 * tmpvar_26.w));
  tmpvar_2 = col_18;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_12;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD4);
  c_1.xyz = (c_1 + vec4(1.0, 1.0, 1.0, 0.0)).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  highp vec3 lightColor0_13;
  lightColor0_13 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_14;
  lightColor1_14 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_15;
  lightColor2_15 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_16;
  lightColor3_16 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_17;
  lightAttenSq_17 = unity_4LightAtten0;
  highp vec3 col_18;
  highp vec4 ndotl_19;
  highp vec4 lengthSq_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_20 = (tmpvar_21 * tmpvar_21);
  lengthSq_20 = (lengthSq_20 + (tmpvar_22 * tmpvar_22));
  lengthSq_20 = (lengthSq_20 + (tmpvar_23 * tmpvar_23));
  highp vec4 tmpvar_24;
  tmpvar_24 = max (lengthSq_20, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_20 = tmpvar_24;
  ndotl_19 = (tmpvar_21 * tmpvar_12.x);
  ndotl_19 = (ndotl_19 + (tmpvar_22 * tmpvar_12.y));
  ndotl_19 = (ndotl_19 + (tmpvar_23 * tmpvar_12.z));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_19 * inversesqrt(tmpvar_24)));
  ndotl_19 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (1.0/((1.0 + 
    (tmpvar_24 * lightAttenSq_17)
  ))));
  col_18 = (lightColor0_13 * tmpvar_26.x);
  col_18 = (col_18 + (lightColor1_14 * tmpvar_26.y));
  col_18 = (col_18 + (lightColor2_15 * tmpvar_26.z));
  col_18 = (col_18 + (lightColor3_16 * tmpvar_26.w));
  tmpvar_2 = col_18;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_12;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD4);
  c_1.xyz = (c_1 + vec4(1.0, 1.0, 1.0, 0.0)).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  highp vec3 lightColor0_13;
  lightColor0_13 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_14;
  lightColor1_14 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_15;
  lightColor2_15 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_16;
  lightColor3_16 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_17;
  lightAttenSq_17 = unity_4LightAtten0;
  highp vec3 col_18;
  highp vec4 ndotl_19;
  highp vec4 lengthSq_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_20 = (tmpvar_21 * tmpvar_21);
  lengthSq_20 = (lengthSq_20 + (tmpvar_22 * tmpvar_22));
  lengthSq_20 = (lengthSq_20 + (tmpvar_23 * tmpvar_23));
  highp vec4 tmpvar_24;
  tmpvar_24 = max (lengthSq_20, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_20 = tmpvar_24;
  ndotl_19 = (tmpvar_21 * tmpvar_12.x);
  ndotl_19 = (ndotl_19 + (tmpvar_22 * tmpvar_12.y));
  ndotl_19 = (ndotl_19 + (tmpvar_23 * tmpvar_12.z));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_19 * inversesqrt(tmpvar_24)));
  ndotl_19 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (1.0/((1.0 + 
    (tmpvar_24 * lightAttenSq_17)
  ))));
  col_18 = (lightColor0_13 * tmpvar_26.x);
  col_18 = (col_18 + (lightColor1_14 * tmpvar_26.y));
  col_18 = (col_18 + (lightColor2_15 * tmpvar_26.z));
  col_18 = (col_18 + (lightColor3_16 * tmpvar_26.w));
  tmpvar_2 = col_18;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_12;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD4);
  c_1.xyz = (c_1 + vec4(1.0, 1.0, 1.0, 0.0)).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  highp vec3 lightColor0_13;
  lightColor0_13 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_14;
  lightColor1_14 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_15;
  lightColor2_15 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_16;
  lightColor3_16 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_17;
  lightAttenSq_17 = unity_4LightAtten0;
  highp vec3 col_18;
  highp vec4 ndotl_19;
  highp vec4 lengthSq_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_20 = (tmpvar_21 * tmpvar_21);
  lengthSq_20 = (lengthSq_20 + (tmpvar_22 * tmpvar_22));
  lengthSq_20 = (lengthSq_20 + (tmpvar_23 * tmpvar_23));
  highp vec4 tmpvar_24;
  tmpvar_24 = max (lengthSq_20, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_20 = tmpvar_24;
  ndotl_19 = (tmpvar_21 * tmpvar_12.x);
  ndotl_19 = (ndotl_19 + (tmpvar_22 * tmpvar_12.y));
  ndotl_19 = (ndotl_19 + (tmpvar_23 * tmpvar_12.z));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_19 * inversesqrt(tmpvar_24)));
  ndotl_19 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (1.0/((1.0 + 
    (tmpvar_24 * lightAttenSq_17)
  ))));
  col_18 = (lightColor0_13 * tmpvar_26.x);
  col_18 = (col_18 + (lightColor1_14 * tmpvar_26.y));
  col_18 = (col_18 + (lightColor2_15 * tmpvar_26.z));
  col_18 = (col_18 + (lightColor3_16 * tmpvar_26.w));
  tmpvar_2 = col_18;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_12;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD4);
  c_1.xyz = (c_1 + vec4(1.0, 1.0, 1.0, 0.0)).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  highp vec3 lightColor0_13;
  lightColor0_13 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_14;
  lightColor1_14 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_15;
  lightColor2_15 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_16;
  lightColor3_16 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_17;
  lightAttenSq_17 = unity_4LightAtten0;
  highp vec3 col_18;
  highp vec4 ndotl_19;
  highp vec4 lengthSq_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_20 = (tmpvar_21 * tmpvar_21);
  lengthSq_20 = (lengthSq_20 + (tmpvar_22 * tmpvar_22));
  lengthSq_20 = (lengthSq_20 + (tmpvar_23 * tmpvar_23));
  highp vec4 tmpvar_24;
  tmpvar_24 = max (lengthSq_20, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_20 = tmpvar_24;
  ndotl_19 = (tmpvar_21 * tmpvar_12.x);
  ndotl_19 = (ndotl_19 + (tmpvar_22 * tmpvar_12.y));
  ndotl_19 = (ndotl_19 + (tmpvar_23 * tmpvar_12.z));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_19 * inversesqrt(tmpvar_24)));
  ndotl_19 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (1.0/((1.0 + 
    (tmpvar_24 * lightAttenSq_17)
  ))));
  col_18 = (lightColor0_13 * tmpvar_26.x);
  col_18 = (col_18 + (lightColor1_14 * tmpvar_26.y));
  col_18 = (col_18 + (lightColor2_15 * tmpvar_26.z));
  col_18 = (col_18 + (lightColor3_16 * tmpvar_26.w));
  tmpvar_2 = col_18;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_12;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD4);
  c_1.xyz = (c_1 + vec4(1.0, 1.0, 1.0, 0.0)).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  highp vec3 lightColor0_13;
  lightColor0_13 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_14;
  lightColor1_14 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_15;
  lightColor2_15 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_16;
  lightColor3_16 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_17;
  lightAttenSq_17 = unity_4LightAtten0;
  highp vec3 col_18;
  highp vec4 ndotl_19;
  highp vec4 lengthSq_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_20 = (tmpvar_21 * tmpvar_21);
  lengthSq_20 = (lengthSq_20 + (tmpvar_22 * tmpvar_22));
  lengthSq_20 = (lengthSq_20 + (tmpvar_23 * tmpvar_23));
  highp vec4 tmpvar_24;
  tmpvar_24 = max (lengthSq_20, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_20 = tmpvar_24;
  ndotl_19 = (tmpvar_21 * tmpvar_12.x);
  ndotl_19 = (ndotl_19 + (tmpvar_22 * tmpvar_12.y));
  ndotl_19 = (ndotl_19 + (tmpvar_23 * tmpvar_12.z));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_19 * inversesqrt(tmpvar_24)));
  ndotl_19 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (1.0/((1.0 + 
    (tmpvar_24 * lightAttenSq_17)
  ))));
  col_18 = (lightColor0_13 * tmpvar_26.x);
  col_18 = (col_18 + (lightColor1_14 * tmpvar_26.y));
  col_18 = (col_18 + (lightColor2_15 * tmpvar_26.z));
  col_18 = (col_18 + (lightColor3_16 * tmpvar_26.w));
  tmpvar_2 = col_18;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_12;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD4);
  c_1.xyz = (c_1 + vec4(1.0, 1.0, 1.0, 0.0)).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_5 = (unity_FogParams.x * tmpvar_6.z);
  mediump float tmpvar_8;
  tmpvar_8 = exp2((-(tmpvar_5) * tmpvar_5));
  tmpvar_5 = tmpvar_8;
  tmpvar_4.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_4.w * tmpvar_8));
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_9.w = tmpvar_4.w;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 col_19;
  highp vec4 ndotl_20;
  highp vec4 lengthSq_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_21 = (tmpvar_22 * tmpvar_22);
  lengthSq_21 = (lengthSq_21 + (tmpvar_23 * tmpvar_23));
  lengthSq_21 = (lengthSq_21 + (tmpvar_24 * tmpvar_24));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (lengthSq_21, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_21 = tmpvar_25;
  ndotl_20 = (tmpvar_22 * tmpvar_13.x);
  ndotl_20 = (ndotl_20 + (tmpvar_23 * tmpvar_13.y));
  ndotl_20 = (ndotl_20 + (tmpvar_24 * tmpvar_13.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_20 * inversesqrt(tmpvar_25)));
  ndotl_20 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (tmpvar_25 * lightAttenSq_18)
  ))));
  col_19 = (lightColor0_14 * tmpvar_27.x);
  col_19 = (col_19 + (lightColor1_15 * tmpvar_27.y));
  col_19 = (col_19 + (lightColor2_16 * tmpvar_27.z));
  col_19 = (col_19 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_2 = col_19;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD2.w;
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_2 = tmpvar_16;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_3.xyz * xlv_TEXCOORD4);
  mediump vec4 tmpvar_17;
  mediump float atten_18;
  atten_18 = atten_2;
  lowp vec4 col_19;
  lowp float mask_20;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - atten_18);
  mask_20 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_3.xyz;
  tmpvar_22.w = tmpvar_4;
  col_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = vec3(atten_18);
  tmpvar_17 = ((col_19 * mask_20) + tmpvar_23);
  c_1.xyz = (c_1 + tmpvar_17).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_5 = (unity_FogParams.x * tmpvar_6.z);
  mediump float tmpvar_8;
  tmpvar_8 = exp2((-(tmpvar_5) * tmpvar_5));
  tmpvar_5 = tmpvar_8;
  tmpvar_4.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_4.w * tmpvar_8));
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_9.w = tmpvar_4.w;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 col_19;
  highp vec4 ndotl_20;
  highp vec4 lengthSq_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_21 = (tmpvar_22 * tmpvar_22);
  lengthSq_21 = (lengthSq_21 + (tmpvar_23 * tmpvar_23));
  lengthSq_21 = (lengthSq_21 + (tmpvar_24 * tmpvar_24));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (lengthSq_21, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_21 = tmpvar_25;
  ndotl_20 = (tmpvar_22 * tmpvar_13.x);
  ndotl_20 = (ndotl_20 + (tmpvar_23 * tmpvar_13.y));
  ndotl_20 = (ndotl_20 + (tmpvar_24 * tmpvar_13.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_20 * inversesqrt(tmpvar_25)));
  ndotl_20 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (tmpvar_25 * lightAttenSq_18)
  ))));
  col_19 = (lightColor0_14 * tmpvar_27.x);
  col_19 = (col_19 + (lightColor1_15 * tmpvar_27.y));
  col_19 = (col_19 + (lightColor2_16 * tmpvar_27.z));
  col_19 = (col_19 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_2 = col_19;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD2.w;
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_2 = tmpvar_16;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_3.xyz * xlv_TEXCOORD4);
  mediump vec4 tmpvar_17;
  mediump float atten_18;
  atten_18 = atten_2;
  lowp vec4 col_19;
  lowp float mask_20;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - atten_18);
  mask_20 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_3.xyz;
  tmpvar_22.w = tmpvar_4;
  col_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = vec3(atten_18);
  tmpvar_17 = ((col_19 * mask_20) + tmpvar_23);
  c_1.xyz = (c_1 + tmpvar_17).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_5 = (unity_FogParams.x * tmpvar_6.z);
  mediump float tmpvar_8;
  tmpvar_8 = exp2((-(tmpvar_5) * tmpvar_5));
  tmpvar_5 = tmpvar_8;
  tmpvar_4.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_4.w * tmpvar_8));
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_9.w = tmpvar_4.w;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 col_19;
  highp vec4 ndotl_20;
  highp vec4 lengthSq_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_21 = (tmpvar_22 * tmpvar_22);
  lengthSq_21 = (lengthSq_21 + (tmpvar_23 * tmpvar_23));
  lengthSq_21 = (lengthSq_21 + (tmpvar_24 * tmpvar_24));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (lengthSq_21, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_21 = tmpvar_25;
  ndotl_20 = (tmpvar_22 * tmpvar_13.x);
  ndotl_20 = (ndotl_20 + (tmpvar_23 * tmpvar_13.y));
  ndotl_20 = (ndotl_20 + (tmpvar_24 * tmpvar_13.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_20 * inversesqrt(tmpvar_25)));
  ndotl_20 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (tmpvar_25 * lightAttenSq_18)
  ))));
  col_19 = (lightColor0_14 * tmpvar_27.x);
  col_19 = (col_19 + (lightColor1_15 * tmpvar_27.y));
  col_19 = (col_19 + (lightColor2_16 * tmpvar_27.z));
  col_19 = (col_19 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_2 = col_19;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD2.w;
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_2 = tmpvar_16;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_3.xyz * xlv_TEXCOORD4);
  mediump vec4 tmpvar_17;
  mediump float atten_18;
  atten_18 = atten_2;
  lowp vec4 col_19;
  lowp float mask_20;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - atten_18);
  mask_20 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_3.xyz;
  tmpvar_22.w = tmpvar_4;
  col_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = vec3(atten_18);
  tmpvar_17 = ((col_19 * mask_20) + tmpvar_23);
  c_1.xyz = (c_1 + tmpvar_17).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_5 = (unity_FogParams.x * tmpvar_6.z);
  mediump float tmpvar_8;
  tmpvar_8 = exp2((-(tmpvar_5) * tmpvar_5));
  tmpvar_5 = tmpvar_8;
  tmpvar_4.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_4.w * tmpvar_8));
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_9.w = tmpvar_4.w;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 col_19;
  highp vec4 ndotl_20;
  highp vec4 lengthSq_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_21 = (tmpvar_22 * tmpvar_22);
  lengthSq_21 = (lengthSq_21 + (tmpvar_23 * tmpvar_23));
  lengthSq_21 = (lengthSq_21 + (tmpvar_24 * tmpvar_24));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (lengthSq_21, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_21 = tmpvar_25;
  ndotl_20 = (tmpvar_22 * tmpvar_13.x);
  ndotl_20 = (ndotl_20 + (tmpvar_23 * tmpvar_13.y));
  ndotl_20 = (ndotl_20 + (tmpvar_24 * tmpvar_13.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_20 * inversesqrt(tmpvar_25)));
  ndotl_20 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (tmpvar_25 * lightAttenSq_18)
  ))));
  col_19 = (lightColor0_14 * tmpvar_27.x);
  col_19 = (col_19 + (lightColor1_15 * tmpvar_27.y));
  col_19 = (col_19 + (lightColor2_16 * tmpvar_27.z));
  col_19 = (col_19 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_2 = col_19;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD2.w;
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_2 = tmpvar_16;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_3.xyz * xlv_TEXCOORD4);
  mediump vec4 tmpvar_17;
  mediump float atten_18;
  atten_18 = atten_2;
  lowp vec4 col_19;
  lowp float mask_20;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - atten_18);
  mask_20 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_3.xyz;
  tmpvar_22.w = tmpvar_4;
  col_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = vec3(atten_18);
  tmpvar_17 = ((col_19 * mask_20) + tmpvar_23);
  c_1.xyz = (c_1 + tmpvar_17).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_5 = (unity_FogParams.x * tmpvar_6.z);
  mediump float tmpvar_8;
  tmpvar_8 = exp2((-(tmpvar_5) * tmpvar_5));
  tmpvar_5 = tmpvar_8;
  tmpvar_4.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_4.w * tmpvar_8));
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_9.w = tmpvar_4.w;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 col_19;
  highp vec4 ndotl_20;
  highp vec4 lengthSq_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_21 = (tmpvar_22 * tmpvar_22);
  lengthSq_21 = (lengthSq_21 + (tmpvar_23 * tmpvar_23));
  lengthSq_21 = (lengthSq_21 + (tmpvar_24 * tmpvar_24));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (lengthSq_21, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_21 = tmpvar_25;
  ndotl_20 = (tmpvar_22 * tmpvar_13.x);
  ndotl_20 = (ndotl_20 + (tmpvar_23 * tmpvar_13.y));
  ndotl_20 = (ndotl_20 + (tmpvar_24 * tmpvar_13.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_20 * inversesqrt(tmpvar_25)));
  ndotl_20 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (tmpvar_25 * lightAttenSq_18)
  ))));
  col_19 = (lightColor0_14 * tmpvar_27.x);
  col_19 = (col_19 + (lightColor1_15 * tmpvar_27.y));
  col_19 = (col_19 + (lightColor2_16 * tmpvar_27.z));
  col_19 = (col_19 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_2 = col_19;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD2.w;
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_2 = tmpvar_16;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_3.xyz * xlv_TEXCOORD4);
  mediump vec4 tmpvar_17;
  mediump float atten_18;
  atten_18 = atten_2;
  lowp vec4 col_19;
  lowp float mask_20;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - atten_18);
  mask_20 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_3.xyz;
  tmpvar_22.w = tmpvar_4;
  col_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = vec3(atten_18);
  tmpvar_17 = ((col_19 * mask_20) + tmpvar_23);
  c_1.xyz = (c_1 + tmpvar_17).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_5 = (unity_FogParams.x * tmpvar_6.z);
  mediump float tmpvar_8;
  tmpvar_8 = exp2((-(tmpvar_5) * tmpvar_5));
  tmpvar_5 = tmpvar_8;
  tmpvar_4.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_4.w * tmpvar_8));
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_9.w = tmpvar_4.w;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 col_19;
  highp vec4 ndotl_20;
  highp vec4 lengthSq_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_21 = (tmpvar_22 * tmpvar_22);
  lengthSq_21 = (lengthSq_21 + (tmpvar_23 * tmpvar_23));
  lengthSq_21 = (lengthSq_21 + (tmpvar_24 * tmpvar_24));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (lengthSq_21, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_21 = tmpvar_25;
  ndotl_20 = (tmpvar_22 * tmpvar_13.x);
  ndotl_20 = (ndotl_20 + (tmpvar_23 * tmpvar_13.y));
  ndotl_20 = (ndotl_20 + (tmpvar_24 * tmpvar_13.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_20 * inversesqrt(tmpvar_25)));
  ndotl_20 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (tmpvar_25 * lightAttenSq_18)
  ))));
  col_19 = (lightColor0_14 * tmpvar_27.x);
  col_19 = (col_19 + (lightColor1_15 * tmpvar_27.y));
  col_19 = (col_19 + (lightColor2_16 * tmpvar_27.z));
  col_19 = (col_19 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_2 = col_19;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD2.w;
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_2 = tmpvar_16;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_3.xyz * xlv_TEXCOORD4);
  mediump vec4 tmpvar_17;
  mediump float atten_18;
  atten_18 = atten_2;
  lowp vec4 col_19;
  lowp float mask_20;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - atten_18);
  mask_20 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_3.xyz;
  tmpvar_22.w = tmpvar_4;
  col_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = vec3(atten_18);
  tmpvar_17 = ((col_19 * mask_20) + tmpvar_23);
  c_1.xyz = (c_1 + tmpvar_17).xyz;
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
  LOD 100
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Background" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 91687
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = (unity_FogParams.x * tmpvar_3.z);
  mediump float tmpvar_5;
  tmpvar_5 = exp2((-(tmpvar_2) * tmpvar_2));
  tmpvar_2 = tmpvar_5;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_1.w * tmpvar_5));
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_6.w = tmpvar_1.w;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_8;
  highp vec4 wPos_9;
  wPos_9 = tmpvar_7;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_10;
    tmpvar_10[0] = unity_WorldToObject[0].xyz;
    tmpvar_10[1] = unity_WorldToObject[1].xyz;
    tmpvar_10[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = normalize((_glesNormal * tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_11, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_7.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_9.xyz = (tmpvar_7.xyz - (tmpvar_11 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_12 * tmpvar_12)))
    )));
  };
  tmpvar_8 = (unity_MatrixVP * wPos_9);
  highp vec4 clipPos_13;
  clipPos_13.xyw = tmpvar_8.xyw;
  clipPos_13.z = (tmpvar_8.z + clamp ((unity_LightShadowBias.x / tmpvar_8.w), 0.0, 1.0));
  clipPos_13.z = mix (clipPos_13.z, max (clipPos_13.z, -(tmpvar_8.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_13;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
void main ()
{
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = (unity_FogParams.x * tmpvar_3.z);
  mediump float tmpvar_5;
  tmpvar_5 = exp2((-(tmpvar_2) * tmpvar_2));
  tmpvar_2 = tmpvar_5;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_1.w * tmpvar_5));
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_6.w = tmpvar_1.w;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_8;
  highp vec4 wPos_9;
  wPos_9 = tmpvar_7;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_10;
    tmpvar_10[0] = unity_WorldToObject[0].xyz;
    tmpvar_10[1] = unity_WorldToObject[1].xyz;
    tmpvar_10[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = normalize((_glesNormal * tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_11, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_7.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_9.xyz = (tmpvar_7.xyz - (tmpvar_11 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_12 * tmpvar_12)))
    )));
  };
  tmpvar_8 = (unity_MatrixVP * wPos_9);
  highp vec4 clipPos_13;
  clipPos_13.xyw = tmpvar_8.xyw;
  clipPos_13.z = (tmpvar_8.z + clamp ((unity_LightShadowBias.x / tmpvar_8.w), 0.0, 1.0));
  clipPos_13.z = mix (clipPos_13.z, max (clipPos_13.z, -(tmpvar_8.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_13;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
void main ()
{
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = (unity_FogParams.x * tmpvar_3.z);
  mediump float tmpvar_5;
  tmpvar_5 = exp2((-(tmpvar_2) * tmpvar_2));
  tmpvar_2 = tmpvar_5;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_1.w * tmpvar_5));
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_6.w = tmpvar_1.w;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_8;
  highp vec4 wPos_9;
  wPos_9 = tmpvar_7;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_10;
    tmpvar_10[0] = unity_WorldToObject[0].xyz;
    tmpvar_10[1] = unity_WorldToObject[1].xyz;
    tmpvar_10[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = normalize((_glesNormal * tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_11, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_7.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_9.xyz = (tmpvar_7.xyz - (tmpvar_11 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_12 * tmpvar_12)))
    )));
  };
  tmpvar_8 = (unity_MatrixVP * wPos_9);
  highp vec4 clipPos_13;
  clipPos_13.xyw = tmpvar_8.xyw;
  clipPos_13.z = (tmpvar_8.z + clamp ((unity_LightShadowBias.x / tmpvar_8.w), 0.0, 1.0));
  clipPos_13.z = mix (clipPos_13.z, max (clipPos_13.z, -(tmpvar_8.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_13;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
void main ()
{
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
attribute vec4 _glesColor;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = _glesColor.xyz;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_6;
  tmpvar_2.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_2.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
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
attribute vec4 _glesColor;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = _glesColor.xyz;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_6;
  tmpvar_2.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_2.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
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
attribute vec4 _glesColor;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = _glesColor.xyz;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_6;
  tmpvar_2.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_2.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
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