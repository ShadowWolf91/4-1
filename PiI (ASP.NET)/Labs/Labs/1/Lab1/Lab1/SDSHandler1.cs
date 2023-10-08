using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Lab1
{
    public class SDSHandler1 : IHttpHandler
    {
        public bool IsReusable => true;

        public void ProcessRequest(HttpContext context)
        {
            string parA = context.Request.Params["ParmA"];
            string parB = context.Request.Params["ParmB"];

            string respText = $"GET-Http-SDS:ParmA = {parA}, ParmB = {parB}";

            context.Response.ContentType = "text/plain";
            context.Response.Write(respText);
        }
    }
}