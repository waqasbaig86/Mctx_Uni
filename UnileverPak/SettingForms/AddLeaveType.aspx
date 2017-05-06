<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddLeaveType.aspx.cs" Inherits="SettingForms_AddLeaveType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modified Leave Type</legend>

                    <table id="tblcity" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">Leave Type:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtLeaveType" Width="95%" placeholder="Leave Type"  class="alpha" runat="server" BackColor="White"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveLeave();" runat="server" />

                                <asp:Button ID="btnClearCaste" Text="Clear" CssClass="btn" OnClientClick="return ClearLeave();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateLeave();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divLeaveDetails">
        <fieldset id="fldLeaveDetails" >
            <legend>Leave Type Details</legend>
             <div style="overflow: auto; width: 100%;">
                  
            <table id="tbleLeaveDetails" class="dataTable">
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
            
            getLeave();

        });

        function dataTable() {
            oTable = $("#tbleLeaveDetails").dataTable();
        }

        function SaveLeave() {
            var i = 0;
            if ($("#tbleLeaveDetails tr").length - 1 > 1) {
                for (i = 0; i < $("#tbleLeaveDetails tr").length - 1; i++) {

                    if ($("#txtLeaveType" + i).html().toUpperCase().trim() == $("input[id$='txtLeaveType']").val().toUpperCase().trim()) {
                        alert("Leave Type " + $("input[id$='txtLeaveType']").val() + " is already added!");
                        $("input[id$='txtLeaveType']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
            if (!validate("tbleLeaveDetails")) {
                var Leave_Type = $("input[id$='txtLeaveType']").val().trim();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveLeave",
                    data: "{'Leave_Type':'" + Leave_Type + "'}",
                    success: onsuccessSaveLeave
                });
            }
            return false;
        }
        function onsuccessSaveLeave(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            $("input[id$='txtLeaveType']").val("");
            
            getLeave();
            ClearLeave();
            return false;
        }
        function ClearLeave() {
            $("input[id$='txtLeaveType']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getLeave() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getLeaveDetail",
                data: "{}",
                success: onsuccessgetLeave
            });
            return false;
        }
        function onsuccessgetLeave(msg) {
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
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Leave ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Leave Type</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.LeaveDetail.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteLeaveRecord(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.LeaveDetail[i].Leave_Id + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtLeaveType" + i + "'>" + data.LeaveDetail[i].Leave_Type + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.LeaveDetail[i].created_by + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.LeaveDetail[i].created_date + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.LeaveDetail[i].modified_by + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.LeaveDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tbleLeaveDetails").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tbleLeaveDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteLeaveRecord(rowNo) {

            var Leave_ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteLeave",
                    data: "{'Leave_ID':'" + Leave_ID + "'}",
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
            getLeave();
            return false;
        }

        function EditRecord(rowNo) {
            
            var Leave_ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(Leave_ID);

            var Leave_Type = $("#txtLeaveType" + rowNo).html().trim();
            $("input[id$='txtLeaveType']").val(Leave_Type);

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateLeave() {
            if (!validate("tbleLeaveDetails")) {
                var Leave_ID = $("input[id$='txtID']").val();
                var Leave_Type = $("input[id$='txtLeaveType']").val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateLeave",
                    data: "{'Leave_ID':'" + Leave_ID + "','Leave_Type':'" + Leave_Type + "'}",
                    success: onsuccessUpdateLeave
                });
            }
            return false;
        }
        function onsuccessUpdateLeave() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtLeaveType']").val("");
            getLeave();
            ClearLeave();
           
           
            return false;
        }
    </script>
</asp:Content>

