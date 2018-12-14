Shader "Unlit/NewsEntry" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_MaskTex ("Mask Texture", 2D) = "white" { }
_ShadowStrength ("Shadow Strength", Float) = 0
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "DEFAULT"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 59940
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MaskTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _ShadowStrength;
uniform highp vec4 _ClipRect;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = tmpvar_2.xyz;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MaskTex, xlv_TEXCOORD2);
  col_1.w = (tmpvar_2.w * tmpvar_3.x);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  col_1.w = (col_1.w * tmpvar_4);
  col_1.w = (col_1.w + tmpvar_3.y);
  col_1.xyz = (tmpvar_2.xyz * (1.0 - (tmpvar_3.y * _ShadowStrength)));
  col_1.xyz = (col_1.xyz * (1.0 - tmpvar_3.z));
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MaskTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _ShadowStrength;
uniform highp vec4 _ClipRect;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = tmpvar_2.xyz;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MaskTex, xlv_TEXCOORD2);
  col_1.w = (tmpvar_2.w * tmpvar_3.x);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  col_1.w = (col_1.w * tmpvar_4);
  col_1.w = (col_1.w + tmpvar_3.y);
  col_1.xyz = (tmpvar_2.xyz * (1.0 - (tmpvar_3.y * _ShadowStrength)));
  col_1.xyz = (col_1.xyz * (1.0 - tmpvar_3.z));
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MaskTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _ShadowStrength;
uniform highp vec4 _ClipRect;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = tmpvar_2.xyz;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MaskTex, xlv_TEXCOORD2);
  col_1.w = (tmpvar_2.w * tmpvar_3.x);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  col_1.w = (col_1.w * tmpvar_4);
  col_1.w = (col_1.w + tmpvar_3.y);
  col_1.xyz = (tmpvar_2.xyz * (1.0 - (tmpvar_3.y * _ShadowStrength)));
  col_1.xyz = (col_1.xyz * (1.0 - tmpvar_3.z));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MaskTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _ShadowStrength;
uniform highp vec4 _ClipRect;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = tmpvar_2.xyz;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MaskTex, xlv_TEXCOORD2);
  col_1.w = (tmpvar_2.w * tmpvar_3.x);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  col_1.w = (col_1.w * tmpvar_4);
  col_1.w = (col_1.w + tmpvar_3.y);
  col_1.xyz = (tmpvar_2.xyz * (1.0 - (tmpvar_3.y * _ShadowStrength)));
  col_1.xyz = (col_1.xyz * (1.0 - tmpvar_3.z));
  lowp float x_7;
  x_7 = (col_1.w - 0.001);
  if ((x_7 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MaskTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _ShadowStrength;
uniform highp vec4 _ClipRect;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = tmpvar_2.xyz;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MaskTex, xlv_TEXCOORD2);
  col_1.w = (tmpvar_2.w * tmpvar_3.x);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  col_1.w = (col_1.w * tmpvar_4);
  col_1.w = (col_1.w + tmpvar_3.y);
  col_1.xyz = (tmpvar_2.xyz * (1.0 - (tmpvar_3.y * _ShadowStrength)));
  col_1.xyz = (col_1.xyz * (1.0 - tmpvar_3.z));
  lowp float x_7;
  x_7 = (col_1.w - 0.001);
  if ((x_7 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MaskTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _ShadowStrength;
uniform highp vec4 _ClipRect;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = tmpvar_2.xyz;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MaskTex, xlv_TEXCOORD2);
  col_1.w = (tmpvar_2.w * tmpvar_3.x);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  col_1.w = (col_1.w * tmpvar_4);
  col_1.w = (col_1.w + tmpvar_3.y);
  col_1.xyz = (tmpvar_2.xyz * (1.0 - (tmpvar_3.y * _ShadowStrength)));
  col_1.xyz = (col_1.xyz * (1.0 - tmpvar_3.z));
  lowp float x_7;
  x_7 = (col_1.w - 0.001);
  if ((x_7 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
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
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
}
}
}
}