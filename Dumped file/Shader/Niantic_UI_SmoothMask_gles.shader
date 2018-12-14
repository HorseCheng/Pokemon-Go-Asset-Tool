Shader "Niantic/UI/SmoothMask" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Radius ("Radius", Float) = 0.4
_Width ("Width", Float) = 0.1
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 10275
Program "vp" {
SubProgram "gles " {
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF3
    #define UNITY_PBS_USE_BRDF3 1
#endif
#ifndef UNITY_NO_FULL_STANDARD_SHADER
    #define UNITY_NO_FULL_STANDARD_SHADER 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER1
    #define UNITY_HARDWARE_TIER1 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201746
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Color _glesColor
attribute vec4 _glesColor;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 34
struct v2f {
    highp vec4 vertex;
    highp vec2 texcoord;
    lowp vec4 color;
};
#line 28
struct appdata_t {
    highp vec4 vertex;
    highp vec2 texcoord;
    lowp vec4 color;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 40
uniform highp float _Radius;
uniform highp float _Width;
uniform sampler _MainTex;
uniform sampler _FaceTime;
#line 45
#line 54
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 45
v2f vert( in appdata_t v ) {
    v2f o;
    o.vertex = UnityObjectToClipPos( v.vertex);
    #line 49
    o.color = v.color;
    o.texcoord = v.texcoord;
    return o;
}
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.vertex);
    xlv_TEXCOORD0 = vec2(xl_retval.texcoord);
    xlv_COLOR = vec4(xl_retval.color);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(43,17): error: syntax error, unexpected NEW_IDENTIFIER, expecting '{'
*/

#endif
#ifdef FRAGMENT
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF3
    #define UNITY_PBS_USE_BRDF3 1
#endif
#ifndef UNITY_NO_FULL_STANDARD_SHADER
    #define UNITY_NO_FULL_STANDARD_SHADER 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER1
    #define UNITY_HARDWARE_TIER1 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201746
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 34
struct v2f {
    highp vec4 vertex;
    highp vec2 texcoord;
    lowp vec4 color;
};
#line 28
struct appdata_t {
    highp vec4 vertex;
    highp vec2 texcoord;
    lowp vec4 color;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 40
uniform highp float _Radius;
uniform highp float _Width;
uniform sampler _MainTex;
uniform sampler _FaceTime;
#line 45
#line 54
#line 54
lowp vec4 frag( in v2f i ) {
    lowp vec4 tex = texture2D( _FaceTime, i.texcoord);
    mediump vec2 uv = (i.texcoord - 0.5);
    #line 58
    return vec4( tex.xyz, (1.0 - smoothstep( _Radius, (_Radius + _Width), length(uv))));
}
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.vertex = vec4(0.0);
    xlt_i.texcoord = vec2(xlv_TEXCOORD0);
    xlt_i.color = vec4(xlv_COLOR);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(43,17): error: syntax error, unexpected NEW_IDENTIFIER, expecting '{'
*/

#endif
"
}
SubProgram "gles " {
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER2
    #define UNITY_HARDWARE_TIER2 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201746
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Color _glesColor
attribute vec4 _glesColor;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 34
struct v2f {
    highp vec4 vertex;
    highp vec2 texcoord;
    lowp vec4 color;
};
#line 28
struct appdata_t {
    highp vec4 vertex;
    highp vec2 texcoord;
    lowp vec4 color;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 40
uniform highp float _Radius;
uniform highp float _Width;
uniform sampler _MainTex;
uniform sampler _FaceTime;
#line 45
#line 54
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 45
v2f vert( in appdata_t v ) {
    v2f o;
    o.vertex = UnityObjectToClipPos( v.vertex);
    #line 49
    o.color = v.color;
    o.texcoord = v.texcoord;
    return o;
}
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.vertex);
    xlv_TEXCOORD0 = vec2(xl_retval.texcoord);
    xlv_COLOR = vec4(xl_retval.color);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(43,17): error: syntax error, unexpected NEW_IDENTIFIER, expecting '{'
*/

#endif
#ifdef FRAGMENT
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER2
    #define UNITY_HARDWARE_TIER2 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201746
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 34
struct v2f {
    highp vec4 vertex;
    highp vec2 texcoord;
    lowp vec4 color;
};
#line 28
struct appdata_t {
    highp vec4 vertex;
    highp vec2 texcoord;
    lowp vec4 color;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 40
uniform highp float _Radius;
uniform highp float _Width;
uniform sampler _MainTex;
uniform sampler _FaceTime;
#line 45
#line 54
#line 54
lowp vec4 frag( in v2f i ) {
    lowp vec4 tex = texture2D( _FaceTime, i.texcoord);
    mediump vec2 uv = (i.texcoord - 0.5);
    #line 58
    return vec4( tex.xyz, (1.0 - smoothstep( _Radius, (_Radius + _Width), length(uv))));
}
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.vertex = vec4(0.0);
    xlt_i.texcoord = vec2(xlv_TEXCOORD0);
    xlt_i.color = vec4(xlv_COLOR);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(43,17): error: syntax error, unexpected NEW_IDENTIFIER, expecting '{'
*/

#endif
"
}
SubProgram "gles " {
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER3
    #define UNITY_HARDWARE_TIER3 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201746
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Color _glesColor
attribute vec4 _glesColor;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 34
struct v2f {
    highp vec4 vertex;
    highp vec2 texcoord;
    lowp vec4 color;
};
#line 28
struct appdata_t {
    highp vec4 vertex;
    highp vec2 texcoord;
    lowp vec4 color;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 40
uniform highp float _Radius;
uniform highp float _Width;
uniform sampler _MainTex;
uniform sampler _FaceTime;
#line 45
#line 54
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 45
v2f vert( in appdata_t v ) {
    v2f o;
    o.vertex = UnityObjectToClipPos( v.vertex);
    #line 49
    o.color = v.color;
    o.texcoord = v.texcoord;
    return o;
}
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.vertex);
    xlv_TEXCOORD0 = vec2(xl_retval.texcoord);
    xlv_COLOR = vec4(xl_retval.color);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(43,17): error: syntax error, unexpected NEW_IDENTIFIER, expecting '{'
*/

#endif
#ifdef FRAGMENT
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER3
    #define UNITY_HARDWARE_TIER3 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201746
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 34
struct v2f {
    highp vec4 vertex;
    highp vec2 texcoord;
    lowp vec4 color;
};
#line 28
struct appdata_t {
    highp vec4 vertex;
    highp vec2 texcoord;
    lowp vec4 color;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 40
uniform highp float _Radius;
uniform highp float _Width;
uniform sampler _MainTex;
uniform sampler _FaceTime;
#line 45
#line 54
#line 54
lowp vec4 frag( in v2f i ) {
    lowp vec4 tex = texture2D( _FaceTime, i.texcoord);
    mediump vec2 uv = (i.texcoord - 0.5);
    #line 58
    return vec4( tex.xyz, (1.0 - smoothstep( _Radius, (_Radius + _Width), length(uv))));
}
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.vertex = vec4(0.0);
    xlt_i.texcoord = vec2(xlv_TEXCOORD0);
    xlt_i.color = vec4(xlv_COLOR);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(43,17): error: syntax error, unexpected NEW_IDENTIFIER, expecting '{'
*/

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