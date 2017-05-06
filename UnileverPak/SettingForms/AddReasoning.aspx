<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddReasoning.aspx.cs" Inherits="SettingForms_AddReasoning" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modified Reasoning</legend>

                    <table id="tblReasoning" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;vertical-align:initial">Add Reasoning<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 900px; height:50px;vertical-align:top">
                                <asp:TextBox ID="txtReasoning" Width="95%" Height="100%" placeholder=""  class="alpha" runat="server" BackColor="White"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveReasoning();" runat="server" />

                                <asp:Button ID="btnClearReasoning" Text="Clear" CssClass="btn" OnClientClick="return ClearReasoning();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateReasoning();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divReasoningDetails">
        <fieldset id="fldReasoningDetails" >
            <legend>Reasoning Details</legend>
             <div style="overflow: auto; width: 100%;">
                  
            <table id="tbleReasoningDetails" class="dataTable">
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
            
            getReasoning();

        });

        function dataTable() {
            oTable = $("#tbleReasoningDetails").dataTable();
        }

        function SaveReasoning() {
            var i = 0;
            if ($("#tbleReasoningDetails tr").length - 1 > 1) {
                for (i = 0; i < $("#tbleReasoningDetails tr").length - 1; i++) {

                    if ($("#txtReasoning" + i).html().toUpperCase().trim() == $("input[id$='txtReasoning']").val().toUpperCase().trim()) {
                        alert("Reasoning " + $("input[id$='txtReasoning']").val() + " is already added!");
                        $("input[id$='txtReasoning']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
            if (!validate("tbleReasoningDetails")) {
                var Reasoning = $("input[id$='txtReasoning']").val().trim();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveReasoning",
                    data: "{'Reasoning':'" + Reasoning + "'}",
                    success: onsuccessSaveReasoning
                });
            }
            return false;
        }
        function onsuccessSaveReasoning(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            $("input[id$='txtReasoning']").val("");
            
            getReasoning();
            ClearReasoning();
            return false;
        }
        function ClearReasoning() {
            $("input[id$='txtReasoning']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getReasoning() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getReasoningDetail",
                data: "{}",
                success: onsuccessgetReasoning
            });
            return false;
        }
        function onsuccessgetReasoning(msg) {
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
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Reasoning ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Reaoning</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.ReasoningDetail.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteReasoning(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.ReasoningDetail[i].Reasoning_Id + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtReasoning" + i + "'>" + data.ReasoningDetail[i].Reasoning + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.ReasoningDetail[i].created_by + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.ReasoningDetail[i].created_date + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.ReasoningDetail[i].modified_by + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.ReasoningDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tbleReasoningDetails").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tbleReasoningDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteReasoning(rowNo) {

            var Reasoning_ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteReasoning",
                    data: "{'Reasoning_ID':'" + Reasoning_ID + "'}",
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
            getReasoning();
            return false;
        }

        function EditRecord(rowNo) {
            
            var Reasoning_ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(Reasoning_ID);

            var Reasoning = $("#txtReasoning" + rowNo).html().trim();
            $("input[id$='txtReasoning']").val(Reasoning);

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateReasoning() {
            if (!validate("tbleReasoningDetails")) {
                var Reasoning_ID = $("input[id$='txtID']").val();
                var Reasoning = $("input[id$='txtReasoning']").val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateReasoning",
                    data: "{'Reasoning_ID':'" + Reasoning_ID + "','Reasoning':'" + Reasoning + "'}",
                    success: onsuccessUpdateReasoning
                });
            }
            return false;
        }
        function onsuccessUpdateReasoning() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtReasoning']").val("");
            getReasoning();
            ClearReasoning();
           
           
            return false;
        }
    </script>
</asp:Content>

