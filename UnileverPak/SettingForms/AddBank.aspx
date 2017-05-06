<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddBank.aspx.cs" Inherits="SettingForms_AddBank" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modified Bank</legend>

                    <table id="tblbank" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">Bank Name:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtBankName" Width="95%" placeholder="Bank Name"   runat="server" BackColor="White"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveBank();" runat="server" />

                                <asp:Button ID="btnClearBank" Text="Clear" CssClass="btn" OnClientClick="return ClearBank();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateBank();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divBankDetails">
        <fieldset id="fldBankDetails" >
            <legend>Bank Details</legend>
             <div style="overflow: auto; width: 100%;">
                  
            <table id="tbleBankDetails" class="dataTable">
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
            //getCaste();
            getBank();

        });

        function dataTable() {
            oTable = $("#tbleBankDetails").dataTable();
        }

        function SaveBank() {
            var i = 0;
            if ($("#tbleBankDetails tr").length - 1 > 1) {
                for (i = 0; i < $("#tbleBankDetails tr").length - 1; i++) {

                    if ($("#txtBankName" + i).html().toUpperCase().trim() == $("input[id$='txtBankName']").val().toUpperCase().trim()) {
                        alert("Bank " + $("input[id$='txtBankName']").val() + " is already added!");
                        $("input[id$='txtBankName']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
            if (!validate("tbleBankDetails")) {
                var Bank_Name = $("input[id$='txtBankName']").val().trim();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveBank",
                    data: "{'Bank_Name':'" + Bank_Name + "'}",
                    success: onsuccessSaveBank
                });
            }
            return false;
        }
        function onsuccessSaveBank(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            $("input[id$='txtBankName']").val("");
            getBank();
            return false;
        }
        function ClearBank() {
            $("input[id$='txtBankName']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getBank() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getBankDetail",
                data: "{}",
                success: onsuccessgetBank
            });
            return false;
        }
        function onsuccessgetBank(msg) {
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
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Bank ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Bank Name</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.BankDetail.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteBankRecord(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.BankDetail[i].Bank_id + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtBankName" + i + "'>" + data.BankDetail[i].Bank_Name + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.BankDetail[i].created_by + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.BankDetail[i].created_date + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.BankDetail[i].modified_by + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.BankDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tbleBankDetails").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tbleBankDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteBankRecord(rowNo) {

            var Bank_ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteBank",
                    data: "{'Bank_ID':'" + Bank_ID + "'}",
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
            getBank();
            return false;
        }

        function EditRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(ID);

            var Bank_Name = $("#txtBankName" + rowNo).html().trim();
            $("input[id$='txtBankName']").val(Bank_Name);

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateBank() {
            if (!validate("tbleBankDetails")) {
                var Bank_ID = $("input[id$='txtID']").val();
                var Bank_Name = $("input[id$='txtBankName']").val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateBank",
                    data: "{'Bank_ID':'" + Bank_ID + "','Bank_Name':'" + Bank_Name + "'}",
                    success: onsuccessUpdateBank
                });
            }
            return false;
        }
        function onsuccessUpdateBank() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtBankName']").val("");
            getBank();

            ClearBank();
           
            return false;
        }
    </script>
</asp:Content>

