<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/PrivateMasterPega.Master" AutoEventWireup="true" CodeBehind="Empleado.aspx.cs" Inherits="Incomel.Web.Mantenimiento.Empelado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%-- MODAL INGRESAR NUEVO EMPLEADO --%>

    <div class="container-fluid">
        <h3>Lista Empleados</h3>
        <br />
        <div class="panel panel-primary">
            <div class="panel-heading">
                <button id="btnNuevoEmpleado" type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#myModal">Nuevo</button>
            </div>
            <div class="panel-body">
                <div class="panel-body">
                    <div class="table-responsive">
                        <table id="dtListaEmpleado" class="table table-bordered table-hover table-striped table-condensed">
                            <thead class="table-head">
                                <tr>
                                    <th>ID</th>
                                    <th>DPI</th>
                                    <th>Nombre Completo</th>
                                    <th>Correo</th>
                                    <th>Fecha Nacimiento</th>
                                    <th>Hijos</th>
                                    <th>Salario Base</th>
                                    <th>IGSS</th>
                                    <th>IRTRA</th>
                                    <th>Bono Paternidad</th>
                                    <th>Salario Total</th>
                                    <th>Salario Liquido</th>
                                    <th>Estado</th>
                                    <th>&nbsp;</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade md-lg" id="myModal" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title">Empleado</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="input-group" style="display: none;">
                        <span class="input-group-addon"><i class="fa fa-user"></i></span>
                        <input id="txtIdEmpleado" type="text" class="form-control" placeholder="Id empleado">
                    </div>
                    <div class="col-md-6">
                        <label>DPI: (*)</label>
                        <div class="input-group input-gropu-sm">
                            <span class="input-group-addon"><i class="fa fa-info-circle"></i></span>
                            <input id="txtDPI" type="text" class="form-control" placeholder="DPI empleado">
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label>Nombre Empleado: (*)</label>
                        <div class="input-group input-group-sm">
                            <span class="input-group-addon"><i class="fa fa-user"></i></span>
                            <input id="txtNombre" type="text" class="form-control" placeholder="Nombre empleado">
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label>Correo: (*)</label>
                        <div class="input-group input-group-sm">
                            <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                            <input id="txtCorreo" type="email" class="form-control" placeholder="ejemplo@gmail.com">
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label>Fecha Nacimiento: (*)</label>
                        <div class="input-group input-group-sm">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            <input id="txtFechaNac" type="date" class="form-control">
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label>Cantidad de Hijos: (*)</label>
                        <div class="input-group input-group-sm">
                            <span class="input-group-addon"><i class="fa fa-user"></i></span>
                            <input id="txtCantHijos" type="text" class="form-control" placeholder="Cantidad de hijos empleado">
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label>Salario Base: (*)</label>
                        <div class="input-group input-group-sm">
                            <span class="input-group-addon">Q</span>
                            <input id="txtSalarioBase" type="text" class="form-control" placeholder="0.00">
                        </div>
                    </div>

                    <div class="row"></div>
                    <br />
                    <div class="col-md-4">
                        <label>Bono Decreto:</label>
                        <label>Q <% { Response.Write(ConfigurationManager.AppSettings.Get("Bono_Decreto")); } %></label>
                    </div>
                    <div class="col-md-4">
                        <label>IGSS: Q </label>
                        <label id="lblIGSS">0.00</label>
                    </div>
                    <div class="col-md-4">
                        <label>IRTRA: Q </label>
                        <label id="lblIRTRA">0.00</label>
                    </div>
                    <div class="col-md-12">
                        <label>Bono Paterniadad: Q </label>
                        <label id="lblBonoPaternidad">0.00</label>
                    </div>
                    <div class="col-md-12">
                        <label>Salario Total: Q </label>
                        <label id="lblSalarioTotal">0.00</label>
                    </div>
                    <div class="col-md-12">
                        <label style="color: green;">Salario Liquido: Q </label>
                        <label id="lblSalarioLiquido" style="color: green;">0.00</label>
                    </div>
                </div>
                <div class="modal-footer bg-primary">
                    <button id="btnGuardar" type="button" class="btn btn-success">Guardar</button>
                </div>
            </div>

        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {

            initTable();
            CargarDatos();

            $('#txtSalarioBase').keypress(function (event) {
                if (event.which == 13) {
                    var sueldoBase = $("#txtSalarioBase").val();
                    sueldoBase = parseFloat(sueldoBase);
                    var hijos = $("#txtCantHijos").val();
                    var iggs = <% { Response.Write(ConfigurationManager.AppSettings.Get("IGSS")); } %>;
                    var irtra = <% { Response.Write(ConfigurationManager.AppSettings.Get("IRTRA")); } %>;
                    var bonoPat = <% { Response.Write(ConfigurationManager.AppSettings.Get("Paternidad")); } %>;
                    var bonoDecreto = <% { Response.Write(ConfigurationManager.AppSettings.Get("Bono_Decreto")); } %>;

                    $("#lblIGSS").text((sueldoBase * iggs).toFixed(2));
                    $("#lblIRTRA").text((sueldoBase * irtra).toFixed(2));
                    $("#lblBonoPaternidad").text((bonoPat * hijos).toFixed(2));

                    var totaIgss = $("#lblIGSS").text();
                    var totalIrtra = $("#lblIRTRA").text();
                    var bonoPaternidad = $("#lblBonoPaternidad").text();
                    var salarioTotal = sueldoBase + parseFloat(bonoPaternidad) + parseFloat(bonoDecreto);
                    $("#lblSalarioTotal").text(salarioTotal.toFixed(2));
                    var salarioLiquido = salarioTotal - parseFloat(totaIgss) - parseFloat(totalIrtra);
                    $("#lblSalarioLiquido").text(salarioLiquido.toFixed(2));
                }
            });

            $("#btnGuardar").on("click", function () {
                if (validate()) {
                    var data = {
                        id: ($("#txtIdEmpleado").val() == "" ? 0 : $("#txtIdEmpleado").val()),
                        DPI: $("#txtDPI").val(),
                        nombre: $("#txtNombre").val(),
                        correo: $("#txtCorreo").val(),
                        fecha_nacimiento: $("#txtFechaNac").val(),
                        cant_hijos: $("#txtCantHijos").val(),
                        salario_base: $("#txtSalarioBase").val(),
                        bono_decreto: parseFloat(<% { Response.Write(ConfigurationManager.AppSettings.Get("Bono_Decreto")); } %>),
                        IGSS: parseFloat($("#lblIGSS").text()),
                        IRTRA: parseFloat($("#lblIRTRA").text()),
                        bono_paternidad: parseFloat($("#lblBonoPaternidad").text()),
                        salario_total: parseFloat($("#lblSalarioTotal").text()),
                        salario_liquido: parseFloat($("#lblSalarioLiquido").text())
                    };

                    if ($("#btnGuardar").text() == "Guardar") {
                        AgregarEmpleado(data);
                    } else {
                        ActualizaEmpleado(data);
                    }
                }
            });

            $("#btnNuevoEmpleado").on("click", function () {
                $("#btnGuardar").text("Guardar");
                ClearFields();
            });
        });

        function validate() {
            if ($("#txtDPI").val() == "") {
                Swal.fire({ title: 'Campos requeridos', icon: 'warning', text: 'ingrese los campos requeridos marcados con un (*)' });
                $("#txtDPI").focus();
                return false;
            }
            else if ($("#txtNombre").val() == "") {
                Swal.fire({ title: 'Campos requeridos', icon: 'warning', text: 'ingrese los campos requeridos marcados con un (*)' });
                $("#txtNombre").focus();
                return false;
            }
            else if ($("#txtCorreo").val() == "") {
                Swal.fire({ title: 'Campos requeridos', icon: 'warning', text: 'ingrese los campos requeridos marcados con un (*)' });
                $("#txtCorreo").focus();
                return false;
            }
            else if ($("#txtFechaNac").val() == "") {
                Swal.fire({ title: 'Campos requeridos', icon: 'warning', text: 'ingrese los campos requeridos marcados con un (*)' });
                $("#txtFechaNac").focus();
                return false;
            }
            else if ($("#txtCantHijos").val() == "") {
                Swal.fire({ title: 'Campos requeridos', icon: 'warning', text: 'ingrese los campos requeridos marcados con un (*)' });
                $("#txtCantHijos").focus();
                return false;
            }
            else if ($("#txtSalarioBase").val() == "") {
                Swal.fire({ title: 'Campos requeridos', icon: 'warning', text: 'ingrese los campos requeridos marcados con un (*)' });
                $("#txtSalarioBase").focus();
                return false;
            }

            return true;
        }

        function ClearFields() {
            $("#txtIdEmpleado").val("");
            $("#txtDPI").val("");
            $("#txtNombre").val("");
            $("#txtCorreo").val("");
            $("#txtFechaNac").val("");
            $("#txtCantHijos").val("");
            $("#txtSalarioBase").val("");
            $("#lblIGSS").text("0.00");
            $("#lblIRTRA").text("0.00");
            $("#lblBonoPaternidad").text("0.00");
            $("#lblSalarioTotal").text("0.00");
            $("#lblSalarioLiquido").text("0.00");
        }

        function initTable() {
            $("#dtListaEmpleado").DataTable({
                language: {
                    "lengthMenu": "_MENU_",
                    "zeroRecords": "No se encontraron registros",
                    "info": "Mostrando _START_ a _END_ de _MAX_",
                    "infoEmpty": "No hay datos",
                    "infoFiltered": "(filtrando _TOTAL_ registro(s))",
                    "sSearch": "",
                    "sLoadingRecords": "Cargando registros...",
                    "oPaginate": {
                        "sFirst": "Primero",
                        "sPrevious": "Anterior",
                        "sNext": "Siguiente",
                        "sLast": "Ultimo"
                    },
                    searchPlaceholder: "Buscar empleado",
                    buttons: {
                        copyTitle: 'Añadido al portapapeles',
                        copyKeys: 'Presione <i>ctrl</i> o <i>\u2318 </i> + <i> C </i> para copiar los datos de la tabla al portapapeles. <br> <br> Para cancelar, haga clic en este mensaje o presione Esc.',
                        copySuccess: {
                            _: '%d lineas copiadas',
                            1: '1 línea copiada',
                            0: 'No se copió ningún registro'
                        }
                    }
                },
                columnDefs: [
                    {
                        targets: 13,
                        width: '10%'
                    },
                    {
                        targets: [0, 12],
                        visible: false
                    },
                    {
                        targets: [6, 7, 8, 9, 10, 11],
                        render: $.fn.dataTable.render.number(',', '.', 2, 'Q ')
                    }
                ],
                columns: [
                    { data: "id" },
                    { data: "DPI" },
                    { data: "nombre" },
                    { data: "correo" },
                    { data: "fecha_nacimiento" },
                    { data: "cant_hijos" },
                    { data: "salario_base" },
                    { data: "IGSS" },
                    { data: "IRTRA" },
                    { data: "bono_paternidad" },
                    { data: "salario_total" },
                    { data: "salario_liquido" },
                    { data: "estado" },
                    {
                        data: function (item) {
                            return '<button id="btnEditar" class="btn btn-success btn-sm" type="button" role="button" title="Editar" data-toggle="modal" data-target="#myModal"><span class="fa fa-edit"></span></button>' +
                                '<button id="btnEliminar" class="btn btn-danger btn-sm" type="button" role="button" title="Eliminar"><span class="fa fa-trash"></span></button>';
                        }
                    }
                ],
                createdRow: function (row, data, dataIndex) {
                    $(row).find("#btnEditar").on("click", function () {
                        AgregarValoresEmpleado(data);
                    });

                    $(row).find("#btnEliminar").on("click", function () {
                        EliminarEmpleado(data);
                    });
                }
            });
        }

        function CargarDatos() {
            var frmData = new FormData();
            frmData.append("mthd", "GetEmpleado");

            $.ajax({
                url: "<% { Response.Write(ConfigurationManager.AppSettings.Get("RutaVirtualWeb")); } %>GenericMethodIncomel.ashx",
                data: frmData,
                contentType: false,
                processData: false,
                type: "POST",
                beforeSend: function () {
                    Holdon_Open("Cargando...");
                },
                success: function (result) {
                    if (result.type == "success") {
                        var data = result.resultObject;
                        $("#dtListaEmpleado").DataTable().clear();
                        $("#dtListaEmpleado").DataTable().rows.add(data).draw();
                    }
                    else {
                        Swal.fire({ icon: result.type, text: result.text });
                    }
                },
                error: function (result) {
                    console.log('error:', result);
                    Swal.fire({
                        icon: 'error',
                        text: 'Ocurrio un error al iniciar el proceso de búsqueda.'
                    });
                },
                complete: function () {
                    Holdon_Close();
                }
            });
        }

        function AgregarEmpleado(data) {
            var frmData = new FormData();
            frmData.append("mthd", "AgregarEmpleado");
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
                    Holdon_Open("Guardando...");
                },
                success: function (result) {
                    if (result.type == "success") {
                        CargarDatos();
                        ClearFields();
                        $("[data-dismiss=modal]").trigger({ type: "click" });
                        Swal.fire({ icon: result.type, text: result.text });
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
                        text: 'Ocurrio un error al momento de guardar los datos.',
                    });
                },
                complete: function () {
                    Holdon_Close();
                }
            });
        }

        function ActualizaEmpleado(data) {
            var frmData = new FormData();
            frmData.append("mthd", "ActualizarEmpleado");
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
                    Holdon_Open("Actualizando...");
                },
                success: function (result) {
                    if (result.type == "success") {
                        CargarDatos();
                        ClearFields();
                        $("[data-dismiss=modal]").trigger({ type: "click" });
                        Swal.fire({ icon: result.type, text: result.text });
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
                        text: 'Ocurrio un error al momento de guardar los datos.',
                    });
                },
                complete: function () {
                    Holdon_Close();
                }
            });
        }

        function EliminarEmpleado(data) {
            var frmData = new FormData();
            frmData.append("mthd", "EliminarEmpleado");
            frmData.append("id", JSON.stringify(data.id));

            $.ajax({
                url: "<% { Response.Write(ConfigurationManager.AppSettings.Get("RutaVirtualWeb")); } %>GenericMethodIncomel.ashx",
                data: frmData,
                contentType: false,
                processData: false,
                type: "POST",
                //contentType: 'application/x-www-form-urlencoded; charset=utf-8',
                //dataType: "json",
                beforeSend: function () {
                    Holdon_Open("Eliminando...");
                },
                success: function (result) {
                    if (result.type == "success") {
                        CargarDatos();
                        ClearFields();
                        Swal.fire({ icon: result.type, text: result.text });
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
                        text: 'Ocurrio un error al momento de eliminar los datos.',
                    });
                },
                complete: function () {
                    Holdon_Close();
                }
            });
        }

        function AgregarValoresEmpleado(data) {
            $("#txtIdEmpleado").val(data.id);
            $("#txtDPI").val(data.DPI);
            $("#txtNombre").val(data.nombre);
            $("#txtCorreo").val(data.correo);
            $("#txtFechaNac").val(data.fecha_nacimiento);
            $("#txtCantHijos").val(data.cant_hijos);
            $("#txtSalarioBase").val(data.salario_base);
            $("#lblIGSS").text(data.IGSS);
            $("#lblIRTRA").text(data.IRTRA);
            $("#lblBonoPaternidad").text(data.bono_paternidad);
            $("#lblSalarioTotal").text(data.salario_total);
            $("#lblSalarioLiquido").text(data.salario_liquido);

            $("#btnGuardar").text("Actualizar");
        }
    </script>
</asp:Content>
