Shader "Holo/Sky/Cloudscape" {
Properties {
_HighlightColor ("Highlight Color", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_CloudShadowColor ("Shadow Color", Color) = (1,1,1,1)
_MainTex ("Main Texture", 2D) = "white" { }
_Alpha ("Alpha", Range(0, 1)) = 1
_PanSpeed ("Pan Speed", Float) = 0.1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 47794
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
uniform lowp float _PanSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.x = (tmpvar_1.x + ((_Time.x * _PanSpeed) * _glesColor.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _HighlightColor;
uniform mediump vec4 _Color;
uniform mediump vec4 _CloudShadowColor;
uniform sampler2D _MainTex;
uniform mediump float _Alpha;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp float highlight_2;
  lowp float shadow_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_5;
  tmpvar_5 = (1.25 - tmpvar_4.x);
  shadow_3 = (tmpvar_5 * (tmpvar_5 * tmpvar_5));
  lowp float tmpvar_6;
  tmpvar_6 = (tmpvar_4.x * tmpvar_4.x);
  highlight_2 = (tmpvar_6 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (_Color, _CloudShadowColor, vec4(shadow_3)).xyz;
  col_1.xyz = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = col_1.xyz;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_8, _HighlightColor, vec4(highlight_2)).xyz;
  col_1.xyz = tmpvar_9;
  col_1.w = (tmpvar_4.w * _Alpha);
  gl_FragData[0] = col_1;
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
uniform lowp float _PanSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.x = (tmpvar_1.x + ((_Time.x * _PanSpeed) * _glesColor.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _HighlightColor;
uniform mediump vec4 _Color;
uniform mediump vec4 _CloudShadowColor;
uniform sampler2D _MainTex;
uniform mediump float _Alpha;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp float highlight_2;
  lowp float shadow_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_5;
  tmpvar_5 = (1.25 - tmpvar_4.x);
  shadow_3 = (tmpvar_5 * (tmpvar_5 * tmpvar_5));
  lowp float tmpvar_6;
  tmpvar_6 = (tmpvar_4.x * tmpvar_4.x);
  highlight_2 = (tmpvar_6 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (_Color, _CloudShadowColor, vec4(shadow_3)).xyz;
  col_1.xyz = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = col_1.xyz;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_8, _HighlightColor, vec4(highlight_2)).xyz;
  col_1.xyz = tmpvar_9;
  col_1.w = (tmpvar_4.w * _Alpha);
  gl_FragData[0] = col_1;
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
uniform lowp float _PanSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.x = (tmpvar_1.x + ((_Time.x * _PanSpeed) * _glesColor.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _HighlightColor;
uniform mediump vec4 _Color;
uniform mediump vec4 _CloudShadowColor;
uniform sampler2D _MainTex;
uniform mediump float _Alpha;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp float highlight_2;
  lowp float shadow_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_5;
  tmpvar_5 = (1.25 - tmpvar_4.x);
  shadow_3 = (tmpvar_5 * (tmpvar_5 * tmpvar_5));
  lowp float tmpvar_6;
  tmpvar_6 = (tmpvar_4.x * tmpvar_4.x);
  highlight_2 = (tmpvar_6 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (_Color, _CloudShadowColor, vec4(shadow_3)).xyz;
  col_1.xyz = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = col_1.xyz;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_8, _HighlightColor, vec4(highlight_2)).xyz;
  col_1.xyz = tmpvar_9;
  col_1.w = (tmpvar_4.w * _Alpha);
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