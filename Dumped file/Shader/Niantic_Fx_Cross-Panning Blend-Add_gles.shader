Shader "Niantic/Fx/Cross-Panning Blend-Add" {
Properties {
_MainTex ("Texture 1", 2D) = "white" { }
_Tex2 ("Texture 2", 2D) = "white" { }
_PanSpeeds ("Pan Speeds: (XY=Tex1, ZW=Tex2)", Vector) = (0,0,0,0)
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 11506
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Tex2_ST;
uniform lowp vec4 _PanSpeeds;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_Texcoord1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _Tex2_ST.xy) + _Tex2_ST.zw);
  tmpvar_1 = (tmpvar_1 - (_PanSpeeds.xy * _Time.x));
  tmpvar_2 = (tmpvar_2 - (_PanSpeeds.zw * _Time.x));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_Texcoord1 = tmpvar_2;
  xlv_COLOR = _glesColor;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Tex2;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_Texcoord1;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0) + texture2D (_Tex2, xlv_Texcoord1)) * xlv_COLOR);
  gl_FragData[0] = tmpvar_1;
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Tex2_ST;
uniform lowp vec4 _PanSpeeds;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_Texcoord1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _Tex2_ST.xy) + _Tex2_ST.zw);
  tmpvar_1 = (tmpvar_1 - (_PanSpeeds.xy * _Time.x));
  tmpvar_2 = (tmpvar_2 - (_PanSpeeds.zw * _Time.x));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_Texcoord1 = tmpvar_2;
  xlv_COLOR = _glesColor;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Tex2;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_Texcoord1;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0) + texture2D (_Tex2, xlv_Texcoord1)) * xlv_COLOR);
  gl_FragData[0] = tmpvar_1;
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Tex2_ST;
uniform lowp vec4 _PanSpeeds;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_Texcoord1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _Tex2_ST.xy) + _Tex2_ST.zw);
  tmpvar_1 = (tmpvar_1 - (_PanSpeeds.xy * _Time.x));
  tmpvar_2 = (tmpvar_2 - (_PanSpeeds.zw * _Time.x));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_Texcoord1 = tmpvar_2;
  xlv_COLOR = _glesColor;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Tex2;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_Texcoord1;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0) + texture2D (_Tex2, xlv_Texcoord1)) * xlv_COLOR);
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