<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Designation.aspx.cs" Inherits="SettingForms_Designation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <table style="width:100%;margin-top:0%;vertical-align:top;">
        <tr>
                <td>
                    <div class="sussessMessageDiv" id="divSuccessMsg" style="display: none">&nbsp;
                    </div>
                     <div class="ErrorMessageDiv" id="ErrorMessageDiv" style="display: none">&nbsp;
                    </div>
                </td>
            </tr>
        <tr>
            <td>
               <fieldset>
                   <legend>Add/Modify Designation</legend>
               
                    <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                    <tr>

                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="lblPersonDesignationName" Text="Person Designation:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 600px;">
                            <asp:TextBox ID="txtPersonDesignationName" Width="95%"  class="alpha" runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                        
                       
                       
                    </tr>
                        <tr>
                            
                             <td colspan="1" align="left">
                            <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                                 <br />
                        </td>
                        
                   
                        <td align="left">
                            <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SavePersonDesignation();" runat="server" />
                        
                            <asp:Button ID="btnClearPersonDesignation" Text="Clear" CssClass="btn" OnClientClick="return ClearPersonDesignation();" runat="server" />
                        
                            <asp:Button ID="btnUpdate" Text="Update" CssClass="btn" Style="display: none;" OnClientClick="return UpdatePersonDesignation();" runat="server" />
                        </td>
                        </tr>
                        
                       
                </table>
                </fieldset>
            </td>
        </tr>

    </table>
     <div id="divPersonDesignationDetails"  >
            <fieldset id="fldPersonDesignationDetails" >
                <legend>Designation Details</legend>
                 <div style="overflow: auto; width: 100%;">
                  
            
                <table id="tblPersonDesignationDetails" class="dataTable">
                </table>
                     </div>
	</fieldset>
        </div>

     <script type="text/javascript">
         var oTable;

         //  $(document).ajaxStart(blockUI).ajaxStop(unblockUI);

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
             getPersonDesignation();

         });

         function dataTable() {
             oTable = $("#tblPersonDesignationDetails").dataTable();
         }

         function SavePersonDesignation() {
             var Designation = $("input[id$='txtPersonDesignationName']").val().trim();
             //var Category = $("select[id$='ddlCategory']").val().trim();


             if (Designation == "") {
                 alert("Please Enter PersonDesignation Name!");
                 return false;
             }

             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "Settingwebmethods.aspx/SavePersonDesignation",
                 data: "{'designation':'" + Designation + "'}",
                 success: onsuccessSavePersonDesignation,
                 error: onretrieveSavePersonDesignationError
             });
             return false;
         }
         function onsuccessSavePersonDesignation(msg) {
             $("#divSuccessMsg").show();
             $("#divSuccessMsg").html("");
             $("#divSuccessMsg").html("Record Successfully Saved!");
             $("#divSuccessMsg").fadeOut(6000);
             $("input[id$='txtPersonDesignationName']").val("");
             getPersonDesignation();
             return false;
         }
         function onretrieveSavePersonDesignationError(msg) {

             alert("Error In Saving Data!");
             return false;
         }
         function ClearPersonDesignation() {
             $("input[id$='txtPersonDesignationName']").val("");

             $("input[id$='btnUpdate']").hide();
             $("input[id$='btnSave']").attr("disabled", false);
             return false;
         }
         function getPersonDesignation() {
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "Settingwebmethods.aspx/getPersonDesignationDetail",
                 data: "{}",
                 success: onsuccessgetPersonDesignation,
                 error: onretrievegetPersonDesignation
             });
             return false;
         }
         function onsuccessgetPersonDesignation(msg) {

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
             tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>PersonDesignation ID</th>";
            
             tbl += "<th style='white-space:nowrap; text-align:left;'>Designation Name</th>";
             

             tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
             tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
             tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
             tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
             tbl += "</tr>";
             tbl += "</thead>";
             tbl += "<tbody>";
             for (var i = 0; i < data.PersonDesignationDetail.length; i++) {
                 tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                 tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeletePersonDesignationRecord(" + i + ");'> </td>";
                 tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                 tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.PersonDesignationDetail[i].designation_id + "</td>";

                 tbl += "<td style='text-align:left; white-space:nowrap;' id='txtPersonDesignationName" + i + "'>" + data.PersonDesignationDetail[i].designation_name+ "</td>";
                
                 tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.PersonDesignationDetail[i].created_by + "</td>";
                 tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.PersonDesignationDetail[i].created_date + " </td>";
                 tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.PersonDesignationDetail[i].modified_by + " </td>";
                 tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.PersonDesignationDetail[i].modified_date + " </td>";
                 tbl += "</tr>";
             }
             tbl += "</tbody>";
             tbl += "</table>";
             $("#tblPersonDesignationDetails").html(tbl);
             dataTable();
             return false;
         }

         function getRowID(rowID) {
             $("table[id$='tblPersonDesignationDetails'] tr").css("background-color", "white");
             $("#trmain" + rowID).css("background-color", "#6798c1");

         }
         function onretrievegetPersonDesignation() {
             alert("Error In Loading Details!");
             return false;
         }

         function DeletePersonDesignationRecord(rowNo) {


             var Person_DesignationID = $("#txtID" + rowNo).html();

             if (confirm("Are you sure you wish to delete this Record?")) {
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "SettingWebMethods.aspx/DeletePersonDesignation",
                     data: "{'Designation_ID':'" + Person_DesignationID + "'}",
                     success: onsuccessDeleteData,
                     error: OnretrievePhysicianError
                 });

                 return false;
             }
             else
                 return false;

         }

         function onsuccessDeleteData(msg) {



             $("#divSuccessMsg").show();
             $("#divSuccessMsg").html("");
             $("#divSuccessMsg").html("Record Successfully Deleted!");
             $("#divSuccessMsg").fadeOut(6000);
             getPersonDesignation();
             return false;

         }

         function OnretrievePhysicianError(msg) {
             // getPersonDesignationalRecod();
             alert(msg.responseText);
             $("#ErrorMessageDiv").show();
             $("#ErrorMessageDiv").html("");
             $("#ErrorMessageDiv").html("Error in Record Deleting!");
             $("#ErrorMessageDiv").fadeOut(6000);
             return false;
         }

         function EditRecord(rowNo) {
             var ID = $("#txtID" + rowNo).html().trim();
             $("input[id$='txtID']").val(ID);

             var Designation = $("#txtPersonDesignationName" + rowNo).html().trim();
             $("input[id$='txtPersonDesignationName']").val(Designation);
             $("input[id$='btnUpdate']").show();
             $("input[id$='btnSave']").attr("disabled", true);
             return false;
         }
         function UpdatePersonDesignation() {
             var Person_DesignationID = $("input[id$='txtID']").val();

             var Designation = $("input[id$='txtPersonDesignationName']").val();
            


             if (Designation == "") {
                 alert("Please Enter PersonDesignation Name!");
                 return false;
             }

             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "Settingwebmethods.aspx/UpdatePersonDesignation",
                 data: "{'Person_DesignationID':'" + Person_DesignationID + "','Designation':'" + Designation + "'}",
                 success: onsuccessUpdatePersonDesignations,
                 error: onretrieveUpdatePersonDesignations
             });
             return false;
         }
         function onsuccessUpdatePersonDesignations() {
             $("#divSuccessMsg").show();
             $("#divSuccessMsg").html("");
             $("#divSuccessMsg").html("Record Successfully Updated!");
             $("#divSuccessMsg").fadeOut(6000);
             $("input[id$='txtPersonDesignationName']").val("");
             getPersonDesignation();

             ClearPersonDesignation();
             getPersonDesignation();
             return false;
         }
         function onretrieveUpdatePersonDesignations() {
             alert("Error In Updating Record!");
             return false;
         }




    </script>
</asp:Content>

