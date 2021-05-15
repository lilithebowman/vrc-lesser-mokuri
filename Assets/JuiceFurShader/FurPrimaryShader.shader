// Original shader concept develped by Sorumi (https://github.com/Sorumi/UnityFurShader)
// Shout out to loverord for help with the hue, saturation and brightness modifications.

Shader "Fur/FurShader"
{
    Properties
    {
        _ColorPrimary ("Color", Color) = (1, 1, 1, 1)
        _ShininessPrimary ("Shininess", Range(0.01, 256.0)) = 8.0
        _SpecularPrimary ("Specular", Range(0, 10.0)) = 5.0
        
        _EmissionPrimary ("Emission", Range(0.0, 4.0)) = .2
		_HuePrimary ("Hue", Range(0.0, 360.0)) = 0.0
		_SatPrimary ("Saturation", Range(0.0, 2.0)) = 1.0
		
        _MainTexPrimary ("Texture", 2D) = "white" { }
        _FurTexPrimary ("Fur Pattern", 2D) = "white" { }
        
        _FurLengthPrimary ("Fur Length", Range(0.0, 1)) = 0.5
        _FurDensityPrimary ("Fur Density", Range(0, 2)) = 0.11
        _FurThinnessPrimary ("Fur Thinness", Range(0.01, 10)) = 1
        _FurShadingPrimary ("Fur Shading", Range(0.0, 1)) = 0.25
    }

    Category
    {

        Tags { "RenderType" = "Transparent" "IgnoreProjector" = "True" "Queue" = "Transparent" }
        Cull Off
        ZWrite On
        Blend SrcAlpha OneMinusSrcAlpha
        
        SubShader
        {
            Pass {
                Name "ShadowCaster"
                Tags { "LightMode" = "ShadowCaster" }
                ZWrite On ZTest LEqual
                CGPROGRAM
                #pragma target 3.0
                #pragma vertex vertShadowCaster
                #pragma fragment fragShadowCaster
                #include "UnityStandardShadow.cginc"
                ENDCG
            }

            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_surface
                #pragma fragment frag_surface
                #define FURSTEP 0.00
                #include "FurPrimaryHelper.cginc"
                ENDCG
                
            }

            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.05
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.10
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.15
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.20
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.25
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.30
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.35
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.40
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.45
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.50
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.55
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.60
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.65
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.70
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.75
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.80
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.85
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.90
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 0.95
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }

            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_base
                #pragma fragment frag_base
                #define FURSTEP 1.00
                #include "FurPrimaryHelper.cginc"
                
                ENDCG
                
            }
        }
    }
}