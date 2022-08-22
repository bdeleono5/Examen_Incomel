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
    [RoutePrefix("api/Empleado")]
    public class EmpleadoController : ApiController
    {
        [Route("GetEmpleado")]
        public IHttpActionResult GetEmpleado(string idEmpleado)
        {
            //sp_GetEmpleado
            Parameters parameters = new Parameters();
            StoredProcedure exeStoredProcedure = new StoredProcedure();
            IList<Empleado> lstEmpleado = new List<Empleado>();

            try
            {
                if (!string.IsNullOrWhiteSpace(idEmpleado))
                {
                    parameters.Add("id", idEmpleado);
                }
                else
                {
                    parameters.Add("id", DBNull.Value);
                }

                lstEmpleado = exeStoredProcedure.ExecuteDataReader<Empleado>("sp_GetEmpleado", parameters);
                return Ok(lstEmpleado);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        [Route("AgregarEmpleado")]
        [HttpPost]
        public IHttpActionResult AddEmpleado(Empleado empleado)
        {
            //sp_GetEmpleado
            Parameters parameters = new Parameters();
            StoredProcedure exeStoredProcedure = new StoredProcedure();
            int result = 0;
            try
            {

                parameters.Add("DPI", SqlDbType.NVarChar, empleado.DPI);
                parameters.Add("nombre", SqlDbType.NVarChar, empleado.nombre);
                parameters.Add("correo", SqlDbType.NVarChar, empleado.correo);
                parameters.Add("fecha_nacimiento", SqlDbType.DateTime2, empleado.fecha_nacimiento);
                parameters.Add("cant_hijos", SqlDbType.Int, empleado.cant_hijos);
                parameters.Add("salario_base", SqlDbType.Decimal, empleado.salario_base);
                parameters.Add("bono_decreto", SqlDbType.Decimal, empleado.bono_decreto);
                parameters.Add("IGSS", SqlDbType.Decimal, empleado.IGSS);
                parameters.Add("IRTRA", SqlDbType.Decimal, empleado.IRTRA);
                parameters.Add("bono_paternidad", SqlDbType.Decimal, empleado.bono_paternidad);
                parameters.Add("salario_total", SqlDbType.Decimal, empleado.salario_total);
                parameters.Add("salario_liquido", SqlDbType.Decimal, empleado.salario_liquido);
                result = exeStoredProcedure.ExecuteScalar<int>("sp_AgregarEmpleado", parameters);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        [Route("ActualizarEmpleado")]
        [HttpPost]
        public IHttpActionResult UpdateEmpleado(Empleado empleado)
        {
            //sp_GetEmpleado
            Parameters parameters = new Parameters();
            StoredProcedure exeStoredProcedure = new StoredProcedure();
            int result = 0;
            try
            {
                parameters.Add("id", empleado.id);
                parameters.Add("DPI", SqlDbType.NVarChar, empleado.DPI);
                parameters.Add("nombre", SqlDbType.NVarChar, empleado.nombre);
                parameters.Add("correo", SqlDbType.NVarChar, empleado.correo);
                parameters.Add("fecha_nacimiento", SqlDbType.DateTime2, empleado.fecha_nacimiento);
                parameters.Add("cant_hijos", SqlDbType.Int, empleado.cant_hijos);
                parameters.Add("salario_base", SqlDbType.Decimal, empleado.salario_base);
                parameters.Add("bono_decreto", SqlDbType.Decimal, empleado.bono_decreto);
                parameters.Add("IGSS", SqlDbType.Decimal, empleado.IGSS);
                parameters.Add("IRTRA", SqlDbType.Decimal, empleado.IRTRA);
                parameters.Add("bono_paternidad", SqlDbType.Decimal, empleado.bono_paternidad);
                parameters.Add("salario_total", SqlDbType.Decimal, empleado.salario_total);
                parameters.Add("salario_liquido", SqlDbType.Decimal, empleado.salario_liquido);
                result = exeStoredProcedure.ExecuteScalar<int>("sp_ActualizarEmpleado", parameters);

                return Ok(result);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        [Route("EliminarEmpleado")]
        [HttpPost]
        public IHttpActionResult DeleteEmpleado(string idEmpleado)
        {
            //sp_GetEmpleado
            Parameters parameters = new Parameters();
            StoredProcedure exeStoredProcedure = new StoredProcedure();
            int result = 0;

            try
            {
                parameters.Add("id", idEmpleado);
                result = exeStoredProcedure.ExecuteScalar<int>("sp_EliminarEmpleado", parameters);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }
    }
}
