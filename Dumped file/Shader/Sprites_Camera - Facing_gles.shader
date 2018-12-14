Shader "Sprites/Camera - Facing" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
_RendererColor ("RendererColor", Color) = (1,1,1,1)
_Flip ("Flip", Vector) = (1,1,1,1)
_AlphaTex ("External Alpha", 2D) = "white" { }
_EnableExternalAlpha ("Enable External Alpha", Float) = 0
_Scale ("Scale", Float) = 1
_Offset ("Offset", Vector) = (0,0,0,0)
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 5408
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform mediump float _Scale;
uniform mediump vec3 _Offset;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xy = ((_glesVertex.xy * vec2(_Scale)) + _Offset.xy);
  tmpvar_2.z = _Offset.z;
  tmpvar_1 = ((_glesColor * _Color) * _RendererColor);
  gl_Position = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_2));
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * tmpvar_2.w);
  gl_FragData[0] = c_1;
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
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform mediump float _Scale;
uniform mediump vec3 _Offset;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xy = ((_glesVertex.xy * vec2(_Scale)) + _Offset.xy);
  tmpvar_2.z = _Offset.z;
  tmpvar_1 = ((_glesColor * _Color) * _RendererColor);
  gl_Position = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_2));
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * tmpvar_2.w);
  gl_FragData[0] = c_1;
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
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform mediump float _Scale;
uniform mediump vec3 _Offset;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xy = ((_glesVertex.xy * vec2(_Scale)) + _Offset.xy);
  tmpvar_2.z = _Offset.z;
  tmpvar_1 = ((_glesColor * _Color) * _RendererColor);
  gl_Position = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_2));
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * tmpvar_2.w);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ETC1_EXTERNAL_ALPHA" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform mediump float _Scale;
uniform mediump vec3 _Offset;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xy = ((_glesVertex.xy * vec2(_Scale)) + _Offset.xy);
  tmpvar_2.z = _Offset.z;
  tmpvar_1 = ((_glesColor * _Color) * _RendererColor);
  gl_Position = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_2));
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp float _EnableExternalAlpha;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2.xyz = tmpvar_3.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = mix (tmpvar_3.w, tmpvar_4.x, _EnableExternalAlpha);
  color_2.w = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (color_2 * xlv_COLOR);
  c_1.w = tmpvar_6.w;
  c_1.xyz = (tmpvar_6.xyz * tmpvar_6.w);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ETC1_EXTERNAL_ALPHA" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform mediump float _Scale;
uniform mediump vec3 _Offset;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xy = ((_glesVertex.xy * vec2(_Scale)) + _Offset.xy);
  tmpvar_2.z = _Offset.z;
  tmpvar_1 = ((_glesColor * _Color) * _RendererColor);
  gl_Position = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_2));
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp float _EnableExternalAlpha;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2.xyz = tmpvar_3.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = mix (tmpvar_3.w, tmpvar_4.x, _EnableExternalAlpha);
  color_2.w = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (color_2 * xlv_COLOR);
  c_1.w = tmpvar_6.w;
  c_1.xyz = (tmpvar_6.xyz * tmpvar_6.w);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ETC1_EXTERNAL_ALPHA" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform mediump float _Scale;
uniform mediump vec3 _Offset;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xy = ((_glesVertex.xy * vec2(_Scale)) + _Offset.xy);
  tmpvar_2.z = _Offset.z;
  tmpvar_1 = ((_glesColor * _Color) * _RendererColor);
  gl_Position = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_2));
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp float _EnableExternalAlpha;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2.xyz = tmpvar_3.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = mix (tmpvar_3.w, tmpvar_4.x, _EnableExternalAlpha);
  color_2.w = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (color_2 * xlv_COLOR);
  c_1.w = tmpvar_6.w;
  c_1.xyz = (tmpvar_6.xyz * tmpvar_6.w);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform mediump float _Scale;
uniform mediump vec3 _Offset;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xy = ((_glesVertex.xy * vec2(_Scale)) + _Offset.xy);
  tmpvar_3.z = _Offset.z;
  tmpvar_1 = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_3));
  tmpvar_2 = ((_glesColor * _Color) * _RendererColor);
  highp vec4 pos_4;
  pos_4.zw = tmpvar_1.zw;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_ScreenParams.xy * 0.5);
  pos_4.xy = ((floor(
    (((tmpvar_1.xy / tmpvar_1.w) * tmpvar_5) + vec2(0.5, 0.5))
  ) / tmpvar_5) * tmpvar_1.w);
  tmpvar_1 = pos_4;
  gl_Position = pos_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * tmpvar_2.w);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform mediump float _Scale;
uniform mediump vec3 _Offset;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xy = ((_glesVertex.xy * vec2(_Scale)) + _Offset.xy);
  tmpvar_3.z = _Offset.z;
  tmpvar_1 = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_3));
  tmpvar_2 = ((_glesColor * _Color) * _RendererColor);
  highp vec4 pos_4;
  pos_4.zw = tmpvar_1.zw;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_ScreenParams.xy * 0.5);
  pos_4.xy = ((floor(
    (((tmpvar_1.xy / tmpvar_1.w) * tmpvar_5) + vec2(0.5, 0.5))
  ) / tmpvar_5) * tmpvar_1.w);
  tmpvar_1 = pos_4;
  gl_Position = pos_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * tmpvar_2.w);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform mediump float _Scale;
uniform mediump vec3 _Offset;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xy = ((_glesVertex.xy * vec2(_Scale)) + _Offset.xy);
  tmpvar_3.z = _Offset.z;
  tmpvar_1 = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_3));
  tmpvar_2 = ((_glesColor * _Color) * _RendererColor);
  highp vec4 pos_4;
  pos_4.zw = tmpvar_1.zw;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_ScreenParams.xy * 0.5);
  pos_4.xy = ((floor(
    (((tmpvar_1.xy / tmpvar_1.w) * tmpvar_5) + vec2(0.5, 0.5))
  ) / tmpvar_5) * tmpvar_1.w);
  tmpvar_1 = pos_4;
  gl_Position = pos_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * tmpvar_2.w);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform mediump float _Scale;
uniform mediump vec3 _Offset;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xy = ((_glesVertex.xy * vec2(_Scale)) + _Offset.xy);
  tmpvar_3.z = _Offset.z;
  tmpvar_1 = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_3));
  tmpvar_2 = ((_glesColor * _Color) * _RendererColor);
  highp vec4 pos_4;
  pos_4.zw = tmpvar_1.zw;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_ScreenParams.xy * 0.5);
  pos_4.xy = ((floor(
    (((tmpvar_1.xy / tmpvar_1.w) * tmpvar_5) + vec2(0.5, 0.5))
  ) / tmpvar_5) * tmpvar_1.w);
  tmpvar_1 = pos_4;
  gl_Position = pos_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp float _EnableExternalAlpha;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2.xyz = tmpvar_3.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = mix (tmpvar_3.w, tmpvar_4.x, _EnableExternalAlpha);
  color_2.w = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (color_2 * xlv_COLOR);
  c_1.w = tmpvar_6.w;
  c_1.xyz = (tmpvar_6.xyz * tmpvar_6.w);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform mediump float _Scale;
uniform mediump vec3 _Offset;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xy = ((_glesVertex.xy * vec2(_Scale)) + _Offset.xy);
  tmpvar_3.z = _Offset.z;
  tmpvar_1 = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_3));
  tmpvar_2 = ((_glesColor * _Color) * _RendererColor);
  highp vec4 pos_4;
  pos_4.zw = tmpvar_1.zw;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_ScreenParams.xy * 0.5);
  pos_4.xy = ((floor(
    (((tmpvar_1.xy / tmpvar_1.w) * tmpvar_5) + vec2(0.5, 0.5))
  ) / tmpvar_5) * tmpvar_1.w);
  tmpvar_1 = pos_4;
  gl_Position = pos_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp float _EnableExternalAlpha;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2.xyz = tmpvar_3.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = mix (tmpvar_3.w, tmpvar_4.x, _EnableExternalAlpha);
  color_2.w = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (color_2 * xlv_COLOR);
  c_1.w = tmpvar_6.w;
  c_1.xyz = (tmpvar_6.xyz * tmpvar_6.w);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ETC1_EXTERNAL_ALPHA" "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform mediump float _Scale;
uniform mediump vec3 _Offset;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xy = ((_glesVertex.xy * vec2(_Scale)) + _Offset.xy);
  tmpvar_3.z = _Offset.z;
  tmpvar_1 = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_3));
  tmpvar_2 = ((_glesColor * _Color) * _RendererColor);
  highp vec4 pos_4;
  pos_4.zw = tmpvar_1.zw;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_ScreenParams.xy * 0.5);
  pos_4.xy = ((floor(
    (((tmpvar_1.xy / tmpvar_1.w) * tmpvar_5) + vec2(0.5, 0.5))
  ) / tmpvar_5) * tmpvar_1.w);
  tmpvar_1 = pos_4;
  gl_Position = pos_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp float _EnableExternalAlpha;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2.xyz = tmpvar_3.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = mix (tmpvar_3.w, tmpvar_4.x, _EnableExternalAlpha);
  color_2.w = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (color_2 * xlv_COLOR);
  c_1.w = tmpvar_6.w;
  c_1.xyz = (tmpvar_6.xyz * tmpvar_6.w);
  gl_FragData[0] = c_1;
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