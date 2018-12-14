Shader "Niantic/Progressbar" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Ratio ("Element Ratio", Float) = 0.1
_Progress ("Progress", Range(0, 1)) = 0.5
_ProgressSteps ("Progress Steps", Float) = 8
_GapWidth ("Gap Width", Float) = 0.05
_ProgressColor ("Progress Color", Color) = (0.2,0.83,0.2,1)
_BackgroundColor ("Background Color", Color) = (1,1,1,1)
_GapColor ("Gap Color", Color) = (0.7,0.7,0.7,1)
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "DEFAULT"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 54618
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp float _Ratio;
uniform highp float _Progress;
uniform highp float _ProgressSteps;
uniform highp float _GapWidth;
uniform lowp vec4 _ProgressColor;
uniform highp vec4 _BackgroundColor;
uniform highp vec4 _GapColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec3 col_2;
  highp float tmpvar_3;
  tmpvar_3 = (0.5 - abs((xlv_TEXCOORD0.x - 0.5)));
  highp vec2 tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Ratio * 0.5);
  tmpvar_4.x = ((tmpvar_5 - tmpvar_3) / _Ratio);
  tmpvar_4.y = (xlv_TEXCOORD0.y - 0.5);
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_ProgressColor.xyz, _BackgroundColor.xyz, vec3(float((xlv_TEXCOORD0.x >= _Progress))));
  col_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = col_2;
  highp float edge0_8;
  edge0_8 = ((_GapWidth * _ProgressSteps) / 10.0);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (0.5 - abs((fract(
      (_ProgressSteps * xlv_TEXCOORD0.x)
    ) - 0.5)))
   - edge0_8) / -(edge0_8)), 0.0, 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_7, _GapColor, vec4((tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )))).xyz;
  col_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = col_2;
  tmpvar_11.w = mix (1.0, float((0.25 >= 
    ((tmpvar_4.x * tmpvar_4.x) + (tmpvar_4.y * tmpvar_4.y))
  )), float((tmpvar_5 >= tmpvar_3)));
  tmpvar_1 = tmpvar_11;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp float _Ratio;
uniform highp float _Progress;
uniform highp float _ProgressSteps;
uniform highp float _GapWidth;
uniform lowp vec4 _ProgressColor;
uniform highp vec4 _BackgroundColor;
uniform highp vec4 _GapColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec3 col_2;
  highp float tmpvar_3;
  tmpvar_3 = (0.5 - abs((xlv_TEXCOORD0.x - 0.5)));
  highp vec2 tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Ratio * 0.5);
  tmpvar_4.x = ((tmpvar_5 - tmpvar_3) / _Ratio);
  tmpvar_4.y = (xlv_TEXCOORD0.y - 0.5);
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_ProgressColor.xyz, _BackgroundColor.xyz, vec3(float((xlv_TEXCOORD0.x >= _Progress))));
  col_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = col_2;
  highp float edge0_8;
  edge0_8 = ((_GapWidth * _ProgressSteps) / 10.0);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (0.5 - abs((fract(
      (_ProgressSteps * xlv_TEXCOORD0.x)
    ) - 0.5)))
   - edge0_8) / -(edge0_8)), 0.0, 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_7, _GapColor, vec4((tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )))).xyz;
  col_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = col_2;
  tmpvar_11.w = mix (1.0, float((0.25 >= 
    ((tmpvar_4.x * tmpvar_4.x) + (tmpvar_4.y * tmpvar_4.y))
  )), float((tmpvar_5 >= tmpvar_3)));
  tmpvar_1 = tmpvar_11;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp float _Ratio;
uniform highp float _Progress;
uniform highp float _ProgressSteps;
uniform highp float _GapWidth;
uniform lowp vec4 _ProgressColor;
uniform highp vec4 _BackgroundColor;
uniform highp vec4 _GapColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec3 col_2;
  highp float tmpvar_3;
  tmpvar_3 = (0.5 - abs((xlv_TEXCOORD0.x - 0.5)));
  highp vec2 tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Ratio * 0.5);
  tmpvar_4.x = ((tmpvar_5 - tmpvar_3) / _Ratio);
  tmpvar_4.y = (xlv_TEXCOORD0.y - 0.5);
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_ProgressColor.xyz, _BackgroundColor.xyz, vec3(float((xlv_TEXCOORD0.x >= _Progress))));
  col_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = col_2;
  highp float edge0_8;
  edge0_8 = ((_GapWidth * _ProgressSteps) / 10.0);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (0.5 - abs((fract(
      (_ProgressSteps * xlv_TEXCOORD0.x)
    ) - 0.5)))
   - edge0_8) / -(edge0_8)), 0.0, 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_7, _GapColor, vec4((tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )))).xyz;
  col_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = col_2;
  tmpvar_11.w = mix (1.0, float((0.25 >= 
    ((tmpvar_4.x * tmpvar_4.x) + (tmpvar_4.y * tmpvar_4.y))
  )), float((tmpvar_5 >= tmpvar_3)));
  tmpvar_1 = tmpvar_11;
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