Shader "Niantic/FriendshipLevel" {
Properties {
_Antialias ("Antialias Strength", Float) = 0.04
_NumHearts ("Number of Hearts", Float) = 4
_CircleSize ("Circle Size", Range(0, 1)) = 0.8
_Progress ("Progress", Range(0, 1)) = 0.5
_HeartbeatIntensity ("Heartbeat Intensity", Float) = 0.005
_HeartbeatSpeed ("Heartbeat Speed", Float) = 3
_BackgroundColor ("Background Color", Color) = (1,1,1,0)
_CircleFullColor ("Circle Full Color", Color) = (1,0.65,0.66,1)
_CircleProgressColor ("Circle Progress Color", Color) = (0.97,0.4,0.98,1)
_CircleNoProgressColor ("Circle No Progress Color", Color) = (0.5,0.5,0.5,1)
_HeartFullColor ("Heart Full Color", Color) = (1,1,1,1)
_HeartUnfullColor ("Heart Unfull Color", Color) = (0.82,0.82,0.82,1)
_MainTex ("Texture", 2D) = "white" { }
_TextureHeight ("Texture Height", Float) = 0
_Stencil ("Stencil ID", Float) = 0
_StencilComp ("Stencil Comparison", Float) = 8
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 5337
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
uniform highp float _HeartbeatIntensity;
uniform highp float _HeartbeatSpeed;
varying lowp vec4 xlv_COLOR;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.z = (_HeartbeatIntensity * dot (vec4(-7.73921, 8.369606, -6.135292, 4.747302), sin(
    ((_HeartbeatSpeed * _Time.w) * vec4(1.0, 2.0, 3.0, 4.0))
  )));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp float _TextureHeight;
uniform highp float _Antialias;
uniform highp int _NumHearts;
uniform highp float _CircleSize;
uniform highp float _Progress;
uniform highp vec4 _BackgroundColor;
uniform highp vec4 _CircleFullColor;
uniform highp vec4 _CircleProgressColor;
uniform highp vec4 _CircleNoProgressColor;
uniform highp vec4 _HeartFullColor;
uniform highp vec4 _HeartUnfullColor;
varying lowp vec4 xlv_COLOR;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD0.x;
  tmpvar_2.y = _Progress;
  highp vec2 x_3;
  highp float tmpvar_4;
  tmpvar_4 = float(_NumHearts);
  x_3 = (tmpvar_2 * tmpvar_4);
  highp vec2 tmpvar_5;
  tmpvar_5 = vec2(ivec2(x_3));
  highp float tmpvar_6;
  tmpvar_6 = float(((tmpvar_5.y / tmpvar_4) >= xlv_TEXCOORD0.x));
  highp vec2 tmpvar_7;
  tmpvar_7.x = (x_3 - tmpvar_5).x;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((2.0 * tmpvar_7) - 1.0);
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_8.x * tmpvar_8.x) + (tmpvar_8.y * tmpvar_8.y));
  highp float edge0_10;
  edge0_10 = (tmpvar_9 - _Antialias);
  highp float tmpvar_11;
  tmpvar_11 = clamp (((_CircleSize - edge0_10) / (
    (tmpvar_9 + _Antialias)
   - edge0_10)), 0.0, 1.0);
  highp vec2 uv_12;
  uv_12 = (mix (tmpvar_8, (tmpvar_8 * 
    (1.0 + xlv_TEXCOORD0.z)
  ), vec2((1.0 - 
    abs(sign((tmpvar_5.y - tmpvar_5.x)))
  ))) * 2.0);
  uv_12.y = (uv_12.y + 0.25);
  highp float tmpvar_13;
  tmpvar_13 = ((_Antialias * _TextureHeight) * 0.005);
  highp vec4 tmpvar_14;
  tmpvar_14.x = (uv_12.x + tmpvar_13);
  tmpvar_14.y = (uv_12.x + tmpvar_13);
  tmpvar_14.z = (uv_12.x - tmpvar_13);
  tmpvar_14.w = (uv_12.x - tmpvar_13);
  highp vec4 tmpvar_15;
  tmpvar_15.x = (uv_12.y + tmpvar_13);
  tmpvar_15.y = (uv_12.y - tmpvar_13);
  tmpvar_15.z = (uv_12.y + tmpvar_13);
  tmpvar_15.w = (uv_12.y - tmpvar_13);
  highp vec4 heart_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) - 1.0);
  heart_16 = (tmpvar_17 * (tmpvar_17 * tmpvar_17));
  heart_16 = (heart_16 - ((tmpvar_14 * tmpvar_14) * (
    (tmpvar_15 * tmpvar_15)
   * tmpvar_15)));
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (mix (_BackgroundColor, mix (
    mix (_CircleNoProgressColor, _CircleProgressColor, vec4(float((_Progress >= xlv_TEXCOORD0.x))))
  , _CircleFullColor, vec4(tmpvar_6)), vec4((tmpvar_11 * 
    (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
  ))), mix (_HeartUnfullColor, _HeartFullColor, vec4(tmpvar_6)), vec4(dot (vec4(
    greaterThanEqual (vec4(0.0, 0.0, 0.0, 0.0), heart_16)
  ), vec4(0.25, 0.25, 0.25, 0.25))));
  tmpvar_1 = (tmpvar_18 * xlv_COLOR);
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
uniform highp float _HeartbeatIntensity;
uniform highp float _HeartbeatSpeed;
varying lowp vec4 xlv_COLOR;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.z = (_HeartbeatIntensity * dot (vec4(-7.73921, 8.369606, -6.135292, 4.747302), sin(
    ((_HeartbeatSpeed * _Time.w) * vec4(1.0, 2.0, 3.0, 4.0))
  )));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp float _TextureHeight;
uniform highp float _Antialias;
uniform highp int _NumHearts;
uniform highp float _CircleSize;
uniform highp float _Progress;
uniform highp vec4 _BackgroundColor;
uniform highp vec4 _CircleFullColor;
uniform highp vec4 _CircleProgressColor;
uniform highp vec4 _CircleNoProgressColor;
uniform highp vec4 _HeartFullColor;
uniform highp vec4 _HeartUnfullColor;
varying lowp vec4 xlv_COLOR;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD0.x;
  tmpvar_2.y = _Progress;
  highp vec2 x_3;
  highp float tmpvar_4;
  tmpvar_4 = float(_NumHearts);
  x_3 = (tmpvar_2 * tmpvar_4);
  highp vec2 tmpvar_5;
  tmpvar_5 = vec2(ivec2(x_3));
  highp float tmpvar_6;
  tmpvar_6 = float(((tmpvar_5.y / tmpvar_4) >= xlv_TEXCOORD0.x));
  highp vec2 tmpvar_7;
  tmpvar_7.x = (x_3 - tmpvar_5).x;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((2.0 * tmpvar_7) - 1.0);
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_8.x * tmpvar_8.x) + (tmpvar_8.y * tmpvar_8.y));
  highp float edge0_10;
  edge0_10 = (tmpvar_9 - _Antialias);
  highp float tmpvar_11;
  tmpvar_11 = clamp (((_CircleSize - edge0_10) / (
    (tmpvar_9 + _Antialias)
   - edge0_10)), 0.0, 1.0);
  highp vec2 uv_12;
  uv_12 = (mix (tmpvar_8, (tmpvar_8 * 
    (1.0 + xlv_TEXCOORD0.z)
  ), vec2((1.0 - 
    abs(sign((tmpvar_5.y - tmpvar_5.x)))
  ))) * 2.0);
  uv_12.y = (uv_12.y + 0.25);
  highp float tmpvar_13;
  tmpvar_13 = ((_Antialias * _TextureHeight) * 0.005);
  highp vec4 tmpvar_14;
  tmpvar_14.x = (uv_12.x + tmpvar_13);
  tmpvar_14.y = (uv_12.x + tmpvar_13);
  tmpvar_14.z = (uv_12.x - tmpvar_13);
  tmpvar_14.w = (uv_12.x - tmpvar_13);
  highp vec4 tmpvar_15;
  tmpvar_15.x = (uv_12.y + tmpvar_13);
  tmpvar_15.y = (uv_12.y - tmpvar_13);
  tmpvar_15.z = (uv_12.y + tmpvar_13);
  tmpvar_15.w = (uv_12.y - tmpvar_13);
  highp vec4 heart_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) - 1.0);
  heart_16 = (tmpvar_17 * (tmpvar_17 * tmpvar_17));
  heart_16 = (heart_16 - ((tmpvar_14 * tmpvar_14) * (
    (tmpvar_15 * tmpvar_15)
   * tmpvar_15)));
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (mix (_BackgroundColor, mix (
    mix (_CircleNoProgressColor, _CircleProgressColor, vec4(float((_Progress >= xlv_TEXCOORD0.x))))
  , _CircleFullColor, vec4(tmpvar_6)), vec4((tmpvar_11 * 
    (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
  ))), mix (_HeartUnfullColor, _HeartFullColor, vec4(tmpvar_6)), vec4(dot (vec4(
    greaterThanEqual (vec4(0.0, 0.0, 0.0, 0.0), heart_16)
  ), vec4(0.25, 0.25, 0.25, 0.25))));
  tmpvar_1 = (tmpvar_18 * xlv_COLOR);
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
uniform highp float _HeartbeatIntensity;
uniform highp float _HeartbeatSpeed;
varying lowp vec4 xlv_COLOR;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.z = (_HeartbeatIntensity * dot (vec4(-7.73921, 8.369606, -6.135292, 4.747302), sin(
    ((_HeartbeatSpeed * _Time.w) * vec4(1.0, 2.0, 3.0, 4.0))
  )));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp float _TextureHeight;
uniform highp float _Antialias;
uniform highp int _NumHearts;
uniform highp float _CircleSize;
uniform highp float _Progress;
uniform highp vec4 _BackgroundColor;
uniform highp vec4 _CircleFullColor;
uniform highp vec4 _CircleProgressColor;
uniform highp vec4 _CircleNoProgressColor;
uniform highp vec4 _HeartFullColor;
uniform highp vec4 _HeartUnfullColor;
varying lowp vec4 xlv_COLOR;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD0.x;
  tmpvar_2.y = _Progress;
  highp vec2 x_3;
  highp float tmpvar_4;
  tmpvar_4 = float(_NumHearts);
  x_3 = (tmpvar_2 * tmpvar_4);
  highp vec2 tmpvar_5;
  tmpvar_5 = vec2(ivec2(x_3));
  highp float tmpvar_6;
  tmpvar_6 = float(((tmpvar_5.y / tmpvar_4) >= xlv_TEXCOORD0.x));
  highp vec2 tmpvar_7;
  tmpvar_7.x = (x_3 - tmpvar_5).x;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((2.0 * tmpvar_7) - 1.0);
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_8.x * tmpvar_8.x) + (tmpvar_8.y * tmpvar_8.y));
  highp float edge0_10;
  edge0_10 = (tmpvar_9 - _Antialias);
  highp float tmpvar_11;
  tmpvar_11 = clamp (((_CircleSize - edge0_10) / (
    (tmpvar_9 + _Antialias)
   - edge0_10)), 0.0, 1.0);
  highp vec2 uv_12;
  uv_12 = (mix (tmpvar_8, (tmpvar_8 * 
    (1.0 + xlv_TEXCOORD0.z)
  ), vec2((1.0 - 
    abs(sign((tmpvar_5.y - tmpvar_5.x)))
  ))) * 2.0);
  uv_12.y = (uv_12.y + 0.25);
  highp float tmpvar_13;
  tmpvar_13 = ((_Antialias * _TextureHeight) * 0.005);
  highp vec4 tmpvar_14;
  tmpvar_14.x = (uv_12.x + tmpvar_13);
  tmpvar_14.y = (uv_12.x + tmpvar_13);
  tmpvar_14.z = (uv_12.x - tmpvar_13);
  tmpvar_14.w = (uv_12.x - tmpvar_13);
  highp vec4 tmpvar_15;
  tmpvar_15.x = (uv_12.y + tmpvar_13);
  tmpvar_15.y = (uv_12.y - tmpvar_13);
  tmpvar_15.z = (uv_12.y + tmpvar_13);
  tmpvar_15.w = (uv_12.y - tmpvar_13);
  highp vec4 heart_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) - 1.0);
  heart_16 = (tmpvar_17 * (tmpvar_17 * tmpvar_17));
  heart_16 = (heart_16 - ((tmpvar_14 * tmpvar_14) * (
    (tmpvar_15 * tmpvar_15)
   * tmpvar_15)));
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (mix (_BackgroundColor, mix (
    mix (_CircleNoProgressColor, _CircleProgressColor, vec4(float((_Progress >= xlv_TEXCOORD0.x))))
  , _CircleFullColor, vec4(tmpvar_6)), vec4((tmpvar_11 * 
    (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
  ))), mix (_HeartUnfullColor, _HeartFullColor, vec4(tmpvar_6)), vec4(dot (vec4(
    greaterThanEqual (vec4(0.0, 0.0, 0.0, 0.0), heart_16)
  ), vec4(0.25, 0.25, 0.25, 0.25))));
  tmpvar_1 = (tmpvar_18 * xlv_COLOR);
  gl_FragData[0] = tmpvar_1;
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _HeartbeatIntensity;
uniform highp float _HeartbeatSpeed;
varying lowp vec4 xlv_COLOR;
varying highp vec3 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.z = (_HeartbeatIntensity * dot (vec4(-7.73921, 8.369606, -6.135292, 4.747302), sin(
    ((_HeartbeatSpeed * _Time.w) * vec4(1.0, 2.0, 3.0, 4.0))
  )));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp float _TextureHeight;
uniform highp float _Antialias;
uniform highp int _NumHearts;
uniform highp float _CircleSize;
uniform highp float _Progress;
uniform highp vec4 _BackgroundColor;
uniform highp vec4 _CircleFullColor;
uniform highp vec4 _CircleProgressColor;
uniform highp vec4 _CircleNoProgressColor;
uniform highp vec4 _HeartFullColor;
uniform highp vec4 _HeartUnfullColor;
varying lowp vec4 xlv_COLOR;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD0.x;
  tmpvar_2.y = _Progress;
  highp vec2 x_3;
  highp float tmpvar_4;
  tmpvar_4 = float(_NumHearts);
  x_3 = (tmpvar_2 * tmpvar_4);
  highp vec2 tmpvar_5;
  tmpvar_5 = vec2(ivec2(x_3));
  highp float tmpvar_6;
  tmpvar_6 = float(((tmpvar_5.y / tmpvar_4) >= xlv_TEXCOORD0.x));
  highp vec2 tmpvar_7;
  tmpvar_7.x = (x_3 - tmpvar_5).x;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((2.0 * tmpvar_7) - 1.0);
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_8.x * tmpvar_8.x) + (tmpvar_8.y * tmpvar_8.y));
  highp float edge0_10;
  edge0_10 = (tmpvar_9 - _Antialias);
  highp float tmpvar_11;
  tmpvar_11 = clamp (((_CircleSize - edge0_10) / (
    (tmpvar_9 + _Antialias)
   - edge0_10)), 0.0, 1.0);
  highp vec2 uv_12;
  uv_12 = (mix (tmpvar_8, (tmpvar_8 * 
    (1.0 + xlv_TEXCOORD0.z)
  ), vec2((1.0 - 
    abs(sign((tmpvar_5.y - tmpvar_5.x)))
  ))) * 2.0);
  uv_12.y = (uv_12.y + 0.25);
  highp float tmpvar_13;
  tmpvar_13 = ((_Antialias * _TextureHeight) * 0.005);
  highp vec4 tmpvar_14;
  tmpvar_14.x = (uv_12.x + tmpvar_13);
  tmpvar_14.y = (uv_12.x + tmpvar_13);
  tmpvar_14.z = (uv_12.x - tmpvar_13);
  tmpvar_14.w = (uv_12.x - tmpvar_13);
  highp vec4 tmpvar_15;
  tmpvar_15.x = (uv_12.y + tmpvar_13);
  tmpvar_15.y = (uv_12.y - tmpvar_13);
  tmpvar_15.z = (uv_12.y + tmpvar_13);
  tmpvar_15.w = (uv_12.y - tmpvar_13);
  highp vec4 heart_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) - 1.0);
  heart_16 = (tmpvar_17 * (tmpvar_17 * tmpvar_17));
  heart_16 = (heart_16 - ((tmpvar_14 * tmpvar_14) * (
    (tmpvar_15 * tmpvar_15)
   * tmpvar_15)));
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (mix (_BackgroundColor, mix (
    mix (_CircleNoProgressColor, _CircleProgressColor, vec4(float((_Progress >= xlv_TEXCOORD0.x))))
  , _CircleFullColor, vec4(tmpvar_6)), vec4((tmpvar_11 * 
    (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
  ))), mix (_HeartUnfullColor, _HeartFullColor, vec4(tmpvar_6)), vec4(dot (vec4(
    greaterThanEqual (vec4(0.0, 0.0, 0.0, 0.0), heart_16)
  ), vec4(0.25, 0.25, 0.25, 0.25))));
  tmpvar_1 = (tmpvar_18 * xlv_COLOR);
  gl_FragData[0] = tmpvar_1;
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _HeartbeatIntensity;
uniform highp float _HeartbeatSpeed;
varying lowp vec4 xlv_COLOR;
varying highp vec3 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.z = (_HeartbeatIntensity * dot (vec4(-7.73921, 8.369606, -6.135292, 4.747302), sin(
    ((_HeartbeatSpeed * _Time.w) * vec4(1.0, 2.0, 3.0, 4.0))
  )));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp float _TextureHeight;
uniform highp float _Antialias;
uniform highp int _NumHearts;
uniform highp float _CircleSize;
uniform highp float _Progress;
uniform highp vec4 _BackgroundColor;
uniform highp vec4 _CircleFullColor;
uniform highp vec4 _CircleProgressColor;
uniform highp vec4 _CircleNoProgressColor;
uniform highp vec4 _HeartFullColor;
uniform highp vec4 _HeartUnfullColor;
varying lowp vec4 xlv_COLOR;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD0.x;
  tmpvar_2.y = _Progress;
  highp vec2 x_3;
  highp float tmpvar_4;
  tmpvar_4 = float(_NumHearts);
  x_3 = (tmpvar_2 * tmpvar_4);
  highp vec2 tmpvar_5;
  tmpvar_5 = vec2(ivec2(x_3));
  highp float tmpvar_6;
  tmpvar_6 = float(((tmpvar_5.y / tmpvar_4) >= xlv_TEXCOORD0.x));
  highp vec2 tmpvar_7;
  tmpvar_7.x = (x_3 - tmpvar_5).x;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((2.0 * tmpvar_7) - 1.0);
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_8.x * tmpvar_8.x) + (tmpvar_8.y * tmpvar_8.y));
  highp float edge0_10;
  edge0_10 = (tmpvar_9 - _Antialias);
  highp float tmpvar_11;
  tmpvar_11 = clamp (((_CircleSize - edge0_10) / (
    (tmpvar_9 + _Antialias)
   - edge0_10)), 0.0, 1.0);
  highp vec2 uv_12;
  uv_12 = (mix (tmpvar_8, (tmpvar_8 * 
    (1.0 + xlv_TEXCOORD0.z)
  ), vec2((1.0 - 
    abs(sign((tmpvar_5.y - tmpvar_5.x)))
  ))) * 2.0);
  uv_12.y = (uv_12.y + 0.25);
  highp float tmpvar_13;
  tmpvar_13 = ((_Antialias * _TextureHeight) * 0.005);
  highp vec4 tmpvar_14;
  tmpvar_14.x = (uv_12.x + tmpvar_13);
  tmpvar_14.y = (uv_12.x + tmpvar_13);
  tmpvar_14.z = (uv_12.x - tmpvar_13);
  tmpvar_14.w = (uv_12.x - tmpvar_13);
  highp vec4 tmpvar_15;
  tmpvar_15.x = (uv_12.y + tmpvar_13);
  tmpvar_15.y = (uv_12.y - tmpvar_13);
  tmpvar_15.z = (uv_12.y + tmpvar_13);
  tmpvar_15.w = (uv_12.y - tmpvar_13);
  highp vec4 heart_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) - 1.0);
  heart_16 = (tmpvar_17 * (tmpvar_17 * tmpvar_17));
  heart_16 = (heart_16 - ((tmpvar_14 * tmpvar_14) * (
    (tmpvar_15 * tmpvar_15)
   * tmpvar_15)));
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (mix (_BackgroundColor, mix (
    mix (_CircleNoProgressColor, _CircleProgressColor, vec4(float((_Progress >= xlv_TEXCOORD0.x))))
  , _CircleFullColor, vec4(tmpvar_6)), vec4((tmpvar_11 * 
    (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
  ))), mix (_HeartUnfullColor, _HeartFullColor, vec4(tmpvar_6)), vec4(dot (vec4(
    greaterThanEqual (vec4(0.0, 0.0, 0.0, 0.0), heart_16)
  ), vec4(0.25, 0.25, 0.25, 0.25))));
  tmpvar_1 = (tmpvar_18 * xlv_COLOR);
  gl_FragData[0] = tmpvar_1;
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _HeartbeatIntensity;
uniform highp float _HeartbeatSpeed;
varying lowp vec4 xlv_COLOR;
varying highp vec3 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.z = (_HeartbeatIntensity * dot (vec4(-7.73921, 8.369606, -6.135292, 4.747302), sin(
    ((_HeartbeatSpeed * _Time.w) * vec4(1.0, 2.0, 3.0, 4.0))
  )));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp float _TextureHeight;
uniform highp float _Antialias;
uniform highp int _NumHearts;
uniform highp float _CircleSize;
uniform highp float _Progress;
uniform highp vec4 _BackgroundColor;
uniform highp vec4 _CircleFullColor;
uniform highp vec4 _CircleProgressColor;
uniform highp vec4 _CircleNoProgressColor;
uniform highp vec4 _HeartFullColor;
uniform highp vec4 _HeartUnfullColor;
varying lowp vec4 xlv_COLOR;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD0.x;
  tmpvar_2.y = _Progress;
  highp vec2 x_3;
  highp float tmpvar_4;
  tmpvar_4 = float(_NumHearts);
  x_3 = (tmpvar_2 * tmpvar_4);
  highp vec2 tmpvar_5;
  tmpvar_5 = vec2(ivec2(x_3));
  highp float tmpvar_6;
  tmpvar_6 = float(((tmpvar_5.y / tmpvar_4) >= xlv_TEXCOORD0.x));
  highp vec2 tmpvar_7;
  tmpvar_7.x = (x_3 - tmpvar_5).x;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((2.0 * tmpvar_7) - 1.0);
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_8.x * tmpvar_8.x) + (tmpvar_8.y * tmpvar_8.y));
  highp float edge0_10;
  edge0_10 = (tmpvar_9 - _Antialias);
  highp float tmpvar_11;
  tmpvar_11 = clamp (((_CircleSize - edge0_10) / (
    (tmpvar_9 + _Antialias)
   - edge0_10)), 0.0, 1.0);
  highp vec2 uv_12;
  uv_12 = (mix (tmpvar_8, (tmpvar_8 * 
    (1.0 + xlv_TEXCOORD0.z)
  ), vec2((1.0 - 
    abs(sign((tmpvar_5.y - tmpvar_5.x)))
  ))) * 2.0);
  uv_12.y = (uv_12.y + 0.25);
  highp float tmpvar_13;
  tmpvar_13 = ((_Antialias * _TextureHeight) * 0.005);
  highp vec4 tmpvar_14;
  tmpvar_14.x = (uv_12.x + tmpvar_13);
  tmpvar_14.y = (uv_12.x + tmpvar_13);
  tmpvar_14.z = (uv_12.x - tmpvar_13);
  tmpvar_14.w = (uv_12.x - tmpvar_13);
  highp vec4 tmpvar_15;
  tmpvar_15.x = (uv_12.y + tmpvar_13);
  tmpvar_15.y = (uv_12.y - tmpvar_13);
  tmpvar_15.z = (uv_12.y + tmpvar_13);
  tmpvar_15.w = (uv_12.y - tmpvar_13);
  highp vec4 heart_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) - 1.0);
  heart_16 = (tmpvar_17 * (tmpvar_17 * tmpvar_17));
  heart_16 = (heart_16 - ((tmpvar_14 * tmpvar_14) * (
    (tmpvar_15 * tmpvar_15)
   * tmpvar_15)));
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (mix (_BackgroundColor, mix (
    mix (_CircleNoProgressColor, _CircleProgressColor, vec4(float((_Progress >= xlv_TEXCOORD0.x))))
  , _CircleFullColor, vec4(tmpvar_6)), vec4((tmpvar_11 * 
    (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
  ))), mix (_HeartUnfullColor, _HeartFullColor, vec4(tmpvar_6)), vec4(dot (vec4(
    greaterThanEqual (vec4(0.0, 0.0, 0.0, 0.0), heart_16)
  ), vec4(0.25, 0.25, 0.25, 0.25))));
  tmpvar_1 = (tmpvar_18 * xlv_COLOR);
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