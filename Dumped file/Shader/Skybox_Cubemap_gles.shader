Shader "Skybox/Cubemap" {
Properties {
_Tint ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_Exposure ("Exposure", Range(0, 8)) = 1
_Rotation ("Rotation", Range(0, 360)) = 0
_Tex ("Cubemap   (HDR)", Cube) = "grey" { }
}
SubShader {
 Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
  ZWrite Off
  Cull Off
  GpuProgramID 32916
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Rotation;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp float tmpvar_2;
  tmpvar_2 = ((_Rotation * 3.141593) / 180.0);
  highp float tmpvar_3;
  tmpvar_3 = sin(tmpvar_2);
  highp float tmpvar_4;
  tmpvar_4 = cos(tmpvar_2);
  highp mat2 tmpvar_5;
  tmpvar_5[0].x = tmpvar_4;
  tmpvar_5[0].y = tmpvar_3;
  tmpvar_5[1].x = -(tmpvar_3);
  tmpvar_5[1].y = tmpvar_4;
  highp vec3 tmpvar_6;
  tmpvar_6.xy = (tmpvar_5 * _glesVertex.xz);
  tmpvar_6.z = tmpvar_1.y;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6.xzy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = tmpvar_1.xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp samplerCube _Tex;
uniform mediump vec4 _Tex_HDR;
uniform mediump vec4 _Tint;
uniform mediump float _Exposure;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 c_2;
  mediump vec4 tex_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = textureCube (_Tex, xlv_TEXCOORD0);
  tex_3 = tmpvar_4;
  c_2 = (((
    (_Tex_HDR.x * ((_Tex_HDR.w * (tex_3.w - 1.0)) + 1.0))
   * tex_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
  c_2 = (c_2 * _Exposure);
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = c_2;
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Rotation;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp float tmpvar_2;
  tmpvar_2 = ((_Rotation * 3.141593) / 180.0);
  highp float tmpvar_3;
  tmpvar_3 = sin(tmpvar_2);
  highp float tmpvar_4;
  tmpvar_4 = cos(tmpvar_2);
  highp mat2 tmpvar_5;
  tmpvar_5[0].x = tmpvar_4;
  tmpvar_5[0].y = tmpvar_3;
  tmpvar_5[1].x = -(tmpvar_3);
  tmpvar_5[1].y = tmpvar_4;
  highp vec3 tmpvar_6;
  tmpvar_6.xy = (tmpvar_5 * _glesVertex.xz);
  tmpvar_6.z = tmpvar_1.y;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6.xzy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = tmpvar_1.xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp samplerCube _Tex;
uniform mediump vec4 _Tex_HDR;
uniform mediump vec4 _Tint;
uniform mediump float _Exposure;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 c_2;
  mediump vec4 tex_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = textureCube (_Tex, xlv_TEXCOORD0);
  tex_3 = tmpvar_4;
  c_2 = (((
    (_Tex_HDR.x * ((_Tex_HDR.w * (tex_3.w - 1.0)) + 1.0))
   * tex_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
  c_2 = (c_2 * _Exposure);
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = c_2;
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Rotation;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp float tmpvar_2;
  tmpvar_2 = ((_Rotation * 3.141593) / 180.0);
  highp float tmpvar_3;
  tmpvar_3 = sin(tmpvar_2);
  highp float tmpvar_4;
  tmpvar_4 = cos(tmpvar_2);
  highp mat2 tmpvar_5;
  tmpvar_5[0].x = tmpvar_4;
  tmpvar_5[0].y = tmpvar_3;
  tmpvar_5[1].x = -(tmpvar_3);
  tmpvar_5[1].y = tmpvar_4;
  highp vec3 tmpvar_6;
  tmpvar_6.xy = (tmpvar_5 * _glesVertex.xz);
  tmpvar_6.z = tmpvar_1.y;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6.xzy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = tmpvar_1.xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp samplerCube _Tex;
uniform mediump vec4 _Tex_HDR;
uniform mediump vec4 _Tint;
uniform mediump float _Exposure;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 c_2;
  mediump vec4 tex_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = textureCube (_Tex, xlv_TEXCOORD0);
  tex_3 = tmpvar_4;
  c_2 = (((
    (_Tex_HDR.x * ((_Tex_HDR.w * (tex_3.w - 1.0)) + 1.0))
   * tex_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
  c_2 = (c_2 * _Exposure);
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = c_2;
  tmpvar_1 = tmpvar_5;
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