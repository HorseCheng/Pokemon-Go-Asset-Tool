Shader "Unlit/ARDKCameraShaderBGRA" {
Properties {
_texture ("Texture", 2D) = "black" { }
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  ZWrite Off
  Cull Off
  GpuProgramID 90301
Program "vp" {
SubProgram "gles " {
"#version 100
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp
#extension GL_OES_EGL_image_external_essl3 : enable
#extension GL_OES_EGL_image_external : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF3 1
#define UNITY_NO_FULL_STANDARD_SHADER 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER1 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 20

#line 16
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 16
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

        // #pragma only_renderers gles3 gles

        #ifdef SHADER_API_GLES3
        
        #else
        
        #endif

        uniform mat4 _textureTransform;

        
        
        

#ifdef VERTEX
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;


        varying vec2 textureCoord;

        void main()
        {
            #if defined(SHADER_API_GLES3) || defined(SHADER_API_GLES)
            textureCoord = (_textureTransform * gl_MultiTexCoord0).xy;
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            #endif
        }

        
#endif
#ifdef FRAGMENT

        varying vec2 textureCoord;
        uniform samplerExternalOES _texture;

        void main()
        {      
          #ifdef SHADER_API_GLES3
          gl_FragColor = texture(_texture, textureCoord);
          #else
          gl_FragColor = texture2D(_texture, textureCoord);
          #endif
        }

        
#endif"
}
SubProgram "gles " {
"#version 100
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp
#extension GL_OES_EGL_image_external_essl3 : enable
#extension GL_OES_EGL_image_external : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER2 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 19

#line 16
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 16
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

        // #pragma only_renderers gles3 gles

        #ifdef SHADER_API_GLES3
        
        #else
        
        #endif

        uniform mat4 _textureTransform;

        
        
        

#ifdef VERTEX
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;


        varying vec2 textureCoord;

        void main()
        {
            #if defined(SHADER_API_GLES3) || defined(SHADER_API_GLES)
            textureCoord = (_textureTransform * gl_MultiTexCoord0).xy;
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            #endif
        }

        
#endif
#ifdef FRAGMENT

        varying vec2 textureCoord;
        uniform samplerExternalOES _texture;

        void main()
        {      
          #ifdef SHADER_API_GLES3
          gl_FragColor = texture(_texture, textureCoord);
          #else
          gl_FragColor = texture2D(_texture, textureCoord);
          #endif
        }

        
#endif"
}
SubProgram "gles " {
"#version 100
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp
#extension GL_OES_EGL_image_external_essl3 : enable
#extension GL_OES_EGL_image_external : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER3 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 19

#line 16
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 16
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

        // #pragma only_renderers gles3 gles

        #ifdef SHADER_API_GLES3
        
        #else
        
        #endif

        uniform mat4 _textureTransform;

        
        
        

#ifdef VERTEX
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;


        varying vec2 textureCoord;

        void main()
        {
            #if defined(SHADER_API_GLES3) || defined(SHADER_API_GLES)
            textureCoord = (_textureTransform * gl_MultiTexCoord0).xy;
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            #endif
        }

        
#endif
#ifdef FRAGMENT

        varying vec2 textureCoord;
        uniform samplerExternalOES _texture;

        void main()
        {      
          #ifdef SHADER_API_GLES3
          gl_FragColor = texture(_texture, textureCoord);
          #else
          gl_FragColor = texture2D(_texture, textureCoord);
          #endif
        }

        
#endif"
}
}
Program "fp" {
SubProgram "gles " {
"#version 100
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp
#extension GL_OES_EGL_image_external_essl3 : enable
#extension GL_OES_EGL_image_external : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF3 1
#define UNITY_NO_FULL_STANDARD_SHADER 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER1 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 20

#line 16
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 16
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

        // #pragma only_renderers gles3 gles

        #ifdef SHADER_API_GLES3
        
        #else
        
        #endif

        uniform mat4 _textureTransform;

        
        
        

#ifdef VERTEX
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;


        varying vec2 textureCoord;

        void main()
        {
            #if defined(SHADER_API_GLES3) || defined(SHADER_API_GLES)
            textureCoord = (_textureTransform * gl_MultiTexCoord0).xy;
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            #endif
        }

        
#endif
#ifdef FRAGMENT

        varying vec2 textureCoord;
        uniform samplerExternalOES _texture;

        void main()
        {      
          #ifdef SHADER_API_GLES3
          gl_FragColor = texture(_texture, textureCoord);
          #else
          gl_FragColor = texture2D(_texture, textureCoord);
          #endif
        }

        
#endif"
}
SubProgram "gles " {
"#version 100
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp
#extension GL_OES_EGL_image_external_essl3 : enable
#extension GL_OES_EGL_image_external : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER2 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 19

#line 16
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 16
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

        // #pragma only_renderers gles3 gles

        #ifdef SHADER_API_GLES3
        
        #else
        
        #endif

        uniform mat4 _textureTransform;

        
        
        

#ifdef VERTEX
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;


        varying vec2 textureCoord;

        void main()
        {
            #if defined(SHADER_API_GLES3) || defined(SHADER_API_GLES)
            textureCoord = (_textureTransform * gl_MultiTexCoord0).xy;
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            #endif
        }

        
#endif
#ifdef FRAGMENT

        varying vec2 textureCoord;
        uniform samplerExternalOES _texture;

        void main()
        {      
          #ifdef SHADER_API_GLES3
          gl_FragColor = texture(_texture, textureCoord);
          #else
          gl_FragColor = texture2D(_texture, textureCoord);
          #endif
        }

        
#endif"
}
SubProgram "gles " {
"#version 100
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp
#extension GL_OES_EGL_image_external_essl3 : enable
#extension GL_OES_EGL_image_external : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER3 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 19

#line 16
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 16
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

        // #pragma only_renderers gles3 gles

        #ifdef SHADER_API_GLES3
        
        #else
        
        #endif

        uniform mat4 _textureTransform;

        
        
        

#ifdef VERTEX
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;


        varying vec2 textureCoord;

        void main()
        {
            #if defined(SHADER_API_GLES3) || defined(SHADER_API_GLES)
            textureCoord = (_textureTransform * gl_MultiTexCoord0).xy;
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            #endif
        }

        
#endif
#ifdef FRAGMENT

        varying vec2 textureCoord;
        uniform samplerExternalOES _texture;

        void main()
        {      
          #ifdef SHADER_API_GLES3
          gl_FragColor = texture(_texture, textureCoord);
          #else
          gl_FragColor = texture2D(_texture, textureCoord);
          #endif
        }

        
#endif"
}
}
}
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  ZWrite Off
  Cull Off
  GpuProgramID 48853
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp mat4 _textureTransform;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = (((_textureTransform[0].x * _glesMultiTexCoord0.x) + (_textureTransform[0].y * _glesMultiTexCoord0.y)) + _textureTransform[3].x);
  tmpvar_1.y = (((_textureTransform[1].x * _glesMultiTexCoord0.x) + (_textureTransform[1].y * _glesMultiTexCoord0.y)) + _textureTransform[3].y);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _texture;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_texture, xlv_TEXCOORD0);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp mat4 _textureTransform;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = (((_textureTransform[0].x * _glesMultiTexCoord0.x) + (_textureTransform[0].y * _glesMultiTexCoord0.y)) + _textureTransform[3].x);
  tmpvar_1.y = (((_textureTransform[1].x * _glesMultiTexCoord0.x) + (_textureTransform[1].y * _glesMultiTexCoord0.y)) + _textureTransform[3].y);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _texture;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_texture, xlv_TEXCOORD0);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp mat4 _textureTransform;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.x = (((_textureTransform[0].x * _glesMultiTexCoord0.x) + (_textureTransform[0].y * _glesMultiTexCoord0.y)) + _textureTransform[3].x);
  tmpvar_1.y = (((_textureTransform[1].x * _glesMultiTexCoord0.x) + (_textureTransform[1].y * _glesMultiTexCoord0.y)) + _textureTransform[3].y);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _texture;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_texture, xlv_TEXCOORD0);
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