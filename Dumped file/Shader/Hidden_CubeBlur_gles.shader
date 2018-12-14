Shader "Hidden/CubeBlur" {
Properties {
_MainTex ("Main", Cube) = "" { }
_Texel ("Texel", Float) = 0.0078125
_Level ("Level", Float) = 0
_Scale ("Scale", Float) = 1
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 25931
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
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

uniform lowp samplerCube _MainTex;
uniform mediump float _Level;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = impl_low_textureCubeLodEXT (_MainTex, xlv_TEXCOORD0.xyz, _Level);
  tmpvar_1 = tmpvar_2;
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
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
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

uniform lowp samplerCube _MainTex;
uniform mediump float _Level;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = impl_low_textureCubeLodEXT (_MainTex, xlv_TEXCOORD0.xyz, _Level);
  tmpvar_1 = tmpvar_2;
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
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
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

uniform lowp samplerCube _MainTex;
uniform mediump float _Level;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = impl_low_textureCubeLodEXT (_MainTex, xlv_TEXCOORD0.xyz, _Level);
  tmpvar_1 = tmpvar_2;
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
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 97250
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
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

uniform lowp samplerCube _MainTex;
uniform mediump float _Level;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = impl_low_textureCubeLodEXT (_MainTex, xlv_TEXCOORD0.xyz, _Level);
  tmpvar_1 = tmpvar_2;
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
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
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

uniform lowp samplerCube _MainTex;
uniform mediump float _Level;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = impl_low_textureCubeLodEXT (_MainTex, xlv_TEXCOORD0.xyz, _Level);
  tmpvar_1 = tmpvar_2;
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
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
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

uniform lowp samplerCube _MainTex;
uniform mediump float _Level;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = impl_low_textureCubeLodEXT (_MainTex, xlv_TEXCOORD0.xyz, _Level);
  tmpvar_1 = tmpvar_2;
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