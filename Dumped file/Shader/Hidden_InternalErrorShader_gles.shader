Shader "Hidden/InternalErrorShader" {
Properties {
}
SubShader {
 Pass {
  GpuProgramID 12560
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
void main ()
{
  gl_FragData[0] = vec4(1.0, 0.0, 1.0, 1.0);
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
void main ()
{
  gl_FragData[0] = vec4(1.0, 0.0, 1.0, 1.0);
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
void main ()
{
  gl_FragData[0] = vec4(1.0, 0.0, 1.0, 1.0);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(1.0, 0.0, 1.0, 1.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(1.0, 0.0, 1.0, 1.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(1.0, 0.0, 1.0, 1.0);
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
Keywords { "UNITY_SINGLE_PASS_STEREO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
""
}
}
}
}
}