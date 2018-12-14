Shader "Holo/Distort" {
Properties {
_Color ("    Color", Color) = (1,1,1,1)
_RefractionAmount ("Refraction Amount", Float) = 100
}
SubShader {
 LOD 400
 Tags { "QUEUE" = "Transparent" "RenderType" = "Opaque" }
 GrabPass {
}
 Pass {
  Name "FORWARD"
  LOD 400
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
  GpuProgramID 5065
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec3 tmpvar_1;
  mediump vec3 vsNormal_2;
  tmpvar_1 = normalize(_glesNormal);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_MatrixMV[0].xyz;
  tmpvar_3[1] = unity_MatrixMV[1].xyz;
  tmpvar_3[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * tmpvar_1));
  vsNormal_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = normalize((tmpvar_1 * tmpvar_8));
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = o_9;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ((vsNormal_2.xy * vsNormal_2.z) * ((_RefractionAmount * _glesColor.w) * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_7);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GrabTexture;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_1 = xlv_COLOR0;
  lowp vec4 refractColor_3;
  mediump vec2 uvgrab_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_2.xy / tmpvar_2.w);
  uvgrab_4 = (tmpvar_5 - ((xlv_TEXCOORD3 / tmpvar_2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_5 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_GrabTexture, uvgrab_4);
  refractColor_3.w = tmpvar_6.w;
  refractColor_3.xyz = (tmpvar_6.xyz * tmpvar_1.xyz);
  gl_FragData[0] = refractColor_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec3 tmpvar_1;
  mediump vec3 vsNormal_2;
  tmpvar_1 = normalize(_glesNormal);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_MatrixMV[0].xyz;
  tmpvar_3[1] = unity_MatrixMV[1].xyz;
  tmpvar_3[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * tmpvar_1));
  vsNormal_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = normalize((tmpvar_1 * tmpvar_8));
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = o_9;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ((vsNormal_2.xy * vsNormal_2.z) * ((_RefractionAmount * _glesColor.w) * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_7);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GrabTexture;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_1 = xlv_COLOR0;
  lowp vec4 refractColor_3;
  mediump vec2 uvgrab_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_2.xy / tmpvar_2.w);
  uvgrab_4 = (tmpvar_5 - ((xlv_TEXCOORD3 / tmpvar_2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_5 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_GrabTexture, uvgrab_4);
  refractColor_3.w = tmpvar_6.w;
  refractColor_3.xyz = (tmpvar_6.xyz * tmpvar_1.xyz);
  gl_FragData[0] = refractColor_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec3 tmpvar_1;
  mediump vec3 vsNormal_2;
  tmpvar_1 = normalize(_glesNormal);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_MatrixMV[0].xyz;
  tmpvar_3[1] = unity_MatrixMV[1].xyz;
  tmpvar_3[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * tmpvar_1));
  vsNormal_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = normalize((tmpvar_1 * tmpvar_8));
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = o_9;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ((vsNormal_2.xy * vsNormal_2.z) * ((_RefractionAmount * _glesColor.w) * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_7);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GrabTexture;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_1 = xlv_COLOR0;
  lowp vec4 refractColor_3;
  mediump vec2 uvgrab_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_2.xy / tmpvar_2.w);
  uvgrab_4 = (tmpvar_5 - ((xlv_TEXCOORD3 / tmpvar_2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_5 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_GrabTexture, uvgrab_4);
  refractColor_3.w = tmpvar_6.w;
  refractColor_3.xyz = (tmpvar_6.xyz * tmpvar_1.xyz);
  gl_FragData[0] = refractColor_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec3 tmpvar_1;
  mediump vec3 vsNormal_2;
  tmpvar_1 = normalize(_glesNormal);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_MatrixMV[0].xyz;
  tmpvar_3[1] = unity_MatrixMV[1].xyz;
  tmpvar_3[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * tmpvar_1));
  vsNormal_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = normalize((tmpvar_1 * tmpvar_8));
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = o_9;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ((vsNormal_2.xy * vsNormal_2.z) * ((_RefractionAmount * _glesColor.w) * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_7);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GrabTexture;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_1 = xlv_COLOR0;
  lowp vec4 refractColor_3;
  mediump vec2 uvgrab_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_2.xy / tmpvar_2.w);
  uvgrab_4 = (tmpvar_5 - ((xlv_TEXCOORD3 / tmpvar_2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_5 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_GrabTexture, uvgrab_4);
  refractColor_3.w = tmpvar_6.w;
  refractColor_3.xyz = (tmpvar_6.xyz * tmpvar_1.xyz);
  gl_FragData[0] = refractColor_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec3 tmpvar_1;
  mediump vec3 vsNormal_2;
  tmpvar_1 = normalize(_glesNormal);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_MatrixMV[0].xyz;
  tmpvar_3[1] = unity_MatrixMV[1].xyz;
  tmpvar_3[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * tmpvar_1));
  vsNormal_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = normalize((tmpvar_1 * tmpvar_8));
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = o_9;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ((vsNormal_2.xy * vsNormal_2.z) * ((_RefractionAmount * _glesColor.w) * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_7);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GrabTexture;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_1 = xlv_COLOR0;
  lowp vec4 refractColor_3;
  mediump vec2 uvgrab_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_2.xy / tmpvar_2.w);
  uvgrab_4 = (tmpvar_5 - ((xlv_TEXCOORD3 / tmpvar_2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_5 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_GrabTexture, uvgrab_4);
  refractColor_3.w = tmpvar_6.w;
  refractColor_3.xyz = (tmpvar_6.xyz * tmpvar_1.xyz);
  gl_FragData[0] = refractColor_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec3 tmpvar_1;
  mediump vec3 vsNormal_2;
  tmpvar_1 = normalize(_glesNormal);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_MatrixMV[0].xyz;
  tmpvar_3[1] = unity_MatrixMV[1].xyz;
  tmpvar_3[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * tmpvar_1));
  vsNormal_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = normalize((tmpvar_1 * tmpvar_8));
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = o_9;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ((vsNormal_2.xy * vsNormal_2.z) * ((_RefractionAmount * _glesColor.w) * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_7);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GrabTexture;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_1 = xlv_COLOR0;
  lowp vec4 refractColor_3;
  mediump vec2 uvgrab_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_2.xy / tmpvar_2.w);
  uvgrab_4 = (tmpvar_5 - ((xlv_TEXCOORD3 / tmpvar_2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_5 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_GrabTexture, uvgrab_4);
  refractColor_3.w = tmpvar_6.w;
  refractColor_3.xyz = (tmpvar_6.xyz * tmpvar_1.xyz);
  gl_FragData[0] = refractColor_3;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
}
}
}
CustomEditor "CustomMaterialInspector"
}