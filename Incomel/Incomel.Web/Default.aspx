<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/PublicMasterPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Incomel.Web.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header -->
    <header id="head">
        <div class="container">
            <div class="row">
                <h1 class="lead">INCOMEL</h1>
                <p class="tagline">Descripcion de la empresa</p>
                <p><a class="btn btn-action btn-lg" role="button">MAS INFORMACIÓN</a></p>
            </div>
        </div>
    </header>
    <!-- /Header -->

    <!-- Intro -->
    <div class="container text-center">
        <br>
        <br>
        <h2 class="thin">Descripción</h2>
        <p class="text-muted">
            Mas información de la empresa 
        </p>
    </div>
    <!-- /Intro-->

    <!-- Highlights - jumbotron -->
    <div class="jumbotron top-space">
        <div class="container">

            <h3 class="text-center thin">Información util para los usuarios</h3>

            <div class="row">
                <div class="col-md-3 col-sm-6 highlight">
                    <div class="h-caption">
                        <h4><i class="fa fa-cogs fa-5"></i>Modulo 1</h4>
                    </div>
                    <div class="h-body text-center">
                        <p>Descripción del modulo 1</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 highlight">
                    <div class="h-caption">
                        <h4><i class="fa fa-flash fa-5"></i>Modulo 2</h4>
                    </div>
                    <div class="h-body text-center">
                        <p>Descripción del modulo 2</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 highlight">
                    <div class="h-caption">
                        <h4><i class="fa fa-heart fa-5"></i>Modulo 3</h4>
                    </div>
                    <div class="h-body text-center">
                        <p>Descripción del modulo 3</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 highlight">
                    <div class="h-caption">
                        <h4><i class="fa fa-smile-o fa-5"></i>Modulo 4</h4>
                    </div>
                    <div class="h-body text-center">
                        <p>Descripción del modulo 4</p>
                    </div>
                </div>
            </div>
            <!-- /row  -->
        </div>
    </div>
    <!-- /Highlights -->

    <!-- container -->
    <div class="container">

        <h2 class="text-center top-space">Mas Información de Incomel</h2>
        <br>

        <div class="row">
            <div class="col-sm-6">
                <h3>Descripción</h3>
                <p>otras descripciones</p>
            </div>
        </div>
        <!-- /row -->

        <div class="jumbotron top-space">
            <h4>Sección donde puede agragrse URL's para redireccionar a otras paginas</h4>
            <p class="text-right"><a class="btn btn-primary btn-large">Aprender más »</a></p>
        </div>

    </div>
    <!-- /container -->
</asp:Content>
