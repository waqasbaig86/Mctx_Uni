<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Hierarchy.aspx.cs" Inherits="HMS_Hierarchy" %>
<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <fieldset>
        <legend>Hierarchy Management System</legend>
        <asp:RadioButton id="rbAssignedPerson" runat="server" Checked="true" onclick="AssignedPerson();" style="margin-left:50px"  Text="Assigned Person" GroupName="measurementSystem"></asp:RadioButton>
        <asp:RadioButton id="rbUnAssignedPerson" runat="server"  style="margin-left:100px" onclick="UnassignPerson();"  Text="UnAssigned Person" GroupName="measurementSystem"></asp:RadioButton>

        <span style="margin-left: 15px;">
                <input type="button" id="btnSearch" onclick="getHierarchy();" class="btn" value="Search" />
            </span>
        <table>
            <tr id="trReporting">
                <td class="right-align"><label id="lblAssignedPerson">Reporting Person:</label>  &nbsp;</td>
                <td>
                   <div id="ddlReporting"> <asp:DropDownList ID="ddlReportingPerson" runat="server" class="req" >                        
                    </asp:DropDownList></div>&nbsp;
                </td>
                <td></td>                
            </tr>
            <tr id="trUnAssignReporting2"  style="display:none;">
                <td class="right-align"><label> Department:</label></td>
                <td>
                    <asp:DropDownList ID="ddlDepartment" runat="server">
                    </asp:DropDownList>
                </td>
                <td  class="right-align"><label> Shift:</label></td>
                <td>
                    <asp:DropDownList ID="ddlShifts" runat="server" >
                    </asp:DropDownList>
                </td>
            </tr>
            <tr id="trUnAssignReporting1" style="display:none;">
                <td class="right-align" style="width:18%;">
                    <label> Assign/Change Reporting:</label></td>
               <td class="right-align"  style="width:14%;">
            <asp:DropDownList ID="ddlChangeReportingPerson" runat="server" class="req">
            </asp:DropDownList>
                   </td>
                   
               <td class="right-align"  style="width:8%;"><label>Date From:</label></td>
                <td class="right-align"  style="width:14%;">

                     <asp:TextBox ID="txtDateFrom" CssClass="date disable_past_dates"  runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar2" Separator="/" Format="mm dd yyyy" Control="txtDateFrom" runat="server" 
                                Font-Names="Tahoma" />
                </td>
                <td class="right-align"  style="width:8%;"><label>Date To:</label></td>
                <td class="right-align"  style="width:14%;">
                     <asp:TextBox ID="txtDateTo" CssClass="date disable_past_dates"  runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar1" Separator="/" Format="mm dd yyyy" Control="txtDateTo" runat="server" 
                                Font-Names="Tahoma" />
                </td>
                <td  style="width:16%;">                    
                    <asp:CheckBox ID="chkMainReporting" Text="Permanent Reporting" runat="server" />
                </td>
                <td>
                       <input type="button" id="btnUpdate" class="btn" onclick="updateReportingPerson();" value="Update" />
                   </td>                
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
    <script src="hierarchy.js"></script>
</asp:Content>

