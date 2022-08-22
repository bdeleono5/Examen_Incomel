using Incomel.Model;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Incomel.Web
{
    /// <summary>
    /// Summary description for GenericMethodIncomel
    /// </summary>
    public class GenericMethodIncomel : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";
            string metodo = context.Request["mthd"];
            //string metodo = context.Request[];

            switch (metodo)
            {
                case "Login":
                    context.Response.Write(JsonConvert.SerializeObject(Login(context)));
                    break;
                case "Logout":
                    context.Response.Write(JsonConvert.SerializeObject(Logout()));
                    break;
                case "GetEmpleado":
                    context.Response.Write(JsonConvert.SerializeObject(ListaEmpleados(context)));
                    break;
                case "AgregarEmpleado":
                    context.Response.Write(JsonConvert.SerializeObject(AgregarEmpleado(context)));
                    break;
                case "ActualizarEmpleado":
                    context.Response.Write(JsonConvert.SerializeObject(ActualizarEmpleado(context)));
                    break;
                case "EliminarEmpleado":
                    context.Response.Write(JsonConvert.SerializeObject(EliminarEmpleado(context)));
                    break;
                case "Palindromo":
                    context.Response.Write(JsonConvert.SerializeObject(ObtenerPalindromo(context)));
                    break;
                default:
                    break;
            }
        }

        private response Login(HttpContext context)
        {
            Empleado empleado = new Empleado();
            response resp = new response();
            string json = context.Request["jsParam"];
            Usuario user = JsonConvert.DeserializeObject<Usuario>(json);

            rest_client rest = new rest_client("URL_API", "Bearer", context.Request.UserAgent);
            empleado = rest.GenericRestClient<Empleado, Usuario>("Autenticacion", null, TypeMethod.Post, user);

            if (empleado != null)
            {
                HttpContext.Current.Session.Remove("informacionUsuario");
                HttpContext.Current.Session.Add("informacionUsuario", empleado);

                resp.title = "Exitoso";
                resp.text = "Inicio de sesion exitoso";
                resp.type = "success";
                resp.resultObject = empleado;
            }
            else
            {
                resp.title = "";
                resp.text = "No se pudo iniciar sesion";
                resp.type = "warning";
            }

            return resp;
        }
        private response Logout()
        {
            response resp = new response();
            HttpContext.Current.Session.Remove("informacionUsuario");

            if (HttpContext.Current.Session["informacionUsuario"] == null)
            {
                resp.title = "LogOut";
                resp.text = "";
                resp.type = "success";
            }

            return resp;
        }

        #region Empleado
        private response ListaEmpleados(HttpContext context)
        {
            Empleado empleado = new Empleado();
            response resp = new response();
            IList<Empleado> lstEmpleado = new List<Empleado>();
            rest_client rest = new rest_client("URL_API", "Bearer", context.Request.UserAgent);

            rest.Add("idEmpleado", "");
            lstEmpleado = rest.GenericRestClient<List<Empleado>, DBNull>("GetEmpleado", null, TypeMethod.Get);

            if (lstEmpleado.Count > 0)
            {
                resp.title = "Exitoso";
                resp.text = "Lista empleados";
                resp.type = "success";
                resp.resultObject = lstEmpleado;
            }
            else
            {
                resp.title = "";
                resp.text = "No se pudo obtener los datos";
                resp.type = "warning";
            }

            return resp;
        }
        private response AgregarEmpleado(HttpContext context)
        {
            int result = 0;
            Empleado empleado = new Empleado();
            response resp = new response();
            string json = context.Request["jsParam"];
            empleado = JsonConvert.DeserializeObject<Empleado>(json);

            rest_client rest = new rest_client("URL_API", "Bearer", context.Request.UserAgent);

            result = rest.GenericRestClient<int, Empleado>("AgregarEmpleado", null, TypeMethod.Post, empleado);

            if (result != 0)
            {
                resp.title = "";
                resp.text = "Empleado guardado Correctamente";
                resp.type = "success";
            }
            else
            {
                resp.title = "";
                resp.text = "No se pudo guardar los datos";
                resp.type = "warning";
            }

            return resp;
        }

        private response ActualizarEmpleado(HttpContext context)
        {
            int result = 0;
            Empleado empleado = new Empleado();
            response resp = new response();
            string json = context.Request["jsParam"];
            empleado = JsonConvert.DeserializeObject<Empleado>(json);

            rest_client rest = new rest_client("URL_API", "Bearer", context.Request.UserAgent);

            result = rest.GenericRestClient<int, Empleado>("ActualizarEmpleado", null, TypeMethod.Post, empleado);

            if (result != 0)
            {
                resp.title = "";
                resp.text = "Empleado Actualizado Correctamente";
                resp.type = "success";
            }
            else
            {
                resp.title = "";
                resp.text = "No se pudo guardar los datos";
                resp.type = "warning";
            }

            return resp;
        }
        private response EliminarEmpleado(HttpContext context)
        {
            int result = 0;
            Empleado empleado = new Empleado();
            response resp = new response();
            string idEmpleado = context.Request["id"];

            rest_client rest = new rest_client("URL_API", "Bearer", context.Request.UserAgent);

            rest.Add("idEmpleado", idEmpleado);
            result = rest.GenericRestClient<int, DBNull>("EliminarEmpleado", null, TypeMethod.Post);

            if (result != 0)
            {
                resp.title = "";
                resp.text = "Empleado se elimino Correctamente";
                resp.type = "success";
            }
            else
            {
                resp.title = "";
                resp.text = "No se pudo eliminar los datos";
                resp.type = "warning";
            }

            return resp;
        }
        #endregion

        #region Palindromo
        private List<PalindromoModel> ObtenerPalindromo(HttpContext context)
        {
            string temp = "";
            string stf;
            int count = 0;
            List<PalindromoModel> palindromos = new List<PalindromoModel>();
            string texto = context.Request["texto"];

            for (int i = 0; i < texto.Length; i++)
            {
                for (int j = i + 1; j <= texto.Length; j++)
                {
                    // Obtenemos cada sub string
                    temp = texto.Substring(i, j - i);

                    //validar si el temp el tamaño es mayor o igual a 2
                    if (temp.Length >= 2)
                    {
                        stf = temp;
                        stf = reverse(temp);

                        //Comparar el texto con el reverso del texto
                        if (stf.ToString().CompareTo(temp) == 0)
                        {
                            PalindromoModel palindromo = new PalindromoModel();
                            palindromo.texto = stf;
                            palindromos.Add(palindromo);
                            count++;
                        }

                    }
                }
            }

            return palindromos;
        }

        static string reverse(string input)
        {
            char[] a = input.ToCharArray();
            int l, r = 0;
            r = a.Length - 1;

            for (l = 0; l < r; l++, r--)
            {
                char temp = a[l];
                a[l] = a[r];
                a[r] = temp;
            }
            return string.Join("", a);
        }
        #endregion

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}