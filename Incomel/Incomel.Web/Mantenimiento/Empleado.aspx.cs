using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Incomel.Web.Mantenimiento
{
    public partial class Empelado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["informacionUsuario"] != null)
            {

            }
            else
            {
                HttpContext.Current.Response.Redirect(ConfigurationManager.AppSettings["RutaVirtualWeb"] + "Login.aspx");
            }
        }
    }
}