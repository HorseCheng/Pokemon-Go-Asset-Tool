Shader "Unlit/Color" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 4001
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = _Color.xyz;
  col_1.w = 1.0;
  gl_FragData[0] = col_1;
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
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = _Color.xyz;
  col_1.w = 1.0;
  gl_FragData[0] = col_1;
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
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = _Color.xyz;
  col_1.w = 1.0;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp float xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _Color;
varying highp float xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp float tmpvar_2;
  tmpvar_2 = clamp (xlv_TEXCOORD0, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, _Color.xyz, vec3(tmpvar_2));
  col_1.w = 1.0;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp float xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _Color;
varying highp float xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp float tmpvar_2;
  tmpvar_2 = clamp (xlv_TEXCOORD0, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, _Color.xyz, vec3(tmpvar_2));
  col_1.w = 1.0;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp float xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _Color;
varying highp float xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp float tmpvar_2;
  tmpvar_2 = clamp (xlv_TEXCOORD0, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, _Color.xyz, vec3(tmpvar_2));
  col_1.w = 1.0;
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
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
}
}
}
}