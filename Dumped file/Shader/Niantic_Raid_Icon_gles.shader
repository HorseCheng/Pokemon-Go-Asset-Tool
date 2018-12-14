Shader "Niantic/Raid/Icon" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_AnglePerPip ("Angle Per Pip (dgr)", Float) = 27.5
[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
_RendererColor ("RendererColor", Color) = (1,1,1,1)
_Flip ("Flip", Vector) = (1,1,1,1)
_AlphaTex ("External Alpha", 2D) = "white" { }
_EnableExternalAlpha ("Enable External Alpha", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 32600
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform highp float _AnglePerPip;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2.xyz = ((_glesColor.xyz * _Color.xyz) * _RendererColor.xyz);
  tmpvar_2.w = tmpvar_1.w;
  tmpvar_3.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_3.x = ((3.141593 * _AnglePerPip) / 180.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp int i_1;
  highp float pipCount_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * xlv_COLOR.xyz);
  c_3.xyz = (c_3.xyz * tmpvar_4.w);
  lowp float tmpvar_5;
  tmpvar_5 = floor((5.1 * xlv_COLOR.w));
  pipCount_2 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0 - 0.5);
  highp float vec_x_7;
  vec_x_7 = -(tmpvar_6.y);
  highp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (min (abs(
    (tmpvar_6.x / vec_x_7)
  ), 1.0) / max (abs(
    (tmpvar_6.x / vec_x_7)
  ), 1.0));
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_9);
  tmpvar_10 = (((
    ((((
      ((((-0.01213232 * tmpvar_10) + 0.05368138) * tmpvar_10) - 0.1173503)
     * tmpvar_10) + 0.1938925) * tmpvar_10) - 0.3326756)
   * tmpvar_10) + 0.9999793) * tmpvar_9);
  tmpvar_10 = (tmpvar_10 + (float(
    (abs((tmpvar_6.x / vec_x_7)) > 1.0)
  ) * (
    (tmpvar_10 * -2.0)
   + 1.570796)));
  tmpvar_8 = (tmpvar_10 * sign((tmpvar_6.x / vec_x_7)));
  if ((abs(vec_x_7) > (1e-08 * abs(tmpvar_6.x)))) {
    if ((vec_x_7 < 0.0)) {
      if ((tmpvar_6.x >= 0.0)) {
        tmpvar_8 += 3.141593;
      } else {
        tmpvar_8 = (tmpvar_8 - 3.141593);
      };
    };
  } else {
    tmpvar_8 = (sign(tmpvar_6.x) * 1.570796);
  };
  highp float tmpvar_11;
  tmpvar_11 = (pipCount_2 / 2.0);
  highp float tmpvar_12;
  tmpvar_12 = (fract(abs(tmpvar_11)) * 2.0);
  highp float tmpvar_13;
  if ((tmpvar_11 >= 0.0)) {
    tmpvar_13 = tmpvar_12;
  } else {
    tmpvar_13 = -(tmpvar_12);
  };
  highp float tmpvar_14;
  highp float x_15;
  x_15 = ((tmpvar_8 - (
    (xlv_TEXCOORD1.x * 0.5)
   * 
    float((tmpvar_13 >= 0.1))
  )) / xlv_TEXCOORD1.x);
  highp int ip_16;
  ip_16 = int(x_15);
  tmpvar_14 = (x_15 - float(ip_16));
  i_1 = int((float(
    (2 * ip_16)
  ) + sign(tmpvar_14)));
  highp float tmpvar_17;
  tmpvar_17 = (sqrt(dot (tmpvar_6, tmpvar_6)) * 2.0);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (c_3.xyz, vec3(1.0, 1.0, 1.0), vec3(((
    ((float((tmpvar_17 >= 0.5)) * float((0.7 >= tmpvar_17))) * float(((
      (0.3 * (tmpvar_17 - 0.5))
     / 0.2) >= abs(
      (abs(tmpvar_14) - 0.5)
    ))))
   * 
    float((float(i_1) >= -(pipCount_2)))
  ) * float(
    ((pipCount_2 - 1.0) >= float(i_1))
  ))));
  c_3.xyz = tmpvar_18;
  gl_FragData[0] = c_3;
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
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform highp float _AnglePerPip;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2.xyz = ((_glesColor.xyz * _Color.xyz) * _RendererColor.xyz);
  tmpvar_2.w = tmpvar_1.w;
  tmpvar_3.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_3.x = ((3.141593 * _AnglePerPip) / 180.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp int i_1;
  highp float pipCount_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * xlv_COLOR.xyz);
  c_3.xyz = (c_3.xyz * tmpvar_4.w);
  lowp float tmpvar_5;
  tmpvar_5 = floor((5.1 * xlv_COLOR.w));
  pipCount_2 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0 - 0.5);
  highp float vec_x_7;
  vec_x_7 = -(tmpvar_6.y);
  highp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (min (abs(
    (tmpvar_6.x / vec_x_7)
  ), 1.0) / max (abs(
    (tmpvar_6.x / vec_x_7)
  ), 1.0));
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_9);
  tmpvar_10 = (((
    ((((
      ((((-0.01213232 * tmpvar_10) + 0.05368138) * tmpvar_10) - 0.1173503)
     * tmpvar_10) + 0.1938925) * tmpvar_10) - 0.3326756)
   * tmpvar_10) + 0.9999793) * tmpvar_9);
  tmpvar_10 = (tmpvar_10 + (float(
    (abs((tmpvar_6.x / vec_x_7)) > 1.0)
  ) * (
    (tmpvar_10 * -2.0)
   + 1.570796)));
  tmpvar_8 = (tmpvar_10 * sign((tmpvar_6.x / vec_x_7)));
  if ((abs(vec_x_7) > (1e-08 * abs(tmpvar_6.x)))) {
    if ((vec_x_7 < 0.0)) {
      if ((tmpvar_6.x >= 0.0)) {
        tmpvar_8 += 3.141593;
      } else {
        tmpvar_8 = (tmpvar_8 - 3.141593);
      };
    };
  } else {
    tmpvar_8 = (sign(tmpvar_6.x) * 1.570796);
  };
  highp float tmpvar_11;
  tmpvar_11 = (pipCount_2 / 2.0);
  highp float tmpvar_12;
  tmpvar_12 = (fract(abs(tmpvar_11)) * 2.0);
  highp float tmpvar_13;
  if ((tmpvar_11 >= 0.0)) {
    tmpvar_13 = tmpvar_12;
  } else {
    tmpvar_13 = -(tmpvar_12);
  };
  highp float tmpvar_14;
  highp float x_15;
  x_15 = ((tmpvar_8 - (
    (xlv_TEXCOORD1.x * 0.5)
   * 
    float((tmpvar_13 >= 0.1))
  )) / xlv_TEXCOORD1.x);
  highp int ip_16;
  ip_16 = int(x_15);
  tmpvar_14 = (x_15 - float(ip_16));
  i_1 = int((float(
    (2 * ip_16)
  ) + sign(tmpvar_14)));
  highp float tmpvar_17;
  tmpvar_17 = (sqrt(dot (tmpvar_6, tmpvar_6)) * 2.0);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (c_3.xyz, vec3(1.0, 1.0, 1.0), vec3(((
    ((float((tmpvar_17 >= 0.5)) * float((0.7 >= tmpvar_17))) * float(((
      (0.3 * (tmpvar_17 - 0.5))
     / 0.2) >= abs(
      (abs(tmpvar_14) - 0.5)
    ))))
   * 
    float((float(i_1) >= -(pipCount_2)))
  ) * float(
    ((pipCount_2 - 1.0) >= float(i_1))
  ))));
  c_3.xyz = tmpvar_18;
  gl_FragData[0] = c_3;
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
uniform lowp vec4 _RendererColor;
uniform lowp vec4 _Color;
uniform highp float _AnglePerPip;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2.xyz = ((_glesColor.xyz * _Color.xyz) * _RendererColor.xyz);
  tmpvar_2.w = tmpvar_1.w;
  tmpvar_3.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_3.x = ((3.141593 * _AnglePerPip) / 180.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp int i_1;
  highp float pipCount_2;
  lowp vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3.w = tmpvar_4.w;
  c_3.xyz = (tmpvar_4.xyz * xlv_COLOR.xyz);
  c_3.xyz = (c_3.xyz * tmpvar_4.w);
  lowp float tmpvar_5;
  tmpvar_5 = floor((5.1 * xlv_COLOR.w));
  pipCount_2 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0 - 0.5);
  highp float vec_x_7;
  vec_x_7 = -(tmpvar_6.y);
  highp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (min (abs(
    (tmpvar_6.x / vec_x_7)
  ), 1.0) / max (abs(
    (tmpvar_6.x / vec_x_7)
  ), 1.0));
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_9);
  tmpvar_10 = (((
    ((((
      ((((-0.01213232 * tmpvar_10) + 0.05368138) * tmpvar_10) - 0.1173503)
     * tmpvar_10) + 0.1938925) * tmpvar_10) - 0.3326756)
   * tmpvar_10) + 0.9999793) * tmpvar_9);
  tmpvar_10 = (tmpvar_10 + (float(
    (abs((tmpvar_6.x / vec_x_7)) > 1.0)
  ) * (
    (tmpvar_10 * -2.0)
   + 1.570796)));
  tmpvar_8 = (tmpvar_10 * sign((tmpvar_6.x / vec_x_7)));
  if ((abs(vec_x_7) > (1e-08 * abs(tmpvar_6.x)))) {
    if ((vec_x_7 < 0.0)) {
      if ((tmpvar_6.x >= 0.0)) {
        tmpvar_8 += 3.141593;
      } else {
        tmpvar_8 = (tmpvar_8 - 3.141593);
      };
    };
  } else {
    tmpvar_8 = (sign(tmpvar_6.x) * 1.570796);
  };
  highp float tmpvar_11;
  tmpvar_11 = (pipCount_2 / 2.0);
  highp float tmpvar_12;
  tmpvar_12 = (fract(abs(tmpvar_11)) * 2.0);
  highp float tmpvar_13;
  if ((tmpvar_11 >= 0.0)) {
    tmpvar_13 = tmpvar_12;
  } else {
    tmpvar_13 = -(tmpvar_12);
  };
  highp float tmpvar_14;
  highp float x_15;
  x_15 = ((tmpvar_8 - (
    (xlv_TEXCOORD1.x * 0.5)
   * 
    float((tmpvar_13 >= 0.1))
  )) / xlv_TEXCOORD1.x);
  highp int ip_16;
  ip_16 = int(x_15);
  tmpvar_14 = (x_15 - float(ip_16));
  i_1 = int((float(
    (2 * ip_16)
  ) + sign(tmpvar_14)));
  highp float tmpvar_17;
  tmpvar_17 = (sqrt(dot (tmpvar_6, tmpvar_6)) * 2.0);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (c_3.xyz, vec3(1.0, 1.0, 1.0), vec3(((
    ((float((tmpvar_17 >= 0.5)) * float((0.7 >= tmpvar_17))) * float(((
      (0.3 * (tmpvar_17 - 0.5))
     / 0.2) >= abs(
      (abs(tmpvar_14) - 0.5)
    ))))
   * 
    float((float(i_1) >= -(pipCount_2)))
  ) * float(
    ((pipCount_2 - 1.0) >= float(i_1))
  ))));
  c_3.xyz = tmpvar_18;
  gl_FragData[0] = c_3;
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