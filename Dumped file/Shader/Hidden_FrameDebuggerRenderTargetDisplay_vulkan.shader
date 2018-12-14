Shader "Hidden/FrameDebuggerRenderTargetDisplay" {
Properties {
_MainTex ("", any) = "white" { }
}
SubShader {
 Tags { "ForceSupported" = "true" }
 Pass {
  Tags { "ForceSupported" = "true" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 52480
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
}
}
 Pass {
  Tags { "ForceSupported" = "true" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 86592
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
}
}
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 154206
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
}
}
}
}