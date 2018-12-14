Shader "Hidden/LuminanceBakeShader" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_RampTex ("Ramp", 2D) = "white" { }
_MaskTex ("Mask", 2D) = "black" { }
_TintColorOne ("Red Channel Tint", Color) = (0.5,0.5,0.5,0.5)
_TintColorTwo ("Green Channel Tint", Color) = (0.5,0.5,0.5,0.5)
_TintColorThree ("Blue Channel Tint", Color) = (0.5,0.5,0.5,0.5)
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 43463
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
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
uniform sampler2D _MaskTex;
uniform lowp vec4 _TintColorOne;
uniform lowp vec4 _TintColorTwo;
uniform lowp vec4 _TintColorThree;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec2 tmpvar_3;
  tmpvar_3.y = 0.5;
  tmpvar_3.x = tmpvar_2.x;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_RampTex, tmpvar_3);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_MaskTex, xlv_TEXCOORD0).xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_4, ((tmpvar_4 * _TintColorOne) * 2.0), tmpvar_5.xxxx);
  lowp vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6, ((tmpvar_6 * _TintColorTwo) * 2.0), tmpvar_5.yyyy);
  col_1.xyz = mix (tmpvar_7, ((tmpvar_7 * _TintColorThree) * 2.0), tmpvar_5.zzzz).xyz;
  col_1.w = tmpvar_2.w;
  gl_FragData[0] = col_1;
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
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
uniform sampler2D _MaskTex;
uniform lowp vec4 _TintColorOne;
uniform lowp vec4 _TintColorTwo;
uniform lowp vec4 _TintColorThree;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec2 tmpvar_3;
  tmpvar_3.y = 0.5;
  tmpvar_3.x = tmpvar_2.x;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_RampTex, tmpvar_3);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_MaskTex, xlv_TEXCOORD0).xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_4, ((tmpvar_4 * _TintColorOne) * 2.0), tmpvar_5.xxxx);
  lowp vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6, ((tmpvar_6 * _TintColorTwo) * 2.0), tmpvar_5.yyyy);
  col_1.xyz = mix (tmpvar_7, ((tmpvar_7 * _TintColorThree) * 2.0), tmpvar_5.zzzz).xyz;
  col_1.w = tmpvar_2.w;
  gl_FragData[0] = col_1;
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
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
uniform sampler2D _MaskTex;
uniform lowp vec4 _TintColorOne;
uniform lowp vec4 _TintColorTwo;
uniform lowp vec4 _TintColorThree;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec2 tmpvar_3;
  tmpvar_3.y = 0.5;
  tmpvar_3.x = tmpvar_2.x;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_RampTex, tmpvar_3);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_MaskTex, xlv_TEXCOORD0).xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_4, ((tmpvar_4 * _TintColorOne) * 2.0), tmpvar_5.xxxx);
  lowp vec4 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6, ((tmpvar_6 * _TintColorTwo) * 2.0), tmpvar_5.yyyy);
  col_1.xyz = mix (tmpvar_7, ((tmpvar_7 * _TintColorThree) * 2.0), tmpvar_5.zzzz).xyz;
  col_1.w = tmpvar_2.w;
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
}
}
}
}