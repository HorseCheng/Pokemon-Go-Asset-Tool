Shader "Hidden/Internal-Colored" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_SrcBlend ("SrcBlend", Float) = 5
_DstBlend ("DstBlend", Float) = 10
_ZWrite ("ZWrite", Float) = 1
_ZTest ("ZTest", Float) = 4
_Cull ("Cull", Float) = 0
_ZBias ("ZBias", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 37372
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