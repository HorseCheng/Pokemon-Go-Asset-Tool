Shader "GUI/Text Shader" {
Properties {
_MainTex ("Font Texture", 2D) = "white" { }
_Color ("Text Color", Color) = (1,1,1,1)
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 52291
Program "vp" {
SubProgram "vulkan hw_tier00 " {
"// shader disassembly not supported on SPIR-V
// https://github.com/KhronosGroup/SPIRV-Cross"
}
SubProgram "vulkan hw_tier01 " {
"// shader disassembly not supported on SPIR-V
// https://github.com/KhronosGroup/SPIRV-Cross"
}
SubProgram "vulkan hw_tier02 " {
"// shader disassembly not supported on SPIR-V
// https://github.com/KhronosGroup/SPIRV-Cross"
}
SubProgram "vulkan hw_tier00 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"// shader disassembly not supported on SPIR-V
// https://github.com/KhronosGroup/SPIRV-Cross"
}
SubProgram "vulkan hw_tier01 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"// shader disassembly not supported on SPIR-V
// https://github.com/KhronosGroup/SPIRV-Cross"
}
SubProgram "vulkan hw_tier02 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
"// shader disassembly not supported on SPIR-V
// https://github.com/KhronosGroup/SPIRV-Cross"
}
SubProgram "vulkan hw_tier00 " {
Keywords { "STEREO_INSTANCING_ON" }
"// shader disassembly not supported on SPIR-V
// https://github.com/KhronosGroup/SPIRV-Cross"
}
SubProgram "vulkan hw_tier01 " {
Keywords { "STEREO_INSTANCING_ON" }
"// shader disassembly not supported on SPIR-V
// https://github.com/KhronosGroup/SPIRV-Cross"
}
SubProgram "vulkan hw_tier02 " {
Keywords { "STEREO_INSTANCING_ON" }
"// shader disassembly not supported on SPIR-V
// https://github.com/KhronosGroup/SPIRV-Cross"
}
SubProgram "vulkan hw_tier00 " {
Keywords { "STEREO_MULTIVIEW_ON" }
"// shader disassembly not supported on SPIR-V
// https://github.com/KhronosGroup/SPIRV-Cross"
}
SubProgram "vulkan hw_tier01 " {
Keywords { "STEREO_MULTIVIEW_ON" }
"// shader disassembly not supported on SPIR-V
// https://github.com/KhronosGroup/SPIRV-Cross"
}
SubProgram "vulkan hw_tier02 " {
Keywords { "STEREO_MULTIVIEW_ON" }
"// shader disassembly not supported on SPIR-V
// https://github.com/KhronosGroup/SPIRV-Cross"
}
}
Program "fp" {
SubProgram "vulkan hw_tier00 " {
""
}
SubProgram "vulkan hw_tier01 " {
""
}
SubProgram "vulkan hw_tier02 " {
""
}
SubProgram "vulkan hw_tier00 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
""
}
SubProgram "vulkan hw_tier01 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
""
}
SubProgram "vulkan hw_tier02 " {
Keywords { "UNITY_SINGLE_PASS_STEREO" }
""
}
SubProgram "vulkan hw_tier00 " {
Keywords { "STEREO_INSTANCING_ON" }
""
}
SubProgram "vulkan hw_tier01 " {
Keywords { "STEREO_INSTANCING_ON" }
""
}
SubProgram "vulkan hw_tier02 " {
Keywords { "STEREO_INSTANCING_ON" }
""
}
SubProgram "vulkan hw_tier00 " {
Keywords { "STEREO_MULTIVIEW_ON" }
""
}
SubProgram "vulkan hw_tier01 " {
Keywords { "STEREO_MULTIVIEW_ON" }
""
}
SubProgram "vulkan hw_tier02 " {
Keywords { "STEREO_MULTIVIEW_ON" }
""
}
}
}
}
}