using Incomel.API.DAL.Stored_Procedure;
using Incomel.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Incomel.API.Controllers
{
    [RoutePrefix("api/Login")]
    public class LoginController : ApiController
    {
        [Route("Autenticacion")]
        [HttpPost]
        public IHttpActionResult Autenticacion(Usuario user)
        {
            Parameters parameters = new Parameters();
            StoredProcedure exeStoredProcedure = new StoredProcedure();

            try
            {
                parameters.Add("usuario", user.usuario);
                parameters.Add("password", user.password);
                var result = exeStoredProcedure.ExecuteDataReader<Empleado>("sp_Login", parameters).FirstOrDefault(); 
                return Ok(result);
            }
            catch (Exception ex)
            {
               return InternalServerError(ex);
            }                           
        }
    }
}
