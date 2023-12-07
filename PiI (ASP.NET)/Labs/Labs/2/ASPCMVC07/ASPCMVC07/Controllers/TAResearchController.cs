using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;
using System.Net.Mail;
using System.Reflection;

namespace ASPCMVC07.Controllers
{
    [Route("it/")]
    public class TAResearchController : Controller
    {
        [HttpGet]
        [Route("{n:int}/{str}")]
        public IActionResult M04(int n, String str)
        {
            return Content($"GET:M04:/{n}/{str}");
        }

        [HttpGet]
        [HttpPost]
        [Route("{b:bool}/{letters:alpha}")]
        public IActionResult M05(bool b, string letters)
        {
            string callingMethodName = ControllerContext.HttpContext.Request.Method;
            return Content($"{callingMethodName}:M05:/{b}/{letters}");
        }

        [HttpGet]
        [HttpDelete]
        [Route("{f:float}/{str:length(2,5)}")]
        public IActionResult M06(float f, String str)
        {
            string callingMethodName = ControllerContext.HttpContext.Request.Method;
            return Content($"{callingMethodName}:M06/{f}/{str}");
        }

        [HttpPut]
        [Route("{letters:alpha:length(3,4)}/{n:int:range(100,200)}")]
        public IActionResult M07(string letters, int n)
        {
            string callingMethodName = ControllerContext.HttpContext.Request.Method;
            return Content($"{callingMethodName}:M07/{letters}/{n}");
        }

        [HttpPost]
        [Route("{mail:regex(^[[A-Za-z0-9._%+-]]+@[[A-Za-z0-9.-]]+\\.[[A-Za-z]]{{2,}}$)}")]
        public IActionResult M08(string mail)
        {
            string callingMethodName = ControllerContext.HttpContext.Request.Method;
            return Content($"{callingMethodName}:M08/{mail}");
        }


    }
}
