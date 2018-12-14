Shader "Hidden/Internal-GUIRoundedRect" {
Properties {
_MainTex ("Texture", any) = "white" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 62409
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 unity_GUIClipTextureMatrix;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.xy = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_2)).xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_GUIClipTextureMatrix * tmpvar_4).xy;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform sampler2D _MainTex;
uniform sampler2D _GUIClipTexture;
uniform highp float _CornerRadiuses[4];
uniform highp float _BorderWidths[4];
uniform highp float _Rect[4];
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 center_2;
  highp int radiusIndex_3;
  highp float bw2_4;
  highp float bw1_5;
  mediump vec4 col_6;
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(abs(dFdx(xlv_TEXCOORD2.x))));
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  col_6 = tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (((xlv_TEXCOORD2.x - _Rect[0]) - (_Rect[2] / 2.0)) <= 0.0);
  bool tmpvar_10;
  tmpvar_10 = (((xlv_TEXCOORD2.y - _Rect[1]) - (_Rect[3] / 2.0)) <= 0.0);
  bw1_5 = _BorderWidths[0];
  bw2_4 = _BorderWidths[1];
  radiusIndex_3 = 0;
  if (tmpvar_9) {
    highp int tmpvar_11;
    if (tmpvar_10) {
      tmpvar_11 = 0;
    } else {
      tmpvar_11 = 3;
    };
    radiusIndex_3 = tmpvar_11;
  } else {
    highp int tmpvar_12;
    if (tmpvar_10) {
      tmpvar_12 = 1;
    } else {
      tmpvar_12 = 2;
    };
    radiusIndex_3 = tmpvar_12;
  };
  highp float tmpvar_13;
  tmpvar_13 = _CornerRadiuses[radiusIndex_3];
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_Rect[0] + tmpvar_13);
  tmpvar_14.y = (_Rect[1] + tmpvar_13);
  center_2 = tmpvar_14;
  if (!(tmpvar_9)) {
    center_2.x = ((_Rect[0] + _Rect[2]) - tmpvar_13);
    bw1_5 = _BorderWidths[2];
  };
  if (!(tmpvar_10)) {
    center_2.y = ((_Rect[1] + _Rect[3]) - tmpvar_13);
    bw2_4 = _BorderWidths[3];
  };
  bool tmpvar_15;
  if (tmpvar_9) {
    tmpvar_15 = (xlv_TEXCOORD2.x <= center_2.x);
  } else {
    tmpvar_15 = (xlv_TEXCOORD2.x >= center_2.x);
  };
  bool tmpvar_16;
  if (tmpvar_15) {
    bool tmpvar_17;
    if (tmpvar_10) {
      tmpvar_17 = (xlv_TEXCOORD2.y <= center_2.y);
    } else {
      tmpvar_17 = (xlv_TEXCOORD2.y >= center_2.y);
    };
    tmpvar_16 = tmpvar_17;
  } else {
    tmpvar_16 = bool(0);
  };
  mediump float tmpvar_18;
  if (tmpvar_16) {
    mediump float rawDist_19;
    highp vec2 v_20;
    bool tmpvar_21;
    tmpvar_21 = ((bw1_5 > 0.0) || (bw2_4 > 0.0));
    highp vec2 tmpvar_22;
    tmpvar_22 = (xlv_TEXCOORD2.xy - center_2);
    v_20 = tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = ((sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - tmpvar_13) * tmpvar_7);
    mediump float tmpvar_24;
    if (tmpvar_21) {
      highp float tmpvar_25;
      tmpvar_25 = clamp ((0.5 + tmpvar_23), 0.0, 1.0);
      tmpvar_24 = tmpvar_25;
    } else {
      tmpvar_24 = 0.0;
    };
    highp float tmpvar_26;
    tmpvar_26 = (tmpvar_13 - bw1_5);
    highp float tmpvar_27;
    tmpvar_27 = (tmpvar_13 - bw2_4);
    v_20.y = (tmpvar_22.y * (tmpvar_26 / tmpvar_27));
    highp float tmpvar_28;
    tmpvar_28 = ((sqrt(
      dot (v_20, v_20)
    ) - tmpvar_26) * tmpvar_7);
    rawDist_19 = tmpvar_28;
    mediump float tmpvar_29;
    tmpvar_29 = clamp ((rawDist_19 + 0.5), 0.0, 1.0);
    mediump float tmpvar_30;
    if (tmpvar_21) {
      mediump float tmpvar_31;
      if (((tmpvar_26 > 0.0) && (tmpvar_27 > 0.0))) {
        tmpvar_31 = tmpvar_29;
      } else {
        tmpvar_31 = 1.0;
      };
      tmpvar_30 = tmpvar_31;
    } else {
      tmpvar_30 = 0.0;
    };
    mediump float tmpvar_32;
    if ((tmpvar_24 == 0.0)) {
      tmpvar_32 = tmpvar_30;
    } else {
      tmpvar_32 = (1.0 - tmpvar_24);
    };
    tmpvar_18 = tmpvar_32;
  } else {
    tmpvar_18 = 1.0;
  };
  col_6.w = (col_6.w * tmpvar_18);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (_Rect[0] + _BorderWidths[0]);
  tmpvar_33.y = (_Rect[1] + _BorderWidths[1]);
  tmpvar_33.z = (_Rect[2] - (_BorderWidths[0] + _BorderWidths[2]));
  tmpvar_33.w = (_Rect[3] - (_BorderWidths[1] + _BorderWidths[3]));
  bool tmpvar_34;
  tmpvar_34 = (((
    (xlv_TEXCOORD2.x >= tmpvar_33.x)
   && 
    (xlv_TEXCOORD2.x <= (tmpvar_33.x + tmpvar_33.z))
  ) && (xlv_TEXCOORD2.y >= tmpvar_33.y)) && (xlv_TEXCOORD2.y <= (tmpvar_33.y + tmpvar_33.w)));
  mediump float tmpvar_35;
  if (tmpvar_34) {
    tmpvar_35 = 0.0;
  } else {
    tmpvar_35 = col_6.w;
  };
  mediump float tmpvar_36;
  if ((((
    (_BorderWidths[0] > 0.0)
   || 
    (_BorderWidths[1] > 0.0)
  ) || (_BorderWidths[2] > 0.0)) || (_BorderWidths[3] > 0.0))) {
    mediump float tmpvar_37;
    if (tmpvar_16) {
      tmpvar_37 = col_6.w;
    } else {
      tmpvar_37 = tmpvar_35;
    };
    tmpvar_36 = tmpvar_37;
  } else {
    tmpvar_36 = 1.0;
  };
  col_6.w = (col_6.w * tmpvar_36);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_GUIClipTexture, xlv_TEXCOORD1);
  col_6.w = (col_6.w * tmpvar_38.w);
  tmpvar_1 = col_6;
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
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 unity_GUIClipTextureMatrix;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.xy = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_2)).xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_GUIClipTextureMatrix * tmpvar_4).xy;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform sampler2D _MainTex;
uniform sampler2D _GUIClipTexture;
uniform highp float _CornerRadiuses[4];
uniform highp float _BorderWidths[4];
uniform highp float _Rect[4];
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 center_2;
  highp int radiusIndex_3;
  highp float bw2_4;
  highp float bw1_5;
  mediump vec4 col_6;
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(abs(dFdx(xlv_TEXCOORD2.x))));
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  col_6 = tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (((xlv_TEXCOORD2.x - _Rect[0]) - (_Rect[2] / 2.0)) <= 0.0);
  bool tmpvar_10;
  tmpvar_10 = (((xlv_TEXCOORD2.y - _Rect[1]) - (_Rect[3] / 2.0)) <= 0.0);
  bw1_5 = _BorderWidths[0];
  bw2_4 = _BorderWidths[1];
  radiusIndex_3 = 0;
  if (tmpvar_9) {
    highp int tmpvar_11;
    if (tmpvar_10) {
      tmpvar_11 = 0;
    } else {
      tmpvar_11 = 3;
    };
    radiusIndex_3 = tmpvar_11;
  } else {
    highp int tmpvar_12;
    if (tmpvar_10) {
      tmpvar_12 = 1;
    } else {
      tmpvar_12 = 2;
    };
    radiusIndex_3 = tmpvar_12;
  };
  highp float tmpvar_13;
  tmpvar_13 = _CornerRadiuses[radiusIndex_3];
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_Rect[0] + tmpvar_13);
  tmpvar_14.y = (_Rect[1] + tmpvar_13);
  center_2 = tmpvar_14;
  if (!(tmpvar_9)) {
    center_2.x = ((_Rect[0] + _Rect[2]) - tmpvar_13);
    bw1_5 = _BorderWidths[2];
  };
  if (!(tmpvar_10)) {
    center_2.y = ((_Rect[1] + _Rect[3]) - tmpvar_13);
    bw2_4 = _BorderWidths[3];
  };
  bool tmpvar_15;
  if (tmpvar_9) {
    tmpvar_15 = (xlv_TEXCOORD2.x <= center_2.x);
  } else {
    tmpvar_15 = (xlv_TEXCOORD2.x >= center_2.x);
  };
  bool tmpvar_16;
  if (tmpvar_15) {
    bool tmpvar_17;
    if (tmpvar_10) {
      tmpvar_17 = (xlv_TEXCOORD2.y <= center_2.y);
    } else {
      tmpvar_17 = (xlv_TEXCOORD2.y >= center_2.y);
    };
    tmpvar_16 = tmpvar_17;
  } else {
    tmpvar_16 = bool(0);
  };
  mediump float tmpvar_18;
  if (tmpvar_16) {
    mediump float rawDist_19;
    highp vec2 v_20;
    bool tmpvar_21;
    tmpvar_21 = ((bw1_5 > 0.0) || (bw2_4 > 0.0));
    highp vec2 tmpvar_22;
    tmpvar_22 = (xlv_TEXCOORD2.xy - center_2);
    v_20 = tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = ((sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - tmpvar_13) * tmpvar_7);
    mediump float tmpvar_24;
    if (tmpvar_21) {
      highp float tmpvar_25;
      tmpvar_25 = clamp ((0.5 + tmpvar_23), 0.0, 1.0);
      tmpvar_24 = tmpvar_25;
    } else {
      tmpvar_24 = 0.0;
    };
    highp float tmpvar_26;
    tmpvar_26 = (tmpvar_13 - bw1_5);
    highp float tmpvar_27;
    tmpvar_27 = (tmpvar_13 - bw2_4);
    v_20.y = (tmpvar_22.y * (tmpvar_26 / tmpvar_27));
    highp float tmpvar_28;
    tmpvar_28 = ((sqrt(
      dot (v_20, v_20)
    ) - tmpvar_26) * tmpvar_7);
    rawDist_19 = tmpvar_28;
    mediump float tmpvar_29;
    tmpvar_29 = clamp ((rawDist_19 + 0.5), 0.0, 1.0);
    mediump float tmpvar_30;
    if (tmpvar_21) {
      mediump float tmpvar_31;
      if (((tmpvar_26 > 0.0) && (tmpvar_27 > 0.0))) {
        tmpvar_31 = tmpvar_29;
      } else {
        tmpvar_31 = 1.0;
      };
      tmpvar_30 = tmpvar_31;
    } else {
      tmpvar_30 = 0.0;
    };
    mediump float tmpvar_32;
    if ((tmpvar_24 == 0.0)) {
      tmpvar_32 = tmpvar_30;
    } else {
      tmpvar_32 = (1.0 - tmpvar_24);
    };
    tmpvar_18 = tmpvar_32;
  } else {
    tmpvar_18 = 1.0;
  };
  col_6.w = (col_6.w * tmpvar_18);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (_Rect[0] + _BorderWidths[0]);
  tmpvar_33.y = (_Rect[1] + _BorderWidths[1]);
  tmpvar_33.z = (_Rect[2] - (_BorderWidths[0] + _BorderWidths[2]));
  tmpvar_33.w = (_Rect[3] - (_BorderWidths[1] + _BorderWidths[3]));
  bool tmpvar_34;
  tmpvar_34 = (((
    (xlv_TEXCOORD2.x >= tmpvar_33.x)
   && 
    (xlv_TEXCOORD2.x <= (tmpvar_33.x + tmpvar_33.z))
  ) && (xlv_TEXCOORD2.y >= tmpvar_33.y)) && (xlv_TEXCOORD2.y <= (tmpvar_33.y + tmpvar_33.w)));
  mediump float tmpvar_35;
  if (tmpvar_34) {
    tmpvar_35 = 0.0;
  } else {
    tmpvar_35 = col_6.w;
  };
  mediump float tmpvar_36;
  if ((((
    (_BorderWidths[0] > 0.0)
   || 
    (_BorderWidths[1] > 0.0)
  ) || (_BorderWidths[2] > 0.0)) || (_BorderWidths[3] > 0.0))) {
    mediump float tmpvar_37;
    if (tmpvar_16) {
      tmpvar_37 = col_6.w;
    } else {
      tmpvar_37 = tmpvar_35;
    };
    tmpvar_36 = tmpvar_37;
  } else {
    tmpvar_36 = 1.0;
  };
  col_6.w = (col_6.w * tmpvar_36);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_GUIClipTexture, xlv_TEXCOORD1);
  col_6.w = (col_6.w * tmpvar_38.w);
  tmpvar_1 = col_6;
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
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 unity_GUIClipTextureMatrix;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.xy = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_2)).xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_GUIClipTextureMatrix * tmpvar_4).xy;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform sampler2D _MainTex;
uniform sampler2D _GUIClipTexture;
uniform highp float _CornerRadiuses[4];
uniform highp float _BorderWidths[4];
uniform highp float _Rect[4];
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 center_2;
  highp int radiusIndex_3;
  highp float bw2_4;
  highp float bw1_5;
  mediump vec4 col_6;
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(abs(dFdx(xlv_TEXCOORD2.x))));
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  col_6 = tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (((xlv_TEXCOORD2.x - _Rect[0]) - (_Rect[2] / 2.0)) <= 0.0);
  bool tmpvar_10;
  tmpvar_10 = (((xlv_TEXCOORD2.y - _Rect[1]) - (_Rect[3] / 2.0)) <= 0.0);
  bw1_5 = _BorderWidths[0];
  bw2_4 = _BorderWidths[1];
  radiusIndex_3 = 0;
  if (tmpvar_9) {
    highp int tmpvar_11;
    if (tmpvar_10) {
      tmpvar_11 = 0;
    } else {
      tmpvar_11 = 3;
    };
    radiusIndex_3 = tmpvar_11;
  } else {
    highp int tmpvar_12;
    if (tmpvar_10) {
      tmpvar_12 = 1;
    } else {
      tmpvar_12 = 2;
    };
    radiusIndex_3 = tmpvar_12;
  };
  highp float tmpvar_13;
  tmpvar_13 = _CornerRadiuses[radiusIndex_3];
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_Rect[0] + tmpvar_13);
  tmpvar_14.y = (_Rect[1] + tmpvar_13);
  center_2 = tmpvar_14;
  if (!(tmpvar_9)) {
    center_2.x = ((_Rect[0] + _Rect[2]) - tmpvar_13);
    bw1_5 = _BorderWidths[2];
  };
  if (!(tmpvar_10)) {
    center_2.y = ((_Rect[1] + _Rect[3]) - tmpvar_13);
    bw2_4 = _BorderWidths[3];
  };
  bool tmpvar_15;
  if (tmpvar_9) {
    tmpvar_15 = (xlv_TEXCOORD2.x <= center_2.x);
  } else {
    tmpvar_15 = (xlv_TEXCOORD2.x >= center_2.x);
  };
  bool tmpvar_16;
  if (tmpvar_15) {
    bool tmpvar_17;
    if (tmpvar_10) {
      tmpvar_17 = (xlv_TEXCOORD2.y <= center_2.y);
    } else {
      tmpvar_17 = (xlv_TEXCOORD2.y >= center_2.y);
    };
    tmpvar_16 = tmpvar_17;
  } else {
    tmpvar_16 = bool(0);
  };
  mediump float tmpvar_18;
  if (tmpvar_16) {
    mediump float rawDist_19;
    highp vec2 v_20;
    bool tmpvar_21;
    tmpvar_21 = ((bw1_5 > 0.0) || (bw2_4 > 0.0));
    highp vec2 tmpvar_22;
    tmpvar_22 = (xlv_TEXCOORD2.xy - center_2);
    v_20 = tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = ((sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - tmpvar_13) * tmpvar_7);
    mediump float tmpvar_24;
    if (tmpvar_21) {
      highp float tmpvar_25;
      tmpvar_25 = clamp ((0.5 + tmpvar_23), 0.0, 1.0);
      tmpvar_24 = tmpvar_25;
    } else {
      tmpvar_24 = 0.0;
    };
    highp float tmpvar_26;
    tmpvar_26 = (tmpvar_13 - bw1_5);
    highp float tmpvar_27;
    tmpvar_27 = (tmpvar_13 - bw2_4);
    v_20.y = (tmpvar_22.y * (tmpvar_26 / tmpvar_27));
    highp float tmpvar_28;
    tmpvar_28 = ((sqrt(
      dot (v_20, v_20)
    ) - tmpvar_26) * tmpvar_7);
    rawDist_19 = tmpvar_28;
    mediump float tmpvar_29;
    tmpvar_29 = clamp ((rawDist_19 + 0.5), 0.0, 1.0);
    mediump float tmpvar_30;
    if (tmpvar_21) {
      mediump float tmpvar_31;
      if (((tmpvar_26 > 0.0) && (tmpvar_27 > 0.0))) {
        tmpvar_31 = tmpvar_29;
      } else {
        tmpvar_31 = 1.0;
      };
      tmpvar_30 = tmpvar_31;
    } else {
      tmpvar_30 = 0.0;
    };
    mediump float tmpvar_32;
    if ((tmpvar_24 == 0.0)) {
      tmpvar_32 = tmpvar_30;
    } else {
      tmpvar_32 = (1.0 - tmpvar_24);
    };
    tmpvar_18 = tmpvar_32;
  } else {
    tmpvar_18 = 1.0;
  };
  col_6.w = (col_6.w * tmpvar_18);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (_Rect[0] + _BorderWidths[0]);
  tmpvar_33.y = (_Rect[1] + _BorderWidths[1]);
  tmpvar_33.z = (_Rect[2] - (_BorderWidths[0] + _BorderWidths[2]));
  tmpvar_33.w = (_Rect[3] - (_BorderWidths[1] + _BorderWidths[3]));
  bool tmpvar_34;
  tmpvar_34 = (((
    (xlv_TEXCOORD2.x >= tmpvar_33.x)
   && 
    (xlv_TEXCOORD2.x <= (tmpvar_33.x + tmpvar_33.z))
  ) && (xlv_TEXCOORD2.y >= tmpvar_33.y)) && (xlv_TEXCOORD2.y <= (tmpvar_33.y + tmpvar_33.w)));
  mediump float tmpvar_35;
  if (tmpvar_34) {
    tmpvar_35 = 0.0;
  } else {
    tmpvar_35 = col_6.w;
  };
  mediump float tmpvar_36;
  if ((((
    (_BorderWidths[0] > 0.0)
   || 
    (_BorderWidths[1] > 0.0)
  ) || (_BorderWidths[2] > 0.0)) || (_BorderWidths[3] > 0.0))) {
    mediump float tmpvar_37;
    if (tmpvar_16) {
      tmpvar_37 = col_6.w;
    } else {
      tmpvar_37 = tmpvar_35;
    };
    tmpvar_36 = tmpvar_37;
  } else {
    tmpvar_36 = 1.0;
  };
  col_6.w = (col_6.w * tmpvar_36);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_GUIClipTexture, xlv_TEXCOORD1);
  col_6.w = (col_6.w * tmpvar_38.w);
  tmpvar_1 = col_6;
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
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 77836
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 unity_GUIClipTextureMatrix;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.xy = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_2)).xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_GUIClipTextureMatrix * tmpvar_4).xy;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform sampler2D _MainTex;
uniform sampler2D _GUIClipTexture;
uniform highp float _CornerRadiuses[4];
uniform highp float _BorderWidths[4];
uniform highp float _Rect[4];
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 center_2;
  highp int radiusIndex_3;
  highp float bw2_4;
  highp float bw1_5;
  mediump vec4 col_6;
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(abs(dFdx(xlv_TEXCOORD2.x))));
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  col_6 = tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (((xlv_TEXCOORD2.x - _Rect[0]) - (_Rect[2] / 2.0)) <= 0.0);
  bool tmpvar_10;
  tmpvar_10 = (((xlv_TEXCOORD2.y - _Rect[1]) - (_Rect[3] / 2.0)) <= 0.0);
  bw1_5 = _BorderWidths[0];
  bw2_4 = _BorderWidths[1];
  radiusIndex_3 = 0;
  if (tmpvar_9) {
    highp int tmpvar_11;
    if (tmpvar_10) {
      tmpvar_11 = 0;
    } else {
      tmpvar_11 = 3;
    };
    radiusIndex_3 = tmpvar_11;
  } else {
    highp int tmpvar_12;
    if (tmpvar_10) {
      tmpvar_12 = 1;
    } else {
      tmpvar_12 = 2;
    };
    radiusIndex_3 = tmpvar_12;
  };
  highp float tmpvar_13;
  tmpvar_13 = _CornerRadiuses[radiusIndex_3];
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_Rect[0] + tmpvar_13);
  tmpvar_14.y = (_Rect[1] + tmpvar_13);
  center_2 = tmpvar_14;
  if (!(tmpvar_9)) {
    center_2.x = ((_Rect[0] + _Rect[2]) - tmpvar_13);
    bw1_5 = _BorderWidths[2];
  };
  if (!(tmpvar_10)) {
    center_2.y = ((_Rect[1] + _Rect[3]) - tmpvar_13);
    bw2_4 = _BorderWidths[3];
  };
  bool tmpvar_15;
  if (tmpvar_9) {
    tmpvar_15 = (xlv_TEXCOORD2.x <= center_2.x);
  } else {
    tmpvar_15 = (xlv_TEXCOORD2.x >= center_2.x);
  };
  bool tmpvar_16;
  if (tmpvar_15) {
    bool tmpvar_17;
    if (tmpvar_10) {
      tmpvar_17 = (xlv_TEXCOORD2.y <= center_2.y);
    } else {
      tmpvar_17 = (xlv_TEXCOORD2.y >= center_2.y);
    };
    tmpvar_16 = tmpvar_17;
  } else {
    tmpvar_16 = bool(0);
  };
  mediump float tmpvar_18;
  if (tmpvar_16) {
    mediump float rawDist_19;
    highp vec2 v_20;
    bool tmpvar_21;
    tmpvar_21 = ((bw1_5 > 0.0) || (bw2_4 > 0.0));
    highp vec2 tmpvar_22;
    tmpvar_22 = (xlv_TEXCOORD2.xy - center_2);
    v_20 = tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = ((sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - tmpvar_13) * tmpvar_7);
    mediump float tmpvar_24;
    if (tmpvar_21) {
      highp float tmpvar_25;
      tmpvar_25 = clamp ((0.5 + tmpvar_23), 0.0, 1.0);
      tmpvar_24 = tmpvar_25;
    } else {
      tmpvar_24 = 0.0;
    };
    highp float tmpvar_26;
    tmpvar_26 = (tmpvar_13 - bw1_5);
    highp float tmpvar_27;
    tmpvar_27 = (tmpvar_13 - bw2_4);
    v_20.y = (tmpvar_22.y * (tmpvar_26 / tmpvar_27));
    highp float tmpvar_28;
    tmpvar_28 = ((sqrt(
      dot (v_20, v_20)
    ) - tmpvar_26) * tmpvar_7);
    rawDist_19 = tmpvar_28;
    mediump float tmpvar_29;
    tmpvar_29 = clamp ((rawDist_19 + 0.5), 0.0, 1.0);
    mediump float tmpvar_30;
    if (tmpvar_21) {
      mediump float tmpvar_31;
      if (((tmpvar_26 > 0.0) && (tmpvar_27 > 0.0))) {
        tmpvar_31 = tmpvar_29;
      } else {
        tmpvar_31 = 1.0;
      };
      tmpvar_30 = tmpvar_31;
    } else {
      tmpvar_30 = 0.0;
    };
    mediump float tmpvar_32;
    if ((tmpvar_24 == 0.0)) {
      tmpvar_32 = tmpvar_30;
    } else {
      tmpvar_32 = (1.0 - tmpvar_24);
    };
    tmpvar_18 = tmpvar_32;
  } else {
    tmpvar_18 = 1.0;
  };
  col_6.w = (col_6.w * tmpvar_18);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (_Rect[0] + _BorderWidths[0]);
  tmpvar_33.y = (_Rect[1] + _BorderWidths[1]);
  tmpvar_33.z = (_Rect[2] - (_BorderWidths[0] + _BorderWidths[2]));
  tmpvar_33.w = (_Rect[3] - (_BorderWidths[1] + _BorderWidths[3]));
  bool tmpvar_34;
  tmpvar_34 = (((
    (xlv_TEXCOORD2.x >= tmpvar_33.x)
   && 
    (xlv_TEXCOORD2.x <= (tmpvar_33.x + tmpvar_33.z))
  ) && (xlv_TEXCOORD2.y >= tmpvar_33.y)) && (xlv_TEXCOORD2.y <= (tmpvar_33.y + tmpvar_33.w)));
  mediump float tmpvar_35;
  if (tmpvar_34) {
    tmpvar_35 = 0.0;
  } else {
    tmpvar_35 = col_6.w;
  };
  mediump float tmpvar_36;
  if ((((
    (_BorderWidths[0] > 0.0)
   || 
    (_BorderWidths[1] > 0.0)
  ) || (_BorderWidths[2] > 0.0)) || (_BorderWidths[3] > 0.0))) {
    mediump float tmpvar_37;
    if (tmpvar_16) {
      tmpvar_37 = col_6.w;
    } else {
      tmpvar_37 = tmpvar_35;
    };
    tmpvar_36 = tmpvar_37;
  } else {
    tmpvar_36 = 1.0;
  };
  col_6.w = (col_6.w * tmpvar_36);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_GUIClipTexture, xlv_TEXCOORD1);
  col_6.w = (col_6.w * tmpvar_38.w);
  tmpvar_1 = col_6;
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
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 unity_GUIClipTextureMatrix;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.xy = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_2)).xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_GUIClipTextureMatrix * tmpvar_4).xy;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform sampler2D _MainTex;
uniform sampler2D _GUIClipTexture;
uniform highp float _CornerRadiuses[4];
uniform highp float _BorderWidths[4];
uniform highp float _Rect[4];
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 center_2;
  highp int radiusIndex_3;
  highp float bw2_4;
  highp float bw1_5;
  mediump vec4 col_6;
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(abs(dFdx(xlv_TEXCOORD2.x))));
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  col_6 = tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (((xlv_TEXCOORD2.x - _Rect[0]) - (_Rect[2] / 2.0)) <= 0.0);
  bool tmpvar_10;
  tmpvar_10 = (((xlv_TEXCOORD2.y - _Rect[1]) - (_Rect[3] / 2.0)) <= 0.0);
  bw1_5 = _BorderWidths[0];
  bw2_4 = _BorderWidths[1];
  radiusIndex_3 = 0;
  if (tmpvar_9) {
    highp int tmpvar_11;
    if (tmpvar_10) {
      tmpvar_11 = 0;
    } else {
      tmpvar_11 = 3;
    };
    radiusIndex_3 = tmpvar_11;
  } else {
    highp int tmpvar_12;
    if (tmpvar_10) {
      tmpvar_12 = 1;
    } else {
      tmpvar_12 = 2;
    };
    radiusIndex_3 = tmpvar_12;
  };
  highp float tmpvar_13;
  tmpvar_13 = _CornerRadiuses[radiusIndex_3];
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_Rect[0] + tmpvar_13);
  tmpvar_14.y = (_Rect[1] + tmpvar_13);
  center_2 = tmpvar_14;
  if (!(tmpvar_9)) {
    center_2.x = ((_Rect[0] + _Rect[2]) - tmpvar_13);
    bw1_5 = _BorderWidths[2];
  };
  if (!(tmpvar_10)) {
    center_2.y = ((_Rect[1] + _Rect[3]) - tmpvar_13);
    bw2_4 = _BorderWidths[3];
  };
  bool tmpvar_15;
  if (tmpvar_9) {
    tmpvar_15 = (xlv_TEXCOORD2.x <= center_2.x);
  } else {
    tmpvar_15 = (xlv_TEXCOORD2.x >= center_2.x);
  };
  bool tmpvar_16;
  if (tmpvar_15) {
    bool tmpvar_17;
    if (tmpvar_10) {
      tmpvar_17 = (xlv_TEXCOORD2.y <= center_2.y);
    } else {
      tmpvar_17 = (xlv_TEXCOORD2.y >= center_2.y);
    };
    tmpvar_16 = tmpvar_17;
  } else {
    tmpvar_16 = bool(0);
  };
  mediump float tmpvar_18;
  if (tmpvar_16) {
    mediump float rawDist_19;
    highp vec2 v_20;
    bool tmpvar_21;
    tmpvar_21 = ((bw1_5 > 0.0) || (bw2_4 > 0.0));
    highp vec2 tmpvar_22;
    tmpvar_22 = (xlv_TEXCOORD2.xy - center_2);
    v_20 = tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = ((sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - tmpvar_13) * tmpvar_7);
    mediump float tmpvar_24;
    if (tmpvar_21) {
      highp float tmpvar_25;
      tmpvar_25 = clamp ((0.5 + tmpvar_23), 0.0, 1.0);
      tmpvar_24 = tmpvar_25;
    } else {
      tmpvar_24 = 0.0;
    };
    highp float tmpvar_26;
    tmpvar_26 = (tmpvar_13 - bw1_5);
    highp float tmpvar_27;
    tmpvar_27 = (tmpvar_13 - bw2_4);
    v_20.y = (tmpvar_22.y * (tmpvar_26 / tmpvar_27));
    highp float tmpvar_28;
    tmpvar_28 = ((sqrt(
      dot (v_20, v_20)
    ) - tmpvar_26) * tmpvar_7);
    rawDist_19 = tmpvar_28;
    mediump float tmpvar_29;
    tmpvar_29 = clamp ((rawDist_19 + 0.5), 0.0, 1.0);
    mediump float tmpvar_30;
    if (tmpvar_21) {
      mediump float tmpvar_31;
      if (((tmpvar_26 > 0.0) && (tmpvar_27 > 0.0))) {
        tmpvar_31 = tmpvar_29;
      } else {
        tmpvar_31 = 1.0;
      };
      tmpvar_30 = tmpvar_31;
    } else {
      tmpvar_30 = 0.0;
    };
    mediump float tmpvar_32;
    if ((tmpvar_24 == 0.0)) {
      tmpvar_32 = tmpvar_30;
    } else {
      tmpvar_32 = (1.0 - tmpvar_24);
    };
    tmpvar_18 = tmpvar_32;
  } else {
    tmpvar_18 = 1.0;
  };
  col_6.w = (col_6.w * tmpvar_18);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (_Rect[0] + _BorderWidths[0]);
  tmpvar_33.y = (_Rect[1] + _BorderWidths[1]);
  tmpvar_33.z = (_Rect[2] - (_BorderWidths[0] + _BorderWidths[2]));
  tmpvar_33.w = (_Rect[3] - (_BorderWidths[1] + _BorderWidths[3]));
  bool tmpvar_34;
  tmpvar_34 = (((
    (xlv_TEXCOORD2.x >= tmpvar_33.x)
   && 
    (xlv_TEXCOORD2.x <= (tmpvar_33.x + tmpvar_33.z))
  ) && (xlv_TEXCOORD2.y >= tmpvar_33.y)) && (xlv_TEXCOORD2.y <= (tmpvar_33.y + tmpvar_33.w)));
  mediump float tmpvar_35;
  if (tmpvar_34) {
    tmpvar_35 = 0.0;
  } else {
    tmpvar_35 = col_6.w;
  };
  mediump float tmpvar_36;
  if ((((
    (_BorderWidths[0] > 0.0)
   || 
    (_BorderWidths[1] > 0.0)
  ) || (_BorderWidths[2] > 0.0)) || (_BorderWidths[3] > 0.0))) {
    mediump float tmpvar_37;
    if (tmpvar_16) {
      tmpvar_37 = col_6.w;
    } else {
      tmpvar_37 = tmpvar_35;
    };
    tmpvar_36 = tmpvar_37;
  } else {
    tmpvar_36 = 1.0;
  };
  col_6.w = (col_6.w * tmpvar_36);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_GUIClipTexture, xlv_TEXCOORD1);
  col_6.w = (col_6.w * tmpvar_38.w);
  tmpvar_1 = col_6;
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
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 unity_GUIClipTextureMatrix;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.xy = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_2)).xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_GUIClipTextureMatrix * tmpvar_4).xy;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform sampler2D _MainTex;
uniform sampler2D _GUIClipTexture;
uniform highp float _CornerRadiuses[4];
uniform highp float _BorderWidths[4];
uniform highp float _Rect[4];
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 center_2;
  highp int radiusIndex_3;
  highp float bw2_4;
  highp float bw1_5;
  mediump vec4 col_6;
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(abs(dFdx(xlv_TEXCOORD2.x))));
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  col_6 = tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (((xlv_TEXCOORD2.x - _Rect[0]) - (_Rect[2] / 2.0)) <= 0.0);
  bool tmpvar_10;
  tmpvar_10 = (((xlv_TEXCOORD2.y - _Rect[1]) - (_Rect[3] / 2.0)) <= 0.0);
  bw1_5 = _BorderWidths[0];
  bw2_4 = _BorderWidths[1];
  radiusIndex_3 = 0;
  if (tmpvar_9) {
    highp int tmpvar_11;
    if (tmpvar_10) {
      tmpvar_11 = 0;
    } else {
      tmpvar_11 = 3;
    };
    radiusIndex_3 = tmpvar_11;
  } else {
    highp int tmpvar_12;
    if (tmpvar_10) {
      tmpvar_12 = 1;
    } else {
      tmpvar_12 = 2;
    };
    radiusIndex_3 = tmpvar_12;
  };
  highp float tmpvar_13;
  tmpvar_13 = _CornerRadiuses[radiusIndex_3];
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_Rect[0] + tmpvar_13);
  tmpvar_14.y = (_Rect[1] + tmpvar_13);
  center_2 = tmpvar_14;
  if (!(tmpvar_9)) {
    center_2.x = ((_Rect[0] + _Rect[2]) - tmpvar_13);
    bw1_5 = _BorderWidths[2];
  };
  if (!(tmpvar_10)) {
    center_2.y = ((_Rect[1] + _Rect[3]) - tmpvar_13);
    bw2_4 = _BorderWidths[3];
  };
  bool tmpvar_15;
  if (tmpvar_9) {
    tmpvar_15 = (xlv_TEXCOORD2.x <= center_2.x);
  } else {
    tmpvar_15 = (xlv_TEXCOORD2.x >= center_2.x);
  };
  bool tmpvar_16;
  if (tmpvar_15) {
    bool tmpvar_17;
    if (tmpvar_10) {
      tmpvar_17 = (xlv_TEXCOORD2.y <= center_2.y);
    } else {
      tmpvar_17 = (xlv_TEXCOORD2.y >= center_2.y);
    };
    tmpvar_16 = tmpvar_17;
  } else {
    tmpvar_16 = bool(0);
  };
  mediump float tmpvar_18;
  if (tmpvar_16) {
    mediump float rawDist_19;
    highp vec2 v_20;
    bool tmpvar_21;
    tmpvar_21 = ((bw1_5 > 0.0) || (bw2_4 > 0.0));
    highp vec2 tmpvar_22;
    tmpvar_22 = (xlv_TEXCOORD2.xy - center_2);
    v_20 = tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = ((sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - tmpvar_13) * tmpvar_7);
    mediump float tmpvar_24;
    if (tmpvar_21) {
      highp float tmpvar_25;
      tmpvar_25 = clamp ((0.5 + tmpvar_23), 0.0, 1.0);
      tmpvar_24 = tmpvar_25;
    } else {
      tmpvar_24 = 0.0;
    };
    highp float tmpvar_26;
    tmpvar_26 = (tmpvar_13 - bw1_5);
    highp float tmpvar_27;
    tmpvar_27 = (tmpvar_13 - bw2_4);
    v_20.y = (tmpvar_22.y * (tmpvar_26 / tmpvar_27));
    highp float tmpvar_28;
    tmpvar_28 = ((sqrt(
      dot (v_20, v_20)
    ) - tmpvar_26) * tmpvar_7);
    rawDist_19 = tmpvar_28;
    mediump float tmpvar_29;
    tmpvar_29 = clamp ((rawDist_19 + 0.5), 0.0, 1.0);
    mediump float tmpvar_30;
    if (tmpvar_21) {
      mediump float tmpvar_31;
      if (((tmpvar_26 > 0.0) && (tmpvar_27 > 0.0))) {
        tmpvar_31 = tmpvar_29;
      } else {
        tmpvar_31 = 1.0;
      };
      tmpvar_30 = tmpvar_31;
    } else {
      tmpvar_30 = 0.0;
    };
    mediump float tmpvar_32;
    if ((tmpvar_24 == 0.0)) {
      tmpvar_32 = tmpvar_30;
    } else {
      tmpvar_32 = (1.0 - tmpvar_24);
    };
    tmpvar_18 = tmpvar_32;
  } else {
    tmpvar_18 = 1.0;
  };
  col_6.w = (col_6.w * tmpvar_18);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (_Rect[0] + _BorderWidths[0]);
  tmpvar_33.y = (_Rect[1] + _BorderWidths[1]);
  tmpvar_33.z = (_Rect[2] - (_BorderWidths[0] + _BorderWidths[2]));
  tmpvar_33.w = (_Rect[3] - (_BorderWidths[1] + _BorderWidths[3]));
  bool tmpvar_34;
  tmpvar_34 = (((
    (xlv_TEXCOORD2.x >= tmpvar_33.x)
   && 
    (xlv_TEXCOORD2.x <= (tmpvar_33.x + tmpvar_33.z))
  ) && (xlv_TEXCOORD2.y >= tmpvar_33.y)) && (xlv_TEXCOORD2.y <= (tmpvar_33.y + tmpvar_33.w)));
  mediump float tmpvar_35;
  if (tmpvar_34) {
    tmpvar_35 = 0.0;
  } else {
    tmpvar_35 = col_6.w;
  };
  mediump float tmpvar_36;
  if ((((
    (_BorderWidths[0] > 0.0)
   || 
    (_BorderWidths[1] > 0.0)
  ) || (_BorderWidths[2] > 0.0)) || (_BorderWidths[3] > 0.0))) {
    mediump float tmpvar_37;
    if (tmpvar_16) {
      tmpvar_37 = col_6.w;
    } else {
      tmpvar_37 = tmpvar_35;
    };
    tmpvar_36 = tmpvar_37;
  } else {
    tmpvar_36 = 1.0;
  };
  col_6.w = (col_6.w * tmpvar_36);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_GUIClipTexture, xlv_TEXCOORD1);
  col_6.w = (col_6.w * tmpvar_38.w);
  tmpvar_1 = col_6;
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
Fallback "Hidden/Internal-GUITextureClip"
}