Shader "Holo/Shadow Matte/Composite (for Pokedex)" {
Properties {
_ShadowColor ("Shadow Tint (RGBA)", Color) = (0,0,0,1)
_Alpha ("Alpha Out (for Pokedex)", Range(0, 1)) = 1
[KeywordEnum(Alpha_X_Ambient, RGBA)] _Multiplier ("    Clear Multiplier", Float) = 0
_Clip ("Target Clip (x min, y min, x max, y max)", Vector) = (0,0,0,0)
_Feather ("Target Feather (x min, y min, x max, y max)", Vector) = (0,0,0,0)
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("Mask X", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("Mask Y", Float) = 0
[Toggle(BRB_EYE_SHADE_DEBUG)] _EyeShadeDebug ("Debug Mask", Float) = 0
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "AlphaTest+50" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 100
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest+50" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 64987
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD4;
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_10));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  color_1.w = 0.0;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD4;
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_10));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  color_1.w = 0.0;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD4;
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_10));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  color_1.w = 0.0;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD4;
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_10));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  color_1.w = 0.0;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD4;
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_10));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  color_1.w = 0.0;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD4;
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_2.w;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_10));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  color_1.w = 0.0;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD4;
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
  tmpvar_8.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_9.zw;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_11));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_7;
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
uniform lowp vec4 _Clip;
uniform lowp vec4 _Feather;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 screenMask_5;
  lowp vec2 screenPos_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD2.xy;
  screenPos_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.xy = ((1.0 - _Clip.zy) - screenPos_6);
  tmpvar_8.zw = (screenPos_6 - _Clip.xw);
  screenMask_5 = tmpvar_8;
  tmpvar_3 = xlv_TEXCOORD3;
  tmpvar_4 = xlv_TEXCOORD3.w;
  mediump float realtimeShadowAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_15;
  highp vec4 shadowCoord_16;
  shadowCoord_16 = (unity_WorldToShadow[0] * tmpvar_14);
  highp float lightShadowDataX_17;
  mediump float tmpvar_18;
  tmpvar_18 = _LightShadowData.x;
  lightShadowDataX_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (float((texture2D (_ShadowMapTexture, shadowCoord_16.xy).x > shadowCoord_16.z)), lightShadowDataX_17);
  tmpvar_15 = tmpvar_19;
  realtimeShadowAttenuation_9 = tmpvar_15;
  mediump float tmpvar_20;
  tmpvar_20 = clamp ((realtimeShadowAttenuation_9 + tmpvar_12), 0.0, 1.0);
  atten_2 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump float atten_22;
  atten_22 = atten_2;
  lowp vec4 col_23;
  lowp float mask_24;
  mediump float tmpvar_25;
  tmpvar_25 = (1.0 - atten_22);
  mask_24 = tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_3.xyz;
  tmpvar_26.w = tmpvar_4;
  col_23 = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = vec3(atten_22);
  tmpvar_21 = ((col_23 * mask_24) + tmpvar_27);
  c_1 = tmpvar_21;
  lowp vec4 color_28;
  color_28.xyz = c_1.xyz;
  mediump vec4 screenRatio_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = ((1.0 - _Clip) - _Clip.zwxy);
  screenRatio_29 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((screenMask_5.y / (screenRatio_29.y * _Feather.y)), 0.0, 1.0);
  color_28.w = (c_1.w * tmpvar_31);
  mediump float tmpvar_32;
  tmpvar_32 = clamp ((screenMask_5.w / (screenRatio_29.w * _Feather.w)), 0.0, 1.0);
  color_28.w = (color_28.w * tmpvar_32);
  c_1 = color_28;
  gl_FragData[0] = color_28;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD4;
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
  tmpvar_8.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_9.zw;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_11));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_7;
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
uniform lowp vec4 _Clip;
uniform lowp vec4 _Feather;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 screenMask_5;
  lowp vec2 screenPos_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD2.xy;
  screenPos_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.xy = ((1.0 - _Clip.zy) - screenPos_6);
  tmpvar_8.zw = (screenPos_6 - _Clip.xw);
  screenMask_5 = tmpvar_8;
  tmpvar_3 = xlv_TEXCOORD3;
  tmpvar_4 = xlv_TEXCOORD3.w;
  mediump float realtimeShadowAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_15;
  highp vec4 shadowCoord_16;
  shadowCoord_16 = (unity_WorldToShadow[0] * tmpvar_14);
  highp float lightShadowDataX_17;
  mediump float tmpvar_18;
  tmpvar_18 = _LightShadowData.x;
  lightShadowDataX_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (float((texture2D (_ShadowMapTexture, shadowCoord_16.xy).x > shadowCoord_16.z)), lightShadowDataX_17);
  tmpvar_15 = tmpvar_19;
  realtimeShadowAttenuation_9 = tmpvar_15;
  mediump float tmpvar_20;
  tmpvar_20 = clamp ((realtimeShadowAttenuation_9 + tmpvar_12), 0.0, 1.0);
  atten_2 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump float atten_22;
  atten_22 = atten_2;
  lowp vec4 col_23;
  lowp float mask_24;
  mediump float tmpvar_25;
  tmpvar_25 = (1.0 - atten_22);
  mask_24 = tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_3.xyz;
  tmpvar_26.w = tmpvar_4;
  col_23 = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = vec3(atten_22);
  tmpvar_21 = ((col_23 * mask_24) + tmpvar_27);
  c_1 = tmpvar_21;
  lowp vec4 color_28;
  color_28.xyz = c_1.xyz;
  mediump vec4 screenRatio_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = ((1.0 - _Clip) - _Clip.zwxy);
  screenRatio_29 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((screenMask_5.y / (screenRatio_29.y * _Feather.y)), 0.0, 1.0);
  color_28.w = (c_1.w * tmpvar_31);
  mediump float tmpvar_32;
  tmpvar_32 = clamp ((screenMask_5.w / (screenRatio_29.w * _Feather.w)), 0.0, 1.0);
  color_28.w = (color_28.w * tmpvar_32);
  c_1 = color_28;
  gl_FragData[0] = color_28;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD4;
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
  tmpvar_8.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_9.zw;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_11));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_7;
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
uniform lowp vec4 _Clip;
uniform lowp vec4 _Feather;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 screenMask_5;
  lowp vec2 screenPos_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD2.xy;
  screenPos_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.xy = ((1.0 - _Clip.zy) - screenPos_6);
  tmpvar_8.zw = (screenPos_6 - _Clip.xw);
  screenMask_5 = tmpvar_8;
  tmpvar_3 = xlv_TEXCOORD3;
  tmpvar_4 = xlv_TEXCOORD3.w;
  mediump float realtimeShadowAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_15;
  highp vec4 shadowCoord_16;
  shadowCoord_16 = (unity_WorldToShadow[0] * tmpvar_14);
  highp float lightShadowDataX_17;
  mediump float tmpvar_18;
  tmpvar_18 = _LightShadowData.x;
  lightShadowDataX_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (float((texture2D (_ShadowMapTexture, shadowCoord_16.xy).x > shadowCoord_16.z)), lightShadowDataX_17);
  tmpvar_15 = tmpvar_19;
  realtimeShadowAttenuation_9 = tmpvar_15;
  mediump float tmpvar_20;
  tmpvar_20 = clamp ((realtimeShadowAttenuation_9 + tmpvar_12), 0.0, 1.0);
  atten_2 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump float atten_22;
  atten_22 = atten_2;
  lowp vec4 col_23;
  lowp float mask_24;
  mediump float tmpvar_25;
  tmpvar_25 = (1.0 - atten_22);
  mask_24 = tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_3.xyz;
  tmpvar_26.w = tmpvar_4;
  col_23 = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = vec3(atten_22);
  tmpvar_21 = ((col_23 * mask_24) + tmpvar_27);
  c_1 = tmpvar_21;
  lowp vec4 color_28;
  color_28.xyz = c_1.xyz;
  mediump vec4 screenRatio_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = ((1.0 - _Clip) - _Clip.zwxy);
  screenRatio_29 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((screenMask_5.y / (screenRatio_29.y * _Feather.y)), 0.0, 1.0);
  color_28.w = (c_1.w * tmpvar_31);
  mediump float tmpvar_32;
  tmpvar_32 = clamp ((screenMask_5.w / (screenRatio_29.w * _Feather.w)), 0.0, 1.0);
  color_28.w = (color_28.w * tmpvar_32);
  c_1 = color_28;
  gl_FragData[0] = color_28;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD4;
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
  tmpvar_8.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_9.zw;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_11));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_7;
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
uniform lowp vec4 _Clip;
uniform lowp vec4 _Feather;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 screenMask_5;
  lowp vec2 screenPos_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD2.xy;
  screenPos_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.xy = ((1.0 - _Clip.zy) - screenPos_6);
  tmpvar_8.zw = (screenPos_6 - _Clip.xw);
  screenMask_5 = tmpvar_8;
  tmpvar_3 = xlv_TEXCOORD3;
  tmpvar_4 = xlv_TEXCOORD3.w;
  mediump float realtimeShadowAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_15;
  highp vec4 shadowCoord_16;
  shadowCoord_16 = (unity_WorldToShadow[0] * tmpvar_14);
  highp float lightShadowDataX_17;
  mediump float tmpvar_18;
  tmpvar_18 = _LightShadowData.x;
  lightShadowDataX_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (float((texture2D (_ShadowMapTexture, shadowCoord_16.xy).x > shadowCoord_16.z)), lightShadowDataX_17);
  tmpvar_15 = tmpvar_19;
  realtimeShadowAttenuation_9 = tmpvar_15;
  mediump float tmpvar_20;
  tmpvar_20 = clamp ((realtimeShadowAttenuation_9 + tmpvar_12), 0.0, 1.0);
  atten_2 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump float atten_22;
  atten_22 = atten_2;
  lowp vec4 col_23;
  lowp float mask_24;
  mediump float tmpvar_25;
  tmpvar_25 = (1.0 - atten_22);
  mask_24 = tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_3.xyz;
  tmpvar_26.w = tmpvar_4;
  col_23 = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = vec3(atten_22);
  tmpvar_21 = ((col_23 * mask_24) + tmpvar_27);
  c_1 = tmpvar_21;
  lowp vec4 color_28;
  color_28.xyz = c_1.xyz;
  mediump vec4 screenRatio_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = ((1.0 - _Clip) - _Clip.zwxy);
  screenRatio_29 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((screenMask_5.y / (screenRatio_29.y * _Feather.y)), 0.0, 1.0);
  color_28.w = (c_1.w * tmpvar_31);
  mediump float tmpvar_32;
  tmpvar_32 = clamp ((screenMask_5.w / (screenRatio_29.w * _Feather.w)), 0.0, 1.0);
  color_28.w = (color_28.w * tmpvar_32);
  c_1 = color_28;
  gl_FragData[0] = color_28;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD4;
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
  tmpvar_8.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_9.zw;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_11));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_7;
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
uniform lowp vec4 _Clip;
uniform lowp vec4 _Feather;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 screenMask_5;
  lowp vec2 screenPos_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD2.xy;
  screenPos_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.xy = ((1.0 - _Clip.zy) - screenPos_6);
  tmpvar_8.zw = (screenPos_6 - _Clip.xw);
  screenMask_5 = tmpvar_8;
  tmpvar_3 = xlv_TEXCOORD3;
  tmpvar_4 = xlv_TEXCOORD3.w;
  mediump float realtimeShadowAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_15;
  highp vec4 shadowCoord_16;
  shadowCoord_16 = (unity_WorldToShadow[0] * tmpvar_14);
  highp float lightShadowDataX_17;
  mediump float tmpvar_18;
  tmpvar_18 = _LightShadowData.x;
  lightShadowDataX_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (float((texture2D (_ShadowMapTexture, shadowCoord_16.xy).x > shadowCoord_16.z)), lightShadowDataX_17);
  tmpvar_15 = tmpvar_19;
  realtimeShadowAttenuation_9 = tmpvar_15;
  mediump float tmpvar_20;
  tmpvar_20 = clamp ((realtimeShadowAttenuation_9 + tmpvar_12), 0.0, 1.0);
  atten_2 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump float atten_22;
  atten_22 = atten_2;
  lowp vec4 col_23;
  lowp float mask_24;
  mediump float tmpvar_25;
  tmpvar_25 = (1.0 - atten_22);
  mask_24 = tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_3.xyz;
  tmpvar_26.w = tmpvar_4;
  col_23 = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = vec3(atten_22);
  tmpvar_21 = ((col_23 * mask_24) + tmpvar_27);
  c_1 = tmpvar_21;
  lowp vec4 color_28;
  color_28.xyz = c_1.xyz;
  mediump vec4 screenRatio_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = ((1.0 - _Clip) - _Clip.zwxy);
  screenRatio_29 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((screenMask_5.y / (screenRatio_29.y * _Feather.y)), 0.0, 1.0);
  color_28.w = (c_1.w * tmpvar_31);
  mediump float tmpvar_32;
  tmpvar_32 = clamp ((screenMask_5.w / (screenRatio_29.w * _Feather.w)), 0.0, 1.0);
  color_28.w = (color_28.w * tmpvar_32);
  c_1 = color_28;
  gl_FragData[0] = color_28;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD4;
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
  tmpvar_8.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_8.w = tmpvar_3.w;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_9.zw;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_11));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_7;
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
uniform lowp vec4 _Clip;
uniform lowp vec4 _Feather;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float atten_2;
  mediump vec4 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 screenMask_5;
  lowp vec2 screenPos_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD2.xy;
  screenPos_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.xy = ((1.0 - _Clip.zy) - screenPos_6);
  tmpvar_8.zw = (screenPos_6 - _Clip.xw);
  screenMask_5 = tmpvar_8;
  tmpvar_3 = xlv_TEXCOORD3;
  tmpvar_4 = xlv_TEXCOORD3.w;
  mediump float realtimeShadowAttenuation_9;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD1 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD1), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_15;
  highp vec4 shadowCoord_16;
  shadowCoord_16 = (unity_WorldToShadow[0] * tmpvar_14);
  highp float lightShadowDataX_17;
  mediump float tmpvar_18;
  tmpvar_18 = _LightShadowData.x;
  lightShadowDataX_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (float((texture2D (_ShadowMapTexture, shadowCoord_16.xy).x > shadowCoord_16.z)), lightShadowDataX_17);
  tmpvar_15 = tmpvar_19;
  realtimeShadowAttenuation_9 = tmpvar_15;
  mediump float tmpvar_20;
  tmpvar_20 = clamp ((realtimeShadowAttenuation_9 + tmpvar_12), 0.0, 1.0);
  atten_2 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump float atten_22;
  atten_22 = atten_2;
  lowp vec4 col_23;
  lowp float mask_24;
  mediump float tmpvar_25;
  tmpvar_25 = (1.0 - atten_22);
  mask_24 = tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_3.xyz;
  tmpvar_26.w = tmpvar_4;
  col_23 = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = vec3(atten_22);
  tmpvar_21 = ((col_23 * mask_24) + tmpvar_27);
  c_1 = tmpvar_21;
  lowp vec4 color_28;
  color_28.xyz = c_1.xyz;
  mediump vec4 screenRatio_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = ((1.0 - _Clip) - _Clip.zwxy);
  screenRatio_29 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((screenMask_5.y / (screenRatio_29.y * _Feather.y)), 0.0, 1.0);
  color_28.w = (c_1.w * tmpvar_31);
  mediump float tmpvar_32;
  tmpvar_32 = clamp ((screenMask_5.w / (screenRatio_29.w * _Feather.w)), 0.0, 1.0);
  color_28.w = (color_28.w * tmpvar_32);
  c_1 = color_28;
  gl_FragData[0] = color_28;
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
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "AlphaTest+50" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 80856
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
  tmpvar_6.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
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
  tmpvar_6.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
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
  tmpvar_6.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
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