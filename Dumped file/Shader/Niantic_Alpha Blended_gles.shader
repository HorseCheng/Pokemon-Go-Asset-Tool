Shader "Niantic/Alpha Blended" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
_OffsetFactor ("Z Offset Factor", Float) = 0
_Offset ("Z Offset", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _ZComp ("Z Compare Function", Float) = 0
[Header(STENCIL_ID_TO_CONTROL_SORTING_SPECIAL_FX)] _Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare Function", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 63183
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((2.0 * xlv_COLOR) * (_TintColor * texture2D (_MainTex, xlv_TEXCOORD0)));
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((2.0 * xlv_COLOR) * (_TintColor * texture2D (_MainTex, xlv_TEXCOORD0)));
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((2.0 * xlv_COLOR) * (_TintColor * texture2D (_MainTex, xlv_TEXCOORD0)));
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  highp float tmpvar_2;
  tmpvar_2 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD2.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_2);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * tmpvar_1) * (_TintColor * texture2D (_MainTex, xlv_TEXCOORD0)));
  gl_FragData[0] = tmpvar_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  highp float tmpvar_2;
  tmpvar_2 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD2.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_2);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * tmpvar_1) * (_TintColor * texture2D (_MainTex, xlv_TEXCOORD0)));
  gl_FragData[0] = tmpvar_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  highp float tmpvar_2;
  tmpvar_2 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD2.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_2);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * tmpvar_1) * (_TintColor * texture2D (_MainTex, xlv_TEXCOORD0)));
  gl_FragData[0] = tmpvar_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = ((2.0 * xlv_COLOR) * (_TintColor * texture2D (_MainTex, xlv_TEXCOORD0)));
  col_1.w = tmpvar_2.w;
  highp float tmpvar_3;
  tmpvar_3 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(tmpvar_3));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = ((2.0 * xlv_COLOR) * (_TintColor * texture2D (_MainTex, xlv_TEXCOORD0)));
  col_1.w = tmpvar_2.w;
  highp float tmpvar_3;
  tmpvar_3 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(tmpvar_3));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = ((2.0 * xlv_COLOR) * (_TintColor * texture2D (_MainTex, xlv_TEXCOORD0)));
  col_1.w = tmpvar_2.w;
  highp float tmpvar_3;
  tmpvar_3 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(tmpvar_3));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  lowp vec4 col_2;
  highp float tmpvar_3;
  tmpvar_3 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD2.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_3);
  lowp vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * tmpvar_1) * (_TintColor * texture2D (_MainTex, xlv_TEXCOORD0)));
  col_2.w = tmpvar_4.w;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_2.xyz = mix (unity_FogColor.xyz, tmpvar_4.xyz, vec3(tmpvar_5));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  lowp vec4 col_2;
  highp float tmpvar_3;
  tmpvar_3 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD2.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_3);
  lowp vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * tmpvar_1) * (_TintColor * texture2D (_MainTex, xlv_TEXCOORD0)));
  col_2.w = tmpvar_4.w;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_2.xyz = mix (unity_FogColor.xyz, tmpvar_4.xyz, vec3(tmpvar_5));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  lowp vec4 col_2;
  highp float tmpvar_3;
  tmpvar_3 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD2.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_3);
  lowp vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * tmpvar_1) * (_TintColor * texture2D (_MainTex, xlv_TEXCOORD0)));
  col_2.w = tmpvar_4.w;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_2.xyz = mix (unity_FogColor.xyz, tmpvar_4.xyz, vec3(tmpvar_5));
  gl_FragData[0] = col_2;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
""
}
}
}
}
}