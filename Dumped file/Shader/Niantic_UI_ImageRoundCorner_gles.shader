Shader "Niantic/UI/ImageRoundCorner" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Corner ("Corner", Float) = 0.1
_Feather ("Feather", Float) = 0.01
_Width ("Image Width", Float) = 586
_Height ("Image Height", Float) = 374
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "DEFAULT"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 60313
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
uniform highp float _Corner;
uniform highp float _Feather;
uniform highp float _Width;
uniform highp float _Height;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = _Corner;
  tmpvar_3.y = (_Corner * (_Width / _Height));
  highp vec2 tmpvar_4;
  tmpvar_4 = (1.0 - (2.0 * abs(
    (xlv_TEXCOORD0 - 0.5)
  )));
  highp vec2 tmpvar_5;
  tmpvar_5 = (clamp ((tmpvar_3 - tmpvar_4), 0.0, 1.0) / tmpvar_3);
  highp vec2 tmpvar_6;
  tmpvar_6.x = float((_Corner >= tmpvar_4.x));
  tmpvar_6.y = float((tmpvar_3.y >= tmpvar_4.y));
  highp float edge0_7;
  edge0_7 = (1.0 - _Feather);
  highp float tmpvar_8;
  tmpvar_8 = clamp (((
    sqrt(dot (tmpvar_5, tmpvar_5))
   - edge0_7) / (
    (1.0 + _Feather)
   - edge0_7)), 0.0, 1.0);
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, (1.0 - (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )), min (tmpvar_6.x, tmpvar_6.y));
  lowp vec4 tmpvar_10;
  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  color_2 = tmpvar_10;
  color_2.w = (color_2.w * tmpvar_9);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  color_2.w = (color_2.w * tmpvar_11);
  tmpvar_1 = color_2;
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
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
uniform highp float _Corner;
uniform highp float _Feather;
uniform highp float _Width;
uniform highp float _Height;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = _Corner;
  tmpvar_3.y = (_Corner * (_Width / _Height));
  highp vec2 tmpvar_4;
  tmpvar_4 = (1.0 - (2.0 * abs(
    (xlv_TEXCOORD0 - 0.5)
  )));
  highp vec2 tmpvar_5;
  tmpvar_5 = (clamp ((tmpvar_3 - tmpvar_4), 0.0, 1.0) / tmpvar_3);
  highp vec2 tmpvar_6;
  tmpvar_6.x = float((_Corner >= tmpvar_4.x));
  tmpvar_6.y = float((tmpvar_3.y >= tmpvar_4.y));
  highp float edge0_7;
  edge0_7 = (1.0 - _Feather);
  highp float tmpvar_8;
  tmpvar_8 = clamp (((
    sqrt(dot (tmpvar_5, tmpvar_5))
   - edge0_7) / (
    (1.0 + _Feather)
   - edge0_7)), 0.0, 1.0);
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, (1.0 - (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )), min (tmpvar_6.x, tmpvar_6.y));
  lowp vec4 tmpvar_10;
  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  color_2 = tmpvar_10;
  color_2.w = (color_2.w * tmpvar_9);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  color_2.w = (color_2.w * tmpvar_11);
  tmpvar_1 = color_2;
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
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
uniform highp float _Corner;
uniform highp float _Feather;
uniform highp float _Width;
uniform highp float _Height;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = _Corner;
  tmpvar_3.y = (_Corner * (_Width / _Height));
  highp vec2 tmpvar_4;
  tmpvar_4 = (1.0 - (2.0 * abs(
    (xlv_TEXCOORD0 - 0.5)
  )));
  highp vec2 tmpvar_5;
  tmpvar_5 = (clamp ((tmpvar_3 - tmpvar_4), 0.0, 1.0) / tmpvar_3);
  highp vec2 tmpvar_6;
  tmpvar_6.x = float((_Corner >= tmpvar_4.x));
  tmpvar_6.y = float((tmpvar_3.y >= tmpvar_4.y));
  highp float edge0_7;
  edge0_7 = (1.0 - _Feather);
  highp float tmpvar_8;
  tmpvar_8 = clamp (((
    sqrt(dot (tmpvar_5, tmpvar_5))
   - edge0_7) / (
    (1.0 + _Feather)
   - edge0_7)), 0.0, 1.0);
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, (1.0 - (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )), min (tmpvar_6.x, tmpvar_6.y));
  lowp vec4 tmpvar_10;
  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  color_2 = tmpvar_10;
  color_2.w = (color_2.w * tmpvar_9);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  color_2.w = (color_2.w * tmpvar_11);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
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
}
}
}
}