Shader "Hidden/BlitToDepth_MSAA" {
Properties {
_MainTex ("DepthTexture", any) = "" { }
}
SubShader {
 Pass {
  ZTest Always
  Cull Off
  GpuProgramID 4079
Program "vp" {
}
Program "fp" {
}
}
}
}