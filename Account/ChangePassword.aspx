<%@ Page Title="更改密码" Language="C#" MasterPageFile="~/Master/Site.master" AutoEventWireup="true"
    CodeFile="ChangePassword.aspx.cs" Inherits="Account_ChangePassword" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript">
        //$(function () {
        //    $("a:eq(1)").css({ "color": "#E65D06" });
        //});
        function Refresh() {
            var num = Math.random();
            var VerifyCode = document.getElementById("VerfyCode");
            VerifyCode.src = "<%=ResolveUrl("~/Account/VerifyCode.aspx?")%>" + num;
        }
    </script>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<form id="ChangePasswordForm" runat="server">
    <div id="content">
            <h2>重置密码
            </h2>
            <p>
                填写你的用户名跟注册邮箱，以便后台处理
            </p>
            <div>
                <asp:Label ID="ErrorMessage" runat="server"  Visible="false" width="912px"></asp:Label>
            </div>
            <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" CssClass="failureNotification" 
                ValidationGroup="RegisterUserValidationGroup" DisplayMode="List"  />
            <div class="accountInfo">
                <fieldset class="register">
                    <legend>重置密码</legend>
                    <table class="DetailForm">
                        <tr>
                            <td>
                                <p>
                                    <asp:Label ID="LoginNameLabel" runat="server" AssociatedControlID="LoginName">用户名</asp:Label>
                                </p>
                            </td>
                            <td>
                                <p>
                                    <asp:TextBox ID="LoginName" runat="server" CssClass="textEntry" Width="300"></asp:TextBox>
                                </p>
                            </td>
                            <td>
                                <p>
                                    <asp:RequiredFieldValidator ID="LoginNameRequired" runat="server" ControlToValidate="LoginName"
                                        CssClass="failureNotification" ErrorMessage="必须填写“用户名”" ToolTip="必须填写“用户名”"
                                        ValidationGroup="RegisterUserValidationGroup" Display="None" />
                                </p>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <p>
                                    <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">电子邮件</asp:Label>
                                </p>
                            </td>
                            <td>
                                <p>
                                    <asp:TextBox ID="Email" runat="server" CssClass="textEntry" Width="300"></asp:TextBox>
                                </p>
                            </td>
                            <td>
                                <p>
                                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                        ErrorMessage="必须填写“电子邮件”" ToolTip="必须填写“电子邮件”"
                                        ValidationGroup="RegisterUserValidationGroup" Display="None" />
                                    <asp:RegularExpressionValidator ID="EmailRequired2" runat="server" ControlToValidate="Email"
                                        ErrorMessage="“电子邮件”请填写正确格式" ToolTip="“电子邮件”请填写正确格式"
                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                        ValidationGroup="RegisterUserValidationGroup" Display="None" />
                                </p>
                            </td>
                        </tr>
                       
                        <tr>
                            <td>
                                <p>
                                    <asp:Label ID="VerificationCodeLabel" runat="server" AssociatedControlID="VerificationCode">验证码</asp:Label>
                                    <asp:RequiredFieldValidator ControlToValidate="VerificationCode" 
                                        ErrorMessage="验证码不能为空" ID="VerificationCodeRequired" runat="server"
                                        ToolTip="验证码不能为空" ValidationGroup="RegisterUserValidationGroup" Display="None" />
                                </p>
                            </td>

                            <td>
                                <p>
                                    <asp:TextBox ID="VerificationCode" runat="server" CssClass="textEntry" Width="300"></asp:TextBox>
                                </p>
                                
                            </td>
                        </tr>
                        <tr>
                            <td><p>点击刷新</p></td>

                            <td>
                                <p>
                                    <img id="VerfyCode" alt="点击修改" src="<%=ResolveUrl("~/Account/VerifyCode.aspx?")%>" onclick="javascript:Refresh();" />
                                </p>
                            </td>

                        </tr>
                        <tr>
                            <td>
                                <p>
                                <asp:Button ID="ChangePasswordButton" runat="server" Text="重置密码"
                        ValidationGroup="RegisterUserValidationGroup"   CssClass="submitButton" OnClick="ChangePasswordButton_Click"/></p>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>
        </div>
</form>

</asp:Content>