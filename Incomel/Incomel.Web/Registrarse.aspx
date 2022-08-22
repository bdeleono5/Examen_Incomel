<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/PublicMasterPage.Master" AutoEventWireup="true" CodeBehind="Registrarse.aspx.cs" Inherits="Incomel.Web.Registrarse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <header id="head" class="secondary"></header>

    <div class="container container-public">
        <div class="row">
            <article class="col-xs-12 maincontent">
                <div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <h3 class="thin text-center">Registrar una nueva cuenta</h3>
                            <p class="text-center text-muted">Ingrese los campos requeridos marcados con *</p>
                            <hr>

                            <form>
                                <div class="top-margin">
                                    <label>Nombre</label>
                                    <input type="text" class="form-control">
                                </div>
                                <div class="top-margin">
                                    <label>Apellido</label>
                                    <input type="text" class="form-control">
                                </div>
                                <div class="top-margin">
                                    <label>Correo<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control">
                                </div>

                                <div class="top-margin">
                                    <label>Fecha Nacimiento<span class="text-danger">*</span></label>
                                    <input type="date" class="form-control">
                                </div>

                                <div class="row top-margin">
                                    <div class="col-sm-6">
                                        <label>Contraseña <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control">
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Confirmar Contraseña <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control">
                                    </div>
                                </div>

                                <hr>

                                <div class="row">
                                    <div class="col-lg-4 text-right">
                                        <button class="btn btn-action" type="submit">Registrar</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </article>
        </div>
    </div>
</asp:Content>
