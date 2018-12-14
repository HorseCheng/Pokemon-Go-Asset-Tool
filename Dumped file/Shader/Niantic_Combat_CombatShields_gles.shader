Shader "Niantic/Combat/CombatShields" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
[Header(REFLECTION)] _ReflectTex ("Reflection Texture", 2D) = "white" { }
_ReflectStrength ("Reflection Strength", Range(0, 1)) = 0.5
_RefScale ("Reflection Scale", Range(0, 3)) = 1
[Header(PARALLAX)] _Parallax1 ("Parallax 1", Vector) = (1,1,2,2)
_Opacity ("Opacity", Range(0, 1)) = 1
_GradCenterWorld ("Gradient Center World Position", Vector) = (0,0,0,0)
_GradColorTop ("Top Gradient Color", Color) = (1,1,1,1)
_GradColorBottom ("Bottom Gradient Color", Color) = (0,0,0,1)
_GradScale ("Gradient Scale", Range(0.001, 1)) = 1
_GradVerticalOffset ("Gradient Offset", Range(-100, 100)) = 1
_SideBrightness ("Side Brightness", Range(0, 1)) = 0.5
_NoiseBrightness ("Noise Brightness", Range(0, 10)) = 1
_NoiseSpeed ("Noise Speed", Vector) = (1,1,0,0)
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 19886
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Parallax1;
uniform highp vec2 _NoiseSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_normal;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump float objectScale_2;
  highp vec3 viewDir_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.x = (tmpvar_4.x + (_Time.x * _NoiseSpeed.x));
  tmpvar_5.y = (tmpvar_4.y + (_Time.x * _NoiseSpeed.y));
  tmpvar_6.x = (tmpvar_4.x + (_Time.x * -(_NoiseSpeed.x)));
  tmpvar_6.y = (tmpvar_4.y + (_Time.x * -(_NoiseSpeed.y)));
  viewDir_3.xy = (tmpvar_9.xyz - _WorldSpaceCameraPos).xy;
  highp vec3 tmpvar_10;
  tmpvar_10.x = unity_ObjectToWorld[0].x;
  tmpvar_10.y = unity_ObjectToWorld[0].y;
  tmpvar_10.z = unity_ObjectToWorld[0].z;
  highp float tmpvar_11;
  tmpvar_11 = sqrt(dot (tmpvar_10, tmpvar_10));
  objectScale_2 = tmpvar_11;
  viewDir_3.z = (_Parallax1.z * objectScale_2);
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_1;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_1;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((tmpvar_13 * unity_WorldToObject).xyz));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD4 = tmpvar_9.xyz;
  xlv_TEXCOORD5 = (viewDir_3 - (2.0 * (
    dot (tmpvar_14, viewDir_3)
   * tmpvar_14)));
  xlv_normal = (unity_ObjectToWorld * tmpvar_12).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ReflectTex;
uniform highp float _ReflectStrength;
uniform highp float _Opacity;
uniform highp vec4 _GradCenterWorld;
uniform lowp vec4 _GradColorTop;
uniform lowp vec4 _GradColorBottom;
uniform highp float _GradScale;
uniform highp float _GradVerticalOffset;
uniform highp float _SideBrightness;
uniform highp float _NoiseBrightness;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_normal;
void main ()
{
  highp vec3 gradColor_1;
  highp vec4 reflectImg_2;
  lowp vec4 color_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2);
  color_3.w = tmpvar_4.w;
  highp vec3 tmpvar_7;
  tmpvar_7.xy = (xlv_TEXCOORD5.xy + vec2(0.5, 0.5));
  tmpvar_7.z = xlv_TEXCOORD5.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(tmpvar_7);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReflectTex, tmpvar_8.xy);
  reflectImg_2 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD4.y - _GradCenterWorld.y) * (1.0/(_GradScale)))
   + _GradVerticalOffset) + 0.5), 0.0, 1.0);
  lowp vec3 tmpvar_11;
  tmpvar_11 = mix (_GradColorBottom, _GradColorTop, vec4(tmpvar_10)).xyz;
  gradColor_1 = tmpvar_11;
  color_3.xyz = (tmpvar_4.xxx * gradColor_1);
  color_3.xyz = (color_3.xyz + ((
    (tmpvar_5.z * tmpvar_6.z)
   * _NoiseBrightness) * gradColor_1));
  color_3.xyz = (color_3.xyz + ((tmpvar_4.y * _SideBrightness) * (tmpvar_5.z * tmpvar_6.z)));
  highp vec3 tmpvar_12;
  tmpvar_12 = (reflectImg_2 * _ReflectStrength).xyz;
  color_3.xyz = (color_3.xyz + tmpvar_12);
  color_3.w = (tmpvar_4.w * _Opacity);
  highp float tmpvar_13;
  tmpvar_13 = abs(xlv_normal.z);
  highp float tmpvar_14;
  tmpvar_14 = abs(xlv_normal.y);
  color_3.w = (color_3.w + ((
    (tmpvar_13 + tmpvar_14)
   * 0.5) * _Opacity));
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Parallax1;
uniform highp vec2 _NoiseSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_normal;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump float objectScale_2;
  highp vec3 viewDir_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.x = (tmpvar_4.x + (_Time.x * _NoiseSpeed.x));
  tmpvar_5.y = (tmpvar_4.y + (_Time.x * _NoiseSpeed.y));
  tmpvar_6.x = (tmpvar_4.x + (_Time.x * -(_NoiseSpeed.x)));
  tmpvar_6.y = (tmpvar_4.y + (_Time.x * -(_NoiseSpeed.y)));
  viewDir_3.xy = (tmpvar_9.xyz - _WorldSpaceCameraPos).xy;
  highp vec3 tmpvar_10;
  tmpvar_10.x = unity_ObjectToWorld[0].x;
  tmpvar_10.y = unity_ObjectToWorld[0].y;
  tmpvar_10.z = unity_ObjectToWorld[0].z;
  highp float tmpvar_11;
  tmpvar_11 = sqrt(dot (tmpvar_10, tmpvar_10));
  objectScale_2 = tmpvar_11;
  viewDir_3.z = (_Parallax1.z * objectScale_2);
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_1;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_1;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((tmpvar_13 * unity_WorldToObject).xyz));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD4 = tmpvar_9.xyz;
  xlv_TEXCOORD5 = (viewDir_3 - (2.0 * (
    dot (tmpvar_14, viewDir_3)
   * tmpvar_14)));
  xlv_normal = (unity_ObjectToWorld * tmpvar_12).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ReflectTex;
uniform highp float _ReflectStrength;
uniform highp float _Opacity;
uniform highp vec4 _GradCenterWorld;
uniform lowp vec4 _GradColorTop;
uniform lowp vec4 _GradColorBottom;
uniform highp float _GradScale;
uniform highp float _GradVerticalOffset;
uniform highp float _SideBrightness;
uniform highp float _NoiseBrightness;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_normal;
void main ()
{
  highp vec3 gradColor_1;
  highp vec4 reflectImg_2;
  lowp vec4 color_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2);
  color_3.w = tmpvar_4.w;
  highp vec3 tmpvar_7;
  tmpvar_7.xy = (xlv_TEXCOORD5.xy + vec2(0.5, 0.5));
  tmpvar_7.z = xlv_TEXCOORD5.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(tmpvar_7);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReflectTex, tmpvar_8.xy);
  reflectImg_2 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD4.y - _GradCenterWorld.y) * (1.0/(_GradScale)))
   + _GradVerticalOffset) + 0.5), 0.0, 1.0);
  lowp vec3 tmpvar_11;
  tmpvar_11 = mix (_GradColorBottom, _GradColorTop, vec4(tmpvar_10)).xyz;
  gradColor_1 = tmpvar_11;
  color_3.xyz = (tmpvar_4.xxx * gradColor_1);
  color_3.xyz = (color_3.xyz + ((
    (tmpvar_5.z * tmpvar_6.z)
   * _NoiseBrightness) * gradColor_1));
  color_3.xyz = (color_3.xyz + ((tmpvar_4.y * _SideBrightness) * (tmpvar_5.z * tmpvar_6.z)));
  highp vec3 tmpvar_12;
  tmpvar_12 = (reflectImg_2 * _ReflectStrength).xyz;
  color_3.xyz = (color_3.xyz + tmpvar_12);
  color_3.w = (tmpvar_4.w * _Opacity);
  highp float tmpvar_13;
  tmpvar_13 = abs(xlv_normal.z);
  highp float tmpvar_14;
  tmpvar_14 = abs(xlv_normal.y);
  color_3.w = (color_3.w + ((
    (tmpvar_13 + tmpvar_14)
   * 0.5) * _Opacity));
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Parallax1;
uniform highp vec2 _NoiseSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_normal;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump float objectScale_2;
  highp vec3 viewDir_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.x = (tmpvar_4.x + (_Time.x * _NoiseSpeed.x));
  tmpvar_5.y = (tmpvar_4.y + (_Time.x * _NoiseSpeed.y));
  tmpvar_6.x = (tmpvar_4.x + (_Time.x * -(_NoiseSpeed.x)));
  tmpvar_6.y = (tmpvar_4.y + (_Time.x * -(_NoiseSpeed.y)));
  viewDir_3.xy = (tmpvar_9.xyz - _WorldSpaceCameraPos).xy;
  highp vec3 tmpvar_10;
  tmpvar_10.x = unity_ObjectToWorld[0].x;
  tmpvar_10.y = unity_ObjectToWorld[0].y;
  tmpvar_10.z = unity_ObjectToWorld[0].z;
  highp float tmpvar_11;
  tmpvar_11 = sqrt(dot (tmpvar_10, tmpvar_10));
  objectScale_2 = tmpvar_11;
  viewDir_3.z = (_Parallax1.z * objectScale_2);
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_1;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_1;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((tmpvar_13 * unity_WorldToObject).xyz));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD4 = tmpvar_9.xyz;
  xlv_TEXCOORD5 = (viewDir_3 - (2.0 * (
    dot (tmpvar_14, viewDir_3)
   * tmpvar_14)));
  xlv_normal = (unity_ObjectToWorld * tmpvar_12).xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ReflectTex;
uniform highp float _ReflectStrength;
uniform highp float _Opacity;
uniform highp vec4 _GradCenterWorld;
uniform lowp vec4 _GradColorTop;
uniform lowp vec4 _GradColorBottom;
uniform highp float _GradScale;
uniform highp float _GradVerticalOffset;
uniform highp float _SideBrightness;
uniform highp float _NoiseBrightness;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_normal;
void main ()
{
  highp vec3 gradColor_1;
  highp vec4 reflectImg_2;
  lowp vec4 color_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2);
  color_3.w = tmpvar_4.w;
  highp vec3 tmpvar_7;
  tmpvar_7.xy = (xlv_TEXCOORD5.xy + vec2(0.5, 0.5));
  tmpvar_7.z = xlv_TEXCOORD5.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(tmpvar_7);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReflectTex, tmpvar_8.xy);
  reflectImg_2 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD4.y - _GradCenterWorld.y) * (1.0/(_GradScale)))
   + _GradVerticalOffset) + 0.5), 0.0, 1.0);
  lowp vec3 tmpvar_11;
  tmpvar_11 = mix (_GradColorBottom, _GradColorTop, vec4(tmpvar_10)).xyz;
  gradColor_1 = tmpvar_11;
  color_3.xyz = (tmpvar_4.xxx * gradColor_1);
  color_3.xyz = (color_3.xyz + ((
    (tmpvar_5.z * tmpvar_6.z)
   * _NoiseBrightness) * gradColor_1));
  color_3.xyz = (color_3.xyz + ((tmpvar_4.y * _SideBrightness) * (tmpvar_5.z * tmpvar_6.z)));
  highp vec3 tmpvar_12;
  tmpvar_12 = (reflectImg_2 * _ReflectStrength).xyz;
  color_3.xyz = (color_3.xyz + tmpvar_12);
  color_3.w = (tmpvar_4.w * _Opacity);
  highp float tmpvar_13;
  tmpvar_13 = abs(xlv_normal.z);
  highp float tmpvar_14;
  tmpvar_14 = abs(xlv_normal.y);
  color_3.w = (color_3.w + ((
    (tmpvar_13 + tmpvar_14)
   * 0.5) * _Opacity));
  gl_FragData[0] = color_3;
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