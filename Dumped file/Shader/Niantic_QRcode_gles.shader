Shader "Niantic/QRcode" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_QRColor ("QR Color", Color) = (0.2,0.83,0.2,1)
_LogoTex ("Logo Texture", 2D) = "white" { }
_LogoScale ("Logo Scale", Float) = 8
_QRPixelCount ("QR Pixel Count", Float) = 42.7
_QRPixelOffset ("QR Pixel Offset", Vector) = (0,0,0,0)
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
  GpuProgramID 61443
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
uniform sampler2D _MainTex;
uniform lowp vec4 _QRColor;
uniform sampler2D _LogoTex;
uniform highp float _LogoScale;
uniform highp float _QRPixelCount;
uniform highp vec4 _QRPixelOffset;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 preLogo_2;
  lowp vec4 cornerLook_3;
  lowp vec4 insideLook_4;
  highp vec4 logo_5;
  highp vec2 fp_6;
  highp vec4 p_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0 - 0.5);
  tmpvar_8 = abs(tmpvar_9);
  highp vec4 tmpvar_10;
  tmpvar_10.xy = tmpvar_8;
  tmpvar_10.z = xlv_TEXCOORD0.x;
  tmpvar_10.w = (1.0 - xlv_TEXCOORD0.y);
  highp vec4 tmpvar_11;
  tmpvar_11.xy = vec2(greaterThanEqual (tmpvar_8, vec2(0.25, 0.25)));
  tmpvar_11.zw = vec2(greaterThanEqual (tmpvar_10.zw, vec2(0.25, 0.25)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  p_7 = tmpvar_12;
  fp_6 = (fract((_QRPixelCount * 
    (xlv_TEXCOORD0 + _QRPixelOffset.xy)
  )) - 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13 = (_LogoScale * tmpvar_9);
  highp vec2 tmpvar_14;
  tmpvar_14.x = dot (fp_6, fp_6);
  tmpvar_14.y = dot (tmpvar_13, tmpvar_13);
  highp vec2 tmpvar_15;
  tmpvar_15 = sqrt(tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_13 + 0.5), 0.0, 1.0);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_LogoTex, tmpvar_16);
  logo_5 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_15.x - 0.45) / 0.2), 0.0, 1.0);
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (vec4(1.0, 1.0, 1.0, 1.0), _QRColor, vec4(min (float(
    (0.5 >= p_7.x)
  ), (1.0 - 
    (tmpvar_18 * (tmpvar_18 * (3.0 - (2.0 * tmpvar_18))))
  ))));
  insideLook_4 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (vec4(1.0, 1.0, 1.0, 1.0), _QRColor, vec4(float((0.5 >= p_7.x))));
  cornerLook_3 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (insideLook_4, cornerLook_3, vec4(((tmpvar_11.x * tmpvar_11.y) * (1.0 - 
    (tmpvar_11.z * tmpvar_11.w)
  ))));
  preLogo_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((tmpvar_15.y - 0.45) / 0.1), 0.0, 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (preLogo_2, logo_5, vec4((1.0 - (tmpvar_22 * 
    (tmpvar_22 * (3.0 - (2.0 * tmpvar_22)))
  ))));
  tmpvar_1 = tmpvar_23;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _QRColor;
uniform sampler2D _LogoTex;
uniform highp float _LogoScale;
uniform highp float _QRPixelCount;
uniform highp vec4 _QRPixelOffset;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 preLogo_2;
  lowp vec4 cornerLook_3;
  lowp vec4 insideLook_4;
  highp vec4 logo_5;
  highp vec2 fp_6;
  highp vec4 p_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0 - 0.5);
  tmpvar_8 = abs(tmpvar_9);
  highp vec4 tmpvar_10;
  tmpvar_10.xy = tmpvar_8;
  tmpvar_10.z = xlv_TEXCOORD0.x;
  tmpvar_10.w = (1.0 - xlv_TEXCOORD0.y);
  highp vec4 tmpvar_11;
  tmpvar_11.xy = vec2(greaterThanEqual (tmpvar_8, vec2(0.25, 0.25)));
  tmpvar_11.zw = vec2(greaterThanEqual (tmpvar_10.zw, vec2(0.25, 0.25)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  p_7 = tmpvar_12;
  fp_6 = (fract((_QRPixelCount * 
    (xlv_TEXCOORD0 + _QRPixelOffset.xy)
  )) - 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13 = (_LogoScale * tmpvar_9);
  highp vec2 tmpvar_14;
  tmpvar_14.x = dot (fp_6, fp_6);
  tmpvar_14.y = dot (tmpvar_13, tmpvar_13);
  highp vec2 tmpvar_15;
  tmpvar_15 = sqrt(tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_13 + 0.5), 0.0, 1.0);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_LogoTex, tmpvar_16);
  logo_5 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_15.x - 0.45) / 0.2), 0.0, 1.0);
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (vec4(1.0, 1.0, 1.0, 1.0), _QRColor, vec4(min (float(
    (0.5 >= p_7.x)
  ), (1.0 - 
    (tmpvar_18 * (tmpvar_18 * (3.0 - (2.0 * tmpvar_18))))
  ))));
  insideLook_4 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (vec4(1.0, 1.0, 1.0, 1.0), _QRColor, vec4(float((0.5 >= p_7.x))));
  cornerLook_3 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (insideLook_4, cornerLook_3, vec4(((tmpvar_11.x * tmpvar_11.y) * (1.0 - 
    (tmpvar_11.z * tmpvar_11.w)
  ))));
  preLogo_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((tmpvar_15.y - 0.45) / 0.1), 0.0, 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (preLogo_2, logo_5, vec4((1.0 - (tmpvar_22 * 
    (tmpvar_22 * (3.0 - (2.0 * tmpvar_22)))
  ))));
  tmpvar_1 = tmpvar_23;
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
uniform sampler2D _MainTex;
uniform lowp vec4 _QRColor;
uniform sampler2D _LogoTex;
uniform highp float _LogoScale;
uniform highp float _QRPixelCount;
uniform highp vec4 _QRPixelOffset;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 preLogo_2;
  lowp vec4 cornerLook_3;
  lowp vec4 insideLook_4;
  highp vec4 logo_5;
  highp vec2 fp_6;
  highp vec4 p_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0 - 0.5);
  tmpvar_8 = abs(tmpvar_9);
  highp vec4 tmpvar_10;
  tmpvar_10.xy = tmpvar_8;
  tmpvar_10.z = xlv_TEXCOORD0.x;
  tmpvar_10.w = (1.0 - xlv_TEXCOORD0.y);
  highp vec4 tmpvar_11;
  tmpvar_11.xy = vec2(greaterThanEqual (tmpvar_8, vec2(0.25, 0.25)));
  tmpvar_11.zw = vec2(greaterThanEqual (tmpvar_10.zw, vec2(0.25, 0.25)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  p_7 = tmpvar_12;
  fp_6 = (fract((_QRPixelCount * 
    (xlv_TEXCOORD0 + _QRPixelOffset.xy)
  )) - 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13 = (_LogoScale * tmpvar_9);
  highp vec2 tmpvar_14;
  tmpvar_14.x = dot (fp_6, fp_6);
  tmpvar_14.y = dot (tmpvar_13, tmpvar_13);
  highp vec2 tmpvar_15;
  tmpvar_15 = sqrt(tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_13 + 0.5), 0.0, 1.0);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_LogoTex, tmpvar_16);
  logo_5 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_15.x - 0.45) / 0.2), 0.0, 1.0);
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (vec4(1.0, 1.0, 1.0, 1.0), _QRColor, vec4(min (float(
    (0.5 >= p_7.x)
  ), (1.0 - 
    (tmpvar_18 * (tmpvar_18 * (3.0 - (2.0 * tmpvar_18))))
  ))));
  insideLook_4 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (vec4(1.0, 1.0, 1.0, 1.0), _QRColor, vec4(float((0.5 >= p_7.x))));
  cornerLook_3 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (insideLook_4, cornerLook_3, vec4(((tmpvar_11.x * tmpvar_11.y) * (1.0 - 
    (tmpvar_11.z * tmpvar_11.w)
  ))));
  preLogo_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((tmpvar_15.y - 0.45) / 0.1), 0.0, 1.0);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (preLogo_2, logo_5, vec4((1.0 - (tmpvar_22 * 
    (tmpvar_22 * (3.0 - (2.0 * tmpvar_22)))
  ))));
  tmpvar_1 = tmpvar_23;
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