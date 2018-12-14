Shader "Unlit/BadgeShader/UI" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_MaskTex ("Mask Texture", 2D) = "white" { }
_WarpTex ("Warp Texture", 2D) = "bump" { }
_WarpStrength ("Warp Strength", Float) = 1
_BlendTex ("Blend Texture", 2D) = "black" { }
_Blend ("Blend Amount", Range(0, 1)) = 1
_AdditiveTex ("Additive Texture (Blend)", 2D) = "black" { }
_AdditiveBlend ("Additive Blend Amount", Range(0, 1)) = 1
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
  GpuProgramID 61811
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
uniform highp vec4 _WarpTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform sampler2D _AdditiveTex;
uniform sampler2D _MaskTex;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
uniform lowp float _Blend;
uniform lowp float _AdditiveBlend;
uniform lowp vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = ((texture2D (_WarpTex, xlv_TEXCOORD3) - 0.5) * _WarpStrength);
  highp vec2 P_3;
  P_3 = (xlv_TEXCOORD0 + tmpvar_2.xy);
  col_1 = (((texture2D (_MainTex, P_3) + _TextureSampleAdd) * xlv_COLOR) * texture2D (_MainTex, xlv_TEXCOORD0).w);
  col_1.xyz = (col_1.xyz + (texture2D (_BlendTex, xlv_TEXCOORD0).xyz * _Blend));
  col_1.xyz = (col_1.xyz + (texture2D (_AdditiveTex, xlv_TEXCOORD0).xyz * _AdditiveBlend));
  col_1.w = (col_1.w * texture2D (_MaskTex, xlv_TEXCOORD2).x);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  col_1.w = (col_1.w * tmpvar_4);
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
uniform highp vec4 _WarpTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform sampler2D _AdditiveTex;
uniform sampler2D _MaskTex;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
uniform lowp float _Blend;
uniform lowp float _AdditiveBlend;
uniform lowp vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = ((texture2D (_WarpTex, xlv_TEXCOORD3) - 0.5) * _WarpStrength);
  highp vec2 P_3;
  P_3 = (xlv_TEXCOORD0 + tmpvar_2.xy);
  col_1 = (((texture2D (_MainTex, P_3) + _TextureSampleAdd) * xlv_COLOR) * texture2D (_MainTex, xlv_TEXCOORD0).w);
  col_1.xyz = (col_1.xyz + (texture2D (_BlendTex, xlv_TEXCOORD0).xyz * _Blend));
  col_1.xyz = (col_1.xyz + (texture2D (_AdditiveTex, xlv_TEXCOORD0).xyz * _AdditiveBlend));
  col_1.w = (col_1.w * texture2D (_MaskTex, xlv_TEXCOORD2).x);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  col_1.w = (col_1.w * tmpvar_4);
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
uniform highp vec4 _WarpTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform sampler2D _AdditiveTex;
uniform sampler2D _MaskTex;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
uniform lowp float _Blend;
uniform lowp float _AdditiveBlend;
uniform lowp vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = ((texture2D (_WarpTex, xlv_TEXCOORD3) - 0.5) * _WarpStrength);
  highp vec2 P_3;
  P_3 = (xlv_TEXCOORD0 + tmpvar_2.xy);
  col_1 = (((texture2D (_MainTex, P_3) + _TextureSampleAdd) * xlv_COLOR) * texture2D (_MainTex, xlv_TEXCOORD0).w);
  col_1.xyz = (col_1.xyz + (texture2D (_BlendTex, xlv_TEXCOORD0).xyz * _Blend));
  col_1.xyz = (col_1.xyz + (texture2D (_AdditiveTex, xlv_TEXCOORD0).xyz * _AdditiveBlend));
  col_1.w = (col_1.w * texture2D (_MaskTex, xlv_TEXCOORD2).x);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  col_1.w = (col_1.w * tmpvar_4);
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
uniform highp vec4 _WarpTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform sampler2D _AdditiveTex;
uniform sampler2D _MaskTex;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
uniform lowp float _Blend;
uniform lowp float _AdditiveBlend;
uniform lowp vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = ((texture2D (_WarpTex, xlv_TEXCOORD3) - 0.5) * _WarpStrength);
  highp vec2 P_3;
  P_3 = (xlv_TEXCOORD0 + tmpvar_2.xy);
  col_1 = (((texture2D (_MainTex, P_3) + _TextureSampleAdd) * xlv_COLOR) * texture2D (_MainTex, xlv_TEXCOORD0).w);
  col_1.xyz = (col_1.xyz + (texture2D (_BlendTex, xlv_TEXCOORD0).xyz * _Blend));
  col_1.xyz = (col_1.xyz + (texture2D (_AdditiveTex, xlv_TEXCOORD0).xyz * _AdditiveBlend));
  col_1.w = (col_1.w * texture2D (_MaskTex, xlv_TEXCOORD2).x);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  col_1.w = (col_1.w * tmpvar_4);
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
uniform highp vec4 _WarpTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform sampler2D _AdditiveTex;
uniform sampler2D _MaskTex;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
uniform lowp float _Blend;
uniform lowp float _AdditiveBlend;
uniform lowp vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = ((texture2D (_WarpTex, xlv_TEXCOORD3) - 0.5) * _WarpStrength);
  highp vec2 P_3;
  P_3 = (xlv_TEXCOORD0 + tmpvar_2.xy);
  col_1 = (((texture2D (_MainTex, P_3) + _TextureSampleAdd) * xlv_COLOR) * texture2D (_MainTex, xlv_TEXCOORD0).w);
  col_1.xyz = (col_1.xyz + (texture2D (_BlendTex, xlv_TEXCOORD0).xyz * _Blend));
  col_1.xyz = (col_1.xyz + (texture2D (_AdditiveTex, xlv_TEXCOORD0).xyz * _AdditiveBlend));
  col_1.w = (col_1.w * texture2D (_MaskTex, xlv_TEXCOORD2).x);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  col_1.w = (col_1.w * tmpvar_4);
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
uniform highp vec4 _WarpTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _BlendTex;
uniform sampler2D _AdditiveTex;
uniform sampler2D _MaskTex;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
uniform lowp float _Blend;
uniform lowp float _AdditiveBlend;
uniform lowp vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = ((texture2D (_WarpTex, xlv_TEXCOORD3) - 0.5) * _WarpStrength);
  highp vec2 P_3;
  P_3 = (xlv_TEXCOORD0 + tmpvar_2.xy);
  col_1 = (((texture2D (_MainTex, P_3) + _TextureSampleAdd) * xlv_COLOR) * texture2D (_MainTex, xlv_TEXCOORD0).w);
  col_1.xyz = (col_1.xyz + (texture2D (_BlendTex, xlv_TEXCOORD0).xyz * _Blend));
  col_1.xyz = (col_1.xyz + (texture2D (_AdditiveTex, xlv_TEXCOORD0).xyz * _AdditiveBlend));
  col_1.w = (col_1.w * texture2D (_MaskTex, xlv_TEXCOORD2).x);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  col_1.w = (col_1.w * tmpvar_4);
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