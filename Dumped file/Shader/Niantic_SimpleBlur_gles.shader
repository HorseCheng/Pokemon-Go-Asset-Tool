Shader "Niantic/SimpleBlur" {
Properties {
_MainTex ("Base (RGB)", 2D) = "" { }
_Offsets ("Texel Offsets", Vector) = (0.0035,0.0035,0.0035,0.0035)
_Kernel ("Kernel", Float) = 0.15
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 17982
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Offsets;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  highp float tmpvar_4;
  tmpvar_4 = sin(_Offsets.z);
  highp float tmpvar_5;
  tmpvar_5 = cos(_Offsets.z);
  highp vec4 tmpvar_6;
  tmpvar_6.x = tmpvar_5;
  tmpvar_6.y = tmpvar_4;
  tmpvar_6.z = -(tmpvar_5);
  tmpvar_6.w = -(tmpvar_4);
  highp vec4 tmpvar_7;
  tmpvar_7.x = -(tmpvar_5);
  tmpvar_7.y = tmpvar_4;
  tmpvar_7.z = tmpvar_5;
  tmpvar_7.w = -(tmpvar_4);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xyxy + (_Offsets.xyxy * tmpvar_6));
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xyxy + (_Offsets.xyxy * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Kernel;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float tmpvar_2;
  tmpvar_2 = (_Kernel * clamp ((2.0 * xlv_TEXCOORD0.y), 0.0, 1.0));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1 = ((1.0 - (4.0 * tmpvar_2)) * tmpvar_3);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  color_1 = (color_1 + (tmpvar_2 * tmpvar_4));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1.zw);
  color_1 = (color_1 + (tmpvar_2 * tmpvar_5));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  color_1 = (color_1 + (tmpvar_2 * tmpvar_6));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD2.zw);
  color_1 = (color_1 + (tmpvar_2 * tmpvar_7));
  gl_FragData[0] = color_1;
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
uniform highp vec4 _Offsets;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  highp float tmpvar_4;
  tmpvar_4 = sin(_Offsets.z);
  highp float tmpvar_5;
  tmpvar_5 = cos(_Offsets.z);
  highp vec4 tmpvar_6;
  tmpvar_6.x = tmpvar_5;
  tmpvar_6.y = tmpvar_4;
  tmpvar_6.z = -(tmpvar_5);
  tmpvar_6.w = -(tmpvar_4);
  highp vec4 tmpvar_7;
  tmpvar_7.x = -(tmpvar_5);
  tmpvar_7.y = tmpvar_4;
  tmpvar_7.z = tmpvar_5;
  tmpvar_7.w = -(tmpvar_4);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xyxy + (_Offsets.xyxy * tmpvar_6));
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xyxy + (_Offsets.xyxy * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Kernel;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float tmpvar_2;
  tmpvar_2 = (_Kernel * clamp ((2.0 * xlv_TEXCOORD0.y), 0.0, 1.0));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1 = ((1.0 - (4.0 * tmpvar_2)) * tmpvar_3);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  color_1 = (color_1 + (tmpvar_2 * tmpvar_4));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1.zw);
  color_1 = (color_1 + (tmpvar_2 * tmpvar_5));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  color_1 = (color_1 + (tmpvar_2 * tmpvar_6));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD2.zw);
  color_1 = (color_1 + (tmpvar_2 * tmpvar_7));
  gl_FragData[0] = color_1;
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
uniform highp vec4 _Offsets;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  highp float tmpvar_4;
  tmpvar_4 = sin(_Offsets.z);
  highp float tmpvar_5;
  tmpvar_5 = cos(_Offsets.z);
  highp vec4 tmpvar_6;
  tmpvar_6.x = tmpvar_5;
  tmpvar_6.y = tmpvar_4;
  tmpvar_6.z = -(tmpvar_5);
  tmpvar_6.w = -(tmpvar_4);
  highp vec4 tmpvar_7;
  tmpvar_7.x = -(tmpvar_5);
  tmpvar_7.y = tmpvar_4;
  tmpvar_7.z = tmpvar_5;
  tmpvar_7.w = -(tmpvar_4);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xyxy + (_Offsets.xyxy * tmpvar_6));
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xyxy + (_Offsets.xyxy * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Kernel;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float tmpvar_2;
  tmpvar_2 = (_Kernel * clamp ((2.0 * xlv_TEXCOORD0.y), 0.0, 1.0));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1 = ((1.0 - (4.0 * tmpvar_2)) * tmpvar_3);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  color_1 = (color_1 + (tmpvar_2 * tmpvar_4));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1.zw);
  color_1 = (color_1 + (tmpvar_2 * tmpvar_5));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  color_1 = (color_1 + (tmpvar_2 * tmpvar_6));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD2.zw);
  color_1 = (color_1 + (tmpvar_2 * tmpvar_7));
  gl_FragData[0] = color_1;
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