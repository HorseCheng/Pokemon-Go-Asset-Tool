Shader "Mobile/Particles/Multiply" {
Properties {
_MainTex ("Particle Texture", 2D) = "white" { }
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 9742
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
  xlv_TEXCOORD0 = (tmpvar_4 + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_4 + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = mix (vec4(1.0, 1.0, 1.0, 1.0), col_1, col_1.wwww);
  col_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
  xlv_TEXCOORD0 = (tmpvar_4 + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_4 + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = mix (vec4(1.0, 1.0, 1.0, 1.0), col_1, col_1.wwww);
  col_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
  xlv_TEXCOORD0 = (tmpvar_4 + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_4 + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = mix (vec4(1.0, 1.0, 1.0, 1.0), col_1, col_1.wwww);
  col_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  highp vec2 tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
  xlv_TEXCOORD0 = (tmpvar_9 + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_9 + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = mix (vec4(1.0, 1.0, 1.0, 1.0), col_1, col_1.wwww);
  col_1.w = tmpvar_2.w;
  col_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(xlv_TEXCOORD2));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  highp vec2 tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
  xlv_TEXCOORD0 = (tmpvar_9 + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_9 + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = mix (vec4(1.0, 1.0, 1.0, 1.0), col_1, col_1.wwww);
  col_1.w = tmpvar_2.w;
  col_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(xlv_TEXCOORD2));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  highp vec2 tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
  xlv_TEXCOORD0 = (tmpvar_9 + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_9 + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = mix (vec4(1.0, 1.0, 1.0, 1.0), col_1, col_1.wwww);
  col_1.w = tmpvar_2.w;
  col_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(xlv_TEXCOORD2));
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
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
}
}
}
}