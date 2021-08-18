Shader "Hirabiki/ScreenSpace/VRCCam Preview Replace"
{
	Properties {
		_MainTex ("Main Texture", 2D) = "black" {}
	}
	SubShader
	{
		// Draw ourselves after all opaque geometry
		Tags
		{
			"Queue" = "Transparent+1000"
			"DisableBatching" = "True"
			"IgnoreProjector" = "True"
		}
		ZTest Always
		
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			
			
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};
			
			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 pos : SV_POSITION;
			};
			
			v2f vert(appdata v) {
				v2f o;
#if defined(USING_STEREO_MATRICES)
				float isCam = 0.0;
#else
				//The filter will only go through when
				//The camera is not 60 degree, and far plane is specific value
				float isCam = 1.0;
#endif
				o.pos = mul(UNITY_MATRIX_P, v.vertex * float4(16,16,0,1) * isCam + float4(0.0, 0.0, -0.001 -_ProjectionParams.y, 0.0));
				
				float4 rawPos = ComputeGrabScreenPos(o.pos);
				float2 scrUVRaw = rawPos.xy / rawPos.w;
				o.uv = scrUVRaw;
				return o;
			}
			
			sampler2D _MainTex;
			
			half4 frag(v2f i) : SV_Target
			{
#if defined(USING_STEREO_MATRICES)
				discard;
				return half4(0,0,0,0);
#else
				half4 col = tex2D(_MainTex, i.uv);
				return col;
#endif
			}
			
			ENDCG
		}
    }
}