using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Lab1
{
    public class SDSHandler4 : IHttpHandler
    {
        public bool IsReusable => true;

        public void ProcessRequest(HttpContext context)
        {
            int sum;

            int a = Convert.ToInt32(context.Request.Form["a"]);
            int b = Convert.ToInt32(context.Request.Form["b"]);

            sum = a + b;

            string responseString = $"{sum}";

            context.Response.ContentType = "text/plain";
            context.Response.Write(responseString);
        }
    }
}