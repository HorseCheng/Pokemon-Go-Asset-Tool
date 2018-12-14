Shader "Sprites/Mask" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_AlphaTex ("External Alpha", 2D) = "white" { }
_Cutoff ("Mask alpha cutoff", Range(0, 1)) = 0
_Color ("Tint", Color) = (1,1,1,0.2)
_EnableExternalAlpha ("Enable External Alpha", Float) = 0
[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 59372
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  lowp float x_2;
  x_2 = (texture2D (_MainTex, uv_1).w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  gl_FragData[0] = _Color;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  lowp float x_2;
  x_2 = (texture2D (_MainTex, uv_1).w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  gl_FragData[0] = _Color;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  lowp float x_2;
  x_2 = (texture2D (_MainTex, uv_1).w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  gl_FragData[0] = _Color;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ETC1_EXTERNAL_ALPHA" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp float _EnableExternalAlpha;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  lowp vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_1);
  color_2.xyz = tmpvar_3.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, uv_1);
  highp float tmpvar_5;
  tmpvar_5 = mix (tmpvar_3.w, tmpvar_4.x, _EnableExternalAlpha);
  color_2.w = tmpvar_5;
  lowp float x_6;
  x_6 = (color_2.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  gl_FragData[0] = _Color;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ETC1_EXTERNAL_ALPHA" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp float _EnableExternalAlpha;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  lowp vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_1);
  color_2.xyz = tmpvar_3.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, uv_1);
  highp float tmpvar_5;
  tmpvar_5 = mix (tmpvar_3.w, tmpvar_4.x, _EnableExternalAlpha);
  color_2.w = tmpvar_5;
  lowp float x_6;
  x_6 = (color_2.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  gl_FragData[0] = _Color;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ETC1_EXTERNAL_ALPHA" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp float _EnableExternalAlpha;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  lowp vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_1);
  color_2.xyz = tmpvar_3.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, uv_1);
  highp float tmpvar_5;
  tmpvar_5 = mix (tmpvar_3.w, tmpvar_4.x, _EnableExternalAlpha);
  color_2.w = tmpvar_5;
  lowp float x_6;
  x_6 = (color_2.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  gl_FragData[0] = _Color;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 pos_3;
  pos_3.zw = tmpvar_1.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_ScreenParams.xy * 0.5);
  pos_3.xy = ((floor(
    (((tmpvar_1.xy / tmpvar_1.w) * tmpvar_4) + vec2(0.5, 0.5))
  ) / tmpvar_4) * tmpvar_1.w);
  gl_Position = pos_3;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  lowp float x_2;
  x_2 = (texture2D (_MainTex, uv_1).w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  gl_FragData[0] = _Color;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 pos_3;
  pos_3.zw = tmpvar_1.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_ScreenParams.xy * 0.5);
  pos_3.xy = ((floor(
    (((tmpvar_1.xy / tmpvar_1.w) * tmpvar_4) + vec2(0.5, 0.5))
  ) / tmpvar_4) * tmpvar_1.w);
  gl_Position = pos_3;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  lowp float x_2;
  x_2 = (texture2D (_MainTex, uv_1).w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  gl_FragData[0] = _Color;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 pos_3;
  pos_3.zw = tmpvar_1.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_ScreenParams.xy * 0.5);
  pos_3.xy = ((floor(
    (((tmpvar_1.xy / tmpvar_1.w) * tmpvar_4) + vec2(0.5, 0.5))
  ) / tmpvar_4) * tmpvar_1.w);
  gl_Position = pos_3;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  lowp float x_2;
  x_2 = (texture2D (_MainTex, uv_1).w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  gl_FragData[0] = _Color;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 pos_3;
  pos_3.zw = tmpvar_1.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_ScreenParams.xy * 0.5);
  pos_3.xy = ((floor(
    (((tmpvar_1.xy / tmpvar_1.w) * tmpvar_4) + vec2(0.5, 0.5))
  ) / tmpvar_4) * tmpvar_1.w);
  gl_Position = pos_3;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp float _EnableExternalAlpha;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  lowp vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_1);
  color_2.xyz = tmpvar_3.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, uv_1);
  highp float tmpvar_5;
  tmpvar_5 = mix (tmpvar_3.w, tmpvar_4.x, _EnableExternalAlpha);
  color_2.w = tmpvar_5;
  lowp float x_6;
  x_6 = (color_2.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  gl_FragData[0] = _Color;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 pos_3;
  pos_3.zw = tmpvar_1.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_ScreenParams.xy * 0.5);
  pos_3.xy = ((floor(
    (((tmpvar_1.xy / tmpvar_1.w) * tmpvar_4) + vec2(0.5, 0.5))
  ) / tmpvar_4) * tmpvar_1.w);
  gl_Position = pos_3;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp float _EnableExternalAlpha;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  lowp vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_1);
  color_2.xyz = tmpvar_3.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, uv_1);
  highp float tmpvar_5;
  tmpvar_5 = mix (tmpvar_3.w, tmpvar_4.x, _EnableExternalAlpha);
  color_2.w = tmpvar_5;
  lowp float x_6;
  x_6 = (color_2.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  gl_FragData[0] = _Color;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 pos_3;
  pos_3.zw = tmpvar_1.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_ScreenParams.xy * 0.5);
  pos_3.xy = ((floor(
    (((tmpvar_1.xy / tmpvar_1.w) * tmpvar_4) + vec2(0.5, 0.5))
  ) / tmpvar_4) * tmpvar_1.w);
  gl_Position = pos_3;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp float _EnableExternalAlpha;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  lowp vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_1);
  color_2.xyz = tmpvar_3.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, uv_1);
  highp float tmpvar_5;
  tmpvar_5 = mix (tmpvar_3.w, tmpvar_4.x, _EnableExternalAlpha);
  color_2.w = tmpvar_5;
  lowp float x_6;
  x_6 = (color_2.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  gl_FragData[0] = _Color;
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
Keywords { "ETC1_EXTERNAL_ALPHA" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ETC1_EXTERNAL_ALPHA" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ETC1_EXTERNAL_ALPHA" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
""
}
}
}
}
}