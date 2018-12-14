Shader "Hidden/InternalClear" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 35719
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 73920
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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
 Pass {
  ZTest Always
  Cull Off
  GpuProgramID 164233
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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
 Pass {
  ZTest Always
  Cull Off
  GpuProgramID 260510
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 322596
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 378727
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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
 Pass {
  ZTest Always
  Cull Off
  GpuProgramID 441213
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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
 Pass {
  ZTest Always
  Cull Off
  GpuProgramID 473486
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_StereoMatrixVP[2];
uniform highp int unity_StereoEyeIndex;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_StereoMatrixVP[unity_StereoEyeIndex] * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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