<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddHolidays.aspx.cs" Inherits="SettingForms_AddHolidays" %>
<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <link href="css/dataTable.css" rel="stylesheet" />
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modified Holiday(s)</legend>

                    <table id="tblHolidays" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">Holiday(s) Name:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtHolidayName" Width="95%" placeholder="Holiday(s) Name"  class="alpha" runat="server" BackColor="White"></asp:TextBox>
                            </td>

                            <td>
                                No of Holiday(S)
                            </td>
                            <td>
                                <asp:TextBox ID="txtTotalNoOfHolidays" runat="server" ReadOnly="true"></asp:TextBox>
                            </td>
                            
                        </tr>

                        <tr>
                            <td style="width: 140px; text-align: left;">Date From:<span class="reqSpan">*</span>
                            </td>
                    <td style="width: 30%;">
                        
                           <asp:TextBox ID="txtDateFrom" CssClass="date disable_past_dates"  runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar2" Separator="/" Format="mm dd yyyy" Control="txtDateFrom" runat="server" 
                                Font-Names="Tahoma" />
                     
                    </td>
                            

                            <td style="width: 140px; text-align: left;">Date To:<span class="reqSpan">*</span>
                            </td>
                    <td style="width: 30%;">
                        
                           <asp:TextBox ID="txtDateTo" CssClass="date disable_past_dates"  runat="server" style="width:60%;float: left; margin-right: 5px;" onblur="getDays();"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar1" Separator="/" Format="mm dd yyyy" Control="txtDateTo" runat="server" 
                                Font-Names="Tahoma" />
                    
                    </td>

                        </tr>
                        <tr>
                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveHoliday();" runat="server" />

                                <asp:Button ID="btnClearHoliday" Text="Clear" CssClass="btn" OnClientClick="return ClearHoliday();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateHoliday();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divHolidayDetails">
        <fieldset id="fldHolidayDetails" >
            <legend>Holiday Details</legend>
             <div style="overflow: auto; width: 100%;">
                  
            <table id="tbleHolidayDetails" class="dataTable">
            </table>
                 </div>
        </fieldset>
    </div>

    <script type="text/javascript">

        function getDays() {
            $("input[id$='txtTotalNoOfHolidays']").val("");
            var firstDate = $("input[id$='txtDateFrom']").val();
            var secondDate = $("input[id$='txtDateTo']").val();
            var startDay = new Date(firstDate);
            var endDay = new Date(secondDate);
            if (endDay.getTime() < startDay.getTime()) {
                alert("Date To can not be less than Date From");
                return false;
            }
            var millisecondsPerDay = 1000 * 60 * 60 * 24;

            var millisBetween = endDay.getTime() - startDay.getTime();
            var days = millisBetween / millisecondsPerDay;
           
            // Round down.
            var totalDays=Math.floor(days) + 1;
            $("input[id$='txtTotalNoOfHolidays']").val(totalDays);
            return totalDays;

        }

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
           getHolidays();

        });

        function dataTable() {
            oTable = $("#tbleHolidayDetails").dataTable();
        }

        function SaveHoliday() {
            debugger;
            if (!validate("tblHolidays")) {
                var Holiday_Name = $("input[id$='txtHolidayName']").val().trim();
                var FromDate = $("input[id$='txtDateFrom']").val();
                var ToDate = $("input[id$='txtDateTo']").val();
                var TotalDays = getDays();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveHoliday",
                    //data: "{'Holiday_Name':'" + Holiday_Name + "'}",
                    data: "{'Holiday_Name':'" + Holiday_Name + "','FromDate':'" + FromDate + "','ToDate':'" + ToDate + "','TotalDays':'" + TotalDays + "'}",
                    success: onsuccessSaveCaste
                });
            }
            return false;
        }
        function onsuccessSaveCaste(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            $("input[id$='txtHolidayName']").val("");
            getHolidays();
            return false;
        }
        function ClearHoliday() {
            $("input[id$='txtHolidayName']").val("");
            $("input[id$='txtDateTo']").val("");
            $("input[id$='txtDateFrom']").val("");
            $("input[id$='txtTotalNoOfHolidays']").val("");

            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getHolidays() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getHolidayDetail",
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
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Holiday ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Holiday Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Date From</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Date To</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>No. of Days</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.dtHolidayDetail.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteCasteRecord(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.dtHolidayDetail[i].holiday_id + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtHolidayName" + i + "'>" + data.dtHolidayDetail[i].holiday_name + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtHolidayFromDate" + i + "'>" + data.dtHolidayDetail[i].from_date + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtHolidayToDate" + i + "'>" + data.dtHolidayDetail[i].to_date + "</td>";
                
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtHolidayTotalDays" + i + "'>" + data.dtHolidayDetail[i].total_holidays + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.dtHolidayDetail[i].created_by + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.dtHolidayDetail[i].created_date + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.dtHolidayDetail[i].modified_by + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.dtHolidayDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tbleHolidayDetails").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tbleHolidayDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteCasteRecord(rowNo) {

            var Holiday_ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteHolidayDetail",
                    data: "{'Holiday_ID':'" + Holiday_ID + "'}",
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
            getHolidays();
            return false;
        }

        function EditRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(ID);

            var Holiday_Name = $("#txtHolidayName" + rowNo).html().trim();
            $("input[id$='txtHolidayName']").val(Holiday_Name);

            var DateFrom = $("#txtHolidayFromDate" + rowNo).html().trim();
            $("input[id$='txtDateFrom']").val(DateFrom);
            var DateTo = $("#txtHolidayToDate" + rowNo).html().trim();
            $("input[id$='txtDateTo']").val(DateTo);

             var TotalNoOfDays = $("#txtHolidayTotalDays" + rowNo).html().trim();
            $("input[id$='txtTotalNoOfHolidays']").val(TotalNoOfDays);


            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateHoliday() {
            if (!validate("tblHolidays")) {
                var Holiday_ID = $("input[id$='txtID']").val();
                var Holiday_Name = $("input[id$='txtHolidayName']").val().trim();
                 var FromDate = $("input[id$='txtDateFrom']").val();
                var ToDate = $("input[id$='txtDateTo']").val();
                var TotalDays = getDays();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateHoliday",
                    data: "{'Holiday_ID':'" + Holiday_ID + "','Holiday_Name':'" + Holiday_Name + "','FromDate':'" + FromDate + "','ToDate':'" + ToDate + "','TotalDays':'" + TotalDays + "'}",
                    success: onsuccessUpdateCaste
                });
            }
            return false;
        }
        function onsuccessUpdateCaste() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtHolidayName']").val("");
            getHolidays();

            ClearHoliday();
           
            return false;
        }
    </script>
</asp:Content>

