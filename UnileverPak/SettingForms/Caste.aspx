<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Caste.aspx.cs" Inherits="SettingForms_Caste" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <link href="css/dataTable.css" rel="stylesheet" />
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modified Caste</legend>

                    <table id="tblCaste" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">Caste Type:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtCasteName" Width="95%" placeholder="Caste Type"  class="alpha" runat="server" BackColor="White"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveCaste();" runat="server" />

                                <asp:Button ID="btnClearCaste" Text="Clear" CssClass="btn" OnClientClick="return ClearCaste();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateCaste();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divCasteDetails">
        <fieldset id="fldCasteDetails" >
            <legend>Caste Details</legend>
             <div style="overflow: auto; width: 100%;">
                  
            <table id="tbleCasteDetails" class="dataTable">
            </table>
                 </div>
        </fieldset>
    </div>

    <script type="text/javascript">
        var oTable;

        $(document).ajaxStart(blockUI).ajaxStop(unblockUI);

        function blockUI() {
            $.blockUI({
                message: '<img src="images/ajax-loader.gif" />',
                css: { borderStyle: 'none', backgroundColor: "Transparent" }
            });
        }
        function unblockUI() {
            $.unblockUI();
        }
        $(document).ready(function () {
            getCaste();

        });

        function dataTable() {
            oTable = $("#tbleCasteDetails").dataTable();
        }

        function SaveCaste() {
            var i = 0;
            if ($("#tbleCasteDetails tr").length - 1 > 1) {
                for (i = 0; i < $("#tbleCasteDetails tr").length - 1; i++) {

                    if ($("#txtCasteName" + i).html().toUpperCase().trim() == $("input[id$='txtCasteName']").val().toUpperCase().trim()) {
                        alert("Caste " + $("input[id$='txtCasteName']").val() + " is alread added!");
                        $("input[id$='txtCasteName']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
            if (!validate("tblCaste")) {
                var Caste_Name = $("input[id$='txtCasteName']").val().trim();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveCaste",
                    data: "{'Caste_Name':'" + Caste_Name + "'}",
                    success: onsuccessSaveCaste
                });
            }
            return false;
        }
        function onsuccessSaveCaste(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            $("input[id$='txtCasteName']").val("");
            getCaste();
            return false;
        }
        function ClearCaste() {
            $("input[id$='txtCasteName']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getCaste() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getCasteDetail",
                data: "{}",
                success: onsuccessgetCaste
            });
            return false;
        }
        function onsuccessgetCaste(msg) {
            var data = msg.d;
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            tbl += "<th style='text-align:center;width:8%;'>Delete</th>";
            tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Caste ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Caste Name</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.CasteDetail.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteCasteRecord(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.CasteDetail[i].cast_id + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCasteName" + i + "'>" + data.CasteDetail[i].cast_name + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.CasteDetail[i].created_by + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.CasteDetail[i].created_date + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.CasteDetail[i].modified_by + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.CasteDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tbleCasteDetails").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tbleCasteDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteCasteRecord(rowNo) {

            var Caste_ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteCaste",
                    data: "{'Caste_ID':'" + Caste_ID + "'}",
                    success: onsuccessDeleteData,
                    error: onerror
                });

                return false;
            }
            else
                return false;
        }

        function onerror(xhr) {
            $(".alert").html(xhr.responseText);

        }
        function onsuccessDeleteData(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record deleted successfully!");
            getCaste();
            return false;
        }

        function EditRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(ID);

            var Caste_Name = $("#txtCasteName" + rowNo).html().trim();
            $("input[id$='txtCasteName']").val(Caste_Name);

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateCaste() {
            if (!validate("tblCaste")) {
                var Caste_ID = $("input[id$='txtID']").val();
                var Caste_Name = $("input[id$='txtCasteName']").val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateCaste",
                    data: "{'Caste_ID':'" + Caste_ID + "','Caste_Name':'" + Caste_Name + "'}",
                    success: onsuccessUpdateCaste
                });
            }
            return false;
        }
        function onsuccessUpdateCaste() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtCasteName']").val("");
            getCaste();

            ClearCaste();
           
            return false;
        }
    </script>
</asp:Content>

