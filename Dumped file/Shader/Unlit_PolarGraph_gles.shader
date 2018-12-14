Shader "Unlit/PolarGraph" {
Properties {
_MainColor ("Color", Color) = (1,1,1,1)
_RingColor ("RingColor", Color) = (0,0,0,1)
_CircleCenter ("Circle Center Position", Vector) = (0,0,0,0)
_RingInterval ("Interval", Float) = 0.1
_OneOverRingWidth ("RingWidth", Float) = 100
_NotchInterval ("RingCrossInterval", Float) = 0.1
_OneOverNotchWidth ("NotchWidth", Float) = 100
_OneOverNotchLength ("NotchLength", Float) = 20
_NotchColor ("NotchColor", Color) = (1,0,0,1)
_SecondaryRingAlpha ("Secondary Ring Alpha", Float) = 0
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 30792
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _CircleCenter;
uniform highp float _RingInterval;
uniform highp float _OneOverRingWidth;
uniform highp float _NotchInterval;
uniform highp float _OneOverNotchWidth;
uniform highp float _OneOverNotchLength;
uniform highp float _SecondaryRingAlpha;
uniform lowp vec4 _MainColor;
uniform lowp vec4 _RingColor;
uniform lowp vec4 _NotchColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float notchAlpha_1;
  highp float ringAlpha_2;
  lowp vec4 xlat_varoutput_3;
  xlat_varoutput_3 = _MainColor;
  highp vec2 x_4;
  x_4 = (xlv_TEXCOORD0 - _CircleCenter.xy);
  highp float tmpvar_5;
  tmpvar_5 = (sqrt(dot (x_4, x_4)) + (_RingInterval * 0.5));
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_5 / _RingInterval);
  highp float tmpvar_7;
  tmpvar_7 = (fract(abs(tmpvar_6)) * _RingInterval);
  highp float tmpvar_8;
  if ((tmpvar_6 >= 0.0)) {
    tmpvar_8 = tmpvar_7;
  } else {
    tmpvar_8 = -(tmpvar_7);
  };
  highp float tmpvar_9;
  tmpvar_9 = floor((tmpvar_5 / _RingInterval));
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_8 - (_RingInterval * 0.5));
  highp float tmpvar_11;
  tmpvar_11 = (tmpvar_10 * _OneOverRingWidth);
  highp float tmpvar_12;
  tmpvar_12 = max ((1.0 - (tmpvar_11 * tmpvar_11)), 0.0);
  ringAlpha_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (tmpvar_9 / 2.0);
  highp float tmpvar_14;
  tmpvar_14 = (fract(abs(tmpvar_13)) * 2.0);
  highp float tmpvar_15;
  if ((tmpvar_13 >= 0.0)) {
    tmpvar_15 = tmpvar_14;
  } else {
    tmpvar_15 = -(tmpvar_14);
  };
  highp float tmpvar_16;
  tmpvar_16 = min (1.0, ((_SecondaryRingAlpha + 1.0) - tmpvar_15));
  ringAlpha_2 = (tmpvar_12 * tmpvar_16);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (_MainColor.xyz, _RingColor.xyz, vec3((_RingColor.w * ringAlpha_2)));
  xlat_varoutput_3.xyz = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_NotchInterval / (2.0 * (tmpvar_9 + 1.0)));
  highp float vec_y_19;
  vec_y_19 = (xlv_TEXCOORD0.y - _CircleCenter.y);
  highp float vec_x_20;
  vec_x_20 = (xlv_TEXCOORD0.x - _CircleCenter.x);
  highp float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (min (abs(
    (vec_y_19 / vec_x_20)
  ), 1.0) / max (abs(
    (vec_y_19 / vec_x_20)
  ), 1.0));
  highp float tmpvar_23;
  tmpvar_23 = (tmpvar_22 * tmpvar_22);
  tmpvar_23 = (((
    ((((
      ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
     * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
   * tmpvar_23) + 0.9999793) * tmpvar_22);
  tmpvar_23 = (tmpvar_23 + (float(
    (abs((vec_y_19 / vec_x_20)) > 1.0)
  ) * (
    (tmpvar_23 * -2.0)
   + 1.570796)));
  tmpvar_21 = (tmpvar_23 * sign((vec_y_19 / vec_x_20)));
  if ((abs(vec_x_20) > (1e-08 * abs(vec_y_19)))) {
    if ((vec_x_20 < 0.0)) {
      if ((vec_y_19 >= 0.0)) {
        tmpvar_21 += 3.141593;
      } else {
        tmpvar_21 = (tmpvar_21 - 3.141593);
      };
    };
  } else {
    tmpvar_21 = (sign(vec_y_19) * 1.570796);
  };
  highp float tmpvar_24;
  tmpvar_24 = (((3.141593 + tmpvar_21) + (tmpvar_18 * 0.5)) / tmpvar_18);
  highp float tmpvar_25;
  tmpvar_25 = (fract(abs(tmpvar_24)) * tmpvar_18);
  highp float tmpvar_26;
  if ((tmpvar_24 >= 0.0)) {
    tmpvar_26 = tmpvar_25;
  } else {
    tmpvar_26 = -(tmpvar_25);
  };
  highp float tmpvar_27;
  tmpvar_27 = (((tmpvar_26 - 
    (tmpvar_18 * 0.5)
  ) * tmpvar_5) * _OneOverNotchWidth);
  highp float tmpvar_28;
  tmpvar_28 = (tmpvar_10 * _OneOverNotchLength);
  notchAlpha_1 = (max ((1.0 - 
    (tmpvar_27 * tmpvar_27)
  ), 0.0) * min (1.0, (1e+16 * 
    max ((1.0 - (tmpvar_28 * tmpvar_28)), 0.0)
  )));
  notchAlpha_1 = (notchAlpha_1 * tmpvar_16);
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlat_varoutput_3.xyz, _NotchColor.xyz, vec3((_NotchColor.w * notchAlpha_1)));
  xlat_varoutput_3.xyz = tmpvar_29;
  gl_FragData[0] = xlat_varoutput_3;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _CircleCenter;
uniform highp float _RingInterval;
uniform highp float _OneOverRingWidth;
uniform highp float _NotchInterval;
uniform highp float _OneOverNotchWidth;
uniform highp float _OneOverNotchLength;
uniform highp float _SecondaryRingAlpha;
uniform lowp vec4 _MainColor;
uniform lowp vec4 _RingColor;
uniform lowp vec4 _NotchColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float notchAlpha_1;
  highp float ringAlpha_2;
  lowp vec4 xlat_varoutput_3;
  xlat_varoutput_3 = _MainColor;
  highp vec2 x_4;
  x_4 = (xlv_TEXCOORD0 - _CircleCenter.xy);
  highp float tmpvar_5;
  tmpvar_5 = (sqrt(dot (x_4, x_4)) + (_RingInterval * 0.5));
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_5 / _RingInterval);
  highp float tmpvar_7;
  tmpvar_7 = (fract(abs(tmpvar_6)) * _RingInterval);
  highp float tmpvar_8;
  if ((tmpvar_6 >= 0.0)) {
    tmpvar_8 = tmpvar_7;
  } else {
    tmpvar_8 = -(tmpvar_7);
  };
  highp float tmpvar_9;
  tmpvar_9 = floor((tmpvar_5 / _RingInterval));
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_8 - (_RingInterval * 0.5));
  highp float tmpvar_11;
  tmpvar_11 = (tmpvar_10 * _OneOverRingWidth);
  highp float tmpvar_12;
  tmpvar_12 = max ((1.0 - (tmpvar_11 * tmpvar_11)), 0.0);
  ringAlpha_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (tmpvar_9 / 2.0);
  highp float tmpvar_14;
  tmpvar_14 = (fract(abs(tmpvar_13)) * 2.0);
  highp float tmpvar_15;
  if ((tmpvar_13 >= 0.0)) {
    tmpvar_15 = tmpvar_14;
  } else {
    tmpvar_15 = -(tmpvar_14);
  };
  highp float tmpvar_16;
  tmpvar_16 = min (1.0, ((_SecondaryRingAlpha + 1.0) - tmpvar_15));
  ringAlpha_2 = (tmpvar_12 * tmpvar_16);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (_MainColor.xyz, _RingColor.xyz, vec3((_RingColor.w * ringAlpha_2)));
  xlat_varoutput_3.xyz = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_NotchInterval / (2.0 * (tmpvar_9 + 1.0)));
  highp float vec_y_19;
  vec_y_19 = (xlv_TEXCOORD0.y - _CircleCenter.y);
  highp float vec_x_20;
  vec_x_20 = (xlv_TEXCOORD0.x - _CircleCenter.x);
  highp float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (min (abs(
    (vec_y_19 / vec_x_20)
  ), 1.0) / max (abs(
    (vec_y_19 / vec_x_20)
  ), 1.0));
  highp float tmpvar_23;
  tmpvar_23 = (tmpvar_22 * tmpvar_22);
  tmpvar_23 = (((
    ((((
      ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
     * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
   * tmpvar_23) + 0.9999793) * tmpvar_22);
  tmpvar_23 = (tmpvar_23 + (float(
    (abs((vec_y_19 / vec_x_20)) > 1.0)
  ) * (
    (tmpvar_23 * -2.0)
   + 1.570796)));
  tmpvar_21 = (tmpvar_23 * sign((vec_y_19 / vec_x_20)));
  if ((abs(vec_x_20) > (1e-08 * abs(vec_y_19)))) {
    if ((vec_x_20 < 0.0)) {
      if ((vec_y_19 >= 0.0)) {
        tmpvar_21 += 3.141593;
      } else {
        tmpvar_21 = (tmpvar_21 - 3.141593);
      };
    };
  } else {
    tmpvar_21 = (sign(vec_y_19) * 1.570796);
  };
  highp float tmpvar_24;
  tmpvar_24 = (((3.141593 + tmpvar_21) + (tmpvar_18 * 0.5)) / tmpvar_18);
  highp float tmpvar_25;
  tmpvar_25 = (fract(abs(tmpvar_24)) * tmpvar_18);
  highp float tmpvar_26;
  if ((tmpvar_24 >= 0.0)) {
    tmpvar_26 = tmpvar_25;
  } else {
    tmpvar_26 = -(tmpvar_25);
  };
  highp float tmpvar_27;
  tmpvar_27 = (((tmpvar_26 - 
    (tmpvar_18 * 0.5)
  ) * tmpvar_5) * _OneOverNotchWidth);
  highp float tmpvar_28;
  tmpvar_28 = (tmpvar_10 * _OneOverNotchLength);
  notchAlpha_1 = (max ((1.0 - 
    (tmpvar_27 * tmpvar_27)
  ), 0.0) * min (1.0, (1e+16 * 
    max ((1.0 - (tmpvar_28 * tmpvar_28)), 0.0)
  )));
  notchAlpha_1 = (notchAlpha_1 * tmpvar_16);
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlat_varoutput_3.xyz, _NotchColor.xyz, vec3((_NotchColor.w * notchAlpha_1)));
  xlat_varoutput_3.xyz = tmpvar_29;
  gl_FragData[0] = xlat_varoutput_3;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _CircleCenter;
uniform highp float _RingInterval;
uniform highp float _OneOverRingWidth;
uniform highp float _NotchInterval;
uniform highp float _OneOverNotchWidth;
uniform highp float _OneOverNotchLength;
uniform highp float _SecondaryRingAlpha;
uniform lowp vec4 _MainColor;
uniform lowp vec4 _RingColor;
uniform lowp vec4 _NotchColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float notchAlpha_1;
  highp float ringAlpha_2;
  lowp vec4 xlat_varoutput_3;
  xlat_varoutput_3 = _MainColor;
  highp vec2 x_4;
  x_4 = (xlv_TEXCOORD0 - _CircleCenter.xy);
  highp float tmpvar_5;
  tmpvar_5 = (sqrt(dot (x_4, x_4)) + (_RingInterval * 0.5));
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_5 / _RingInterval);
  highp float tmpvar_7;
  tmpvar_7 = (fract(abs(tmpvar_6)) * _RingInterval);
  highp float tmpvar_8;
  if ((tmpvar_6 >= 0.0)) {
    tmpvar_8 = tmpvar_7;
  } else {
    tmpvar_8 = -(tmpvar_7);
  };
  highp float tmpvar_9;
  tmpvar_9 = floor((tmpvar_5 / _RingInterval));
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_8 - (_RingInterval * 0.5));
  highp float tmpvar_11;
  tmpvar_11 = (tmpvar_10 * _OneOverRingWidth);
  highp float tmpvar_12;
  tmpvar_12 = max ((1.0 - (tmpvar_11 * tmpvar_11)), 0.0);
  ringAlpha_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (tmpvar_9 / 2.0);
  highp float tmpvar_14;
  tmpvar_14 = (fract(abs(tmpvar_13)) * 2.0);
  highp float tmpvar_15;
  if ((tmpvar_13 >= 0.0)) {
    tmpvar_15 = tmpvar_14;
  } else {
    tmpvar_15 = -(tmpvar_14);
  };
  highp float tmpvar_16;
  tmpvar_16 = min (1.0, ((_SecondaryRingAlpha + 1.0) - tmpvar_15));
  ringAlpha_2 = (tmpvar_12 * tmpvar_16);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (_MainColor.xyz, _RingColor.xyz, vec3((_RingColor.w * ringAlpha_2)));
  xlat_varoutput_3.xyz = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_NotchInterval / (2.0 * (tmpvar_9 + 1.0)));
  highp float vec_y_19;
  vec_y_19 = (xlv_TEXCOORD0.y - _CircleCenter.y);
  highp float vec_x_20;
  vec_x_20 = (xlv_TEXCOORD0.x - _CircleCenter.x);
  highp float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (min (abs(
    (vec_y_19 / vec_x_20)
  ), 1.0) / max (abs(
    (vec_y_19 / vec_x_20)
  ), 1.0));
  highp float tmpvar_23;
  tmpvar_23 = (tmpvar_22 * tmpvar_22);
  tmpvar_23 = (((
    ((((
      ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
     * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
   * tmpvar_23) + 0.9999793) * tmpvar_22);
  tmpvar_23 = (tmpvar_23 + (float(
    (abs((vec_y_19 / vec_x_20)) > 1.0)
  ) * (
    (tmpvar_23 * -2.0)
   + 1.570796)));
  tmpvar_21 = (tmpvar_23 * sign((vec_y_19 / vec_x_20)));
  if ((abs(vec_x_20) > (1e-08 * abs(vec_y_19)))) {
    if ((vec_x_20 < 0.0)) {
      if ((vec_y_19 >= 0.0)) {
        tmpvar_21 += 3.141593;
      } else {
        tmpvar_21 = (tmpvar_21 - 3.141593);
      };
    };
  } else {
    tmpvar_21 = (sign(vec_y_19) * 1.570796);
  };
  highp float tmpvar_24;
  tmpvar_24 = (((3.141593 + tmpvar_21) + (tmpvar_18 * 0.5)) / tmpvar_18);
  highp float tmpvar_25;
  tmpvar_25 = (fract(abs(tmpvar_24)) * tmpvar_18);
  highp float tmpvar_26;
  if ((tmpvar_24 >= 0.0)) {
    tmpvar_26 = tmpvar_25;
  } else {
    tmpvar_26 = -(tmpvar_25);
  };
  highp float tmpvar_27;
  tmpvar_27 = (((tmpvar_26 - 
    (tmpvar_18 * 0.5)
  ) * tmpvar_5) * _OneOverNotchWidth);
  highp float tmpvar_28;
  tmpvar_28 = (tmpvar_10 * _OneOverNotchLength);
  notchAlpha_1 = (max ((1.0 - 
    (tmpvar_27 * tmpvar_27)
  ), 0.0) * min (1.0, (1e+16 * 
    max ((1.0 - (tmpvar_28 * tmpvar_28)), 0.0)
  )));
  notchAlpha_1 = (notchAlpha_1 * tmpvar_16);
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlat_varoutput_3.xyz, _NotchColor.xyz, vec3((_NotchColor.w * notchAlpha_1)));
  xlat_varoutput_3.xyz = tmpvar_29;
  gl_FragData[0] = xlat_varoutput_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _CircleCenter;
uniform highp float _RingInterval;
uniform highp float _OneOverRingWidth;
uniform highp float _NotchInterval;
uniform highp float _OneOverNotchWidth;
uniform highp float _OneOverNotchLength;
uniform highp float _SecondaryRingAlpha;
uniform lowp vec4 _MainColor;
uniform lowp vec4 _RingColor;
uniform lowp vec4 _NotchColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float notchAlpha_1;
  highp float ringAlpha_2;
  lowp vec4 xlat_varoutput_3;
  xlat_varoutput_3 = _MainColor;
  highp vec2 x_4;
  x_4 = (xlv_TEXCOORD0 - _CircleCenter.xy);
  highp float tmpvar_5;
  tmpvar_5 = (sqrt(dot (x_4, x_4)) + (_RingInterval * 0.5));
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_5 / _RingInterval);
  highp float tmpvar_7;
  tmpvar_7 = (fract(abs(tmpvar_6)) * _RingInterval);
  highp float tmpvar_8;
  if ((tmpvar_6 >= 0.0)) {
    tmpvar_8 = tmpvar_7;
  } else {
    tmpvar_8 = -(tmpvar_7);
  };
  highp float tmpvar_9;
  tmpvar_9 = floor((tmpvar_5 / _RingInterval));
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_8 - (_RingInterval * 0.5));
  highp float tmpvar_11;
  tmpvar_11 = (tmpvar_10 * _OneOverRingWidth);
  highp float tmpvar_12;
  tmpvar_12 = max ((1.0 - (tmpvar_11 * tmpvar_11)), 0.0);
  ringAlpha_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (tmpvar_9 / 2.0);
  highp float tmpvar_14;
  tmpvar_14 = (fract(abs(tmpvar_13)) * 2.0);
  highp float tmpvar_15;
  if ((tmpvar_13 >= 0.0)) {
    tmpvar_15 = tmpvar_14;
  } else {
    tmpvar_15 = -(tmpvar_14);
  };
  highp float tmpvar_16;
  tmpvar_16 = min (1.0, ((_SecondaryRingAlpha + 1.0) - tmpvar_15));
  ringAlpha_2 = (tmpvar_12 * tmpvar_16);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (_MainColor.xyz, _RingColor.xyz, vec3((_RingColor.w * ringAlpha_2)));
  xlat_varoutput_3.xyz = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_NotchInterval / (2.0 * (tmpvar_9 + 1.0)));
  highp float vec_y_19;
  vec_y_19 = (xlv_TEXCOORD0.y - _CircleCenter.y);
  highp float vec_x_20;
  vec_x_20 = (xlv_TEXCOORD0.x - _CircleCenter.x);
  highp float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (min (abs(
    (vec_y_19 / vec_x_20)
  ), 1.0) / max (abs(
    (vec_y_19 / vec_x_20)
  ), 1.0));
  highp float tmpvar_23;
  tmpvar_23 = (tmpvar_22 * tmpvar_22);
  tmpvar_23 = (((
    ((((
      ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
     * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
   * tmpvar_23) + 0.9999793) * tmpvar_22);
  tmpvar_23 = (tmpvar_23 + (float(
    (abs((vec_y_19 / vec_x_20)) > 1.0)
  ) * (
    (tmpvar_23 * -2.0)
   + 1.570796)));
  tmpvar_21 = (tmpvar_23 * sign((vec_y_19 / vec_x_20)));
  if ((abs(vec_x_20) > (1e-08 * abs(vec_y_19)))) {
    if ((vec_x_20 < 0.0)) {
      if ((vec_y_19 >= 0.0)) {
        tmpvar_21 += 3.141593;
      } else {
        tmpvar_21 = (tmpvar_21 - 3.141593);
      };
    };
  } else {
    tmpvar_21 = (sign(vec_y_19) * 1.570796);
  };
  highp float tmpvar_24;
  tmpvar_24 = (((3.141593 + tmpvar_21) + (tmpvar_18 * 0.5)) / tmpvar_18);
  highp float tmpvar_25;
  tmpvar_25 = (fract(abs(tmpvar_24)) * tmpvar_18);
  highp float tmpvar_26;
  if ((tmpvar_24 >= 0.0)) {
    tmpvar_26 = tmpvar_25;
  } else {
    tmpvar_26 = -(tmpvar_25);
  };
  highp float tmpvar_27;
  tmpvar_27 = (((tmpvar_26 - 
    (tmpvar_18 * 0.5)
  ) * tmpvar_5) * _OneOverNotchWidth);
  highp float tmpvar_28;
  tmpvar_28 = (tmpvar_10 * _OneOverNotchLength);
  notchAlpha_1 = (max ((1.0 - 
    (tmpvar_27 * tmpvar_27)
  ), 0.0) * min (1.0, (1e+16 * 
    max ((1.0 - (tmpvar_28 * tmpvar_28)), 0.0)
  )));
  notchAlpha_1 = (notchAlpha_1 * tmpvar_16);
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlat_varoutput_3.xyz, _NotchColor.xyz, vec3((_NotchColor.w * notchAlpha_1)));
  xlat_varoutput_3.xyz = tmpvar_29;
  gl_FragData[0] = xlat_varoutput_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _CircleCenter;
uniform highp float _RingInterval;
uniform highp float _OneOverRingWidth;
uniform highp float _NotchInterval;
uniform highp float _OneOverNotchWidth;
uniform highp float _OneOverNotchLength;
uniform highp float _SecondaryRingAlpha;
uniform lowp vec4 _MainColor;
uniform lowp vec4 _RingColor;
uniform lowp vec4 _NotchColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float notchAlpha_1;
  highp float ringAlpha_2;
  lowp vec4 xlat_varoutput_3;
  xlat_varoutput_3 = _MainColor;
  highp vec2 x_4;
  x_4 = (xlv_TEXCOORD0 - _CircleCenter.xy);
  highp float tmpvar_5;
  tmpvar_5 = (sqrt(dot (x_4, x_4)) + (_RingInterval * 0.5));
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_5 / _RingInterval);
  highp float tmpvar_7;
  tmpvar_7 = (fract(abs(tmpvar_6)) * _RingInterval);
  highp float tmpvar_8;
  if ((tmpvar_6 >= 0.0)) {
    tmpvar_8 = tmpvar_7;
  } else {
    tmpvar_8 = -(tmpvar_7);
  };
  highp float tmpvar_9;
  tmpvar_9 = floor((tmpvar_5 / _RingInterval));
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_8 - (_RingInterval * 0.5));
  highp float tmpvar_11;
  tmpvar_11 = (tmpvar_10 * _OneOverRingWidth);
  highp float tmpvar_12;
  tmpvar_12 = max ((1.0 - (tmpvar_11 * tmpvar_11)), 0.0);
  ringAlpha_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (tmpvar_9 / 2.0);
  highp float tmpvar_14;
  tmpvar_14 = (fract(abs(tmpvar_13)) * 2.0);
  highp float tmpvar_15;
  if ((tmpvar_13 >= 0.0)) {
    tmpvar_15 = tmpvar_14;
  } else {
    tmpvar_15 = -(tmpvar_14);
  };
  highp float tmpvar_16;
  tmpvar_16 = min (1.0, ((_SecondaryRingAlpha + 1.0) - tmpvar_15));
  ringAlpha_2 = (tmpvar_12 * tmpvar_16);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (_MainColor.xyz, _RingColor.xyz, vec3((_RingColor.w * ringAlpha_2)));
  xlat_varoutput_3.xyz = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_NotchInterval / (2.0 * (tmpvar_9 + 1.0)));
  highp float vec_y_19;
  vec_y_19 = (xlv_TEXCOORD0.y - _CircleCenter.y);
  highp float vec_x_20;
  vec_x_20 = (xlv_TEXCOORD0.x - _CircleCenter.x);
  highp float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (min (abs(
    (vec_y_19 / vec_x_20)
  ), 1.0) / max (abs(
    (vec_y_19 / vec_x_20)
  ), 1.0));
  highp float tmpvar_23;
  tmpvar_23 = (tmpvar_22 * tmpvar_22);
  tmpvar_23 = (((
    ((((
      ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
     * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
   * tmpvar_23) + 0.9999793) * tmpvar_22);
  tmpvar_23 = (tmpvar_23 + (float(
    (abs((vec_y_19 / vec_x_20)) > 1.0)
  ) * (
    (tmpvar_23 * -2.0)
   + 1.570796)));
  tmpvar_21 = (tmpvar_23 * sign((vec_y_19 / vec_x_20)));
  if ((abs(vec_x_20) > (1e-08 * abs(vec_y_19)))) {
    if ((vec_x_20 < 0.0)) {
      if ((vec_y_19 >= 0.0)) {
        tmpvar_21 += 3.141593;
      } else {
        tmpvar_21 = (tmpvar_21 - 3.141593);
      };
    };
  } else {
    tmpvar_21 = (sign(vec_y_19) * 1.570796);
  };
  highp float tmpvar_24;
  tmpvar_24 = (((3.141593 + tmpvar_21) + (tmpvar_18 * 0.5)) / tmpvar_18);
  highp float tmpvar_25;
  tmpvar_25 = (fract(abs(tmpvar_24)) * tmpvar_18);
  highp float tmpvar_26;
  if ((tmpvar_24 >= 0.0)) {
    tmpvar_26 = tmpvar_25;
  } else {
    tmpvar_26 = -(tmpvar_25);
  };
  highp float tmpvar_27;
  tmpvar_27 = (((tmpvar_26 - 
    (tmpvar_18 * 0.5)
  ) * tmpvar_5) * _OneOverNotchWidth);
  highp float tmpvar_28;
  tmpvar_28 = (tmpvar_10 * _OneOverNotchLength);
  notchAlpha_1 = (max ((1.0 - 
    (tmpvar_27 * tmpvar_27)
  ), 0.0) * min (1.0, (1e+16 * 
    max ((1.0 - (tmpvar_28 * tmpvar_28)), 0.0)
  )));
  notchAlpha_1 = (notchAlpha_1 * tmpvar_16);
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlat_varoutput_3.xyz, _NotchColor.xyz, vec3((_NotchColor.w * notchAlpha_1)));
  xlat_varoutput_3.xyz = tmpvar_29;
  gl_FragData[0] = xlat_varoutput_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _CircleCenter;
uniform highp float _RingInterval;
uniform highp float _OneOverRingWidth;
uniform highp float _NotchInterval;
uniform highp float _OneOverNotchWidth;
uniform highp float _OneOverNotchLength;
uniform highp float _SecondaryRingAlpha;
uniform lowp vec4 _MainColor;
uniform lowp vec4 _RingColor;
uniform lowp vec4 _NotchColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float notchAlpha_1;
  highp float ringAlpha_2;
  lowp vec4 xlat_varoutput_3;
  xlat_varoutput_3 = _MainColor;
  highp vec2 x_4;
  x_4 = (xlv_TEXCOORD0 - _CircleCenter.xy);
  highp float tmpvar_5;
  tmpvar_5 = (sqrt(dot (x_4, x_4)) + (_RingInterval * 0.5));
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_5 / _RingInterval);
  highp float tmpvar_7;
  tmpvar_7 = (fract(abs(tmpvar_6)) * _RingInterval);
  highp float tmpvar_8;
  if ((tmpvar_6 >= 0.0)) {
    tmpvar_8 = tmpvar_7;
  } else {
    tmpvar_8 = -(tmpvar_7);
  };
  highp float tmpvar_9;
  tmpvar_9 = floor((tmpvar_5 / _RingInterval));
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_8 - (_RingInterval * 0.5));
  highp float tmpvar_11;
  tmpvar_11 = (tmpvar_10 * _OneOverRingWidth);
  highp float tmpvar_12;
  tmpvar_12 = max ((1.0 - (tmpvar_11 * tmpvar_11)), 0.0);
  ringAlpha_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (tmpvar_9 / 2.0);
  highp float tmpvar_14;
  tmpvar_14 = (fract(abs(tmpvar_13)) * 2.0);
  highp float tmpvar_15;
  if ((tmpvar_13 >= 0.0)) {
    tmpvar_15 = tmpvar_14;
  } else {
    tmpvar_15 = -(tmpvar_14);
  };
  highp float tmpvar_16;
  tmpvar_16 = min (1.0, ((_SecondaryRingAlpha + 1.0) - tmpvar_15));
  ringAlpha_2 = (tmpvar_12 * tmpvar_16);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (_MainColor.xyz, _RingColor.xyz, vec3((_RingColor.w * ringAlpha_2)));
  xlat_varoutput_3.xyz = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_NotchInterval / (2.0 * (tmpvar_9 + 1.0)));
  highp float vec_y_19;
  vec_y_19 = (xlv_TEXCOORD0.y - _CircleCenter.y);
  highp float vec_x_20;
  vec_x_20 = (xlv_TEXCOORD0.x - _CircleCenter.x);
  highp float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (min (abs(
    (vec_y_19 / vec_x_20)
  ), 1.0) / max (abs(
    (vec_y_19 / vec_x_20)
  ), 1.0));
  highp float tmpvar_23;
  tmpvar_23 = (tmpvar_22 * tmpvar_22);
  tmpvar_23 = (((
    ((((
      ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
     * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
   * tmpvar_23) + 0.9999793) * tmpvar_22);
  tmpvar_23 = (tmpvar_23 + (float(
    (abs((vec_y_19 / vec_x_20)) > 1.0)
  ) * (
    (tmpvar_23 * -2.0)
   + 1.570796)));
  tmpvar_21 = (tmpvar_23 * sign((vec_y_19 / vec_x_20)));
  if ((abs(vec_x_20) > (1e-08 * abs(vec_y_19)))) {
    if ((vec_x_20 < 0.0)) {
      if ((vec_y_19 >= 0.0)) {
        tmpvar_21 += 3.141593;
      } else {
        tmpvar_21 = (tmpvar_21 - 3.141593);
      };
    };
  } else {
    tmpvar_21 = (sign(vec_y_19) * 1.570796);
  };
  highp float tmpvar_24;
  tmpvar_24 = (((3.141593 + tmpvar_21) + (tmpvar_18 * 0.5)) / tmpvar_18);
  highp float tmpvar_25;
  tmpvar_25 = (fract(abs(tmpvar_24)) * tmpvar_18);
  highp float tmpvar_26;
  if ((tmpvar_24 >= 0.0)) {
    tmpvar_26 = tmpvar_25;
  } else {
    tmpvar_26 = -(tmpvar_25);
  };
  highp float tmpvar_27;
  tmpvar_27 = (((tmpvar_26 - 
    (tmpvar_18 * 0.5)
  ) * tmpvar_5) * _OneOverNotchWidth);
  highp float tmpvar_28;
  tmpvar_28 = (tmpvar_10 * _OneOverNotchLength);
  notchAlpha_1 = (max ((1.0 - 
    (tmpvar_27 * tmpvar_27)
  ), 0.0) * min (1.0, (1e+16 * 
    max ((1.0 - (tmpvar_28 * tmpvar_28)), 0.0)
  )));
  notchAlpha_1 = (notchAlpha_1 * tmpvar_16);
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlat_varoutput_3.xyz, _NotchColor.xyz, vec3((_NotchColor.w * notchAlpha_1)));
  xlat_varoutput_3.xyz = tmpvar_29;
  gl_FragData[0] = xlat_varoutput_3;
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