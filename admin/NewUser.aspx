<%@ Page  Language="C#" ValidateRequest="false" MasterPageFile="~/Master/AdminConsole.master" 
AutoEventWireup="true" CodeFile="NewUser.aspx.cs" Inherits="Account_NewUser" 
Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    
            <h3><a href="<%=ResolveUrl("~/admin/Index.aspx") %>">首页</a><small>></small><a href="<%=ResolveUrl("~/admin/UserManage.aspx") %>">油站用户管理</a><small>></small>新建帐户
            </h3>
            <div>
                <asp:Label ID="ErrorMessage" runat="server"  Visible="false" width="912px"></asp:Label>
            </div>
            <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" CssClass="failureNotification" 
                ValidationGroup="RegisterUserValidationGroup" DisplayMode="List"  />
            <div >                    
                    <table class="DetailForm" width="100%" cellspacing="0" >
                        <tr style="color: White;background-color: #366B6B; font-weight: bold;height:16px;" >
                            <th colspan="3">
                            帐户信息
                            </th>
                        </tr>
                        <tr style="color: #333333;background-color: #F7F6F3;font-size: Small;height: 10px;">
                            <td>
                                <p >
                                    <asp:Label  ID="LoginNameLabel" runat="server" AssociatedControlID="LoginName">用户名</asp:Label>
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
                        <tr style="color: #333333;background-color: White;font-size: Small;height: 10px;">
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
                                <p style="color:gray;">
                                    最长为15个字符
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                        CssClass="failureNotification" ErrorMessage="必须填写“真实姓名”" ToolTip="必须填写“真实姓名”"
                                        ValidationGroup="RegisterUserValidationGroup" Display="None" />
                                </p>
                            </td>
                        </tr>
                        <tr style="color: #333333;background-color: #F7F6F3;font-size: Small;height: 10px;">
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
                        <tr style="color: #333333;background-color: White;font-size: Small;height: 10px;">
                            <td>
                                <p>
                                    <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">密码</asp:Label>
                                </p>
                            </td>
                            
                            <td>
                                <p>
                                    <asp:TextBox ID="Password" runat="server" CssClass="textEntry" TextMode="Password" Width="300"></asp:TextBox>
                                </p>
                            </td>
                            <td>
                                <p style="color:gray;">
                                    最长为16个字符
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                        CssClass="failureNotification" ErrorMessage="必须填写“密码”" ToolTip="必须填写“密码”"
                                        ValidationGroup="RegisterUserValidationGroup" Display="None" />
                                </p>
                            </td>
                        </tr>
                        <tr style="color: #333333;background-color: #F7F6F3;font-size: Small;height: 10px;">
                            <td></td>
                            <td>
                                 <p>密码的长度至少必须为6字符</p>
                            </td>
                            <td>

                            </td>
                        </tr>
                        <tr style="color: #333333;background-color: White;font-size: Small;height: 10px;">
                            <td>
                                <p>
                                    <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">确认密码</asp:Label>
                                </p>
                            </td>

                            <td>
                                <p>
                                    <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="textEntry" TextMode="Password" Width="300"></asp:TextBox>
                                </p>
                            </td>
                             <td>管理员&nbsp;
                                <asp:CheckBox ID="Admini" runat="server" />
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
                        <tr >
                            <td>
                                <p>
                                <asp:Button ID="CreateUserButton" runat="server" CommandName="MoveNext" Text="添加"
                        ValidationGroup="RegisterUserValidationGroup" OnClick="CreateUserButton_Click"  CssClass="submitButton"/></p>
                            </td>
                        </tr>
                    </table>
               
            </div>
        
</asp:Content>

