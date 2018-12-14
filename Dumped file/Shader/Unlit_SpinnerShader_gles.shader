Shader "Unlit/SpinnerShader" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_ColorA ("Color", Color) = (1,1,1,1)
_ColorB ("Color", Color) = (0,0,0,1)
}
SubShader {
 LOD 100
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 18524
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ColorA;
uniform highp vec4 _ColorB;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp float clampSin_2;
  highp float tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD0.x - 0.5);
  highp float tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.y - 0.5);
  highp float tmpvar_5;
  tmpvar_5 = sqrt(((tmpvar_3 * tmpvar_3) + (tmpvar_4 * tmpvar_4)));
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_5 - 0.5) / -0.02000001), 0.0, 1.0);
  tmpvar_6 = (tmpvar_7 * (tmpvar_7 * (3.0 - 
    (2.0 * tmpvar_7)
  )));
  highp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (min (abs(
    (tmpvar_3 / tmpvar_4)
  ), 1.0) / max (abs(
    (tmpvar_3 / tmpvar_4)
  ), 1.0));
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_9);
  tmpvar_10 = (((
    ((((
      ((((-0.01213232 * tmpvar_10) + 0.05368138) * tmpvar_10) - 0.1173503)
     * tmpvar_10) + 0.1938925) * tmpvar_10) - 0.3326756)
   * tmpvar_10) + 0.9999793) * tmpvar_9);
  tmpvar_10 = (tmpvar_10 + (float(
    (abs((tmpvar_3 / tmpvar_4)) > 1.0)
  ) * (
    (tmpvar_10 * -2.0)
   + 1.570796)));
  tmpvar_8 = (tmpvar_10 * sign((tmpvar_3 / tmpvar_4)));
  if ((abs(tmpvar_4) > (1e-08 * abs(tmpvar_3)))) {
    if ((tmpvar_4 < 0.0)) {
      if ((tmpvar_3 >= 0.0)) {
        tmpvar_8 += 3.141593;
      } else {
        tmpvar_8 = (tmpvar_8 - 3.141593);
      };
    };
  } else {
    tmpvar_8 = (sign(tmpvar_3) * 1.570796);
  };
  clampSin_2 = ((sin(
    ((tmpvar_8 * 2.0) + (tmpvar_5 * -55.0))
  ) + 0.5) - ((
    cos((12.56 * tmpvar_5))
   + 0.5) * 1.2));
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = ((vec3(clampSin_2) * _ColorA.xyz) + ((vec3(1.0, 1.0, 1.0) - vec3(clampSin_2)) * _ColorB.xyz));
  tmpvar_11.w = (((clampSin_2 * _ColorA.w) + (
    (1.0 - clampSin_2)
   * _ColorB.w)) * tmpvar_6);
  col_1 = tmpvar_11;
  col_1.xyz = (col_1.xyz * col_1.w);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ColorA;
uniform highp vec4 _ColorB;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp float clampSin_2;
  highp float tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD0.x - 0.5);
  highp float tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.y - 0.5);
  highp float tmpvar_5;
  tmpvar_5 = sqrt(((tmpvar_3 * tmpvar_3) + (tmpvar_4 * tmpvar_4)));
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_5 - 0.5) / -0.02000001), 0.0, 1.0);
  tmpvar_6 = (tmpvar_7 * (tmpvar_7 * (3.0 - 
    (2.0 * tmpvar_7)
  )));
  highp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (min (abs(
    (tmpvar_3 / tmpvar_4)
  ), 1.0) / max (abs(
    (tmpvar_3 / tmpvar_4)
  ), 1.0));
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_9);
  tmpvar_10 = (((
    ((((
      ((((-0.01213232 * tmpvar_10) + 0.05368138) * tmpvar_10) - 0.1173503)
     * tmpvar_10) + 0.1938925) * tmpvar_10) - 0.3326756)
   * tmpvar_10) + 0.9999793) * tmpvar_9);
  tmpvar_10 = (tmpvar_10 + (float(
    (abs((tmpvar_3 / tmpvar_4)) > 1.0)
  ) * (
    (tmpvar_10 * -2.0)
   + 1.570796)));
  tmpvar_8 = (tmpvar_10 * sign((tmpvar_3 / tmpvar_4)));
  if ((abs(tmpvar_4) > (1e-08 * abs(tmpvar_3)))) {
    if ((tmpvar_4 < 0.0)) {
      if ((tmpvar_3 >= 0.0)) {
        tmpvar_8 += 3.141593;
      } else {
        tmpvar_8 = (tmpvar_8 - 3.141593);
      };
    };
  } else {
    tmpvar_8 = (sign(tmpvar_3) * 1.570796);
  };
  clampSin_2 = ((sin(
    ((tmpvar_8 * 2.0) + (tmpvar_5 * -55.0))
  ) + 0.5) - ((
    cos((12.56 * tmpvar_5))
   + 0.5) * 1.2));
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = ((vec3(clampSin_2) * _ColorA.xyz) + ((vec3(1.0, 1.0, 1.0) - vec3(clampSin_2)) * _ColorB.xyz));
  tmpvar_11.w = (((clampSin_2 * _ColorA.w) + (
    (1.0 - clampSin_2)
   * _ColorB.w)) * tmpvar_6);
  col_1 = tmpvar_11;
  col_1.xyz = (col_1.xyz * col_1.w);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ColorA;
uniform highp vec4 _ColorB;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp float clampSin_2;
  highp float tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD0.x - 0.5);
  highp float tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.y - 0.5);
  highp float tmpvar_5;
  tmpvar_5 = sqrt(((tmpvar_3 * tmpvar_3) + (tmpvar_4 * tmpvar_4)));
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_5 - 0.5) / -0.02000001), 0.0, 1.0);
  tmpvar_6 = (tmpvar_7 * (tmpvar_7 * (3.0 - 
    (2.0 * tmpvar_7)
  )));
  highp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (min (abs(
    (tmpvar_3 / tmpvar_4)
  ), 1.0) / max (abs(
    (tmpvar_3 / tmpvar_4)
  ), 1.0));
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_9);
  tmpvar_10 = (((
    ((((
      ((((-0.01213232 * tmpvar_10) + 0.05368138) * tmpvar_10) - 0.1173503)
     * tmpvar_10) + 0.1938925) * tmpvar_10) - 0.3326756)
   * tmpvar_10) + 0.9999793) * tmpvar_9);
  tmpvar_10 = (tmpvar_10 + (float(
    (abs((tmpvar_3 / tmpvar_4)) > 1.0)
  ) * (
    (tmpvar_10 * -2.0)
   + 1.570796)));
  tmpvar_8 = (tmpvar_10 * sign((tmpvar_3 / tmpvar_4)));
  if ((abs(tmpvar_4) > (1e-08 * abs(tmpvar_3)))) {
    if ((tmpvar_4 < 0.0)) {
      if ((tmpvar_3 >= 0.0)) {
        tmpvar_8 += 3.141593;
      } else {
        tmpvar_8 = (tmpvar_8 - 3.141593);
      };
    };
  } else {
    tmpvar_8 = (sign(tmpvar_3) * 1.570796);
  };
  clampSin_2 = ((sin(
    ((tmpvar_8 * 2.0) + (tmpvar_5 * -55.0))
  ) + 0.5) - ((
    cos((12.56 * tmpvar_5))
   + 0.5) * 1.2));
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = ((vec3(clampSin_2) * _ColorA.xyz) + ((vec3(1.0, 1.0, 1.0) - vec3(clampSin_2)) * _ColorB.xyz));
  tmpvar_11.w = (((clampSin_2 * _ColorA.w) + (
    (1.0 - clampSin_2)
   * _ColorB.w)) * tmpvar_6);
  col_1 = tmpvar_11;
  col_1.xyz = (col_1.xyz * col_1.w);
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