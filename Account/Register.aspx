<%@ Page Title="注册" Language="C#" MasterPageFile="~/Master/Site.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="Account_Register" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript">
        $(function () {
            $("a:eq(2)").css({ "color": "#E65D06" });
        });

        function Refresh() {
            var num = Math.random();
            var VerifyCode = document.getElementById("VerfyCode");
            VerifyCode.src = "<%=ResolveUrl("~/Account/VerifyCode.aspx?")%>" + num;
        }
    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <form id="RegisterForm" runat="server">
        <div id="content">
            <h2>创建新帐户
            </h2>
            <p>
                填写以下表单创建新帐户。
            </p>
            <div>
                <asp:Label ID="ErrorMessage" runat="server" Visible="false" Width="912px"></asp:Label>
            </div>
            <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" CssClass="failureNotification"
                ValidationGroup="RegisterUserValidationGroup" DisplayMode="List" />
            <div class="accountInfo">
                <fieldset class="register">
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
                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">真实姓名</asp:Label>
                                </p>
                            </td>
                            <td>
                                <p>
                                    <asp:TextBox ID="UserName" runat="server" CssClass="textEntry" Width="300" MaxLength="15"></asp:TextBox>
                                </p>
                            </td>
                            <td>
                                <p style="color: gray;">
                                    最长为15个字符
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                        CssClass="failureNotification" ErrorMessage="必须填写“真实姓名”" ToolTip="必须填写“真实姓名”"
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
                                    <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">密码</asp:Label>
                                </p>
                            </td>

                            <td>
                                <p>
                                    <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password" Width="300"></asp:TextBox>
                                </p>
                            </td>
                            <td>
                                <p style="color: gray;">
                                    最长为16个字符
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                        CssClass="failureNotification" ErrorMessage="必须填写“密码”" ToolTip="必须填写“密码”"
                                        ValidationGroup="RegisterUserValidationGroup" Display="None" />
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="color: gray;">
                                <p>密码的长度至少必须为6字符</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p>
                                    <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">确认密码</asp:Label>
                                </p>
                            </td>
                            <td>
                                <p>
                                    <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="passwordEntry" TextMode="Password" Width="300"></asp:TextBox>
                                </p>
                            </td>
                            <td>
                                <p>
                                    <asp:RequiredFieldValidator ControlToValidate="ConfirmPassword" CssClass="failureNotification"
                                        ErrorMessage="必须填写“确认密码”" ID="ConfirmPasswordRequired" runat="server"
                                        ToolTip="必须填写“确认密码”" ValidationGroup="RegisterUserValidationGroup" Display="None" />
                                    <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                        CssClass="failureNotification" Display="None" ErrorMessage="“密码”和“确认密码”必须匹配"
                                        ValidationGroup="RegisterUserValidationGroup" />
                                    <asp:RegularExpressionValidator ID="PasswordLengthRequired" runat="server" ControlToValidate="Password"
                                        CssClass="failureNotification" ErrorMessage="密码长度不应少于6个字符或多于16个字符" ToolTip="密码长度不应少于6个字符或多于16个字符"
                                        ValidationExpression="[a-zA-Z0-9-_&]{6,16}" ValidationGroup="RegisterUserValidationGroup" Display="None" />
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
                            <td>
                                <p>点击刷新</p>
                            </td>

                            <td>
                                <p>
                                    <img id="VerfyCode" alt="点击修改" src="<%=ResolveUrl("~/Account/VerifyCode.aspx?")%>" onclick="javascript:Refresh();" />
                                </p>
                            </td>

                        </tr>
                        <tr>
                            <td>
                                <p>
                                    <asp:Button ID="CreateUserButton" runat="server" CommandName="MoveNext" Text="确认注册"
                                        ValidationGroup="RegisterUserValidationGroup" OnClick="CreateUserButton_Click" CssClass="submitButton" />
                                </p>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>
        </div>
    </form>
</asp:Content>

