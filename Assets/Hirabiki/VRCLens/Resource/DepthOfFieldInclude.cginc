#ifndef _VRCLensInclude
#define _VRCLensInclude

uniform float4 _RenderTex_TexelSize;
uniform bool _IsDesktopMode, _IsDirectStream;
uniform float _PreviewPosMode;

struct appdata
{
	float2 uv : TEXCOORD0;
	float4 vertex : POSITION;
};

struct v2f
{
	float2 uv : TEXCOORD0;
	float4 pos : SV_POSITION;
};

v2f vert(appdata v)
{
	v2f o;
#if defined(USING_STEREO_MATRICES)
	o.pos = float4(0,0,0,1);
	o.uv = v.uv;
#else
	bool isNotWindowed = !_IsDesktopMode || floor(_PreviewPosMode) == 2 || (all(_ScreenParams.xy == half2(1920, 1080) || _ScreenParams.xy == _RenderTex_TexelSize.zw) && _IsDesktopMode);
	float isCam = abs(unity_CameraProjection._m11 - 1.73205) < 0.00001;
	isCam *= unity_OrthoParams.w == 0.0 && abs(_ProjectionParams.y - 0.01) < 0.001 && abs(_ProjectionParams.z - 1.00) < 0.001 // output camera
		&& (any(_ScreenParams.xy != half2(1280, 720)) || _IsDirectStream) && isNotWindowed;
	isCam += unity_OrthoParams.w == 1.0 && unity_OrthoParams.y == -0.007;
	isCam *= all(unity_CameraProjection._m20_m21 == 0.0);
	
	o.pos = mul(UNITY_MATRIX_P, v.vertex * float4(16,16,0,1) * isCam + float4(0.0, 0.0, -0.001 -_ProjectionParams.y, 0.0));
	float4 rawPos = ComputeNonStereoScreenPos(o.pos);
	float2 scrUVRaw = rawPos.xy / rawPos.w;
	o.uv = scrUVRaw;
#endif
	return o;
}

#endif