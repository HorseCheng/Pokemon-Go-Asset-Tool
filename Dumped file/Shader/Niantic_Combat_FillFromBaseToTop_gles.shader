Shader "Niantic/Combat/FillFromBaseToTop" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_UnfillColor ("Unfilled Color", Color) = (1,1,1,1)
_UnfillOuter ("Unfilled Outer", Range(0, 1)) = 0.5
_UnfilledOuterFeather ("Unfilled Outer Feather", Float) = 0.1
_UnfilledOuterThickness ("Unfilled Outer Thickness", Float) = 0.1
_FillAmt ("Fill Amount", Range(0, 1)) = 0
_TimerFillValue ("Attack Wait Fill Value", Range(0, 1)) = 0
_ScreenExtends ("Extends of Icon on Screen", Vector) = (0,0,1,1)
}
SubShader {
 Tags { "QUEUE" = "Transparent+100" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+100" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 34379
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1 = (o_4.xy / tmpvar_2.w);
  tmpvar_1.y = (1.0 - tmpvar_1.y);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _UnfillColor;
uniform highp float _UnfillOuter;
uniform highp float _UnfilledOuterFeather;
uniform highp float _UnfilledOuterThickness;
uniform highp float _FillAmt;
uniform highp float _TimerFillValue;
uniform highp vec4 _ScreenExtends;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 finColor_1;
  mediump vec4 Color_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = (1.0 - ((xlv_TEXCOORD1 - _ScreenExtends.xy) / _ScreenExtends.zw));
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - 0.5);
  highp float tmpvar_5;
  highp float edge0_6;
  edge0_6 = (tmpvar_3.y - 0.01);
  highp float tmpvar_7;
  tmpvar_7 = clamp (((_FillAmt - edge0_6) / (
    (tmpvar_3.y + 0.01)
   - edge0_6)), 0.0, 1.0);
  tmpvar_5 = (tmpvar_7 * (tmpvar_7 * (3.0 - 
    (2.0 * tmpvar_7)
  )));
  highp float tmpvar_8;
  tmpvar_8 = mix (_UnfillColor.w, 1.0, tmpvar_5);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  Color_2 = tmpvar_9;
  highp float tmpvar_10;
  highp float edge0_11;
  edge0_11 = (_UnfilledOuterThickness - _UnfilledOuterFeather);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    sqrt(((tmpvar_4.x * tmpvar_4.x) + (tmpvar_4.y * tmpvar_4.y)))
   - edge0_11) / (
    (_UnfilledOuterThickness + _UnfilledOuterFeather)
   - edge0_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (((Color_2.xyz * _UnfillColor.xyz) * mix (1.0, _UnfillOuter, tmpvar_10)), Color_2.xyz, vec3(tmpvar_5));
  Color_2.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (tmpvar_10 * float((_FillAmt >= 1.0)));
  highp float vec_y_15;
  vec_y_15 = -(tmpvar_4.x);
  highp float vec_x_16;
  vec_x_16 = -(tmpvar_4.y);
  highp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (min (abs(
    (vec_y_15 / vec_x_16)
  ), 1.0) / max (abs(
    (vec_y_15 / vec_x_16)
  ), 1.0));
  highp float tmpvar_19;
  tmpvar_19 = (tmpvar_18 * tmpvar_18);
  tmpvar_19 = (((
    ((((
      ((((-0.01213232 * tmpvar_19) + 0.05368138) * tmpvar_19) - 0.1173503)
     * tmpvar_19) + 0.1938925) * tmpvar_19) - 0.3326756)
   * tmpvar_19) + 0.9999793) * tmpvar_18);
  tmpvar_19 = (tmpvar_19 + (float(
    (abs((vec_y_15 / vec_x_16)) > 1.0)
  ) * (
    (tmpvar_19 * -2.0)
   + 1.570796)));
  tmpvar_17 = (tmpvar_19 * sign((vec_y_15 / vec_x_16)));
  if ((abs(vec_x_16) > (1e-08 * abs(vec_y_15)))) {
    if ((vec_x_16 < 0.0)) {
      if ((vec_y_15 >= 0.0)) {
        tmpvar_17 += 3.141593;
      } else {
        tmpvar_17 = (tmpvar_17 - 3.141593);
      };
    };
  } else {
    tmpvar_17 = (sign(vec_y_15) * 1.570796);
  };
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (Color_2, vec4(1.0, 1.0, 1.0, 0.0), vec4(tmpvar_14)).xyz;
  finColor_1 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = float((_TimerFillValue >= (
    (tmpvar_17 + 3.141593)
   / 6.283185)));
  finColor_1 = (finColor_1 + (0.2 * tmpvar_21));
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = finColor_1;
  tmpvar_22.w = min (Color_2.w, tmpvar_8);
  gl_FragData[0] = tmpvar_22;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1 = (o_4.xy / tmpvar_2.w);
  tmpvar_1.y = (1.0 - tmpvar_1.y);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _UnfillColor;
uniform highp float _UnfillOuter;
uniform highp float _UnfilledOuterFeather;
uniform highp float _UnfilledOuterThickness;
uniform highp float _FillAmt;
uniform highp float _TimerFillValue;
uniform highp vec4 _ScreenExtends;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 finColor_1;
  mediump vec4 Color_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = (1.0 - ((xlv_TEXCOORD1 - _ScreenExtends.xy) / _ScreenExtends.zw));
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - 0.5);
  highp float tmpvar_5;
  highp float edge0_6;
  edge0_6 = (tmpvar_3.y - 0.01);
  highp float tmpvar_7;
  tmpvar_7 = clamp (((_FillAmt - edge0_6) / (
    (tmpvar_3.y + 0.01)
   - edge0_6)), 0.0, 1.0);
  tmpvar_5 = (tmpvar_7 * (tmpvar_7 * (3.0 - 
    (2.0 * tmpvar_7)
  )));
  highp float tmpvar_8;
  tmpvar_8 = mix (_UnfillColor.w, 1.0, tmpvar_5);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  Color_2 = tmpvar_9;
  highp float tmpvar_10;
  highp float edge0_11;
  edge0_11 = (_UnfilledOuterThickness - _UnfilledOuterFeather);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    sqrt(((tmpvar_4.x * tmpvar_4.x) + (tmpvar_4.y * tmpvar_4.y)))
   - edge0_11) / (
    (_UnfilledOuterThickness + _UnfilledOuterFeather)
   - edge0_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (((Color_2.xyz * _UnfillColor.xyz) * mix (1.0, _UnfillOuter, tmpvar_10)), Color_2.xyz, vec3(tmpvar_5));
  Color_2.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (tmpvar_10 * float((_FillAmt >= 1.0)));
  highp float vec_y_15;
  vec_y_15 = -(tmpvar_4.x);
  highp float vec_x_16;
  vec_x_16 = -(tmpvar_4.y);
  highp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (min (abs(
    (vec_y_15 / vec_x_16)
  ), 1.0) / max (abs(
    (vec_y_15 / vec_x_16)
  ), 1.0));
  highp float tmpvar_19;
  tmpvar_19 = (tmpvar_18 * tmpvar_18);
  tmpvar_19 = (((
    ((((
      ((((-0.01213232 * tmpvar_19) + 0.05368138) * tmpvar_19) - 0.1173503)
     * tmpvar_19) + 0.1938925) * tmpvar_19) - 0.3326756)
   * tmpvar_19) + 0.9999793) * tmpvar_18);
  tmpvar_19 = (tmpvar_19 + (float(
    (abs((vec_y_15 / vec_x_16)) > 1.0)
  ) * (
    (tmpvar_19 * -2.0)
   + 1.570796)));
  tmpvar_17 = (tmpvar_19 * sign((vec_y_15 / vec_x_16)));
  if ((abs(vec_x_16) > (1e-08 * abs(vec_y_15)))) {
    if ((vec_x_16 < 0.0)) {
      if ((vec_y_15 >= 0.0)) {
        tmpvar_17 += 3.141593;
      } else {
        tmpvar_17 = (tmpvar_17 - 3.141593);
      };
    };
  } else {
    tmpvar_17 = (sign(vec_y_15) * 1.570796);
  };
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (Color_2, vec4(1.0, 1.0, 1.0, 0.0), vec4(tmpvar_14)).xyz;
  finColor_1 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = float((_TimerFillValue >= (
    (tmpvar_17 + 3.141593)
   / 6.283185)));
  finColor_1 = (finColor_1 + (0.2 * tmpvar_21));
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = finColor_1;
  tmpvar_22.w = min (Color_2.w, tmpvar_8);
  gl_FragData[0] = tmpvar_22;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1 = (o_4.xy / tmpvar_2.w);
  tmpvar_1.y = (1.0 - tmpvar_1.y);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _UnfillColor;
uniform highp float _UnfillOuter;
uniform highp float _UnfilledOuterFeather;
uniform highp float _UnfilledOuterThickness;
uniform highp float _FillAmt;
uniform highp float _TimerFillValue;
uniform highp vec4 _ScreenExtends;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 finColor_1;
  mediump vec4 Color_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = (1.0 - ((xlv_TEXCOORD1 - _ScreenExtends.xy) / _ScreenExtends.zw));
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 - 0.5);
  highp float tmpvar_5;
  highp float edge0_6;
  edge0_6 = (tmpvar_3.y - 0.01);
  highp float tmpvar_7;
  tmpvar_7 = clamp (((_FillAmt - edge0_6) / (
    (tmpvar_3.y + 0.01)
   - edge0_6)), 0.0, 1.0);
  tmpvar_5 = (tmpvar_7 * (tmpvar_7 * (3.0 - 
    (2.0 * tmpvar_7)
  )));
  highp float tmpvar_8;
  tmpvar_8 = mix (_UnfillColor.w, 1.0, tmpvar_5);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  Color_2 = tmpvar_9;
  highp float tmpvar_10;
  highp float edge0_11;
  edge0_11 = (_UnfilledOuterThickness - _UnfilledOuterFeather);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    sqrt(((tmpvar_4.x * tmpvar_4.x) + (tmpvar_4.y * tmpvar_4.y)))
   - edge0_11) / (
    (_UnfilledOuterThickness + _UnfilledOuterFeather)
   - edge0_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (((Color_2.xyz * _UnfillColor.xyz) * mix (1.0, _UnfillOuter, tmpvar_10)), Color_2.xyz, vec3(tmpvar_5));
  Color_2.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (tmpvar_10 * float((_FillAmt >= 1.0)));
  highp float vec_y_15;
  vec_y_15 = -(tmpvar_4.x);
  highp float vec_x_16;
  vec_x_16 = -(tmpvar_4.y);
  highp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (min (abs(
    (vec_y_15 / vec_x_16)
  ), 1.0) / max (abs(
    (vec_y_15 / vec_x_16)
  ), 1.0));
  highp float tmpvar_19;
  tmpvar_19 = (tmpvar_18 * tmpvar_18);
  tmpvar_19 = (((
    ((((
      ((((-0.01213232 * tmpvar_19) + 0.05368138) * tmpvar_19) - 0.1173503)
     * tmpvar_19) + 0.1938925) * tmpvar_19) - 0.3326756)
   * tmpvar_19) + 0.9999793) * tmpvar_18);
  tmpvar_19 = (tmpvar_19 + (float(
    (abs((vec_y_15 / vec_x_16)) > 1.0)
  ) * (
    (tmpvar_19 * -2.0)
   + 1.570796)));
  tmpvar_17 = (tmpvar_19 * sign((vec_y_15 / vec_x_16)));
  if ((abs(vec_x_16) > (1e-08 * abs(vec_y_15)))) {
    if ((vec_x_16 < 0.0)) {
      if ((vec_y_15 >= 0.0)) {
        tmpvar_17 += 3.141593;
      } else {
        tmpvar_17 = (tmpvar_17 - 3.141593);
      };
    };
  } else {
    tmpvar_17 = (sign(vec_y_15) * 1.570796);
  };
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (Color_2, vec4(1.0, 1.0, 1.0, 0.0), vec4(tmpvar_14)).xyz;
  finColor_1 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = float((_TimerFillValue >= (
    (tmpvar_17 + 3.141593)
   / 6.283185)));
  finColor_1 = (finColor_1 + (0.2 * tmpvar_21));
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = finColor_1;
  tmpvar_22.w = min (Color_2.w, tmpvar_8);
  gl_FragData[0] = tmpvar_22;
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
Fallback "Diffuse"
}