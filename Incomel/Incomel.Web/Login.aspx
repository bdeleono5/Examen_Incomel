<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/PublicMasterPage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Incomel.Web.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <header id="head" class="secondary"></header>

    <div class="container container-public">
        <div class="row">
            <!-- Article main content -->
            <article class="col-xs-12 maincontent">
                <div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="text-center">
                                <img src="https://wf.incomel.com.gt/imagenes/japon.gif" width="232" height="70">
                            </div>
                            <h3 class="thin text-center">Iniciar sesión</h3>
                            <hr>

                            <form>
                                <div class="top-margin">
                                    <label>Usuario/Correo <span class="text-danger">*</span></label>
                                    <input id="txtUsuario" type="text" class="form-control">
                                </div>
                                <div class="top-margin">
                                    <label>Contraseña <span class="text-danger">*</span></label>
                                    <input id="txtPassword" type="password" class="form-control">
                                </div>

                                <hr>

                                <div class="row">
                                    <div class="col-lg-8">
                                        <b><a href="">Recuperar Contraseña?</a></b>
                                    </div>
                                    <div class="col-lg-4 text-right">
                                        <button id="btnLogin" class="btn btn-action" type="button">Acceder</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </article>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnLogin").on("click", function () {
                var dataJson = {
                    usuario: $("#txtUsuario").val(),
                    password: $("#txtPassword").val()
                }
                _Login(dataJson);
            });
        });

        function _Login(data) {
            var frmData = new FormData();
            frmData.append("mthd", "Login");
            frmData.append("jsParam", JSON.stringify(data));

            $.ajax({
                url: "<% { Response.Write(ConfigurationManager.AppSettings.Get("RutaVirtualWeb")); } %>GenericMethodIncomel.ashx",
                data: frmData,
                contentType: false,
                processData: false,
                type: "POST",
                //contentType: 'application/x-www-form-urlencoded; charset=utf-8',
                //dataType: "json",
                beforeSend: function () {
                    Holdon_Open("Autenticando...");
                },
                success: function (result) {
                    if (result.type == "success") {
                        window.location.href = "<% { Response.Write(ConfigurationManager.AppSettings.Get("RutaVirtualWeb")); } %>Home/Default.aspx";
                    }
                    else if (result.type == "warning") {
                        Swal.fire({ icon: result.type, text: result.text });
                    }
                    else {
                        Swal.fire({ icon: result.type, text: result.text });
                    }
                },
                error: function (result) {
                    console.log('error:', result);
                    Swal.fire({
                        icon: 'error',
                        text: 'Ocurrio un error al momento de iniciar sesion.',
                    });
                },
                complete: function () {
                    Holdon_Close();
                }
            });
        }
    </script>

</asp:Content>
