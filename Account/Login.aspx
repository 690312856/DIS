<%@ Page Title="登录" Language="C#" MasterPageFile="~/Master/Site.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="Account_Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript">
        $(function () {
            $("a:eq(1)").css({ "color": "#E65D06" });
        });

    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <form id="LoginForm" runat="server">
        <div id="content">
            <h2>登录</h2>
            <p>
                请输入用户名和密码。如果您没有帐户,请点击 
        <asp:HyperLink ID="RegisterHyperLink" runat="server" EnableViewState="false" NavigateUrl="~/Account/Register.aspx">注册</asp:HyperLink>

            </p>
          
            <div>
                <asp:Label ID="ErrorMessage" runat="server" Visible="false" Width="912px"></asp:Label>
            </div>
            <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification"
                ValidationGroup="LoginUserValidationGroup" DisplayMode="List" />
            <div class="accountInfo">

                <fieldset class="login">
                    <legend>帐户信息</legend>
                    <table class="DetailForm">
                        <tr>
                            <td>
                                <p>
                                    <asp:Label ID="LoginNameLabel" runat="server" AssociatedControlID="LoginName">用户名</asp:Label>
                                </p>
                            </td>
                            <td>
                                <p>
                                    <asp:TextBox ID="LoginName" runat="server" CssClass="textEntry" Width="300px"></asp:TextBox>
                                </p>
                            </td>
                            <td>
                                <p>
                                    <asp:RequiredFieldValidator ID="LoginNameRequired" runat="server" ControlToValidate="LoginName"
                                        ErrorMessage="必须填写“用户名”" ToolTip="必须填写“用户名”"
                                        ValidationGroup="LoginUserValidationGroup" Display="None"></asp:RequiredFieldValidator>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td>

                                <p>
                                    <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">密码</asp:Label>
                                </p>
                            </td>
                            <td>
                                <p>
                                    <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password" Width="300px"></asp:TextBox>
                                </p>
                            </td>
                            <td>
                                <p>
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                        ErrorMessage="必须填写“密码”" ToolTip="必须填写“密码”"
                                        ValidationGroup="LoginUserValidationGroup" Display="None" />
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <p style="text-align: center">
                                    <asp:CheckBox ID="RememberMe" runat="server" />
                                    <asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="RememberMe" CssClass="inline">保持登录状态</asp:Label>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <p>
                                    <span style="float:left;margin-left:30px;"><a href="ChangePassword.aspx">忘记密码？</a></span>
                                    <span style="float:right;margin-right:30px;"><asp:Button ID="LoginButton" runat="server" Text="登录" ValidationGroup="LoginUserValidationGroup" CssClass="submitButton" OnClick="LoginButton_Click"/></span>
                                </p>
                            </td>
                        </tr>
                    </table>
                    
                </fieldset>

            </div>
            
        </div>
    </form>
</asp:Content>
