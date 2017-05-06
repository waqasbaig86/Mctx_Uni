<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddEmployeeJob_Status.aspx.cs" Inherits="SettingForms_AddEmployeeJob_Status" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modified Employee Job Status</legend>

                    <table id="tbljobstatus" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">Add Job Status<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtjobStatus" Width="95%" placeholder="Job Status"  class="alpha" runat="server" BackColor="White"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveJobStatus();" runat="server" />

                                <asp:Button ID="btnClearCaste" Text="Clear" CssClass="btn" OnClientClick="return ClearJobStatus();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateJobStatus();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divjobstatusDetails">
        <fieldset id="fldjobstatusDetails" >
            <legend>Employee Job Status Details</legend>
             <div style="overflow: auto; width: 100%;">
                  
            <table id="tblejobstatusDetails" class="dataTable">
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
            
            getJobStatus();

        });

        function dataTable() {
            oTable = $("#tblejobstatusDetails").dataTable();
        }

        function SaveJobStatus() {
            var i = 0;
            if ($("#tblejobstatusDetails tr").length - 1 > 1) {
                for (i = 0; i < $("#tblejobstatusDetails tr").length - 1; i++) {

                    if ($("#txtjobStatus" + i).html().toUpperCase().trim() == $("input[id$='txtjobStatus']").val().toUpperCase().trim()) {
                        alert("Job Status " + $("input[id$='txtjobStatus']").val() + " is already added!");
                        $("input[id$='txtjobStatus']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
            if (!validate("tblejobstatusDetails")) {
                var Job_Status = $("input[id$='txtjobStatus']").val().trim();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveJobStatus",
                    data: "{'Job_Status':'" + Job_Status + "'}",
                    success: onsuccessSaveJobStatus
                });
            }
            return false;
        }
        function onsuccessSaveJobStatus(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            $("input[id$='txtjobStatus']").val("");
            
            getJobStatus();
            ClearJobStatus();
            return false;
        }
        function ClearJobStatus() {
            $("input[id$='txtjobStatus']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getJobStatus() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getJobStatusDetail",
                data: "{}",
                success: onsuccessgetJobStatus
            });
            return false;
        }
        function onsuccessgetJobStatus(msg) {
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
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Job Status ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Job Status</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.JobStatusDetail.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteJobStatusRecord(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.JobStatusDetail[i].EmployeeStatus_Id + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtjobStatus" + i + "'>" + data.JobStatusDetail[i].Employee_Job_status + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.JobStatusDetail[i].created_by + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.JobStatusDetail[i].created_date + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.JobStatusDetail[i].modified_by + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.JobStatusDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblejobstatusDetails").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tblejobstatusDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteJobStatusRecord(rowNo) {

            var JobStatus_ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteJobstatus",
                    data: "{'JobStatus_ID':'" + JobStatus_ID + "'}",
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
            getJobStatus();
            return false;
        }

        function EditRecord(rowNo) {
            
            var JobStatus_ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(JobStatus_ID);

            var JobStatus = $("#txtjobStatus" + rowNo).html().trim();
            $("input[id$='txtjobStatus']").val(JobStatus);

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateJobStatus() {
            if (!validate("tbleLeaveDetails")) {
                var JobStatus_ID = $("input[id$='txtID']").val();
                var JobStatus = $("input[id$='txtjobStatus']").val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateJobStatus",
                    data: "{'JobStatus_ID':'" + JobStatus_ID + "','JobStatus':'" + JobStatus + "'}",
                    success: onsuccessUpdateJobStatus
                });
            }
            return false;
        }
        function onsuccessUpdateJobStatus() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtjobStatus']").val("");
            getJobStatus();
            ClearJobStatus();
           
           
            return false;
        }
    </script>
</asp:Content>

