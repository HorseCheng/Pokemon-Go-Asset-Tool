Shader "Holo/Effects/Particles/Distort" {
Properties {
_MainTex ("Particle Texture", 2D) = "white" { }
_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 3
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 GrabPass {
}
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  Lighting On
  GpuProgramID 26012
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyz = _glesColor.xyz;
  tmpvar_1.w = (_glesColor.w * 0.1);
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GrabTexture;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 uvgrab_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD2.xyz / xlv_TEXCOORD2.w);
  uvgrab_1 = tmpvar_2;
  uvgrab_1.xy = (uvgrab_1.xy + ((texture2D (_MainTex, xlv_TEXCOORD0) - 0.5).xy * xlv_COLOR.w));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = ((xlv_COLOR.xyz * xlv_COLOR.w) + (1.0 - xlv_COLOR.www));
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * texture2D (_GrabTexture, uvgrab_1.xy));
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyz = _glesColor.xyz;
  tmpvar_1.w = (_glesColor.w * 0.1);
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GrabTexture;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 uvgrab_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD2.xyz / xlv_TEXCOORD2.w);
  uvgrab_1 = tmpvar_2;
  uvgrab_1.xy = (uvgrab_1.xy + ((texture2D (_MainTex, xlv_TEXCOORD0) - 0.5).xy * xlv_COLOR.w));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = ((xlv_COLOR.xyz * xlv_COLOR.w) + (1.0 - xlv_COLOR.www));
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * texture2D (_GrabTexture, uvgrab_1.xy));
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyz = _glesColor.xyz;
  tmpvar_1.w = (_glesColor.w * 0.1);
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GrabTexture;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 uvgrab_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD2.xyz / xlv_TEXCOORD2.w);
  uvgrab_1 = tmpvar_2;
  uvgrab_1.xy = (uvgrab_1.xy + ((texture2D (_MainTex, xlv_TEXCOORD0) - 0.5).xy * xlv_COLOR.w));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = ((xlv_COLOR.xyz * xlv_COLOR.w) + (1.0 - xlv_COLOR.www));
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * texture2D (_GrabTexture, uvgrab_1.xy));
  gl_FragData[0] = tmpvar_4;
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
CustomEditor "CustomMaterialInspector"
}