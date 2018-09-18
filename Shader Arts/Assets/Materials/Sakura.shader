Shader "Unlit/Sakura"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			float heart(float2 st) {
				st = (st - float2(0.5, 0.38)) * float2(2.1, 2.8);

				return pow(st.x, 2) + pow(st.y - sqrt(abs(st.x)), 2);
			}

			fixed4 frag(v2f_img i) : SV_Target
			{
				fixed2 resolution = _ScreenParams;
				fixed2 position = (i.uv * resolution / resolution.xy);
				float time = _Time * 30;

				// return float4(i.uv.x, i.uv.y, 0, 1);

				float d = heart(position);
				return step(d, abs(sin(d * 8 - time * 2)));
			}
			ENDCG
		}
	}
}
