Shader "Unlit/QuadSketch"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			/*#pragma vertex vert*/
			#pragma vertex vert_img
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			/*struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}*/
			
			float heart(float2 st) {
				st = (st - float2(0.5, 0.38)) * float2(2.1, 2.8);

				return pow(st.x, 2) + pow(st.y - sqrt(abs(st.x)), 2);
			}

			fixed4 frag (v2f_img i) : SV_Target
			{
				fixed2 resolution = _ScreenParams;
				fixed2 position = (i.uv * resolution / resolution.xy);
				float time = _Time * 30;

				// return float4(i.uv.x, i.uv.y, 0, 1);

				float d = heart(position);
				return step(d, abs(sin(d * 8 - time * 2)));

				// return fixed4(heart(position), heart(position), heart(position), 1.0);

				//float d = distance(float2(0.5, 0.5), position);
				//d = d * 30;
				//d = abs(sin(d));
				//d = step(0.5, d);
				////float a = abs(sin(time)) * 0.4; // 閾値
				////float color = step(a, d);
				//return fixed4(d, d, d, 1.0);

				/*fixed color = 0.0;
				color += sin(position.x * cos(time / 15.0) * 80.0) + cos(position.y * cos(time / 15.0) * 10.0);
				color += sin(position.y * sin(time / 10.0) * 40.0) + cos(position.x * sin(time / 25.0) * 40.0);
				color += sin(position.x * sin(time / 5.0) * 10.0) + sin(position.y * sin(time / 35.0) * 80.0);
				color *= sin(time / 10.0) * 0.5;
				return fixed4(color, color * 0.5, sin(color + time / 3.0) * 0.75, 1.0);*/

				//// sample the texture
				//fixed4 col = tex2D(_MainTex, i.uv);
				//// apply fog
				//UNITY_APPLY_FOG(i.fogCoord, col);
				//return col;
			}
			ENDCG
		}
	}
}
