<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/PrivateMasterPega.Master" AutoEventWireup="true" CodeBehind="Palindromos.aspx.cs" Inherits="Incomel.Web.Palindromo.Palindromos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <br />
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h4>Palindromos</h4>
                <%--<button id="btnNuevoEmpleado" type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#myModal">Nuevo</button>--%>
            </div>
            <div class="panel-body">
                <div class="panel-body">
                    <div class="col-md-6">
                        <label>Texto:</label>
                        <div class="input-group input-gropu-sm">
                            <span class="input-group-addon"><i class="fa fa-info-circle"></i></span>
                            <input id="txtTexto" type="text" class="form-control" placeholder="prueba palindromo">
                            <span class="input-group-btn">
                                <button id="btnBuscar" class="btn btn-primary" type="button">
                                    <span class="glyphicon glyphicon-search" aria-hidden="true"></span>Búscar</button>
                            </span>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <label>Palíndromos: </label>
                        <label id="lblCantidadPalindromos">0</label>
                    </div>
                    <div class="col-md-12">
                        <ul id="list">
                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnBuscar").on("click", function () {
                var frmData = new FormData();
                frmData.append("mthd", "Palindromo");
                frmData.append("texto", $("#txtTexto").val());

                $.ajax({
                    url: "<% { Response.Write(ConfigurationManager.AppSettings.Get("RutaVirtualWeb")); } %>GenericMethodIncomel.ashx",
                    data: frmData,
                    contentType: false,
                    processData: false,
                    type: "POST",
                    //contentType: 'application/x-www-form-urlencoded; charset=utf-8',
                    //dataType: "json",
                    beforeSend: function () {
                        Holdon_Open("Convirtiendo...");
                    },
                    success: function (result) {
                        $("#lblCantidadPalindromos").text(result.length);

                        var ul = document.getElementById("list");
                        while (ul.hasChildNodes()) {
                            ul.removeChild(ul.firstChild);
                        }

                        for (var x = 0; x < result.length; x++) {
                            //console.log(result.texto);
                            var li = document.createElement("li");
                            li.appendChild(document.createTextNode(result[x].texto));
                            ul.appendChild(li);
                        }
                    },
                    error: function (result) {
                        console.log('error:', result);
                        Swal.fire({
                            icon: 'error',
                            text: 'Ocurrio un error al obtener el palindromo.',
                        });
                    },
                    complete: function () {
                        Holdon_Close();
                    }
                });
            });
        });
    </script>

</asp:Content>
