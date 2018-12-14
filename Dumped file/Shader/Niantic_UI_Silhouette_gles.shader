Shader "Niantic/UI/Silhouette" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_SilhouetteStrength ("Silhouette Strength", Range(0, 1)) = 1
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
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 32271
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = tmpvar_2;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform lowp float _SilhouetteStrength;
uniform lowp vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) + _TextureSampleAdd);
  color_2 = tmpvar_3;
  color_2.xyz = mix (color_2.xyz, xlv_COLOR.xyz, vec3(_SilhouetteStrength));
  color_2.w = (color_2.w * xlv_COLOR.w);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  color_2.w = (color_2.w * tmpvar_4);
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = tmpvar_2;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform lowp float _SilhouetteStrength;
uniform lowp vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) + _TextureSampleAdd);
  color_2 = tmpvar_3;
  color_2.xyz = mix (color_2.xyz, xlv_COLOR.xyz, vec3(_SilhouetteStrength));
  color_2.w = (color_2.w * xlv_COLOR.w);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  color_2.w = (color_2.w * tmpvar_4);
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
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = tmpvar_2;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform lowp float _SilhouetteStrength;
uniform lowp vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) + _TextureSampleAdd);
  color_2 = tmpvar_3;
  color_2.xyz = mix (color_2.xyz, xlv_COLOR.xyz, vec3(_SilhouetteStrength));
  color_2.w = (color_2.w * xlv_COLOR.w);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  color_2.w = (color_2.w * tmpvar_4);
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
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
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = tmpvar_2;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform lowp float _SilhouetteStrength;
uniform lowp vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) + _TextureSampleAdd);
  color_2 = tmpvar_3;
  color_2.xyz = mix (color_2.xyz, xlv_COLOR.xyz, vec3(_SilhouetteStrength));
  color_2.w = (color_2.w * xlv_COLOR.w);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  color_2.w = (color_2.w * tmpvar_4);
  mediump float x_7;
  x_7 = (color_2.w - 0.001);
  if ((x_7 < 0.0)) {
    discard;
  };
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
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
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = tmpvar_2;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform lowp float _SilhouetteStrength;
uniform lowp vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) + _TextureSampleAdd);
  color_2 = tmpvar_3;
  color_2.xyz = mix (color_2.xyz, xlv_COLOR.xyz, vec3(_SilhouetteStrength));
  color_2.w = (color_2.w * xlv_COLOR.w);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  color_2.w = (color_2.w * tmpvar_4);
  mediump float x_7;
  x_7 = (color_2.w - 0.001);
  if ((x_7 < 0.0)) {
    discard;
  };
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
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
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = tmpvar_2;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform lowp float _SilhouetteStrength;
uniform lowp vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) + _TextureSampleAdd);
  color_2 = tmpvar_3;
  color_2.xyz = mix (color_2.xyz, xlv_COLOR.xyz, vec3(_SilhouetteStrength));
  color_2.w = (color_2.w * xlv_COLOR.w);
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  color_2.w = (color_2.w * tmpvar_4);
  mediump float x_7;
  x_7 = (color_2.w - 0.001);
  if ((x_7 < 0.0)) {
    discard;
  };
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