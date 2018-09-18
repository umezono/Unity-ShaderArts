using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Sketch : MonoBehaviour {

    [SerializeField]
    Material mat;

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        Graphics.Blit(null, dest, mat);
    }

    //// Use this for initialization
    //void Start () {

    //}

    //// Update is called once per frame
    //void Update () {

    //}
}
