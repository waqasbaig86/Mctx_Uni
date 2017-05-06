<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Hierarchy.aspx.cs" Inherits="HMS_Hierarchy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <fieldset>
        <legend>Hierarchy Management System</legend>
        <asp:RadioButton id="rbAssignedPerson" runat="server" Checked="true" onclick="AssignedPerson();" style="margin-left:50px"  Text="Assigned Person" GroupName="measurementSystem"></asp:RadioButton>
        <asp:RadioButton id="rbUnAssignedPerson" runat="server"  style="margin-left:100px" onclick="UnassignPerson();"  Text="UnAssigned Person" GroupName="measurementSystem"></asp:RadioButton>
        <table id="tblAssignedPerson" style="margin:25px 0px 15px 70px" >
            <tr>
                <td ><label id="lblAssignedPerson">Reporting Person</label>  &nbsp;</td>

                <td >
                   <div id="ddlReporting"> <asp:DropDownList ID="ddlReportingPerson" runat="server" class="req" style="width:270px">                        
                    </asp:DropDownList></div>&nbsp;
                </td>
                <td>
                <input type="button" id="btnSearch" onclick="getHierarchy();" class="btn" value="Search" style="margin-left:200px" />
            </td>
            </tr>
            
            <tr>
                <td>Change assign Reporting Person</td>
               <td>
            <asp:DropDownList ID="ddlChangeReportingPerson" runat="server" class="req" style="width:270px">                        
            </asp:DropDownList>
                   </td>
                   <td>
                       <input type="button" id="btnUpdate" class="btn" onclick="updateReportingPerson();" value="Update" style="margin-left:200px" />
                   </td>
                <%--<td>
                    <input type="button" id="btnSearch1" onclick="getHierarchy();" class="btn" value="Search" style="margin-left:200px" />
                </td>--%>
               
                    </tr>
        </table>
        
    </fieldset>
    
    <div id="divHierarchyDetails">
        <fieldset id="fldHierarchyDetails" >
            <legend>Hierarchy Details</legend>
            <input type="checkbox" id="checkall"  />Check All
             <div style="overflow: auto; width: 100%;">
                  
            <table id="tblHierarchyDetails" class="dataTable">
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
            $("input[id$='checkall']").click(function () {
                if ($(this).is(":checked")) {
                    $("input[id*='txtcheckbox']").attr("checked", true);
                }
                else {
                    $("input[id*='txtcheckbox']").attr("checked", false);
                }
            });

           
        });

        function checkUnChkCheckAll() {
           
                var totalChkBoxes = $("#tblHierarchyDetails tr td input[type='checkbox']").length;
                var checkedChkBoxes = $("#tblHierarchyDetails tr td input[type='checkbox']:checked").length;
                if (totalChkBoxes == checkedChkBoxes)
                {
                    $("input[id$='checkall']").attr("checked", true);
                }
                else {
                    $("input[id$='checkall']").attr("checked", false);
                }
           
        }
       
        function dataTable() {
            oTable = $("#tblHierarchyDetails").dataTable();
        }
        function getHierarchy() {
            var Employee_ID = "";
            if ($("input[id$='rbUnAssignedPerson']").is(":checked"))
                Employee_ID = "0";
            else
             Employee_ID = $("select[id$='ddlReportingPerson']").val().trim();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "HMSwebmethods.aspx/getHeirarchy",
                data: "{'Employee_ID':'" + Employee_ID + "'}",
                success: onsuccessgetHierarchy
            });
            return false;
        }
        function onsuccessgetHierarchy(msg) {
            var data = msg.d;
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }

            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            //tbl += "<th style='text-align:center;width:8%;'>Delete</th>";
            //tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
            tbl += "<th style='text-align:left; white-space:nowrap;'>Check Box</th>";
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Employee ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;display:none'>Designation ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Designation Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;display:none'>Department ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Department Name</th>";

            //tbl += "<th style='white-space:nowrap; text-align:left;display:none'>Reporting Person ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Reporting Person Name</th>";

            //tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            //tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            //tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            //tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.Heirarchy.length; i++) {
                //tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                //tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteAssignChargeRecord(" + i + ");'> </td>";
                //tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='cursor:Pointer;' id='txtcheckbox' align='center' ><input type='checkbox' onclick='checkUnChkCheckAll();' id='txtcheckbox" + i + "'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtEmployeeID" + i + "'>" + data.Heirarchy[i].employee_id + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEmployeeName" + i + "'>" + data.Heirarchy[i].employee_name + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap; display:none' id='txtDesignationId" + i + "'>" + data.Heirarchy[i].designationid + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDesignationName" + i + "'>" + data.Heirarchy[i].designationName + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap; display:none' id='txtDepartmentID" + i + "'>" + data.Heirarchy[i].departmentid + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDepartmentName" + i + "'>" + data.Heirarchy[i].departmentname + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap; ' id='txtReportingPerson" + i + "'>" + data.Heirarchy[i].reportingPersonName + " </td>";
                //tbl += "<td style='text-align:left; white-space:nowrap;' id='txtassigncharge" + i + "'>" + data.Heirarchy[i].Assign_Charge + "</td>";
                //tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.Heirarchy[i].created_by + "</td>";
                //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.Heirarchy[i].created_date + " </td>";
                //tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.Heirarchy[i].modified_by + " </td>";
                //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.Heirarchy[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblHierarchyDetails").html(tbl);
            $("#tblHierarchyDetails").show();
            dataTable();
            return false;
        }
       function updateReportingPerson()
        {

           var i = -1;
           var Employee_ID = "";
           $("#tblHierarchyDetails tr td input[type='checkbox']:checked").each(function () {
               i++;

               if ($(this).is(":checked")) {
                   Employee_ID = Employee_ID + $("#txtEmployeeID" + i).html() + "`";
               }
           });
           var Reporting_Id = $("select[id$='ddlChangeReportingPerson']").val().trim();
           $.ajax({
               type: "POST",
               contentType: "application/json; charset=utf-8",
               url: "HMSwebmethods.aspx/UpdateHierarchy",
               data: "{'Employee_ID':'" + Employee_ID + "','Reporting_Id':'" + Reporting_Id + "'}",
               success: onsuccessUpdateHeirarchy
           });
       }
       function onsuccessUpdateHeirarchy() {
           showSuccessMsg("Record Updated successfully!");
           $("select[id$='ddlChangeReportingPerson']").val("");
         
           return false;
       }
       
        function AssignedPerson()
       {
           $("#lblAssignedPerson").show();
           $("#ddlReporting").show();
           $("#tblHierarchyDetails").html("");
           
           
       }
       function UnassignPerson()
       {
           
           $("#lblAssignedPerson").hide();
           $("#ddlReporting").hide();
           $("#tblHierarchyDetails").html("");
          
       }
        </script>
</asp:Content>

