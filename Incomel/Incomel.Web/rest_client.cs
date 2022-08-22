using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;

namespace Incomel.Web
{
    public class rest_client
    {
        public string TokenPrefixApiRest;
        private string ApiKeyUrl;
        private bool RunMethod;
        private bool RunMethodPrefix;
        private string UserAgent;
        private Dictionary<string, string> _Params = new Dictionary<string, string>();
        private Dictionary<string, string> _ParamsHeaders = new Dictionary<string, string>();

        /// <summary>
        /// Constructor: rest_client
        /// </summary>
        /// <param name="apiKeyUrl">variable de entorno de la api</param>
        /// <param name="tokenPrefixApiRest">variable de entorno de token prefix</param>
        /// <param name="userAgent"></param>
        public rest_client(string apiKeyUrl, string tokenPrefixApiRest, string userAgent)
        {
            ApiKeyUrl = ConfigurationManager.AppSettings.Get(apiKeyUrl);
            TokenPrefixApiRest = ConfigurationManager.AppSettings.Get(tokenPrefixApiRest);

            RunMethod = string.IsNullOrEmpty(apiKeyUrl) ? false : true;
            RunMethodPrefix = string.IsNullOrEmpty(TokenPrefixApiRest) ? false : true;
            UserAgent = userAgent;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="TIn">tipo de dato de entrada (string,int,objeto, dynamic)</typeparam>
        /// <typeparam name="TOut">tipo de dato de salida (string,int,objeto, dynamic)</typeparam>
        /// <param name="metodo">url o direccion de la funcion que se encuentra en la API</param>
        /// <param name="contenido">valores del tipo de dato que espera la API</param>
        /// <param name="token">valor del token generado si existe si no mandarlo como vacio("")</param>
        /// <param name="typeMethod">tipo de metodo (GET,POST,PUT,DELETE)</param>
        /// <returns></returns>
        public TOut GenericRestClient<TOut, TIn>(string method, string token, TypeMethod typeMethod, TIn contenido = default(TIn))
        {
            string requestUri = string.Empty;

            if (!RunMethod)
            {
                throw new Exception("No se encontró la llave con la URL del servicio.");
            }
            //if (!RunMethodPrefix)
            //{
            //    throw new Exception("No se encontró la llave con el prefijo de envío del Token.");
            //}

            #region formateando URI
            requestUri = string.Format("{0}{1}", ApiKeyUrl + ConfigurationManager.AppSettings.Get(method).ToString(), AddParametersUri());
            #endregion

            try
            {
                using (var client = new HttpClient())
                {
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                    client.DefaultRequestHeaders.UserAgent.ParseAdd(UserAgent);
                    //client.BaseAddress = new Uri(ApiKeyUrl);

                    if (!string.IsNullOrEmpty(token))
                    {
                        client.DefaultRequestHeaders.Add("Authorization", string.Format("{0} {1}", TokenPrefixApiRest, token));
                    }

                    foreach (var param in _ParamsHeaders)
                    {
                        client.DefaultRequestHeaders.Add(param.Key, param.Value);
                    }

                    StringContent contenidoSerializado = null;

                    if (contenido != null)
                    {
                        contenidoSerializado = new StringContent(JsonConvert.SerializeObject(contenido), Encoding.UTF8, "application/json");
                    }

                    switch (typeMethod)
                    {
                        case TypeMethod.Get:
                            using (HttpResponseMessage respuesta = client.GetAsync(requestUri).Result)
                            {
                                respuesta.EnsureSuccessStatusCode();
                                string respuestaContenido = respuesta.Content.ReadAsStringAsync().Result;
                                return JsonConvert.DeserializeObject<TOut>(respuestaContenido);
                            }
                        case TypeMethod.Post:
                            using (HttpResponseMessage respuesta = client.PostAsync(requestUri, contenidoSerializado).Result)
                            {
                                respuesta.EnsureSuccessStatusCode();
                                string respuestaContenido = respuesta.Content.ReadAsStringAsync().Result;
                                return JsonConvert.DeserializeObject<TOut>(respuestaContenido);
                            }
                        case TypeMethod.Put:

                            using (HttpResponseMessage respuesta = client.PutAsync(requestUri, contenidoSerializado).Result)
                            {
                                respuesta.EnsureSuccessStatusCode();
                                string respuestaContenido = respuesta.Content.ReadAsStringAsync().Result;
                                return JsonConvert.DeserializeObject<TOut>(respuestaContenido);
                            }
                        case TypeMethod.Delete:
                            using (HttpResponseMessage respuesta = client.DeleteAsync(requestUri).Result)
                            {
                                respuesta.EnsureSuccessStatusCode();
                                string respuestaContenido = respuesta.Content.ReadAsStringAsync().Result;
                                return JsonConvert.DeserializeObject<TOut>(respuestaContenido);
                            }
                        default:
                            throw new Exception("Método no implementado.");
                    }

                }
            } //verificar como retornar estos mensajesy
            catch (Exception ex)
            {
                return JsonConvert.DeserializeObject<TOut>(ex.Message.ToString());
                //throw new Exception("Ocurrío un error al ejecutar la petición por RestClient.", ex);
            }
        }

        #region Add Parameters Uri
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        private string AddParametersUri()
        {
            if (!_Params.Any())
                return "";

            List<string> returnParams = new List<string>();

            foreach (var param in _Params)
            {
                returnParams.Add(String.Format("{0}={1}", param.Key, param.Value));
            }

            // credit annakata
            return "?" + String.Join("&", returnParams.ToArray());
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        //use form: var param = resCliente.ToString();
        public override string ToString()
        {
            if (!_Params.Any())
                return "";

            List<string> returnParams = new List<string>();

            foreach (var param in _Params)
            {
                returnParams.Add(String.Format("{0}={1}", param.Key, param.Value));
            }

            // return String.Format("?{0}", String.Join("&", returnParams.ToArray())); 

            // credit annakata
            return "?" + String.Join("&", returnParams.ToArray());
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="key"></param>
        /// <param name="value"></param>
        public void Add(string key, string value)
        {
            _Params.Add(key, HttpUtility.UrlEncode(value));
        }

        public void AddParamHeaders(string key, string value)
        {
            _ParamsHeaders.Add(key, HttpUtility.UrlEncode(value));
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="parameters"></param>
        /// <returns></returns>
        public string AsQueryString(IEnumerable<KeyValuePair<string, object>> parameters)
        {
            if (!parameters.Any())
                return "";

            var builder = new StringBuilder("?");

            var separator = "";
            foreach (var kvp in parameters.Where(kvp => kvp.Value != null))
            {
                builder.AppendFormat("{0}{1}={2}", separator, HttpUtility.UrlEncode(kvp.Key), HttpUtility.UrlEncode(kvp.Value.ToString()));

                separator = "&";
            }

            return builder.ToString();
        }

        /// <summary>
        /// 
        /// </summary>
        public void Clear()
        {
            this._Params.Clear();
            this._ParamsHeaders.Clear();
        }
        #endregion
    }

    /// <summary>
    /// 
    /// </summary>
    public enum TypeMethod
    {
        Get,
        Post,
        Put,
        Delete
    }
}