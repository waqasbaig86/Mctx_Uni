<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="TrainingSchedule.aspx.cs" Inherits="SettingForms_TrainingSchedule" %>

    
 <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

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
                       <legend>Add/Modify Training Schedule</legend>
               
                        <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                        <tr>
                            <td style="width:140px;text-align:left;">
                                <asp:Label ID="lblStarteDate" Text="Start Date:" runat="server"></asp:Label>
                            </td>
                            <td   style="width: 600px;">
                               <%-- <asp:TextBox ID="txtStartDate" Width="95%"    runat="server" BackColor="White" ></asp:TextBox>--%>

                                  <asp:TextBox ID="txtStartDate" CssClass="date disable_past_dates"  runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar2" Separator="/" Format="mm dd yyyy" Control="txtStartDate" runat="server" 
                                Font-Names="Tahoma" />
                            </td>

                            <td style="width:140px;text-align:left;">
                                <asp:Label ID="lblEndDate" Text="End Date:" runat="server"></asp:Label>


                            </td>
                            <td   style="width: 600px;">
                         <%--       <asp:TextBox ID="txtEndDate" Width="95%"    runat="server" BackColor="White" ></asp:TextBox>--%>

                                
                                  <asp:TextBox ID="txtEndDate" CssClass="date disable_past_dates"  runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar1" Separator="/" Format="mm dd yyyy" Control="txtEndDate" runat="server" 
                                Font-Names="Tahoma" />
                            </td>
                        
                       </tr>
                            <tr>
                            <td style="width:140px;text-align:left;">
                                <asp:Label ID="lblStartTime" Text="Start Time:" runat="server"></asp:Label>
                            </td>
                            <td   style="width: 600px;">
                                <asp:TextBox ID="txtStartTime" Width="95%"  CssClass="time"  runat="server" BackColor="White" ></asp:TextBox>
                            </td>

                            <td style="width:140px;text-align:left;">
                                <asp:Label ID="lblEndTime"  Text="End Time:" runat="server"></asp:Label>
                            </td>
                            <td   style="width: 600px;">
                                <asp:TextBox ID="txtEndTime" Width="95%" CssClass="time"  runat="server" BackColor="White" ></asp:TextBox>
                            </td>
                        
                       </tr>
                            <tr>
                           <td style="width: 140px; text-align: left;">Training ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddlTrainingid" runat="server"></asp:DropDownList>
                            </td>
                                </tr>
                            <tr>
                                <td  align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                                    </td>
                               <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveTrainingSchedule();" runat="server" />
                        
                                <asp:Button ID="btnCleartrainingschedule" Text="Clear" CssClass="btn" OnClientClick="return ClearTrainingSchedule();" runat="server" />
                        
                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateTrainingSchedule();" runat="server" />
                            </td>
                            
                            
                        </tr>
                            <tr>
                            
                                
                                </tr>
                    </table>
                    </fieldset>
                </td>
            </tr>

        </table>
         <div id="divTrainingscheduleDetails"  >
                <fieldset id="fldTrainingScheduleDetails" >
                    <legend>Training Schedule Details</legend>
                     <div style="overflow: auto; width: 100%;">
                  
            
                    <table id="tblTrainingScheduleDetails" class="dataTable">
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
                            
               
                 getTrainingSchedule();

             });

             function dataTable() {
                 oTable = $("#tblTrainingScheduleDetails").dataTable();
             }

             function SaveTrainingSchedule() {
                 debugger;
                 var i = 0;
                 if ($("#tblTrainingScheduleDetails tr").length - 1 > 1) {
                     for (i = 0; i < $("#tblTrainingScheduleDetails tr").length - 1; i++) {

                         if ($("#txtStartDate" + i).html().toUpperCase().trim() == $("input[id$='txtStartDate']").val().toUpperCase().trim()) {
                             alert("Training schedule " + $("input[id$='txtStartDate']").val() + " is alread added!");
                             $("input[id$='txtStartDate']").val("");
                             return false;
                         }
                         // alert("test")
                     }
                 }
                 var Start_Date = $("input[id$='txtStartDate']").val().trim();
                 var End_Date = $("input[id$='txtEndDate']").val().trim();
                 var Start_Time = $("input[id$='txtStartTime']").val().trim();
                 var End_Time = $("input[id$='txtEndTime']").val().trim();
                 var Training_ID = $("select[id$='ddlTrainingid']").val().trim();

                 if (Start_Date == "") {
                     alert("Please Enter Start Date Name!");
                     return false;
                 }

                 $.ajax({
                     
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "Settingwebmethods.aspx/SaveTrainingSchedule",
                     data: "{'Start_Date':'" + Start_Date + "','End_Date':'" + End_Date + "','Start_Time':'" + Start_Time + "','End_Time':'" + End_Time + "','Training_ID':'" + Training_ID + "'}",
                     success: onsuccessSaveTrainingSchedule,
                     error: onretrieveSaveTrainingScheduleError
                 });
                 return false;
             }
             function onsuccessSaveTrainingSchedule(msg) {
                 $("#divSuccessMsg").show();
                 $("#divSuccessMsg").html("");
                 $("#divSuccessMsg").html("Record Successfully Saved!");
                 $("#divSuccessMsg").fadeOut(6000);
                 $("input[id$='txtStartDate']").val("");
                 $("input[id$='txtEndDate']").val("");
                 $("input[id$='txtStartTime']").val("");
                 $("input[id$='txtEndTime']").val("");
                 $("select[id$='ddlTrainingid']").val("");
                 getTrainingSchedule();
                 return false;
             }
             function onretrieveSaveTrainingScheduleError(msg) {

                 alert("Error In Saving Data!");
                 return false;
             }
             function ClearTrainingSchedule() {
                 $("input[id$='txtStartDate']").val("");
                 $("input[id$='txtEndDate']").val("");
                 $("input[id$='txtStartTime']").val("");
                 $("input[id$='txtEndTime']").val("");
                 $("select[id$='ddlTrainingid']").val("");

                 $("input[id$='btnUpdate']").hide();
                 $("input[id$='btnSave']").attr("disabled", false);
                 return false;
             }
             function getTrainingSchedule() {
                 
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "Settingwebmethods.aspx/gettrainingschedule",
                     data: "{}",
                     success: onsuccessgettrainingSchedule,
                     error: onretrievegetTrainingschedule
                 });
                 return false;
             }
             function onsuccessgettrainingSchedule(msg) {
                
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
                 tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Training Schedule ID</th>";

                 tbl += "<th style='white-space:nowrap; text-align:left;'>Start Date</th>";
                 tbl += "<th style='white-space:nowrap; text-align:left;'>End Date</th>";

                 tbl += "<th style='white-space:nowrap; text-align:left;'>Start Time</th>";
                 tbl += "<th style='white-space:nowrap; text-align:left;'>End Time</th>";
                 tbl += "<th style='white-space:nowrap; text-align:left;'>Training Name</th>";
                 tbl += "<th style='white-space:nowrap; text-align:left;display:none'>Terminal Id</th>";
                 tbl += "</tr>";
                 tbl += "</thead>";
                 tbl += "<tbody>";
                 for (var i = 0; i < data.TrainingSchedule.length; i++) {
                     tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                     tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteTrainingScheduleRecord(" + i + ");'> </td>";
                     tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                     tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.TrainingSchedule[i].Trainingscheduleid + "</td>";

                     tbl += "<td style='text-align:left; white-space:nowrap;' id='txtStartdate" + i + "'>" + data.TrainingSchedule[i].stratdate + "</td>";
                     tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEndDate" + i + "'>" + data.TrainingSchedule[i].enddate + "</td>";

                     tbl += "<td style='text-align:left; white-space:nowrap;' id='txtStartTime" + i + "'>" + data.TrainingSchedule[i].strattime + "</td>";
                     tbl += "<td style='text-align:right; white-space:nowrap;' id='txtEndTime" + i + "'>" + data.TrainingSchedule[i].endtime + " </td>";
                     tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTraningName" + i + "'>" + data.TrainingSchedule[i].trainingname + " </td>";
                     tbl += "<td style='text-align:left; white-space:nowrap;display:none' id='txtTerminalID" + i + "'>" + data.TrainingSchedule[i].training_id + " </td>";
                    // tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.TrainingSchedule[i].modified_date + " </td>";
                     tbl += "</tr>";
                 }
                 tbl += "</tbody>";
                 tbl += "</table>";
                 $("#tblTrainingScheduleDetails").html(tbl);
                 dataTable();
                 return false;
             }

             function getRowID(rowID) {
                 $("table[id$='tblTrainingScheduleDetails'] tr").css("background-color", "white");
                 $("#trmain" + rowID).css("background-color", "#6798c1");

             }
             function onretrievegetTrainingschedule() {
                 alert("Error In Loading Details!");
                 return false;
             }

             function DeleteTrainingScheduleRecord(rowNo) {


                 var TrainingSchedule_ID = $("#txtID" + rowNo).html();

                 if (confirm("Are you sure you wish to delete this Record?")) {
                     $.ajax({
                         type: "POST",
                         contentType: "application/json; charset=utf-8",
                         url: "Settingwebmethods.aspx/DeleteTrainingSchedule",
                         data: "{'TrainingSchedule_ID':'" + TrainingSchedule_ID + "'}",
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
                 getTrainingSchedule();
                 return false;

             }

             function OnretrievePhysicianError(msg) {
                 // getSecttalRecod();
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

                 var Training_stratdate = $("#txtStartdate" + rowNo).html().trim();
                 $("input[id$='txtStartDate']").val(Training_stratdate);
                 var Training_Enddate = $("#txtEndDate" + rowNo).html().trim();
                 $("input[id$='txtEndDate']").val(Training_Enddate);
                 var Training_StartTime = $("#txtStartTime" + rowNo).html().trim();
                 $("input[id$='txtStartTime']").val(Training_StartTime);
                 var Training_EndTime = $("#txtEndTime" + rowNo).html().trim();
                 $("input[id$='txtEndTime']").val(Training_EndTime);
                 var txtTerminalID = $("#txtTerminalID" + rowNo).html().trim();
                 $("select[id$='ddlTrainingid']").val(txtTerminalID);

                 
                 $("input[id$='btnUpdate']").show();
                 $("input[id$='btnSave']").attr("disabled", true);
                 return false;
             }
             function UpdateTrainingSchedule() {
                 var TrainingSchedule_ID = $("input[id$='txtID']").val();

                 var StartDate = $("input[id$='txtStartDate']").val();
                 var EndDate = $("input[id$='txtEndDate']").val();
                 var StartTime = $("input[id$='txtStartTime']").val();
                 var EndTime = $("input[id$='txtEndTime']").val();
                 var TrainingName = $("select[id$='ddlTrainingid']").val();

                 if (TrainingName == "") {
                     alert("Please Enter Training Name!");
                     return false;
                 }

                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "Settingwebmethods.aspx/UpdateTrainingschedule",
                     data: "{'TrainingSchedule_ID':'" + TrainingSchedule_ID + "','StartDate':'" + StartDate + "','EndDate':'" + EndDate + "','StartTime':'" + StartTime + "','EndTime':'" + EndTime + "','TrainingName':'" + TrainingName + "'}",
                     success: onsuccessUpdateTrainingSchedule,
                     error: onretrieveUpdateTrainingSchedule
                 });
                 return false;
             }
             function onsuccessUpdateTrainingSchedule() {
                 $("#divSuccessMsg").show();
                 $("#divSuccessMsg").html("");
                 $("#divSuccessMsg").html("Record Successfully Updated!");
                 $("#divSuccessMsg").fadeOut(6000);
                 $("input[id$='txtStartDate']").val("");
                 $("input[id$='txtEndDate']").val("");
                 $("input[id$='txtStartTime']").val("");
                 $("input[id$='txtEndTime']").val("");
                 $("select[id$='ddlTrainingid']").val("");
                 getTrainingSchedule();

                 ClearTrainingSchedule();
                 getTrainingSchedule();
                 return false;
             }
             function onretrieveUpdateTrainingSchedule() {
                 alert("Error In Updating Record!");
                 return false;
             }




        </script>
</asp:Content>

