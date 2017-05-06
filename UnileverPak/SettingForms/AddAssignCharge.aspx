<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddAssignCharge.aspx.cs" Inherits="SettingForms_AddAssignCharge" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modified Assign Charge</legend>

                    <table id="tblassigncharge" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                           <td style="width: 140px; text-align: left;">Employee Name:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddlemployeename" runat="server" onchange="getDeptAndDesig();"></asp:DropDownList>
                            </td> 
                            
                            <td style="width: 140px; text-align: left;">Department<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">                            
                                 
                             <asp:TextBox ID="txtdepartment" Width="95%" ReadOnly="true" placeholder="Department"  class="alpha" runat="server" BackColor="White"></asp:TextBox>
                                 <asp:TextBox ID="txtDepartmentID" Width="95%" style="display:none"  ReadOnly="true" placeholder="Department ID"  class="alpha" runat="server" BackColor="White"></asp:TextBox>
                            </td>

                            </tr>
                        <tr>
                            <td style="width: 140px; text-align: left;">Designation<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtdesignation" Width="95%" ReadOnly="true" placeholder="Designation"  class="alpha" runat="server" BackColor="White"></asp:TextBox>
                                 <asp:TextBox ID="txtDesignationID" Width="95%" style="display:none"  ReadOnly="true" placeholder="Designation ID"  class="alpha" runat="server" BackColor="White"></asp:TextBox>
                            </td>
                            
                            <td style="width: 140px; text-align: left;">Assign Charge<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtassigncharge" Width="95%"  placeholder="Assign Charge"  class="alpha" runat="server" BackColor="White"></asp:TextBox>
                            </td>

                            </tr>
                        <tr>

                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveAssignCharge();" runat="server" />

                                <asp:Button ID="btnClearAssignCharge" Text="Clear" CssClass="btn" OnClientClick="return ClearAssignCharge();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateAssignCharge();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divassignchargeDetails">
        <fieldset id="fldassignchargeDetails" >
            <legend>Assign Charge Details</legend>
             <div style="overflow: auto; width: 100%;">
                  
            <table id="tbleassignchargeDetails" class="dataTable">
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

             getAssignCharge();

        });

        function dataTable() {
            oTable = $("#tbleassignchargeDetails").dataTable();
        }

        function SaveAssignCharge() {
            debugger;
            var i = 0;
            if ($("#tbleassignchargeDetails tr").length - 1 > 1) {
                for (i = 0; i < $("#tbleassignchargeDetails tr").length - 1; i++) {

                    if ($("#ddlemployeename" + i).html().toUpperCase().trim() == $("select[id$='ddlemployeename']").val().toUpperCase().trim()) {
                        alert("Assign Charge " + $("select[id$='ddlemployeename']").val() + " is already added!");
                        $("select[id$='ddlemployeename']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
            if (!validate("tbleassignchargeDetails")) {
                var Employee_Id = $("select[id$='ddlemployeename']").val().trim();
                var Designation_Name = $("input[id$='txtDesignationID']").val().trim();
                var Department_Name = $("input[id$='txtDepartmentID']").val().trim();
                var AssignCharge_Name = $("input[id$='txtassigncharge']").val().trim();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveAssignCharge",
                    data: "{'Employee_Id':'" + Employee_Id + "','Designation_Name':'" + Designation_Name + "','Department_Name':'" + Department_Name + "','AssignCharge_Name':'" + AssignCharge_Name + "'}",
                    success: onsuccessSaveAssignCharge
                });
            }
            return false;
        }
        function onsuccessSaveAssignCharge(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            $("select[id$='ddlemployeename']").val("");
            $("input[id$='txtdesignation']").val("");
            $("input[id$='txtdepartment']").val("");
            $("input[id$='txtassigncharge']").val("");

            getAssignCharge();
            ClearAssignCharge();
            return false;
        }
        function ClearAssignCharge() {
            $("select[id$='ddlemployeename']").val("");
            $("input[id$='txtdesignation']").val("");
            $("input[id$='txtdepartment']").val("");
            $("input[id$='txtassigncharge']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getAssignCharge() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getAssignCharge",
                data: "{}",
                success: onsuccessgetAssignCharge
            });
            return false;
        }
        function onsuccessgetAssignCharge(msg) {
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
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Assign Charge ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;display:none'>Employee ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Department Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;display:none'>Department ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Designation</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;display:none'>Designation ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Assign Charge</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.AssignChargeDetail.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteAssignChargeRecord(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.AssignChargeDetail[i].AssignCharge_Id + "</td>";
                
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEmployeeName" + i + "'>" + data.AssignChargeDetail[i].employee_name + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap; display:none' id='txtEmployeeId" + i + "'>" + data.AssignChargeDetail[i].employee_id + "</td>";
                

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDepartmentName" + i + "'>" + data.AssignChargeDetail[i].department_name + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap; display:none' id='txtDepartmentID" + i + "'>" + data.AssignChargeDetail[i].department_id + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDesignationName" + i + "'>" + data.AssignChargeDetail[i].designation_name + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none' id='txtDesignationID" + i + "'>" + data.AssignChargeDetail[i].designation_id + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtassigncharge" + i + "'>" + data.AssignChargeDetail[i].Assign_Charge + "</td>";
                
               
                
               
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.AssignChargeDetail[i].created_by + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.AssignChargeDetail[i].created_date + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.AssignChargeDetail[i].modified_by + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.AssignChargeDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tbleassignchargeDetails").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tbleassignchargeDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteAssignChargeRecord(rowNo) {

            var AssignCharge_ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteAssignCharge",
                    data: "{'AssignCharge_ID':'" + AssignCharge_ID + "'}",
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
            getAssignCharge();
            ClearAssignCharge();
            return false;
        }

        function EditRecord(rowNo) {

            var AssignCharge_ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(AssignCharge_ID);
            var AssignCharge = $("#txtassigncharge" + rowNo).html().trim();
            $("input[id$='txtassigncharge']").val(AssignCharge);
            var Designation_Name = $("#txtDesignationName" + rowNo).html().trim();
            $("input[id$='txtdesignation']").val(Designation_Name);
            var Department_Name = $("#txtDepartmentName" + rowNo).html().trim();
            $("input[id$='txtdepartment']").val(Department_Name);


            var Designation_ID = $("#txtDesignationID" + rowNo).html().trim();
            $("input[id$='txtDesignationID']").val(Designation_ID);
            var Department_ID = $("#txtDepartmentID" + rowNo).html().trim();
            $("input[id$='txtDepartmentID']").val(Department_ID);

            var Employee_ID = $("#txtEmployeeId" + rowNo).html().trim();
            $("select[id$='ddlemployeename']").val(Employee_ID);

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateAssignCharge() {
            if (!validate("tbleassignchargeDetails")) {
                var AssignCharge_ID = $("input[id$='txtID']").val();
                var AssignCharge = $("input[id$='txtassigncharge']").val();
                var Department = $("input[id$='txtDepartmentID']").val();
                var Desigantion = $("input[id$='txtDesignationID']").val();
                var Employee = $("select[id$='ddlemployeename']").val();
                
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateAssignCharge",
                    data: "{'AssignCharge_ID':'" + AssignCharge_ID + "','AssignCharge':'" + AssignCharge + "','Department':'" + Department + "','Desigantion':'" + Desigantion + "','Employee':'" + Employee + "'}",
                    success: onsuccessUpdateJobStatus
                });
            }
            return false;
        }
        function onsuccessUpdateJobStatus() {
            //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtassigncharge']").val("");
            $("input[id$='txtdepartment']").val("");
            $("input[id$='txtdesignation']").val("");
            $("select[id$='ddlemployeename']").val("");
            getAssignCharge();
            ClearAssignCharge();


            return false;
        }

        function getDeptAndDesig() {
            
           
            var Employee_ID = $("select[id$='ddlemployeename']").val().trim();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/retrievedesigdepart",
                data: "{'Employee_ID':'" + Employee_ID + "'}",
                success: onsuccessRetrievalDesigAndDepart
            });
            return false;
        }
        function onsuccessRetrievalDesigAndDepart(msg) {
            var data = msg.d;
            $("input[id$='txtdepartment']").val(data.RetrieveDesigAndDepartDetail[0].department_name);
            $("input[id$='txtdesignation']").val(data.RetrieveDesigAndDepartDetail[0].designation_name);
            $("input[id$='txtDepartmentID']").val(data.RetrieveDesigAndDepartDetail[0].department_id);
            $("input[id$='txtDesignationID']").val(data.RetrieveDesigAndDepartDetail[0].designation_id);
        }
    </script>
</asp:Content>

