// Original shader concept develped by Sorumi (https://github.com/Sorumi/UnityFurShader)
// Shout out to loverord for help with the hue, saturation and brightness modifications.

#pragma target 3.0

#include "Lighting.cginc"
#include "UnityCG.cginc"

struct v2f
{
    float4 pos: SV_POSITION;
    half4 uv: TEXCOORD0;
    float3 worldNormal: TEXCOORD1;
    float3 worldPos: TEXCOORD2;
};

fixed4 _ColorPrimary;
half _SpecularPrimary;
half _ShininessPrimary;

fixed _EmissionPrimary;
fixed _HuePrimary;
fixed _SatPrimary;

sampler2D _MainTexPrimary;
half4 _MainTexPrimary_ST;
sampler2D _FurTexPrimary;
half4 _FurTexPrimary_ST;

fixed _FurLengthPrimary;
fixed _FurDensityPrimary;
fixed _FurThinnessPrimary;
fixed _FurShadingPrimary;

fixed alt(fixed n, fixed3 hsv)
{
	fixed k=fmod(n+hsv.x/60,6);
	return (hsv.z-hsv.z*hsv.y*max(0,min(min(k,4-k),1)));
}

fixed3 conv(fixed3 clr)
{
	fixed mx=max(clr.r,max(clr.g,clr.b));
	fixed mn=min(clr.r,min(clr.g,clr.b));
	fixed3 hsv={0,0,mx};
	fixed c=mx-mn;
	if(hsv.z == clr.r){
		hsv.x=60*((clr.g-clr.b)/c);
	}else{
		if(hsv.z == clr.g){
			hsv.x=60*(2+(clr.b-clr.r)/c);
		}else{
			if(hsv.z == clr.b){
				hsv.x=60*(4+(clr.r-clr.g)/c);
			}
		}
	}
	if(hsv.z!=0){
		hsv.y=c/hsv.z;
	}
	hsv.x+=_HuePrimary;
	if(hsv.x>360)hsv.x-=360;
	hsv.y*=_SatPrimary;
	return fixed3(alt(5,hsv),alt(3,hsv),alt(1,hsv));
}

v2f vert_surface(appdata_base v)
{
    v2f o;
    o.pos = UnityObjectToClipPos(v.vertex);
    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTexPrimary);
    o.worldNormal = UnityObjectToWorldNormal(v.normal);
    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

    return o;
}

v2f vert_base(appdata_base v)
{
    v2f o;
    float3 P = v.vertex.xyz + v.normal * _FurLengthPrimary * FURSTEP;
    o.pos = UnityObjectToClipPos(float4(P, 1.0));
    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTexPrimary );
    o.uv.zw = TRANSFORM_TEX(v.texcoord, _FurTexPrimary );
    o.worldNormal = UnityObjectToWorldNormal(v.normal);
    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

    return o;
}

fixed4 frag_surface(v2f i): SV_Target
{
    fixed3 worldNormal = normalize(i.worldNormal);
    fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
    fixed3 worldHalf = normalize(worldView + worldLight);

    fixed3 albedo = conv(tex2D(_MainTexPrimary, i.uv.xy).rgb) * _ColorPrimary;
    fixed3 ambient = albedo * _EmissionPrimary + UNITY_LIGHTMODEL_AMBIENT.xyz * albedo * (1 - _EmissionPrimary);
    fixed3 diffuse = _LightColor0.rgb * albedo * saturate(dot(worldNormal, worldLight));
    fixed3 specular = _LightColor0.rgb * conv(tex2D(_MainTexPrimary, i.uv.xy).rgb)  * _SpecularPrimary * pow(saturate(dot(worldNormal, worldHalf)), _ShininessPrimary);

    fixed3 color = ambient + diffuse + specular;
    
    return fixed4(color, 1.0);
}

fixed4 frag_base(v2f i): SV_Target
{
    fixed3 worldNormal = normalize(i.worldNormal);
    fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
    fixed3 worldHalf = normalize(worldView + worldLight);
	
    fixed3 albedo = conv(tex2D(_MainTexPrimary, i.uv.xy).rgb) * _ColorPrimary;
    albedo -= (pow(1 - FURSTEP, 3)) * _FurShadingPrimary;

    fixed3 ambient = albedo * _EmissionPrimary + albedo * UNITY_LIGHTMODEL_AMBIENT.xyz * (1 - _EmissionPrimary);
    fixed3 diffuse = _LightColor0.rgb * albedo * saturate(dot(worldNormal, worldLight));
    fixed3 specular = _LightColor0.rgb * conv(tex2D(_MainTexPrimary, i.uv.xy).rgb) * _SpecularPrimary * pow(saturate(dot(worldNormal, worldHalf)), _ShininessPrimary);

    fixed3 color = ambient + diffuse + specular;
    fixed3 noise = tex2D(_FurTexPrimary, i.uv.zw * _FurThinnessPrimary).rgb;
    fixed alpha = clamp(noise - (FURSTEP * FURSTEP) * _FurDensityPrimary, 0, 1);
    
    return fixed4(color, alpha);
}