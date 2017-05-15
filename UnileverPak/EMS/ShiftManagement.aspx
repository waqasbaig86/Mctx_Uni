<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="ShiftManagement.aspx.cs" Inherits="HMS_ShiftManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <fieldset>
        <legend>Shift Management System</legend>
        <table style="width:100%;">
            <tr>
                <td>Emp #:</td>
                <td>
                    <input type="text" id="txtEmpId" />
                </td>
                <td>Department:</td>
                <td>
                    <asp:DropDownList ID="ddlDepartment" runat="server" Style="width: 270px">
                    </asp:DropDownList>
                </td>
                <td>Shift:</td>
                <td>
                    <asp:DropDownList ID="ddlShifts" runat="server" Style="width: 270px">
                    </asp:DropDownList>
                </td>
                <td>
                    <input type="button" id="btnSearch" onclick="getEmployees();" class="btn" value="Search" style="margin-left: 200px" />
                </td>
            </tr>

            <tr>
                <td>Change Shift:</td>
                <td>
                    <asp:DropDownList ID="ddlChangeShift" runat="server" Style="width: 270px">
                    </asp:DropDownList>
                </td>
                <td colspan="5">
                    <input type="button" id="btnUpdate" class="btn" onclick="changeShift();" value="Update" style="margin-left: 200px" />
                </td>
            </tr>
        </table>

    </fieldset>

    <div id="divHierarchyDetails">
        <fieldset id="fldHierarchyDetails">
            <legend>Employee Details</legend>
            <input type="checkbox" id="checkall" />Check All
             <div style="overflow: auto; width: 100%;">

                 <table id="tblEmployeeDetails" class="dataTable">
                 </table>
             </div>
        </fieldset>
    </div>
    <script src="shiftManagement.js"></script>
</asp:Content>

