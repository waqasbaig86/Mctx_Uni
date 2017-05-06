<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="TestReport.aspx.cs" Inherits="Reports_TestReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <table>
            <tr>
                <td>
                    <asp:Button ID="btnShow" Text="Show Report" runat="server" OnClick="btnShow_Click" />
                </td>
                
            </tr>
        </table>

    </div>
    <div style="width:100%">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" ></rsweb:ReportViewer>
    </div>
</asp:Content>

