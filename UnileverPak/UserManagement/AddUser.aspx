<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddUser.aspx.cs" Inherits="UserManagement_AddUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   
    <fieldset  style="width: 97%;" id="fldAddModifyUser">
        <legend>Add/Modify User</legend>
  
     <table class="form" id="tblUserForm" style="width: 90%; margin: auto;">
        <tr>
            <td class="right" style="width: 20%;">First Name:<span class="reqSpan">*</span></td>
            <td style="width: 30%;">
                <input type="text" id="txtFName" class="alpha req" runat="server" /></td>
            <td class="right" style="width: 20%;">Department:</td>
            <td>
             <%--   <input type="text" id="ddlDepartmentSearch" class="department" runat="server" />--%>

                <asp:DropDownList ID="ddlDepartmentSearch" runat="server"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="right">Last Name:<span class="reqSpan">*</span></td>
            <td>
                <input type="text" id="txtLName" class="alpha req" runat="server" /></td>
            <td class="right">Employee No:<span class="reqSpan">*</span></td>
            <td>
                <input type="text" id="txtPno" class="alphanumeric req" runat="server" /></td>
        </tr>
        <tr>
            <td class="right">Role:<span class="reqSpan">*</span></td>
            <td>
                <asp:DropDownList ID="ddlRole" CssClass="req" runat="server">
                    <asp:ListItem Text="-- Select --" Value="-- Select --"></asp:ListItem>
                    <asp:ListItem Text="Admin" Value="1"></asp:ListItem>
                    <asp:ListItem Text="User" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Viewer" Value="3"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="right">Mobile #:</td>
            <td>
                <input type="text" id="txtMobileNo" class="cell" runat="server" /></td>
        </tr>
        <tr>
            <td class="right">User Name:<span class="reqSpan">*</span></td>
            <td>
                <input type="text" id="txtUserName" class="alpha req" runat="server" /></td>
            <td class="right" style="display:none;" >Email:</td>
            <td style="display:none;">
                <input type="text" id="txtEmail" class="email" runat="server" /></td>
            <asp:TextBox TextMode="Password" ID="txtPasswords" runat="server" style="width:1px;"></asp:TextBox>
        </tr>
        <tr>
            <td class="right">Password:<span class="reqSpan">*</span></td>
            <td>
           <%--     <input type="text" id="txtPassword" class="password" runat="server" />--%>
               

               
                  <input type="password" id="txtPassword" class="req" runat="server" />

            </td>

        </tr>
        <tr>
            <td colspan="4" style="padding-left:70%;">
                <input type="button" id="btnSaveUser" class="btn" value="Save" onclick="saveUser()" />
                 <input type="button" id="btnNew" class="btn" value="New" onclick="ClearUser()" />
            </td>
        </tr>
    </table>
    <input type="hidden" id="hdnUserId" runat="server" value="0" />
      </fieldset>

      <fieldset id="fieldsetPersonalGrd" style="width: 97%;">
            <legend>Users</legend>

            <div style="padding-bottom: 20px; width: 1208px; max-height: 300px; overflow: auto;">
                <table class="dataTable">
                    <thead>
                        <tr>
                        <th>Delete</th>
                        <th>Edit</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Department</th>
                        <th>Pno</th>
                        <th>Mobile #</th>
                        <th style="display:none;">Email</th>
                        <th>User Name</th>
                        <th style="display:none;">Password</th>
                        <th>Role</th>
                          
                        </tr>
                    </thead>
                    <tbody id="tbodyUser" style="background-color:white;">
                        <tr>
                            <td colspan="10">&nbsp;</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>

    <script type="text/javascript">
    
        $(document).ready(function () {
            if ($("span[id$='lblRole']").text().trim() != "Admin") {
                $("#fldAddModifyUser input").attr("disabled", true);
                $("#fldAddModifyUser select").attr("disabled", true);
            }
            //alert($("input[id$='txtPassword']").val());
            getUsers();
           var UserIDs = getUrlVars()["UserId"];
          //  alert(UserIDs);

            if(UserIDs !=undefined)
                $("input[id$='txtPassword']").val("!#!#!#!#!#!#!#!#Abcdefgh123");
            
        });


        function getUrlVars() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
       return vars;

            
        }
        function saveUser() {
          
            var newPwd = $("[id$='txtPassword']").val();
            var validLength = /.{8}/.test(newPwd);
            var hasCaps = /[A-Z]/.test(newPwd);
            var hasNums = /\d/.test(newPwd);
            var hasSpecials = /[~!,@#%&_\$\^\*\?\-]/.test(newPwd);

            var isValid = validLength && hasCaps && hasNums && hasSpecials;

            if (!isValid) {
                alert("Please Enter Strong Password! Password must be minimum 8 characters long having atleast one Upper Case letter, one Number and one Special Character");
                return false;
            }
               
            if (!validate("tblUserForm")) {
                var request = "{"
                    + "'userId':'" + $.trim($("[id$='hdnUserId']").val()) + "',"
                    + "'username':'" + $.trim($("[id$='txtUserName']").val()) + "',"
                    + "'password':'" + $.trim($("[id$='txtPassword']").val()) + "',"
                    + "'firstname':'" + $.trim($("[id$='txtFName']").val()) + "',"
                    + "'lastname':'" + $.trim($("[id$='txtLName']").val()) + "',"
                    + "'department':'" + $.trim($("[id$='ddlDepartmentSearch'] option:selected").text()) + "',"
                    + "'Pno':'" + $.trim($("[id$='txtPno']").val()) + "',"
                    + "'mobile':'" + $.trim($("[id$='txtMobileNo']").val()) + "',"
                    + "'email':'" + $.trim($("[id$='txtEmail']").val()) + "',"
                    + "'RoleId':'" + $.trim($("[id$='ddlRole']").val()) + "'"
                    + "}";

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "/PascWebMethod.aspx/SaveUser",
                    data: request,
                    success: onsuccessSaveUser
                });
            }
        }

        function onsuccessSaveUser() {
            $("#divMsg").html("Record Successfully Updated!").removeClass("error").addClass("success").show();
            $("#divMsg").fadeOut(6000);
            getUsers();
            //   window.location = "../UserManagement/Users.aspx";
        }


        function getUsers() {

            $.post("../UserManagement/Users.aspx").done(function (data) {
                var response = data;
                var start = data.indexOf("#StartUser#") + 11;
                var end = data.indexOf("#EndUsers#");
                $("#tbodyUser").html(response.substring(start, end));

                if ($("#tbodyUser tr").length == 0) {
                    $("#tbodyUser").html("<tr><td class='noRecordFound' colspan='11'>No Record Found</td></tr>");
                }

            });
        }


        function getUsersbyID(userId) {
            window.location = "../UserManagement/AddUser.aspx?UserId=" + userId;

         
        }

        function ClearUser() {

            window.location = "../UserManagement/AddUser.aspx";
        }
        function deleteUserRecord(UserID) {

           // var Caste_ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../UserManagement/AddUser.aspx/DeleteUser",
                    data: "{'UserID':'" + UserID + "'}",
                    success: onsuccessDeleteData
                });

                return false;
            }
            else
                return false;
        }

        function onsuccessDeleteData(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record deleted successfully!");
            getUsers();
            return false;
        }
    </script>
</asp:Content>

