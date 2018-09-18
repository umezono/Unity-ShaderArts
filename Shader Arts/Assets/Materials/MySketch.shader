Shader "Hidden/NewImageEffectShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			/*#pragma vertex vert*/
			#pragma vertex vert_img
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			/*struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};*/

			/*struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};*/

			/*v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			};*/
			
			sampler2D _MainTex;

			fixed4 frag(v2f_img i) : SV_Target
			{
				fixed2 resolution = _ScreenParams;
				fixed2 position = (i.uv * resolution / resolution.xy);
				float time = _Time * 30;

				// return float4(i.uv.x, i.uv.y, 0, 1);

				//float d = distance(float2(0.5, 0.5), i.uv);
				//float a = 0.4; // 閾値
				//return step(a, d);

				fixed color = 0.0;
				color += sin(position.x * cos(time / 15.0) * 80.0) + cos(position.y * cos(time / 15.0) * 10.0);
				color += sin(position.y * sin(time / 10.0) * 40.0) + cos(position.x * sin(time / 25.0) * 40.0);
				color += sin(position.x * sin(time / 5.0) * 10.0) + sin(position.y * sin(time / 35.0) * 80.0);
				color *= sin(time / 10.0) * 0.5;
				return fixed4(color, color * 0.5, sin(color + time / 3.0) * 0.75, 1.0);
			};

			//fixed4 frag (v2f i) : SV_Target
			//{
			//	fixed4 col = tex2D(_MainTex, i.uv);
			//	// just invert the colors
			//	col.rgb = 1 - col.rgb;
			//	return col;
			//}
			ENDCG
		}
	}
}
