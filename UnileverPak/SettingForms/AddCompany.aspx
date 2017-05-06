<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddCompany.aspx.cs" Inherits="SettingForms_AddCompany" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modified Company</legend>

                    <table id="tblcompany" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">Company Name:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtCompanyName" Width="95%" placeholder="Company Name"  class="alpha" runat="server" BackColor="White"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveCompany();" runat="server" />

                                <asp:Button ID="btnClearCaste" Text="Clear" CssClass="btn" OnClientClick="return ClearCompany();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateCompany();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divCompanyDetails">
        <fieldset id="fldCompanyDetails" >
            <legend>Company Details</legend>
             <div style="overflow: auto; width: 100%;">
                  
            <table id="tbleCompanyDetails" class="dataTable">
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
            
             getCompany();

        });

        function dataTable() {
            oTable = $("#tbleCompanyDetails").dataTable();
        }

        function SaveCompany() {
            var i = 0;
            if ($("#tbleCompanyDetails tr").length - 1 > 1) {
                for (i = 0; i < $("#tbleCompanyDetails tr").length - 1; i++) {

                    if ($("#txtCompanyName" + i).html().toUpperCase().trim() == $("input[id$='txtCompanyName']").val().toUpperCase().trim()) {
                        alert("Company " + $("input[id$='txtCompanyName']").val() + " is already added!");
                        $("input[id$='txtCompanyName']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
            if (!validate("tbleCompanyDetails")) {
                var Company_Name = $("input[id$='txtCompanyName']").val().trim();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/Savecompany",
                    data: "{'Company_Name':'" + Company_Name + "'}",
                    success: onsuccessSaveCompany
                });
            }
            return false;
        }
        function onsuccessSaveCompany(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            $("input[id$='txtCompanyName']").val("");
            
            getCompany();
            ClearCompany();
            return false;
        }
        function ClearCompany() {
            $("input[id$='txtCompanyName']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getCompany() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getCompanyDetail",
                data: "{}",
                success: onsuccessgetCompany
            });
            return false;
        }
        function onsuccessgetCompany(msg) {
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
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Company ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Company Name</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.CompanyDetail.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteCompanyRecord(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.CompanyDetail[i].Company_id + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCompanyName" + i + "'>" + data.CompanyDetail[i].Company_Name + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.CompanyDetail[i].created_by + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.CompanyDetail[i].created_date + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.CompanyDetail[i].modified_by + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.CompanyDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tbleCompanyDetails").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tbleCompanyDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteCompanyRecord(rowNo) {

            var Company_ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteCompany",
                    data: "{'Company_ID':'" + Company_ID + "'}",
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
            getCompany();
            return false;
        }

        function EditRecord(rowNo) {
            debugger;
            var Company_ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(Company_ID);

            var Company_Name = $("#txtCompanyName" + rowNo).html().trim();
            $("input[id$='txtCompanyName']").val(Company_Name);

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateCompany() {
            if (!validate("tbleCompanyDetails")) {
                var Company_ID = $("input[id$='txtID']").val();
                var Company_Name = $("input[id$='txtCompanyName']").val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateCompany",
                    data: "{'Company_ID':'" + Company_ID + "','Company_Name':'" + Company_Name + "'}",
                    success: onsuccessUpdateCompany
                });
            }
            return false;
        }
        function onsuccessUpdateCompany() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtCompanyName']").val("");
            getCompany();
            ClearCompany();
           
           
            return false;
        }
    </script>
</asp:Content>

