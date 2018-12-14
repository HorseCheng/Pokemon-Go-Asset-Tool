Shader "Niantic/World Map/Buildings" {
Properties {
_yFaceColor ("Up Facing Color", Color) = (1,1,1,1)
_blendedFaceColor ("Blended (distant) Face Color", Color) = (1,1,1,1)
_wallColor ("Wall Color 1", Color) = (1,1,1,1)
_wallColorSecondary ("Wall Color 2", Color) = (1,1,1,1)
_NearOpacity ("Near Opacity", Range(0, 1)) = 0
_FarOpacity ("Far Opacity", Range(0, 1)) = 1
_NearDist ("Near Distance", Float) = 100
_FarDist ("Far Distance", Float) = 250
_BlendedColorNearDist ("Blended Near Distance", Float) = 80
_BlendedColorFarDist ("Blended Far Distance", Float) = 250
}
SubShader {
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 12813
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _wallColor;
uniform lowp vec4 _wallColorSecondary;
uniform lowp vec4 _yFaceColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 wall_1;
  mediump float left_2;
  mediump float up_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp float tmpvar_8;
  tmpvar_8 = ((tmpvar_7.y + 1.0) * 0.5);
  up_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_7.z + 1.0) * 0.5);
  left_2 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_wallColor, _wallColorSecondary, vec4(left_2));
  wall_1 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (wall_1, _yFaceColor, vec4(up_3));
  tmpvar_4 = tmpvar_11;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _blendedFaceColor;
uniform highp vec4 _playerPosition;
uniform mediump float _NearOpacity;
uniform mediump float _FarOpacity;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _BlendedColorNearDist;
uniform mediump float _BlendedColorFarDist;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  highp float tmpvar_2;
  highp vec3 x_3;
  x_3 = (_playerPosition.xyz - xlv_TEXCOORD1);
  tmpvar_2 = sqrt(dot (x_3, x_3));
  mediump float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_2 - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_2 - _BlendedColorNearDist) / (_BlendedColorFarDist - _BlendedColorNearDist)), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_blendedFaceColor, xlv_TEXCOORD0, vec4(tmpvar_6)).xyz;
  c_1.xyz = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = mix (_NearOpacity, _FarOpacity, tmpvar_4);
  c_1.w = (tmpvar_9 * xlv_TEXCOORD0.w);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _wallColor;
uniform lowp vec4 _wallColorSecondary;
uniform lowp vec4 _yFaceColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 wall_1;
  mediump float left_2;
  mediump float up_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp float tmpvar_8;
  tmpvar_8 = ((tmpvar_7.y + 1.0) * 0.5);
  up_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_7.z + 1.0) * 0.5);
  left_2 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_wallColor, _wallColorSecondary, vec4(left_2));
  wall_1 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (wall_1, _yFaceColor, vec4(up_3));
  tmpvar_4 = tmpvar_11;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _blendedFaceColor;
uniform highp vec4 _playerPosition;
uniform mediump float _NearOpacity;
uniform mediump float _FarOpacity;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _BlendedColorNearDist;
uniform mediump float _BlendedColorFarDist;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  highp float tmpvar_2;
  highp vec3 x_3;
  x_3 = (_playerPosition.xyz - xlv_TEXCOORD1);
  tmpvar_2 = sqrt(dot (x_3, x_3));
  mediump float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_2 - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_2 - _BlendedColorNearDist) / (_BlendedColorFarDist - _BlendedColorNearDist)), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_blendedFaceColor, xlv_TEXCOORD0, vec4(tmpvar_6)).xyz;
  c_1.xyz = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = mix (_NearOpacity, _FarOpacity, tmpvar_4);
  c_1.w = (tmpvar_9 * xlv_TEXCOORD0.w);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _wallColor;
uniform lowp vec4 _wallColorSecondary;
uniform lowp vec4 _yFaceColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 wall_1;
  mediump float left_2;
  mediump float up_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp float tmpvar_8;
  tmpvar_8 = ((tmpvar_7.y + 1.0) * 0.5);
  up_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_7.z + 1.0) * 0.5);
  left_2 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_wallColor, _wallColorSecondary, vec4(left_2));
  wall_1 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (wall_1, _yFaceColor, vec4(up_3));
  tmpvar_4 = tmpvar_11;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _blendedFaceColor;
uniform highp vec4 _playerPosition;
uniform mediump float _NearOpacity;
uniform mediump float _FarOpacity;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _BlendedColorNearDist;
uniform mediump float _BlendedColorFarDist;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  highp float tmpvar_2;
  highp vec3 x_3;
  x_3 = (_playerPosition.xyz - xlv_TEXCOORD1);
  tmpvar_2 = sqrt(dot (x_3, x_3));
  mediump float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_2 - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_2 - _BlendedColorNearDist) / (_BlendedColorFarDist - _BlendedColorNearDist)), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_blendedFaceColor, xlv_TEXCOORD0, vec4(tmpvar_6)).xyz;
  c_1.xyz = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = mix (_NearOpacity, _FarOpacity, tmpvar_4);
  c_1.w = (tmpvar_9 * xlv_TEXCOORD0.w);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _wallColor;
uniform lowp vec4 _wallColorSecondary;
uniform lowp vec4 _yFaceColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 wall_1;
  mediump float left_2;
  mediump float up_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_8.y + 1.0) * 0.5);
  up_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((tmpvar_8.z + 1.0) * 0.5);
  left_2 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (_wallColor, _wallColorSecondary, vec4(left_2));
  wall_1 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (wall_1, _yFaceColor, vec4(up_3));
  tmpvar_4 = tmpvar_12;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _blendedFaceColor;
uniform highp vec4 _playerPosition;
uniform mediump float _NearOpacity;
uniform mediump float _FarOpacity;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _BlendedColorNearDist;
uniform mediump float _BlendedColorFarDist;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp float tmpvar_2;
  highp vec3 x_3;
  x_3 = (_playerPosition.xyz - xlv_TEXCOORD1);
  tmpvar_2 = sqrt(dot (x_3, x_3));
  mediump float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_2 - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_2 - _BlendedColorNearDist) / (_BlendedColorFarDist - _BlendedColorNearDist)), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_blendedFaceColor, xlv_TEXCOORD0, vec4(tmpvar_6)).xyz;
  c_1.xyz = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = mix (_NearOpacity, _FarOpacity, tmpvar_4);
  c_1.w = (tmpvar_9 * xlv_TEXCOORD0.w);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _wallColor;
uniform lowp vec4 _wallColorSecondary;
uniform lowp vec4 _yFaceColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 wall_1;
  mediump float left_2;
  mediump float up_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_8.y + 1.0) * 0.5);
  up_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((tmpvar_8.z + 1.0) * 0.5);
  left_2 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (_wallColor, _wallColorSecondary, vec4(left_2));
  wall_1 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (wall_1, _yFaceColor, vec4(up_3));
  tmpvar_4 = tmpvar_12;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _blendedFaceColor;
uniform highp vec4 _playerPosition;
uniform mediump float _NearOpacity;
uniform mediump float _FarOpacity;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _BlendedColorNearDist;
uniform mediump float _BlendedColorFarDist;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp float tmpvar_2;
  highp vec3 x_3;
  x_3 = (_playerPosition.xyz - xlv_TEXCOORD1);
  tmpvar_2 = sqrt(dot (x_3, x_3));
  mediump float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_2 - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_2 - _BlendedColorNearDist) / (_BlendedColorFarDist - _BlendedColorNearDist)), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_blendedFaceColor, xlv_TEXCOORD0, vec4(tmpvar_6)).xyz;
  c_1.xyz = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = mix (_NearOpacity, _FarOpacity, tmpvar_4);
  c_1.w = (tmpvar_9 * xlv_TEXCOORD0.w);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _wallColor;
uniform lowp vec4 _wallColorSecondary;
uniform lowp vec4 _yFaceColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 wall_1;
  mediump float left_2;
  mediump float up_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_8.y + 1.0) * 0.5);
  up_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((tmpvar_8.z + 1.0) * 0.5);
  left_2 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (_wallColor, _wallColorSecondary, vec4(left_2));
  wall_1 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (wall_1, _yFaceColor, vec4(up_3));
  tmpvar_4 = tmpvar_12;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _blendedFaceColor;
uniform highp vec4 _playerPosition;
uniform mediump float _NearOpacity;
uniform mediump float _FarOpacity;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _BlendedColorNearDist;
uniform mediump float _BlendedColorFarDist;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp float tmpvar_2;
  highp vec3 x_3;
  x_3 = (_playerPosition.xyz - xlv_TEXCOORD1);
  tmpvar_2 = sqrt(dot (x_3, x_3));
  mediump float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_2 - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_2 - _BlendedColorNearDist) / (_BlendedColorFarDist - _BlendedColorNearDist)), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_blendedFaceColor, xlv_TEXCOORD0, vec4(tmpvar_6)).xyz;
  c_1.xyz = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = mix (_NearOpacity, _FarOpacity, tmpvar_4);
  c_1.w = (tmpvar_9 * xlv_TEXCOORD0.w);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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