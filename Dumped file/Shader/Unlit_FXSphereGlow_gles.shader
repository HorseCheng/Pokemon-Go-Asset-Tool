Shader "Unlit/FXSphereGlow" {
Properties {
_Color1 ("Color1", Color) = (1,0,0,1)
_Color2 ("Color2", Color) = (0,0.3793104,1,1)
[Toggle(NIANTIC_FX)] _ColorBlend ("ColorBlend", Float) = 1
_BlendPoint ("BlendPoint", Range(0, 1)) = 0.5
_AttenuationStart ("AttenuationStart", Range(0, 1)) = 1
_AttenuationEnd ("AttenuationEnd", Range(0, 1)) = 0
_Intensity ("Intensity", Range(0, 10)) = 1
_AnimInput ("AnimInput", Range(0, 5)) = 1
[Header(SORTING_AND_CULLING)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling", Float) = 2
[Toggle] _ZWrite ("Z Write", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 11436
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 vNormal_1;
  mediump vec3 viewDir_2;
  lowp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = _glesNormal;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((unity_ObjectToWorld * tmpvar_6).xyz);
  vNormal_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (vNormal_1, viewDir_2);
  tmpvar_3.y = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (vNormal_1, _WorldSpaceLightPos0.xyz);
  tmpvar_3.x = ((tmpvar_9 * 0.5) + 0.5);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color1;
uniform mediump float _AttenuationEnd;
uniform mediump float _AttenuationStart;
uniform lowp float _Intensity;
uniform lowp float _AnimInput;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp float xlat_varstep_1;
  mediump float rimFallOff_2;
  lowp float tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD0.y;
  rimFallOff_2 = tmpvar_3;
  mediump float tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = clamp (((rimFallOff_2 - _AttenuationEnd) / (_AttenuationStart - _AttenuationEnd)), 0.0, 1.0);
  tmpvar_4 = (tmpvar_5 * (tmpvar_5 * (3.0 - 
    (2.0 * tmpvar_5)
  )));
  xlat_varstep_1 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (((
    (_Color1 * (xlat_varstep_1 * xlat_varstep_1))
   * _Intensity) * xlv_COLOR.w) * _AnimInput);
  gl_FragData[0] = tmpvar_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 vNormal_1;
  mediump vec3 viewDir_2;
  lowp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = _glesNormal;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((unity_ObjectToWorld * tmpvar_6).xyz);
  vNormal_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (vNormal_1, viewDir_2);
  tmpvar_3.y = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (vNormal_1, _WorldSpaceLightPos0.xyz);
  tmpvar_3.x = ((tmpvar_9 * 0.5) + 0.5);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color1;
uniform mediump float _AttenuationEnd;
uniform mediump float _AttenuationStart;
uniform lowp float _Intensity;
uniform lowp float _AnimInput;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp float xlat_varstep_1;
  mediump float rimFallOff_2;
  lowp float tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD0.y;
  rimFallOff_2 = tmpvar_3;
  mediump float tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = clamp (((rimFallOff_2 - _AttenuationEnd) / (_AttenuationStart - _AttenuationEnd)), 0.0, 1.0);
  tmpvar_4 = (tmpvar_5 * (tmpvar_5 * (3.0 - 
    (2.0 * tmpvar_5)
  )));
  xlat_varstep_1 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (((
    (_Color1 * (xlat_varstep_1 * xlat_varstep_1))
   * _Intensity) * xlv_COLOR.w) * _AnimInput);
  gl_FragData[0] = tmpvar_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 vNormal_1;
  mediump vec3 viewDir_2;
  lowp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = _glesNormal;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((unity_ObjectToWorld * tmpvar_6).xyz);
  vNormal_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (vNormal_1, viewDir_2);
  tmpvar_3.y = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (vNormal_1, _WorldSpaceLightPos0.xyz);
  tmpvar_3.x = ((tmpvar_9 * 0.5) + 0.5);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color1;
uniform mediump float _AttenuationEnd;
uniform mediump float _AttenuationStart;
uniform lowp float _Intensity;
uniform lowp float _AnimInput;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp float xlat_varstep_1;
  mediump float rimFallOff_2;
  lowp float tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD0.y;
  rimFallOff_2 = tmpvar_3;
  mediump float tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = clamp (((rimFallOff_2 - _AttenuationEnd) / (_AttenuationStart - _AttenuationEnd)), 0.0, 1.0);
  tmpvar_4 = (tmpvar_5 * (tmpvar_5 * (3.0 - 
    (2.0 * tmpvar_5)
  )));
  xlat_varstep_1 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (((
    (_Color1 * (xlat_varstep_1 * xlat_varstep_1))
   * _Intensity) * xlv_COLOR.w) * _AnimInput);
  gl_FragData[0] = tmpvar_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "NIANTIC_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 vNormal_1;
  mediump vec3 viewDir_2;
  lowp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = _glesNormal;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((unity_ObjectToWorld * tmpvar_6).xyz);
  vNormal_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (vNormal_1, viewDir_2);
  tmpvar_3.y = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (vNormal_1, _WorldSpaceLightPos0.xyz);
  tmpvar_3.x = ((tmpvar_9 * 0.5) + 0.5);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color1;
uniform mediump float _AttenuationEnd;
uniform mediump float _AttenuationStart;
uniform lowp vec4 _Color2;
uniform lowp float _BlendPoint;
uniform lowp float _Intensity;
uniform lowp float _AnimInput;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp float xlat_varstep_1;
  lowp vec4 mGlow_2;
  mediump float rimFallOff_3;
  lowp float tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD0.y;
  rimFallOff_3 = tmpvar_4;
  mediump float A_5;
  A_5 = _BlendPoint;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (A_5, 1e-05, 0.99999);
  mediump float tmpvar_7;
  tmpvar_7 = clamp (0.5, 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((1.0 - tmpvar_7) / (1.0 - tmpvar_6)) - (tmpvar_7 / tmpvar_6));
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (_Color2, _Color1, vec4(clamp ((
    (tmpvar_8 * (rimFallOff_3 * rimFallOff_3))
   - 
    ((((tmpvar_8 * 
      (tmpvar_6 * tmpvar_6)
    ) - tmpvar_7) / tmpvar_6) * rimFallOff_3)
  ), 0.0, 1.0)));
  mGlow_2 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((rimFallOff_3 - _AttenuationEnd) / (_AttenuationStart - _AttenuationEnd)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_11 * (tmpvar_11 * (3.0 - 
    (2.0 * tmpvar_11)
  )));
  xlat_varstep_1 = tmpvar_10;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (((
    (mGlow_2 * (xlat_varstep_1 * xlat_varstep_1))
   * _Intensity) * xlv_COLOR.w) * _AnimInput);
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "NIANTIC_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 vNormal_1;
  mediump vec3 viewDir_2;
  lowp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = _glesNormal;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((unity_ObjectToWorld * tmpvar_6).xyz);
  vNormal_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (vNormal_1, viewDir_2);
  tmpvar_3.y = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (vNormal_1, _WorldSpaceLightPos0.xyz);
  tmpvar_3.x = ((tmpvar_9 * 0.5) + 0.5);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color1;
uniform mediump float _AttenuationEnd;
uniform mediump float _AttenuationStart;
uniform lowp vec4 _Color2;
uniform lowp float _BlendPoint;
uniform lowp float _Intensity;
uniform lowp float _AnimInput;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp float xlat_varstep_1;
  lowp vec4 mGlow_2;
  mediump float rimFallOff_3;
  lowp float tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD0.y;
  rimFallOff_3 = tmpvar_4;
  mediump float A_5;
  A_5 = _BlendPoint;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (A_5, 1e-05, 0.99999);
  mediump float tmpvar_7;
  tmpvar_7 = clamp (0.5, 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((1.0 - tmpvar_7) / (1.0 - tmpvar_6)) - (tmpvar_7 / tmpvar_6));
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (_Color2, _Color1, vec4(clamp ((
    (tmpvar_8 * (rimFallOff_3 * rimFallOff_3))
   - 
    ((((tmpvar_8 * 
      (tmpvar_6 * tmpvar_6)
    ) - tmpvar_7) / tmpvar_6) * rimFallOff_3)
  ), 0.0, 1.0)));
  mGlow_2 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((rimFallOff_3 - _AttenuationEnd) / (_AttenuationStart - _AttenuationEnd)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_11 * (tmpvar_11 * (3.0 - 
    (2.0 * tmpvar_11)
  )));
  xlat_varstep_1 = tmpvar_10;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (((
    (mGlow_2 * (xlat_varstep_1 * xlat_varstep_1))
   * _Intensity) * xlv_COLOR.w) * _AnimInput);
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "NIANTIC_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 vNormal_1;
  mediump vec3 viewDir_2;
  lowp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = _glesNormal;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((unity_ObjectToWorld * tmpvar_6).xyz);
  vNormal_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (vNormal_1, viewDir_2);
  tmpvar_3.y = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (vNormal_1, _WorldSpaceLightPos0.xyz);
  tmpvar_3.x = ((tmpvar_9 * 0.5) + 0.5);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color1;
uniform mediump float _AttenuationEnd;
uniform mediump float _AttenuationStart;
uniform lowp vec4 _Color2;
uniform lowp float _BlendPoint;
uniform lowp float _Intensity;
uniform lowp float _AnimInput;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp float xlat_varstep_1;
  lowp vec4 mGlow_2;
  mediump float rimFallOff_3;
  lowp float tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD0.y;
  rimFallOff_3 = tmpvar_4;
  mediump float A_5;
  A_5 = _BlendPoint;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (A_5, 1e-05, 0.99999);
  mediump float tmpvar_7;
  tmpvar_7 = clamp (0.5, 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((1.0 - tmpvar_7) / (1.0 - tmpvar_6)) - (tmpvar_7 / tmpvar_6));
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (_Color2, _Color1, vec4(clamp ((
    (tmpvar_8 * (rimFallOff_3 * rimFallOff_3))
   - 
    ((((tmpvar_8 * 
      (tmpvar_6 * tmpvar_6)
    ) - tmpvar_7) / tmpvar_6) * rimFallOff_3)
  ), 0.0, 1.0)));
  mGlow_2 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((rimFallOff_3 - _AttenuationEnd) / (_AttenuationStart - _AttenuationEnd)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_11 * (tmpvar_11 * (3.0 - 
    (2.0 * tmpvar_11)
  )));
  xlat_varstep_1 = tmpvar_10;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (((
    (mGlow_2 * (xlat_varstep_1 * xlat_varstep_1))
   * _Intensity) * xlv_COLOR.w) * _AnimInput);
  gl_FragData[0] = tmpvar_12;
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
Keywords { "NIANTIC_FX" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "NIANTIC_FX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "NIANTIC_FX" }
""
}
}
}
}
}