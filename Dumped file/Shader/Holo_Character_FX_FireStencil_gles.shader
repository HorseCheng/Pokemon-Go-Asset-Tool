Shader "Holo/Character/FX/FireStencil" {
Properties {
_Color1 ("Color1", Color) = (1,1,0,0.5)
_Color2 ("Color2", Color) = (1,0.282353,0,0)
_MainTex ("Combo (R=A1,G=A2,B=Mask)", 2D) = "black" { }
_TilingRG ("Tiling for R(.xy) and G(.zw) channels", Vector) = (1,1,1,1)
_Vspeed ("Vspeed ", Range(0, 10)) = 1
_Vmultiply ("Vmultiply", Range(0, 10)) = 1.5
_Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare Function", Float) = 3
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Geometry+2" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Geometry+2" "RenderType" = "Opaque" }
  GpuProgramID 57911
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
uniform highp vec4 _TilingRG;
uniform highp float _Vspeed;
uniform highp float _Vmultiply;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_4 = tmpvar_1;
  tmpvar_2.x = _glesMultiTexCoord0.x;
  tmpvar_2.y = min (0.95, _glesMultiTexCoord0.y);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3.xy = (tmpvar_3.xy * _TilingRG.xy);
  tmpvar_3.y = (tmpvar_3.y - ((_Time.y * _TilingRG.y) * _Vspeed));
  tmpvar_3.zw = (tmpvar_3.zw * _TilingRG.zw);
  tmpvar_3.w = (tmpvar_3.w - ((_Time.y * _TilingRG.w) * (_Vspeed * _Vmultiply)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tex_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.zw);
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = mix (_Color2.xyz, _Color1.xyz, vec3(((
    ((_Color1.w * tmpvar_3.x) + tmpvar_4.y)
   + tex_1.z) * (tex_1.w + _Color2.w))));
  gl_FragData[0] = tmpvar_5;
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
uniform highp vec4 _TilingRG;
uniform highp float _Vspeed;
uniform highp float _Vmultiply;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_4 = tmpvar_1;
  tmpvar_2.x = _glesMultiTexCoord0.x;
  tmpvar_2.y = min (0.95, _glesMultiTexCoord0.y);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3.xy = (tmpvar_3.xy * _TilingRG.xy);
  tmpvar_3.y = (tmpvar_3.y - ((_Time.y * _TilingRG.y) * _Vspeed));
  tmpvar_3.zw = (tmpvar_3.zw * _TilingRG.zw);
  tmpvar_3.w = (tmpvar_3.w - ((_Time.y * _TilingRG.w) * (_Vspeed * _Vmultiply)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tex_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.zw);
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = mix (_Color2.xyz, _Color1.xyz, vec3(((
    ((_Color1.w * tmpvar_3.x) + tmpvar_4.y)
   + tex_1.z) * (tex_1.w + _Color2.w))));
  gl_FragData[0] = tmpvar_5;
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
uniform highp vec4 _TilingRG;
uniform highp float _Vspeed;
uniform highp float _Vmultiply;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_4 = tmpvar_1;
  tmpvar_2.x = _glesMultiTexCoord0.x;
  tmpvar_2.y = min (0.95, _glesMultiTexCoord0.y);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3.xy = (tmpvar_3.xy * _TilingRG.xy);
  tmpvar_3.y = (tmpvar_3.y - ((_Time.y * _TilingRG.y) * _Vspeed));
  tmpvar_3.zw = (tmpvar_3.zw * _TilingRG.zw);
  tmpvar_3.w = (tmpvar_3.w - ((_Time.y * _TilingRG.w) * (_Vspeed * _Vmultiply)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tex_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.zw);
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = mix (_Color2.xyz, _Color1.xyz, vec3(((
    ((_Color1.w * tmpvar_3.x) + tmpvar_4.y)
   + tex_1.z) * (tex_1.w + _Color2.w))));
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _TilingRG;
uniform highp float _Vspeed;
uniform highp float _Vmultiply;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_4 = tmpvar_1;
  tmpvar_2.x = _glesMultiTexCoord0.x;
  tmpvar_2.y = min (0.95, _glesMultiTexCoord0.y);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3.xy = (tmpvar_3.xy * _TilingRG.xy);
  tmpvar_3.y = (tmpvar_3.y - ((_Time.y * _TilingRG.y) * _Vspeed));
  tmpvar_3.zw = (tmpvar_3.zw * _TilingRG.zw);
  tmpvar_3.w = (tmpvar_3.w - ((_Time.y * _TilingRG.w) * (_Vspeed * _Vmultiply)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tex_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.zw);
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = mix (_Color2.xyz, _Color1.xyz, vec3(((
    ((_Color1.w * tmpvar_3.x) + tmpvar_4.y)
   + tex_1.z) * (tex_1.w + _Color2.w))));
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _TilingRG;
uniform highp float _Vspeed;
uniform highp float _Vmultiply;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_4 = tmpvar_1;
  tmpvar_2.x = _glesMultiTexCoord0.x;
  tmpvar_2.y = min (0.95, _glesMultiTexCoord0.y);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3.xy = (tmpvar_3.xy * _TilingRG.xy);
  tmpvar_3.y = (tmpvar_3.y - ((_Time.y * _TilingRG.y) * _Vspeed));
  tmpvar_3.zw = (tmpvar_3.zw * _TilingRG.zw);
  tmpvar_3.w = (tmpvar_3.w - ((_Time.y * _TilingRG.w) * (_Vspeed * _Vmultiply)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tex_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.zw);
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = mix (_Color2.xyz, _Color1.xyz, vec3(((
    ((_Color1.w * tmpvar_3.x) + tmpvar_4.y)
   + tex_1.z) * (tex_1.w + _Color2.w))));
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _TilingRG;
uniform highp float _Vspeed;
uniform highp float _Vmultiply;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_4 = tmpvar_1;
  tmpvar_2.x = _glesMultiTexCoord0.x;
  tmpvar_2.y = min (0.95, _glesMultiTexCoord0.y);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3.xy = (tmpvar_3.xy * _TilingRG.xy);
  tmpvar_3.y = (tmpvar_3.y - ((_Time.y * _TilingRG.y) * _Vspeed));
  tmpvar_3.zw = (tmpvar_3.zw * _TilingRG.zw);
  tmpvar_3.w = (tmpvar_3.w - ((_Time.y * _TilingRG.w) * (_Vspeed * _Vmultiply)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tex_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.zw);
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = mix (_Color2.xyz, _Color1.xyz, vec3(((
    ((_Color1.w * tmpvar_3.x) + tmpvar_4.y)
   + tex_1.z) * (tex_1.w + _Color2.w))));
  gl_FragData[0] = tmpvar_5;
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
Keywords { "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "BRB_CHAR_FX" }
""
}
}
}
}
CustomEditor "CustomMaterialInspector"
}