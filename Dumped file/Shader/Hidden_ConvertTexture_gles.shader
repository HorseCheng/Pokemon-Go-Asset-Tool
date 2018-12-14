Shader "Hidden/ConvertTexture" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 55655
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _faceIndex;
highp vec3 faceU[6];
highp vec3 faceV[6];
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  faceU[0] = vec3(0.0, 0.0, -1.0);
  faceU[1] = vec3(0.0, 0.0, 1.0);
  faceU[2] = vec3(1.0, 0.0, 0.0);
  faceU[3] = vec3(1.0, 0.0, 0.0);
  faceU[4] = vec3(1.0, 0.0, 0.0);
  faceU[5] = vec3(-1.0, 0.0, 0.0);
  faceV[0] = vec3(0.0, -1.0, 0.0);
  faceV[1] = vec3(0.0, -1.0, 0.0);
  faceV[2] = vec3(0.0, 0.0, 1.0);
  faceV[3] = vec3(0.0, 0.0, -1.0);
  faceV[4] = vec3(0.0, -1.0, 0.0);
  faceV[5] = vec3(0.0, -1.0, 0.0);
  highp vec2 uv_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  uv_1 = (((
    (_glesMultiTexCoord0.xy * _MainTex_ST.xy)
   + _MainTex_ST.zw) * 2.0) - 1.0);
  highp int tmpvar_3;
  tmpvar_3 = int(_faceIndex);
  highp vec3 tmpvar_4;
  tmpvar_4 = faceU[tmpvar_3];
  highp vec3 tmpvar_5;
  tmpvar_5 = faceV[tmpvar_3];
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = (((
    (tmpvar_5.yzx * tmpvar_4.zxy)
   - 
    (tmpvar_5.zxy * tmpvar_4.yzx)
  ) + (uv_1.x * tmpvar_4)) + (uv_1.y * tmpvar_5));
}


#endif
#ifdef FRAGMENT
uniform lowp samplerCube _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = textureCube (_MainTex, xlv_TEXCOORD0);
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
uniform highp vec4 _MainTex_ST;
uniform highp float _faceIndex;
highp vec3 faceU[6];
highp vec3 faceV[6];
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  faceU[0] = vec3(0.0, 0.0, -1.0);
  faceU[1] = vec3(0.0, 0.0, 1.0);
  faceU[2] = vec3(1.0, 0.0, 0.0);
  faceU[3] = vec3(1.0, 0.0, 0.0);
  faceU[4] = vec3(1.0, 0.0, 0.0);
  faceU[5] = vec3(-1.0, 0.0, 0.0);
  faceV[0] = vec3(0.0, -1.0, 0.0);
  faceV[1] = vec3(0.0, -1.0, 0.0);
  faceV[2] = vec3(0.0, 0.0, 1.0);
  faceV[3] = vec3(0.0, 0.0, -1.0);
  faceV[4] = vec3(0.0, -1.0, 0.0);
  faceV[5] = vec3(0.0, -1.0, 0.0);
  highp vec2 uv_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  uv_1 = (((
    (_glesMultiTexCoord0.xy * _MainTex_ST.xy)
   + _MainTex_ST.zw) * 2.0) - 1.0);
  highp int tmpvar_3;
  tmpvar_3 = int(_faceIndex);
  highp vec3 tmpvar_4;
  tmpvar_4 = faceU[tmpvar_3];
  highp vec3 tmpvar_5;
  tmpvar_5 = faceV[tmpvar_3];
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = (((
    (tmpvar_5.yzx * tmpvar_4.zxy)
   - 
    (tmpvar_5.zxy * tmpvar_4.yzx)
  ) + (uv_1.x * tmpvar_4)) + (uv_1.y * tmpvar_5));
}


#endif
#ifdef FRAGMENT
uniform lowp samplerCube _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = textureCube (_MainTex, xlv_TEXCOORD0);
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
uniform highp vec4 _MainTex_ST;
uniform highp float _faceIndex;
highp vec3 faceU[6];
highp vec3 faceV[6];
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  faceU[0] = vec3(0.0, 0.0, -1.0);
  faceU[1] = vec3(0.0, 0.0, 1.0);
  faceU[2] = vec3(1.0, 0.0, 0.0);
  faceU[3] = vec3(1.0, 0.0, 0.0);
  faceU[4] = vec3(1.0, 0.0, 0.0);
  faceU[5] = vec3(-1.0, 0.0, 0.0);
  faceV[0] = vec3(0.0, -1.0, 0.0);
  faceV[1] = vec3(0.0, -1.0, 0.0);
  faceV[2] = vec3(0.0, 0.0, 1.0);
  faceV[3] = vec3(0.0, 0.0, -1.0);
  faceV[4] = vec3(0.0, -1.0, 0.0);
  faceV[5] = vec3(0.0, -1.0, 0.0);
  highp vec2 uv_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  uv_1 = (((
    (_glesMultiTexCoord0.xy * _MainTex_ST.xy)
   + _MainTex_ST.zw) * 2.0) - 1.0);
  highp int tmpvar_3;
  tmpvar_3 = int(_faceIndex);
  highp vec3 tmpvar_4;
  tmpvar_4 = faceU[tmpvar_3];
  highp vec3 tmpvar_5;
  tmpvar_5 = faceV[tmpvar_3];
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = (((
    (tmpvar_5.yzx * tmpvar_4.zxy)
   - 
    (tmpvar_5.zxy * tmpvar_4.yzx)
  ) + (uv_1.x * tmpvar_4)) + (uv_1.y * tmpvar_5));
}


#endif
#ifdef FRAGMENT
uniform lowp samplerCube _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = textureCube (_MainTex, xlv_TEXCOORD0);
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