Shader "Unlit/InputChallengeShader" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
}
SubShader {
 LOD 100
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 44638
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
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp float tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.x - 0.5);
  highp float tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD0.y - 0.5);
  highp float tmpvar_4;
  tmpvar_4 = sqrt(((tmpvar_2 * tmpvar_2) + (tmpvar_3 * tmpvar_3)));
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_4 - 0.48) / 0.01000002), 0.0, 1.0);
  highp float tmpvar_6;
  tmpvar_6 = clamp (((tmpvar_4 - 0.49) / 0.00999999), 0.0, 1.0);
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = _Color.xyz;
  tmpvar_7.w = ((tmpvar_5 * (tmpvar_5 * 
    (3.0 - (2.0 * tmpvar_5))
  )) - (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
  col_1 = tmpvar_7;
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
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp float tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.x - 0.5);
  highp float tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD0.y - 0.5);
  highp float tmpvar_4;
  tmpvar_4 = sqrt(((tmpvar_2 * tmpvar_2) + (tmpvar_3 * tmpvar_3)));
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_4 - 0.48) / 0.01000002), 0.0, 1.0);
  highp float tmpvar_6;
  tmpvar_6 = clamp (((tmpvar_4 - 0.49) / 0.00999999), 0.0, 1.0);
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = _Color.xyz;
  tmpvar_7.w = ((tmpvar_5 * (tmpvar_5 * 
    (3.0 - (2.0 * tmpvar_5))
  )) - (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
  col_1 = tmpvar_7;
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
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp float tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.x - 0.5);
  highp float tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD0.y - 0.5);
  highp float tmpvar_4;
  tmpvar_4 = sqrt(((tmpvar_2 * tmpvar_2) + (tmpvar_3 * tmpvar_3)));
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_4 - 0.48) / 0.01000002), 0.0, 1.0);
  highp float tmpvar_6;
  tmpvar_6 = clamp (((tmpvar_4 - 0.49) / 0.00999999), 0.0, 1.0);
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = _Color.xyz;
  tmpvar_7.w = ((tmpvar_5 * (tmpvar_5 * 
    (3.0 - (2.0 * tmpvar_5))
  )) - (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
  col_1 = tmpvar_7;
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