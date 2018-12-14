Shader "Hidden/VideoDecode" {
Properties {
_MainTex ("_MainTex (A)", 2D) = "black" { }
_SecondTex ("_SecondTex (A)", 2D) = "black" { }
_ThirdTex ("_ThirdTex (A)", 2D) = "black" { }
}
SubShader {
 Pass {
  Name "YCBCR_TO_RGB1"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 28028
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _RightEyeUVOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform sampler2D _ThirdTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 y_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).wwww;
  y_1.w = tmpvar_2.w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_SecondTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ThirdTex, xlv_TEXCOORD0);
  lowp float tmpvar_5;
  tmpvar_5 = (1.15625 * tmpvar_2.w);
  y_1.x = ((tmpvar_5 + (1.59375 * tmpvar_4.w)) - 0.87254);
  y_1.y = (((tmpvar_5 - 
    (0.390625 * tmpvar_3.w)
  ) - (0.8125 * tmpvar_4.w)) + 0.53137);
  y_1.z = ((tmpvar_5 + (1.984375 * tmpvar_3.w)) - 1.06862);
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = y_1.xyz;
  gl_FragData[0] = tmpvar_6;
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
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _RightEyeUVOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform sampler2D _ThirdTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 y_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).wwww;
  y_1.w = tmpvar_2.w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_SecondTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ThirdTex, xlv_TEXCOORD0);
  lowp float tmpvar_5;
  tmpvar_5 = (1.15625 * tmpvar_2.w);
  y_1.x = ((tmpvar_5 + (1.59375 * tmpvar_4.w)) - 0.87254);
  y_1.y = (((tmpvar_5 - 
    (0.390625 * tmpvar_3.w)
  ) - (0.8125 * tmpvar_4.w)) + 0.53137);
  y_1.z = ((tmpvar_5 + (1.984375 * tmpvar_3.w)) - 1.06862);
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = y_1.xyz;
  gl_FragData[0] = tmpvar_6;
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
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _RightEyeUVOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform sampler2D _ThirdTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 y_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).wwww;
  y_1.w = tmpvar_2.w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_SecondTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ThirdTex, xlv_TEXCOORD0);
  lowp float tmpvar_5;
  tmpvar_5 = (1.15625 * tmpvar_2.w);
  y_1.x = ((tmpvar_5 + (1.59375 * tmpvar_4.w)) - 0.87254);
  y_1.y = (((tmpvar_5 - 
    (0.390625 * tmpvar_3.w)
  ) - (0.8125 * tmpvar_4.w)) + 0.53137);
  y_1.z = ((tmpvar_5 + (1.984375 * tmpvar_3.w)) - 1.06862);
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = y_1.xyz;
  gl_FragData[0] = tmpvar_6;
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
 Pass {
  Name "YCBCRA_TO_RGBAFULL"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 113027
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _RightEyeUVOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform sampler2D _ThirdTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 y_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (0.5 * xlv_TEXCOORD0.x);
  tmpvar_2.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_2).wwww;
  y_1.w = tmpvar_3.w;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SecondTex, tmpvar_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ThirdTex, tmpvar_2);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + 0.5);
  tmpvar_6.y = tmpvar_2.y;
  lowp float tmpvar_7;
  tmpvar_7 = (1.15625 * tmpvar_3.w);
  y_1.x = ((tmpvar_7 + (1.59375 * tmpvar_5.w)) - 0.87254);
  y_1.y = (((tmpvar_7 - 
    (0.390625 * tmpvar_4.w)
  ) - (0.8125 * tmpvar_5.w)) + 0.53137);
  y_1.z = ((tmpvar_7 + (1.984375 * tmpvar_4.w)) - 1.06862);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = y_1.xyz;
  tmpvar_8.w = texture2D (_MainTex, tmpvar_6).w;
  gl_FragData[0] = tmpvar_8;
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
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _RightEyeUVOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform sampler2D _ThirdTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 y_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (0.5 * xlv_TEXCOORD0.x);
  tmpvar_2.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_2).wwww;
  y_1.w = tmpvar_3.w;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SecondTex, tmpvar_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ThirdTex, tmpvar_2);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + 0.5);
  tmpvar_6.y = tmpvar_2.y;
  lowp float tmpvar_7;
  tmpvar_7 = (1.15625 * tmpvar_3.w);
  y_1.x = ((tmpvar_7 + (1.59375 * tmpvar_5.w)) - 0.87254);
  y_1.y = (((tmpvar_7 - 
    (0.390625 * tmpvar_4.w)
  ) - (0.8125 * tmpvar_5.w)) + 0.53137);
  y_1.z = ((tmpvar_7 + (1.984375 * tmpvar_4.w)) - 1.06862);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = y_1.xyz;
  tmpvar_8.w = texture2D (_MainTex, tmpvar_6).w;
  gl_FragData[0] = tmpvar_8;
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
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _RightEyeUVOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform sampler2D _ThirdTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 y_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (0.5 * xlv_TEXCOORD0.x);
  tmpvar_2.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_2).wwww;
  y_1.w = tmpvar_3.w;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SecondTex, tmpvar_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ThirdTex, tmpvar_2);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + 0.5);
  tmpvar_6.y = tmpvar_2.y;
  lowp float tmpvar_7;
  tmpvar_7 = (1.15625 * tmpvar_3.w);
  y_1.x = ((tmpvar_7 + (1.59375 * tmpvar_5.w)) - 0.87254);
  y_1.y = (((tmpvar_7 - 
    (0.390625 * tmpvar_4.w)
  ) - (0.8125 * tmpvar_5.w)) + 0.53137);
  y_1.z = ((tmpvar_7 + (1.984375 * tmpvar_4.w)) - 1.06862);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = y_1.xyz;
  tmpvar_8.w = texture2D (_MainTex, tmpvar_6).w;
  gl_FragData[0] = tmpvar_8;
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
 Pass {
  Name "YCBCRA_TO_RGBA"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 142939
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _RightEyeUVOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform sampler2D _ThirdTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 y_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (0.5 * xlv_TEXCOORD0.x);
  tmpvar_2.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_2).wwww;
  y_1.w = tmpvar_3.w;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SecondTex, tmpvar_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ThirdTex, tmpvar_2);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + 0.5);
  tmpvar_6.y = tmpvar_2.y;
  lowp float tmpvar_7;
  tmpvar_7 = (1.15625 * tmpvar_3.w);
  y_1.x = ((tmpvar_7 + (1.59375 * tmpvar_5.w)) - 0.87254);
  y_1.y = (((tmpvar_7 - 
    (0.390625 * tmpvar_4.w)
  ) - (0.8125 * tmpvar_5.w)) + 0.53137);
  y_1.z = ((tmpvar_7 + (1.984375 * tmpvar_4.w)) - 1.06862);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = y_1.xyz;
  tmpvar_8.w = (1.15625 * (texture2D (_MainTex, tmpvar_6).w - 0.062745));
  gl_FragData[0] = tmpvar_8;
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
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _RightEyeUVOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform sampler2D _ThirdTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 y_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (0.5 * xlv_TEXCOORD0.x);
  tmpvar_2.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_2).wwww;
  y_1.w = tmpvar_3.w;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SecondTex, tmpvar_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ThirdTex, tmpvar_2);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + 0.5);
  tmpvar_6.y = tmpvar_2.y;
  lowp float tmpvar_7;
  tmpvar_7 = (1.15625 * tmpvar_3.w);
  y_1.x = ((tmpvar_7 + (1.59375 * tmpvar_5.w)) - 0.87254);
  y_1.y = (((tmpvar_7 - 
    (0.390625 * tmpvar_4.w)
  ) - (0.8125 * tmpvar_5.w)) + 0.53137);
  y_1.z = ((tmpvar_7 + (1.984375 * tmpvar_4.w)) - 1.06862);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = y_1.xyz;
  tmpvar_8.w = (1.15625 * (texture2D (_MainTex, tmpvar_6).w - 0.062745));
  gl_FragData[0] = tmpvar_8;
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
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _RightEyeUVOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform sampler2D _ThirdTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 y_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (0.5 * xlv_TEXCOORD0.x);
  tmpvar_2.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_2).wwww;
  y_1.w = tmpvar_3.w;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SecondTex, tmpvar_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ThirdTex, tmpvar_2);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + 0.5);
  tmpvar_6.y = tmpvar_2.y;
  lowp float tmpvar_7;
  tmpvar_7 = (1.15625 * tmpvar_3.w);
  y_1.x = ((tmpvar_7 + (1.59375 * tmpvar_5.w)) - 0.87254);
  y_1.y = (((tmpvar_7 - 
    (0.390625 * tmpvar_4.w)
  ) - (0.8125 * tmpvar_5.w)) + 0.53137);
  y_1.z = ((tmpvar_7 + (1.984375 * tmpvar_4.w)) - 1.06862);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = y_1.xyz;
  tmpvar_8.w = (1.15625 * (texture2D (_MainTex, tmpvar_6).w - 0.062745));
  gl_FragData[0] = tmpvar_8;
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
 Pass {
  Name "COMPOSITE_RGBA_TO_RGBA"
  Cull Off
  GpuProgramID 238344
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _RightEyeUVOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _AlphaParam;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_2.xyz;
  tmpvar_3.w = (tmpvar_2.w * _AlphaParam);
  tmpvar_1 = tmpvar_3;
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
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _RightEyeUVOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _AlphaParam;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_2.xyz;
  tmpvar_3.w = (tmpvar_2.w * _AlphaParam);
  tmpvar_1 = tmpvar_3;
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
uniform highp int unity_StereoEyeIndex;
uniform highp vec4 _RightEyeUVOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _AlphaParam;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_2.xyz;
  tmpvar_3.w = (tmpvar_2.w * _AlphaParam);
  tmpvar_1 = tmpvar_3;
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
 Pass {
  Name "FLIP_RGBA_TO_RGBA"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 288062
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _AlphaParam;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = tmpvar_1.xyz;
  tmpvar_2.w = (tmpvar_1.w * _AlphaParam);
  lowp vec4 color_3;
  color_3 = tmpvar_2;
  gl_FragData[0] = color_3;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _AlphaParam;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = tmpvar_1.xyz;
  tmpvar_2.w = (tmpvar_1.w * _AlphaParam);
  lowp vec4 color_3;
  color_3 = tmpvar_2;
  gl_FragData[0] = color_3;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _AlphaParam;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = tmpvar_1.xyz;
  tmpvar_2.w = (tmpvar_1.w * _AlphaParam);
  lowp vec4 color_3;
  color_3 = tmpvar_2;
  gl_FragData[0] = color_3;
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
 Pass {
  Name "FLIP_RGBASPLIT_TO_RGBA"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 375129
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1.x = (0.5 * xlv_TEXCOORD0.x);
  tmpvar_1.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (tmpvar_1.x + 0.5);
  tmpvar_2.y = tmpvar_1.y;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = texture2D (_MainTex, tmpvar_1).xyz;
  tmpvar_3.w = texture2D (_MainTex, tmpvar_2).y;
  gl_FragData[0] = tmpvar_3;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1.x = (0.5 * xlv_TEXCOORD0.x);
  tmpvar_1.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (tmpvar_1.x + 0.5);
  tmpvar_2.y = tmpvar_1.y;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = texture2D (_MainTex, tmpvar_1).xyz;
  tmpvar_3.w = texture2D (_MainTex, tmpvar_2).y;
  gl_FragData[0] = tmpvar_3;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1.x = (0.5 * xlv_TEXCOORD0.x);
  tmpvar_1.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (tmpvar_1.x + 0.5);
  tmpvar_2.y = tmpvar_1.y;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = texture2D (_MainTex, tmpvar_1).xyz;
  tmpvar_3.w = texture2D (_MainTex, tmpvar_2).y;
  gl_FragData[0] = tmpvar_3;
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
 Pass {
  Name "FLIP_SEMIPLANARYCBCR_TO_RGB1"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 440144
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (_MainTex_TexelSize.z - 0.5);
  highp float tmpvar_2;
  tmpvar_2 = (1.0/(tmpvar_1));
  highp int tmpvar_3;
  tmpvar_3 = int(floor((
    (xlv_TEXCOORD0.x * tmpvar_1)
   + 0.5)));
  highp float tmpvar_4;
  tmpvar_4 = (float(tmpvar_3) / 2.0);
  highp float tmpvar_5;
  tmpvar_5 = (fract(abs(tmpvar_4)) * 2.0);
  highp float tmpvar_6;
  if ((tmpvar_4 >= 0.0)) {
    tmpvar_6 = tmpvar_5;
  } else {
    tmpvar_6 = -(tmpvar_5);
  };
  highp int tmpvar_7;
  if ((tmpvar_6 == 0.0)) {
    tmpvar_7 = tmpvar_3;
  } else {
    tmpvar_7 = (tmpvar_3 - 1);
  };
  highp vec2 tmpvar_8;
  tmpvar_8.x = (float(tmpvar_7) * tmpvar_2);
  tmpvar_8.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (float((tmpvar_7 + 1)) * tmpvar_2);
  tmpvar_9.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SecondTex, tmpvar_8);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_SecondTex, tmpvar_9);
  lowp float tmpvar_12;
  tmpvar_12 = (1.15625 * texture2D (_MainTex, xlv_TEXCOORD0).w);
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.x = ((tmpvar_12 + (1.59375 * tmpvar_11.w)) - 0.87254);
  tmpvar_13.y = (((tmpvar_12 - 
    (0.390625 * tmpvar_10.w)
  ) - (0.8125 * tmpvar_11.w)) + 0.53137);
  tmpvar_13.z = ((tmpvar_12 + (1.984375 * tmpvar_10.w)) - 1.06862);
  gl_FragData[0] = tmpvar_13;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (_MainTex_TexelSize.z - 0.5);
  highp float tmpvar_2;
  tmpvar_2 = (1.0/(tmpvar_1));
  highp int tmpvar_3;
  tmpvar_3 = int(floor((
    (xlv_TEXCOORD0.x * tmpvar_1)
   + 0.5)));
  highp float tmpvar_4;
  tmpvar_4 = (float(tmpvar_3) / 2.0);
  highp float tmpvar_5;
  tmpvar_5 = (fract(abs(tmpvar_4)) * 2.0);
  highp float tmpvar_6;
  if ((tmpvar_4 >= 0.0)) {
    tmpvar_6 = tmpvar_5;
  } else {
    tmpvar_6 = -(tmpvar_5);
  };
  highp int tmpvar_7;
  if ((tmpvar_6 == 0.0)) {
    tmpvar_7 = tmpvar_3;
  } else {
    tmpvar_7 = (tmpvar_3 - 1);
  };
  highp vec2 tmpvar_8;
  tmpvar_8.x = (float(tmpvar_7) * tmpvar_2);
  tmpvar_8.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (float((tmpvar_7 + 1)) * tmpvar_2);
  tmpvar_9.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SecondTex, tmpvar_8);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_SecondTex, tmpvar_9);
  lowp float tmpvar_12;
  tmpvar_12 = (1.15625 * texture2D (_MainTex, xlv_TEXCOORD0).w);
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.x = ((tmpvar_12 + (1.59375 * tmpvar_11.w)) - 0.87254);
  tmpvar_13.y = (((tmpvar_12 - 
    (0.390625 * tmpvar_10.w)
  ) - (0.8125 * tmpvar_11.w)) + 0.53137);
  tmpvar_13.z = ((tmpvar_12 + (1.984375 * tmpvar_10.w)) - 1.06862);
  gl_FragData[0] = tmpvar_13;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (_MainTex_TexelSize.z - 0.5);
  highp float tmpvar_2;
  tmpvar_2 = (1.0/(tmpvar_1));
  highp int tmpvar_3;
  tmpvar_3 = int(floor((
    (xlv_TEXCOORD0.x * tmpvar_1)
   + 0.5)));
  highp float tmpvar_4;
  tmpvar_4 = (float(tmpvar_3) / 2.0);
  highp float tmpvar_5;
  tmpvar_5 = (fract(abs(tmpvar_4)) * 2.0);
  highp float tmpvar_6;
  if ((tmpvar_4 >= 0.0)) {
    tmpvar_6 = tmpvar_5;
  } else {
    tmpvar_6 = -(tmpvar_5);
  };
  highp int tmpvar_7;
  if ((tmpvar_6 == 0.0)) {
    tmpvar_7 = tmpvar_3;
  } else {
    tmpvar_7 = (tmpvar_3 - 1);
  };
  highp vec2 tmpvar_8;
  tmpvar_8.x = (float(tmpvar_7) * tmpvar_2);
  tmpvar_8.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (float((tmpvar_7 + 1)) * tmpvar_2);
  tmpvar_9.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SecondTex, tmpvar_8);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_SecondTex, tmpvar_9);
  lowp float tmpvar_12;
  tmpvar_12 = (1.15625 * texture2D (_MainTex, xlv_TEXCOORD0).w);
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.x = ((tmpvar_12 + (1.59375 * tmpvar_11.w)) - 0.87254);
  tmpvar_13.y = (((tmpvar_12 - 
    (0.390625 * tmpvar_10.w)
  ) - (0.8125 * tmpvar_11.w)) + 0.53137);
  tmpvar_13.z = ((tmpvar_12 + (1.984375 * tmpvar_10.w)) - 1.06862);
  gl_FragData[0] = tmpvar_13;
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
 Pass {
  Name "FLIP_SEMIPLANARYCBCRA_TO_RGBA"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 487501
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (_MainTex_TexelSize.z - 0.5);
  highp float tmpvar_2;
  tmpvar_2 = (2.0 / tmpvar_1);
  highp float tmpvar_3;
  tmpvar_3 = (0.5 * xlv_TEXCOORD0.x);
  highp int tmpvar_4;
  tmpvar_4 = int(floor((
    (tmpvar_3 * tmpvar_1)
   + 0.5)));
  highp float tmpvar_5;
  tmpvar_5 = (float(tmpvar_4) / 2.0);
  highp float tmpvar_6;
  tmpvar_6 = (fract(abs(tmpvar_5)) * 2.0);
  highp float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = tmpvar_6;
  } else {
    tmpvar_7 = -(tmpvar_6);
  };
  highp int tmpvar_8;
  if ((tmpvar_7 == 0.0)) {
    tmpvar_8 = tmpvar_4;
  } else {
    tmpvar_8 = (tmpvar_4 - 1);
  };
  highp vec2 tmpvar_9;
  tmpvar_9.x = (float(tmpvar_8) * tmpvar_2);
  tmpvar_9.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_10;
  tmpvar_10.x = (float((tmpvar_8 + 1)) * tmpvar_2);
  tmpvar_10.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_3;
  tmpvar_11.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_SecondTex, tmpvar_9);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_SecondTex, tmpvar_10);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_3 + 0.5);
  tmpvar_14.y = xlv_TEXCOORD0.y;
  lowp float tmpvar_15;
  tmpvar_15 = (1.15625 * texture2D (_MainTex, tmpvar_11).w);
  lowp vec4 tmpvar_16;
  tmpvar_16.x = ((tmpvar_15 + (1.59375 * tmpvar_13.w)) - 0.87254);
  tmpvar_16.y = (((tmpvar_15 - 
    (0.390625 * tmpvar_12.w)
  ) - (0.8125 * tmpvar_13.w)) + 0.53137);
  tmpvar_16.z = ((tmpvar_15 + (1.984375 * tmpvar_12.w)) - 1.06862);
  tmpvar_16.w = (1.15625 * (texture2D (_MainTex, tmpvar_14).w - 0.062745));
  gl_FragData[0] = tmpvar_16;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (_MainTex_TexelSize.z - 0.5);
  highp float tmpvar_2;
  tmpvar_2 = (2.0 / tmpvar_1);
  highp float tmpvar_3;
  tmpvar_3 = (0.5 * xlv_TEXCOORD0.x);
  highp int tmpvar_4;
  tmpvar_4 = int(floor((
    (tmpvar_3 * tmpvar_1)
   + 0.5)));
  highp float tmpvar_5;
  tmpvar_5 = (float(tmpvar_4) / 2.0);
  highp float tmpvar_6;
  tmpvar_6 = (fract(abs(tmpvar_5)) * 2.0);
  highp float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = tmpvar_6;
  } else {
    tmpvar_7 = -(tmpvar_6);
  };
  highp int tmpvar_8;
  if ((tmpvar_7 == 0.0)) {
    tmpvar_8 = tmpvar_4;
  } else {
    tmpvar_8 = (tmpvar_4 - 1);
  };
  highp vec2 tmpvar_9;
  tmpvar_9.x = (float(tmpvar_8) * tmpvar_2);
  tmpvar_9.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_10;
  tmpvar_10.x = (float((tmpvar_8 + 1)) * tmpvar_2);
  tmpvar_10.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_3;
  tmpvar_11.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_SecondTex, tmpvar_9);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_SecondTex, tmpvar_10);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_3 + 0.5);
  tmpvar_14.y = xlv_TEXCOORD0.y;
  lowp float tmpvar_15;
  tmpvar_15 = (1.15625 * texture2D (_MainTex, tmpvar_11).w);
  lowp vec4 tmpvar_16;
  tmpvar_16.x = ((tmpvar_15 + (1.59375 * tmpvar_13.w)) - 0.87254);
  tmpvar_16.y = (((tmpvar_15 - 
    (0.390625 * tmpvar_12.w)
  ) - (0.8125 * tmpvar_13.w)) + 0.53137);
  tmpvar_16.z = ((tmpvar_15 + (1.984375 * tmpvar_12.w)) - 1.06862);
  tmpvar_16.w = (1.15625 * (texture2D (_MainTex, tmpvar_14).w - 0.062745));
  gl_FragData[0] = tmpvar_16;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (_MainTex_TexelSize.z - 0.5);
  highp float tmpvar_2;
  tmpvar_2 = (2.0 / tmpvar_1);
  highp float tmpvar_3;
  tmpvar_3 = (0.5 * xlv_TEXCOORD0.x);
  highp int tmpvar_4;
  tmpvar_4 = int(floor((
    (tmpvar_3 * tmpvar_1)
   + 0.5)));
  highp float tmpvar_5;
  tmpvar_5 = (float(tmpvar_4) / 2.0);
  highp float tmpvar_6;
  tmpvar_6 = (fract(abs(tmpvar_5)) * 2.0);
  highp float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = tmpvar_6;
  } else {
    tmpvar_7 = -(tmpvar_6);
  };
  highp int tmpvar_8;
  if ((tmpvar_7 == 0.0)) {
    tmpvar_8 = tmpvar_4;
  } else {
    tmpvar_8 = (tmpvar_4 - 1);
  };
  highp vec2 tmpvar_9;
  tmpvar_9.x = (float(tmpvar_8) * tmpvar_2);
  tmpvar_9.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_10;
  tmpvar_10.x = (float((tmpvar_8 + 1)) * tmpvar_2);
  tmpvar_10.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_3;
  tmpvar_11.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_SecondTex, tmpvar_9);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_SecondTex, tmpvar_10);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_3 + 0.5);
  tmpvar_14.y = xlv_TEXCOORD0.y;
  lowp float tmpvar_15;
  tmpvar_15 = (1.15625 * texture2D (_MainTex, tmpvar_11).w);
  lowp vec4 tmpvar_16;
  tmpvar_16.x = ((tmpvar_15 + (1.59375 * tmpvar_13.w)) - 0.87254);
  tmpvar_16.y = (((tmpvar_15 - 
    (0.390625 * tmpvar_12.w)
  ) - (0.8125 * tmpvar_13.w)) + 0.53137);
  tmpvar_16.z = ((tmpvar_15 + (1.984375 * tmpvar_12.w)) - 1.06862);
  tmpvar_16.w = (1.15625 * (texture2D (_MainTex, tmpvar_14).w - 0.062745));
  gl_FragData[0] = tmpvar_16;
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
 Pass {
  Name "FLIP_NV12_TO_RGB1"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 586429
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 result_1;
  highp vec3 yCbCr_2;
  lowp vec3 tmpvar_3;
  tmpvar_3.x = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.0625);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SecondTex, xlv_TEXCOORD0);
  tmpvar_3.y = (tmpvar_4.x - 0.5);
  tmpvar_3.z = (tmpvar_4.y - 0.5);
  yCbCr_2 = tmpvar_3;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = dot (vec3(1.1644, 0.0, 1.7927), yCbCr_2);
  tmpvar_5.y = dot (vec3(1.1644, -0.2133, -0.5329), yCbCr_2);
  tmpvar_5.z = dot (vec3(1.1644, 2.1124, 0.0), yCbCr_2);
  result_1 = tmpvar_5;
  gl_FragData[0] = result_1;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 result_1;
  highp vec3 yCbCr_2;
  lowp vec3 tmpvar_3;
  tmpvar_3.x = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.0625);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SecondTex, xlv_TEXCOORD0);
  tmpvar_3.y = (tmpvar_4.x - 0.5);
  tmpvar_3.z = (tmpvar_4.y - 0.5);
  yCbCr_2 = tmpvar_3;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = dot (vec3(1.1644, 0.0, 1.7927), yCbCr_2);
  tmpvar_5.y = dot (vec3(1.1644, -0.2133, -0.5329), yCbCr_2);
  tmpvar_5.z = dot (vec3(1.1644, 2.1124, 0.0), yCbCr_2);
  result_1 = tmpvar_5;
  gl_FragData[0] = result_1;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 result_1;
  highp vec3 yCbCr_2;
  lowp vec3 tmpvar_3;
  tmpvar_3.x = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.0625);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SecondTex, xlv_TEXCOORD0);
  tmpvar_3.y = (tmpvar_4.x - 0.5);
  tmpvar_3.z = (tmpvar_4.y - 0.5);
  yCbCr_2 = tmpvar_3;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = dot (vec3(1.1644, 0.0, 1.7927), yCbCr_2);
  tmpvar_5.y = dot (vec3(1.1644, -0.2133, -0.5329), yCbCr_2);
  tmpvar_5.z = dot (vec3(1.1644, 2.1124, 0.0), yCbCr_2);
  result_1 = tmpvar_5;
  gl_FragData[0] = result_1;
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
 Pass {
  Name "FLIP_NV12_TO_RGBA"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 632801
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (0.5 * xlv_TEXCOORD0.x);
  highp vec2 tmpvar_2;
  tmpvar_2.x = tmpvar_1;
  tmpvar_2.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_3;
  tmpvar_3.x = (tmpvar_1 + 0.5);
  tmpvar_3.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_1;
  tmpvar_4.y = xlv_TEXCOORD0.y;
  lowp vec2 tmpvar_5;
  tmpvar_5 = texture2D (_SecondTex, tmpvar_4).xy;
  lowp float tmpvar_6;
  tmpvar_6 = (1.15625 * texture2D (_MainTex, tmpvar_2).w);
  lowp vec4 tmpvar_7;
  tmpvar_7.x = ((tmpvar_6 + (1.59375 * tmpvar_5.y)) - 0.87254);
  tmpvar_7.y = (((tmpvar_6 - 
    (0.390625 * tmpvar_5.x)
  ) - (0.8125 * tmpvar_5.y)) + 0.53137);
  tmpvar_7.z = ((tmpvar_6 + (1.984375 * tmpvar_5.x)) - 1.06862);
  tmpvar_7.w = (1.15625 * (texture2D (_MainTex, tmpvar_3).w - 0.062745));
  gl_FragData[0] = tmpvar_7;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (0.5 * xlv_TEXCOORD0.x);
  highp vec2 tmpvar_2;
  tmpvar_2.x = tmpvar_1;
  tmpvar_2.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_3;
  tmpvar_3.x = (tmpvar_1 + 0.5);
  tmpvar_3.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_1;
  tmpvar_4.y = xlv_TEXCOORD0.y;
  lowp vec2 tmpvar_5;
  tmpvar_5 = texture2D (_SecondTex, tmpvar_4).xy;
  lowp float tmpvar_6;
  tmpvar_6 = (1.15625 * texture2D (_MainTex, tmpvar_2).w);
  lowp vec4 tmpvar_7;
  tmpvar_7.x = ((tmpvar_6 + (1.59375 * tmpvar_5.y)) - 0.87254);
  tmpvar_7.y = (((tmpvar_6 - 
    (0.390625 * tmpvar_5.x)
  ) - (0.8125 * tmpvar_5.y)) + 0.53137);
  tmpvar_7.z = ((tmpvar_6 + (1.984375 * tmpvar_5.x)) - 1.06862);
  tmpvar_7.w = (1.15625 * (texture2D (_MainTex, tmpvar_3).w - 0.062745));
  gl_FragData[0] = tmpvar_7;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = (1.0 - _glesMultiTexCoord0.y);
  tmpvar_1 = ((tmpvar_1 * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SecondTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (0.5 * xlv_TEXCOORD0.x);
  highp vec2 tmpvar_2;
  tmpvar_2.x = tmpvar_1;
  tmpvar_2.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_3;
  tmpvar_3.x = (tmpvar_1 + 0.5);
  tmpvar_3.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_1;
  tmpvar_4.y = xlv_TEXCOORD0.y;
  lowp vec2 tmpvar_5;
  tmpvar_5 = texture2D (_SecondTex, tmpvar_4).xy;
  lowp float tmpvar_6;
  tmpvar_6 = (1.15625 * texture2D (_MainTex, tmpvar_2).w);
  lowp vec4 tmpvar_7;
  tmpvar_7.x = ((tmpvar_6 + (1.59375 * tmpvar_5.y)) - 0.87254);
  tmpvar_7.y = (((tmpvar_6 - 
    (0.390625 * tmpvar_5.x)
  ) - (0.8125 * tmpvar_5.y)) + 0.53137);
  tmpvar_7.z = ((tmpvar_6 + (1.984375 * tmpvar_5.x)) - 1.06862);
  tmpvar_7.w = (1.15625 * (texture2D (_MainTex, tmpvar_3).w - 0.062745));
  gl_FragData[0] = tmpvar_7;
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