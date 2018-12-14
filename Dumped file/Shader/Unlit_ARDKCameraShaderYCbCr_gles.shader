Shader "Unlit/ARDKCameraShaderYCbCr" {
Properties {
_textureY ("TextureY", 2D) = "black" { }
_textureCbCr ("TextureCbCr", 2D) = "black" { }
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  ZWrite Off
  Cull Off
  GpuProgramID 48626
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp mat4 _textureTransform;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = (((_textureTransform[0].x * _glesMultiTexCoord0.x) + (_textureTransform[0].y * _glesMultiTexCoord0.y)) + _textureTransform[3].x);
  tmpvar_1.y = (((_textureTransform[1].x * _glesMultiTexCoord0.x) + (_textureTransform[1].y * _glesMultiTexCoord0.y)) + _textureTransform[3].y);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _textureY;
uniform sampler2D _textureCbCr;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float y_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_textureY, xlv_TEXCOORD0).x;
  y_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_textureCbCr, xlv_TEXCOORD0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = y_2;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat4 tmpvar_6;
  tmpvar_6[0].x = 1.0;
  tmpvar_6[0].y = 1.0;
  tmpvar_6[0].z = 1.0;
  tmpvar_6[0].w = 0.0;
  tmpvar_6[1].x = 0.0;
  tmpvar_6[1].y = -0.3441;
  tmpvar_6[1].z = 1.772;
  tmpvar_6[1].w = 0.0;
  tmpvar_6[2].x = 1.402;
  tmpvar_6[2].y = -0.7141;
  tmpvar_6[2].z = 0.0;
  tmpvar_6[2].w = 0.0;
  tmpvar_6[3].x = -0.701;
  tmpvar_6[3].y = 0.5291;
  tmpvar_6[3].z = -0.886;
  tmpvar_6[3].w = 1.0;
  tmpvar_1 = (tmpvar_6 * tmpvar_5);
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 _textureTransform;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = (((_textureTransform[0].x * _glesMultiTexCoord0.x) + (_textureTransform[0].y * _glesMultiTexCoord0.y)) + _textureTransform[3].x);
  tmpvar_1.y = (((_textureTransform[1].x * _glesMultiTexCoord0.x) + (_textureTransform[1].y * _glesMultiTexCoord0.y)) + _textureTransform[3].y);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _textureY;
uniform sampler2D _textureCbCr;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float y_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_textureY, xlv_TEXCOORD0).x;
  y_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_textureCbCr, xlv_TEXCOORD0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = y_2;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat4 tmpvar_6;
  tmpvar_6[0].x = 1.0;
  tmpvar_6[0].y = 1.0;
  tmpvar_6[0].z = 1.0;
  tmpvar_6[0].w = 0.0;
  tmpvar_6[1].x = 0.0;
  tmpvar_6[1].y = -0.3441;
  tmpvar_6[1].z = 1.772;
  tmpvar_6[1].w = 0.0;
  tmpvar_6[2].x = 1.402;
  tmpvar_6[2].y = -0.7141;
  tmpvar_6[2].z = 0.0;
  tmpvar_6[2].w = 0.0;
  tmpvar_6[3].x = -0.701;
  tmpvar_6[3].y = 0.5291;
  tmpvar_6[3].z = -0.886;
  tmpvar_6[3].w = 1.0;
  tmpvar_1 = (tmpvar_6 * tmpvar_5);
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 _textureTransform;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = (((_textureTransform[0].x * _glesMultiTexCoord0.x) + (_textureTransform[0].y * _glesMultiTexCoord0.y)) + _textureTransform[3].x);
  tmpvar_1.y = (((_textureTransform[1].x * _glesMultiTexCoord0.x) + (_textureTransform[1].y * _glesMultiTexCoord0.y)) + _textureTransform[3].y);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _textureY;
uniform sampler2D _textureCbCr;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float y_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_textureY, xlv_TEXCOORD0).x;
  y_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_textureCbCr, xlv_TEXCOORD0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = y_2;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat4 tmpvar_6;
  tmpvar_6[0].x = 1.0;
  tmpvar_6[0].y = 1.0;
  tmpvar_6[0].z = 1.0;
  tmpvar_6[0].w = 0.0;
  tmpvar_6[1].x = 0.0;
  tmpvar_6[1].y = -0.3441;
  tmpvar_6[1].z = 1.772;
  tmpvar_6[1].w = 0.0;
  tmpvar_6[2].x = 1.402;
  tmpvar_6[2].y = -0.7141;
  tmpvar_6[2].z = 0.0;
  tmpvar_6[2].w = 0.0;
  tmpvar_6[3].x = -0.701;
  tmpvar_6[3].y = 0.5291;
  tmpvar_6[3].z = -0.886;
  tmpvar_6[3].w = 1.0;
  tmpvar_1 = (tmpvar_6 * tmpvar_5);
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