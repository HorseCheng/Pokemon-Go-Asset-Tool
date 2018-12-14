Shader "Hidden/CubeBlend" {
Properties {
_TexA ("Cubemap", Cube) = "grey" { }
_TexB ("Cubemap", Cube) = "grey" { }
_value ("Value", Range(0, 1)) = 0.5
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Background" }
  ZTest Always
  ZWrite Off
  GpuProgramID 19854
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _TexA_HDR;
uniform mediump vec4 _TexB_HDR;
uniform lowp samplerCube _TexA;
uniform lowp samplerCube _TexB;
uniform highp float _Level;
uniform highp float _value;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 res_1;
  mediump vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = impl_low_textureCubeLodEXT (_TexA, xlv_TEXCOORD0, _Level);
  tmpvar_2 = tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = ((_TexA_HDR.x * (
    (_TexA_HDR.w * (tmpvar_2.w - 1.0))
   + 1.0)) * tmpvar_2.xyz);
  mediump vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = impl_low_textureCubeLodEXT (_TexB, xlv_TEXCOORD0, _Level);
  tmpvar_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((_TexB_HDR.x * (
    (_TexB_HDR.w * (tmpvar_5.w - 1.0))
   + 1.0)) * tmpvar_5.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, tmpvar_7, vec3(_value));
  res_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = res_1;
  gl_FragData[0] = tmpvar_9;
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
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _TexA_HDR;
uniform mediump vec4 _TexB_HDR;
uniform lowp samplerCube _TexA;
uniform lowp samplerCube _TexB;
uniform highp float _Level;
uniform highp float _value;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 res_1;
  mediump vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = impl_low_textureCubeLodEXT (_TexA, xlv_TEXCOORD0, _Level);
  tmpvar_2 = tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = ((_TexA_HDR.x * (
    (_TexA_HDR.w * (tmpvar_2.w - 1.0))
   + 1.0)) * tmpvar_2.xyz);
  mediump vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = impl_low_textureCubeLodEXT (_TexB, xlv_TEXCOORD0, _Level);
  tmpvar_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((_TexB_HDR.x * (
    (_TexB_HDR.w * (tmpvar_5.w - 1.0))
   + 1.0)) * tmpvar_5.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, tmpvar_7, vec3(_value));
  res_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = res_1;
  gl_FragData[0] = tmpvar_9;
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
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _TexA_HDR;
uniform mediump vec4 _TexB_HDR;
uniform lowp samplerCube _TexA;
uniform lowp samplerCube _TexB;
uniform highp float _Level;
uniform highp float _value;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 res_1;
  mediump vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = impl_low_textureCubeLodEXT (_TexA, xlv_TEXCOORD0, _Level);
  tmpvar_2 = tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = ((_TexA_HDR.x * (
    (_TexA_HDR.w * (tmpvar_2.w - 1.0))
   + 1.0)) * tmpvar_2.xyz);
  mediump vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = impl_low_textureCubeLodEXT (_TexB, xlv_TEXCOORD0, _Level);
  tmpvar_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((_TexB_HDR.x * (
    (_TexB_HDR.w * (tmpvar_5.w - 1.0))
   + 1.0)) * tmpvar_5.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, tmpvar_7, vec3(_value));
  res_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = res_1;
  gl_FragData[0] = tmpvar_9;
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
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Background" }
  ZTest Always
  ZWrite Off
  GpuProgramID 105093
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _TexA_HDR;
uniform mediump vec4 _TexB_HDR;
uniform lowp samplerCube _TexA;
uniform lowp samplerCube _TexB;
uniform highp float _Level;
uniform highp float _value;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 res_1;
  mediump vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = impl_low_textureCubeLodEXT (_TexA, xlv_TEXCOORD0, _Level);
  tmpvar_2 = tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = ((_TexA_HDR.x * (
    (_TexA_HDR.w * (tmpvar_2.w - 1.0))
   + 1.0)) * tmpvar_2.xyz);
  mediump vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = impl_low_textureCubeLodEXT (_TexB, xlv_TEXCOORD0, _Level);
  tmpvar_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((_TexB_HDR.x * (
    (_TexB_HDR.w * (tmpvar_5.w - 1.0))
   + 1.0)) * tmpvar_5.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, tmpvar_7, vec3(_value));
  res_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = res_1;
  gl_FragData[0] = tmpvar_9;
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
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _TexA_HDR;
uniform mediump vec4 _TexB_HDR;
uniform lowp samplerCube _TexA;
uniform lowp samplerCube _TexB;
uniform highp float _Level;
uniform highp float _value;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 res_1;
  mediump vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = impl_low_textureCubeLodEXT (_TexA, xlv_TEXCOORD0, _Level);
  tmpvar_2 = tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = ((_TexA_HDR.x * (
    (_TexA_HDR.w * (tmpvar_2.w - 1.0))
   + 1.0)) * tmpvar_2.xyz);
  mediump vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = impl_low_textureCubeLodEXT (_TexB, xlv_TEXCOORD0, _Level);
  tmpvar_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((_TexB_HDR.x * (
    (_TexB_HDR.w * (tmpvar_5.w - 1.0))
   + 1.0)) * tmpvar_5.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, tmpvar_7, vec3(_value));
  res_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = res_1;
  gl_FragData[0] = tmpvar_9;
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
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _TexA_HDR;
uniform mediump vec4 _TexB_HDR;
uniform lowp samplerCube _TexA;
uniform lowp samplerCube _TexB;
uniform highp float _Level;
uniform highp float _value;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 res_1;
  mediump vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = impl_low_textureCubeLodEXT (_TexA, xlv_TEXCOORD0, _Level);
  tmpvar_2 = tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = ((_TexA_HDR.x * (
    (_TexA_HDR.w * (tmpvar_2.w - 1.0))
   + 1.0)) * tmpvar_2.xyz);
  mediump vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = impl_low_textureCubeLodEXT (_TexB, xlv_TEXCOORD0, _Level);
  tmpvar_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((_TexB_HDR.x * (
    (_TexB_HDR.w * (tmpvar_5.w - 1.0))
   + 1.0)) * tmpvar_5.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, tmpvar_7, vec3(_value));
  res_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = res_1;
  gl_FragData[0] = tmpvar_9;
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