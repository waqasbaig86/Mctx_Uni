<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Users.aspx.cs" Inherits="UserManagement_Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <table class="dataTable">
        <thead>
            <tr>
                <th>Edit</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Address</th>
                <th>City</th>
                <th>Mobile #</th>
                <th>Email</th>
                <th>User Name</th>
                <th>Password</th>
                <th>Role</th>
                
            </tr>
        </thead>
       <tbody>--%>
             #StartUser#
            <asp:Repeater ID="rptUsers" runat="server">
                <ItemTemplate>
                    <tr>
                        <td><span style="padding-left: 20%;" onclick="deleteUserRecord('<%# Eval("userid") %>')">
                            <img style="text-align: center;" src='../images/Cross2.png' />
                        </span></td>
                        <td><span class="edit-icon" style="padding-left: 20%;" onclick="getUsersbyID(<%# Eval("userid") %>)">
                            <img src="../images/Edit.png" /></span> </td>
                        <td><%# Eval("firstname") %></td>
                        <td><%# Eval("lastname") %></td>
                        <td><%# Eval("address") %></td>
                        <td><%# Eval("city") %></td>
                        <td><%# Eval("mobile") %></td>
                        <td style="display:none;"><%# Eval("email") %></td>
                        <td><%# Eval("username") %></td>
                        <td style="display:none;"><%# Eval("password") %></td>
                        <td><%# Eval("role_name") %></td>

                    </tr>
                </ItemTemplate>
            </asp:Repeater>
    #EndUsers#
       <%-- </tbody>
    </table>--%>
    <script type="text/javascript">
        
    </script>
</asp:Content>

