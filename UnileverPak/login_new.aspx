<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login_new.aspx.cs" Inherits="login_new" %>

<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]> <html class="lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]> <html class="lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<html lang="en">
<!--<![endif]-->

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link href="css/Login_StyleSheet.css" rel="stylesheet" />
    <!--[if lt IE 9]><script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
</head>
<body >

    <form id="form1" runat="server">

        <section class="container">
            <div class="login">
                <div style="border-bottom:1px solid #ccc;" ><h1>HR Watch</h1></div>

                    <p>
                        <asp:TextBox  runat="server" id="TxtUserName"  placeholder="Username"></asp:TextBox></p>
                    <p>
                        <asp:TextBox  runat="server" TextMode="Password" id="TxtPassword"  placeholder="Password"></asp:TextBox></p>
                    <p class="remember_me">
                        <label>
                            <input type="checkbox" name="remember_me" id="remember_me">
                            Remember me on this computer
                        </label>
                    </p>
                    <p class="submit">
                        <asp:Button ID="BtnLogin" runat="server" OnClick="btnLogin_Click" Text="Login" />
                    </p>
                 <asp:Label ID="lblErrorMessage" runat="server" Style="color:maroon; font-size: 14px; font-weight: bold;"></asp:Label>
            </div>
        </section>
            
    </form>

</body>
</html>
