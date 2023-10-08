using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Lab1
{
    public class SDSHandler5 : IHttpHandler
    {
        public bool IsReusable => true;

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.HttpMethod == "GET")
            {
                context.Response.ContentType = "text/html";
                context.Response.WriteFile("../forTask5.html");
            }
            else if (context.Request.HttpMethod == "POST")
            {
                int result;
                int a = Convert.ToInt32(context.Request.Form["a"]);
                int b = Convert.ToInt32(context.Request.Form["b"]);

                result = a * b;

                context.Response.ContentType = "text/plain";
                context.Response.Write(result);
            }
        }
    }
}