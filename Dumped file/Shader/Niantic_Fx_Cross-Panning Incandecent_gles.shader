Shader "Niantic/Fx/Cross-Panning Incandecent" {
Properties {
_MainTex ("Texture 1", 2D) = "white" { }
_Tex2 ("Texture 2", 2D) = "white" { }
_DiffuseIntensity ("Diffuse Intensity", Float) = 0.5
_PanSpeeds ("Pan Speeds: (XY=Tex1, ZW=Tex2)", Vector) = (0,0,0,0)
_IncandecentColor ("Incandecent Color", Color) = (0,0,0,0)
_SpecularColor ("Specular Color", Color) = (1,1,1,1)
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 35262
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Tex2_ST;
uniform lowp vec4 _PanSpeeds;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_Texcoord1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _Tex2_ST.xy) + _Tex2_ST.zw);
  tmpvar_1 = (tmpvar_1 + (_PanSpeeds.xy * _Time.x));
  tmpvar_2 = (tmpvar_2 + (_PanSpeeds.zw * _Time.x));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_Texcoord1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Tex2;
uniform highp vec4 _IncandecentColor;
uniform highp vec4 _SpecularColor;
uniform highp float _DiffuseIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_Texcoord1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec3 noise_2;
  lowp vec4 tex1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_3.w = tmpvar_4.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Tex2, xlv_TEXCOORD0);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Tex2, xlv_Texcoord1);
  tex1_3.xyz = (tmpvar_4.xyz * _DiffuseIntensity);
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_IncandecentColor.xyz * tmpvar_6.x) * tmpvar_5.yyy);
  noise_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = mix (tex1_3.xyz, noise_2, tmpvar_5.yyy);
  tmpvar_1 = (tmpvar_8 + (tmpvar_5.z * _SpecularColor));
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Tex2_ST;
uniform lowp vec4 _PanSpeeds;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_Texcoord1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _Tex2_ST.xy) + _Tex2_ST.zw);
  tmpvar_1 = (tmpvar_1 + (_PanSpeeds.xy * _Time.x));
  tmpvar_2 = (tmpvar_2 + (_PanSpeeds.zw * _Time.x));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_Texcoord1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Tex2;
uniform highp vec4 _IncandecentColor;
uniform highp vec4 _SpecularColor;
uniform highp float _DiffuseIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_Texcoord1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec3 noise_2;
  lowp vec4 tex1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_3.w = tmpvar_4.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Tex2, xlv_TEXCOORD0);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Tex2, xlv_Texcoord1);
  tex1_3.xyz = (tmpvar_4.xyz * _DiffuseIntensity);
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_IncandecentColor.xyz * tmpvar_6.x) * tmpvar_5.yyy);
  noise_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = mix (tex1_3.xyz, noise_2, tmpvar_5.yyy);
  tmpvar_1 = (tmpvar_8 + (tmpvar_5.z * _SpecularColor));
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Tex2_ST;
uniform lowp vec4 _PanSpeeds;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_Texcoord1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _Tex2_ST.xy) + _Tex2_ST.zw);
  tmpvar_1 = (tmpvar_1 + (_PanSpeeds.xy * _Time.x));
  tmpvar_2 = (tmpvar_2 + (_PanSpeeds.zw * _Time.x));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_Texcoord1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Tex2;
uniform highp vec4 _IncandecentColor;
uniform highp vec4 _SpecularColor;
uniform highp float _DiffuseIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_Texcoord1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec3 noise_2;
  lowp vec4 tex1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_3.w = tmpvar_4.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Tex2, xlv_TEXCOORD0);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Tex2, xlv_Texcoord1);
  tex1_3.xyz = (tmpvar_4.xyz * _DiffuseIntensity);
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_IncandecentColor.xyz * tmpvar_6.x) * tmpvar_5.yyy);
  noise_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = mix (tex1_3.xyz, noise_2, tmpvar_5.yyy);
  tmpvar_1 = (tmpvar_8 + (tmpvar_5.z * _SpecularColor));
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