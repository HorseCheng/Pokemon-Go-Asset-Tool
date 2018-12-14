Shader "Unlit/Gym Interior Lobby Screen" {
Properties {
_POITex ("POI Photo Texture", 2D) = "white" { }
_POIAdditive ("POI Additive Texture", 2D) = "black" { }
_AvatarTex ("Avatar Photo Texture", 2D) = "white" { }
_AvatarLerp ("Avatar Photo Lerp", Range(0, 1)) = 0
_AvatarOffset ("Avatar Photo Offset and Scale", Vector) = (0,0,1,1)
_AvatarOffsetNoiseSpeed ("Avatar Photo Offset Noise Speed", Float) = 0.1
_AvatarOffsetNoiseScale ("Avatar Photo Offset Noise Scale", Float) = 0.2
_AvatarMask ("Avatar Photo Mask", 2D) = "white" { }
_WarpTex ("Warp Texture", 2D) = "bump" { }
_WarpStrength ("Warp Strength", Float) = 1
_WarpSpeedX ("Warp X Pan Speed", Float) = 0
_WarpSpeedY ("Warp Y Pan Speed", Float) = 0
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 11899
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _POITex_ST;
uniform highp vec4 _POIAdditive_ST;
uniform lowp vec4 _AvatarOffset;
uniform lowp float _AvatarOffsetNoiseSpeed;
uniform lowp float _AvatarOffsetNoiseScale;
uniform highp vec4 _WarpTex_ST;
uniform lowp float _WarpSpeedX;
uniform lowp float _WarpSpeedY;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp mat4 tmpvar_1;
  tmpvar_1[0].x = unity_MatrixMV[0].x;
  tmpvar_1[0].y = unity_MatrixMV[1].x;
  tmpvar_1[0].z = unity_MatrixMV[2].x;
  tmpvar_1[0].w = unity_MatrixMV[3].x;
  tmpvar_1[1].x = unity_MatrixMV[0].y;
  tmpvar_1[1].y = unity_MatrixMV[1].y;
  tmpvar_1[1].z = unity_MatrixMV[2].y;
  tmpvar_1[1].w = unity_MatrixMV[3].y;
  tmpvar_1[2].x = unity_MatrixMV[0].z;
  tmpvar_1[2].y = unity_MatrixMV[1].z;
  tmpvar_1[2].z = unity_MatrixMV[2].z;
  tmpvar_1[2].w = unity_MatrixMV[3].z;
  tmpvar_1[3].x = unity_MatrixMV[0].w;
  tmpvar_1[3].y = unity_MatrixMV[1].w;
  tmpvar_1[3].z = unity_MatrixMV[2].w;
  tmpvar_1[3].w = unity_MatrixMV[3].w;
  lowp vec2 offsetNoise_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.x * _AvatarOffsetNoiseSpeed);
  tmpvar_7.x = sin(tmpvar_8);
  tmpvar_7.y = (sin((tmpvar_8 * 0.37)) * cos((tmpvar_8 * 0.97)));
  highp vec2 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _AvatarOffsetNoiseScale);
  offsetNoise_2 = tmpvar_9;
  tmpvar_3 = (((
    (tmpvar_1 * _glesVertex)
   / tmpvar_5.w).xy * _AvatarOffset.zw) + _AvatarOffset.xy);
  tmpvar_4 = tmpvar_3;
  tmpvar_3 = (tmpvar_3 + offsetNoise_2);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.x * _WarpSpeedX);
  tmpvar_10.y = (_Time.x * _WarpSpeedY);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _POITex_ST.xy) + _POITex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _POIAdditive_ST.xy) + _POIAdditive_ST.zw);
  xlv_TEXCOORD2 = (((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw) + tmpvar_10);
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _POITex;
uniform sampler2D _POIAdditive;
uniform sampler2D _AvatarTex;
uniform lowp float _AvatarLerp;
uniform sampler2D _AvatarMask;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 col_1;
  lowp vec2 warpedUv_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_WarpTex, xlv_TEXCOORD2);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_POIAdditive, xlv_TEXCOORD1);
  highp vec2 tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0 + ((tmpvar_3.xy - 0.5) * _WarpStrength));
  warpedUv_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (texture2D (_POITex, warpedUv_2), texture2D (_AvatarTex, xlv_TEXCOORD3), vec4((_AvatarLerp * texture2D (_AvatarMask, xlv_TEXCOORD4).w)));
  col_1.w = tmpvar_6.w;
  col_1.xyz = mix (tmpvar_6.xyz, tmpvar_4.xyz, tmpvar_4.www);
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _POITex_ST;
uniform highp vec4 _POIAdditive_ST;
uniform lowp vec4 _AvatarOffset;
uniform lowp float _AvatarOffsetNoiseSpeed;
uniform lowp float _AvatarOffsetNoiseScale;
uniform highp vec4 _WarpTex_ST;
uniform lowp float _WarpSpeedX;
uniform lowp float _WarpSpeedY;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp mat4 tmpvar_1;
  tmpvar_1[0].x = unity_MatrixMV[0].x;
  tmpvar_1[0].y = unity_MatrixMV[1].x;
  tmpvar_1[0].z = unity_MatrixMV[2].x;
  tmpvar_1[0].w = unity_MatrixMV[3].x;
  tmpvar_1[1].x = unity_MatrixMV[0].y;
  tmpvar_1[1].y = unity_MatrixMV[1].y;
  tmpvar_1[1].z = unity_MatrixMV[2].y;
  tmpvar_1[1].w = unity_MatrixMV[3].y;
  tmpvar_1[2].x = unity_MatrixMV[0].z;
  tmpvar_1[2].y = unity_MatrixMV[1].z;
  tmpvar_1[2].z = unity_MatrixMV[2].z;
  tmpvar_1[2].w = unity_MatrixMV[3].z;
  tmpvar_1[3].x = unity_MatrixMV[0].w;
  tmpvar_1[3].y = unity_MatrixMV[1].w;
  tmpvar_1[3].z = unity_MatrixMV[2].w;
  tmpvar_1[3].w = unity_MatrixMV[3].w;
  lowp vec2 offsetNoise_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.x * _AvatarOffsetNoiseSpeed);
  tmpvar_7.x = sin(tmpvar_8);
  tmpvar_7.y = (sin((tmpvar_8 * 0.37)) * cos((tmpvar_8 * 0.97)));
  highp vec2 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _AvatarOffsetNoiseScale);
  offsetNoise_2 = tmpvar_9;
  tmpvar_3 = (((
    (tmpvar_1 * _glesVertex)
   / tmpvar_5.w).xy * _AvatarOffset.zw) + _AvatarOffset.xy);
  tmpvar_4 = tmpvar_3;
  tmpvar_3 = (tmpvar_3 + offsetNoise_2);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.x * _WarpSpeedX);
  tmpvar_10.y = (_Time.x * _WarpSpeedY);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _POITex_ST.xy) + _POITex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _POIAdditive_ST.xy) + _POIAdditive_ST.zw);
  xlv_TEXCOORD2 = (((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw) + tmpvar_10);
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _POITex;
uniform sampler2D _POIAdditive;
uniform sampler2D _AvatarTex;
uniform lowp float _AvatarLerp;
uniform sampler2D _AvatarMask;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 col_1;
  lowp vec2 warpedUv_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_WarpTex, xlv_TEXCOORD2);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_POIAdditive, xlv_TEXCOORD1);
  highp vec2 tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0 + ((tmpvar_3.xy - 0.5) * _WarpStrength));
  warpedUv_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (texture2D (_POITex, warpedUv_2), texture2D (_AvatarTex, xlv_TEXCOORD3), vec4((_AvatarLerp * texture2D (_AvatarMask, xlv_TEXCOORD4).w)));
  col_1.w = tmpvar_6.w;
  col_1.xyz = mix (tmpvar_6.xyz, tmpvar_4.xyz, tmpvar_4.www);
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _POITex_ST;
uniform highp vec4 _POIAdditive_ST;
uniform lowp vec4 _AvatarOffset;
uniform lowp float _AvatarOffsetNoiseSpeed;
uniform lowp float _AvatarOffsetNoiseScale;
uniform highp vec4 _WarpTex_ST;
uniform lowp float _WarpSpeedX;
uniform lowp float _WarpSpeedY;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp mat4 tmpvar_1;
  tmpvar_1[0].x = unity_MatrixMV[0].x;
  tmpvar_1[0].y = unity_MatrixMV[1].x;
  tmpvar_1[0].z = unity_MatrixMV[2].x;
  tmpvar_1[0].w = unity_MatrixMV[3].x;
  tmpvar_1[1].x = unity_MatrixMV[0].y;
  tmpvar_1[1].y = unity_MatrixMV[1].y;
  tmpvar_1[1].z = unity_MatrixMV[2].y;
  tmpvar_1[1].w = unity_MatrixMV[3].y;
  tmpvar_1[2].x = unity_MatrixMV[0].z;
  tmpvar_1[2].y = unity_MatrixMV[1].z;
  tmpvar_1[2].z = unity_MatrixMV[2].z;
  tmpvar_1[2].w = unity_MatrixMV[3].z;
  tmpvar_1[3].x = unity_MatrixMV[0].w;
  tmpvar_1[3].y = unity_MatrixMV[1].w;
  tmpvar_1[3].z = unity_MatrixMV[2].w;
  tmpvar_1[3].w = unity_MatrixMV[3].w;
  lowp vec2 offsetNoise_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.x * _AvatarOffsetNoiseSpeed);
  tmpvar_7.x = sin(tmpvar_8);
  tmpvar_7.y = (sin((tmpvar_8 * 0.37)) * cos((tmpvar_8 * 0.97)));
  highp vec2 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _AvatarOffsetNoiseScale);
  offsetNoise_2 = tmpvar_9;
  tmpvar_3 = (((
    (tmpvar_1 * _glesVertex)
   / tmpvar_5.w).xy * _AvatarOffset.zw) + _AvatarOffset.xy);
  tmpvar_4 = tmpvar_3;
  tmpvar_3 = (tmpvar_3 + offsetNoise_2);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.x * _WarpSpeedX);
  tmpvar_10.y = (_Time.x * _WarpSpeedY);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _POITex_ST.xy) + _POITex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _POIAdditive_ST.xy) + _POIAdditive_ST.zw);
  xlv_TEXCOORD2 = (((_glesMultiTexCoord0.xy * _WarpTex_ST.xy) + _WarpTex_ST.zw) + tmpvar_10);
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _POITex;
uniform sampler2D _POIAdditive;
uniform sampler2D _AvatarTex;
uniform lowp float _AvatarLerp;
uniform sampler2D _AvatarMask;
uniform sampler2D _WarpTex;
uniform lowp float _WarpStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 col_1;
  lowp vec2 warpedUv_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_WarpTex, xlv_TEXCOORD2);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_POIAdditive, xlv_TEXCOORD1);
  highp vec2 tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0 + ((tmpvar_3.xy - 0.5) * _WarpStrength));
  warpedUv_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = mix (texture2D (_POITex, warpedUv_2), texture2D (_AvatarTex, xlv_TEXCOORD3), vec4((_AvatarLerp * texture2D (_AvatarMask, xlv_TEXCOORD4).w)));
  col_1.w = tmpvar_6.w;
  col_1.xyz = mix (tmpvar_6.xyz, tmpvar_4.xyz, tmpvar_4.www);
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