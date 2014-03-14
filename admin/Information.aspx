<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Information.aspx.cs" Inherits="Information" MasterPageFile="~/Master/AdminConsole.master" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="Head">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="ContentPlaceHolder">
    <h3>
        <a href="<%=ResolveUrl("~/admin/Index.aspx") %>">首页</a><small>></small>我的账户</h3>
    <div>
        <asp:Label ID="ErrorMessage" runat="server" Visible="False" Width="771px"></asp:Label>
    </div>
    <br />
    <h4>个人信息</h4>
    <table style="margin-left:40px">
        <tr>
            <td style="width:90px">真实姓名</td>
            <td><asp:TextBox ID="Name" runat="server" Enabled="False" Width="200px"></asp:TextBox></td>
        </tr>
        <tr>
            <td>电子邮箱</td>
            <td><asp:TextBox ID="tbemail" runat="server" Enabled="False" Width="200px"></asp:TextBox></td>
        </tr>
        <tr>
            <td>注册时间</td>
            <td><asp:TextBox ID="tbtime" runat="server" Enabled="False" Width="200px"></asp:TextBox></td>
        </tr>
    </table>
    <br />
    <h4>修改密码</h4>
    <table style="margin-left:40px">
        <tr>
            <td style="width:90px">原密码</td>
            <td><asp:TextBox ID="pass" runat="server" TextMode="Password" Width="200px"></asp:TextBox></td>
        </tr>
        <tr>
            <td>新密码</td>
            <td><asp:TextBox ID="tbpass" runat="server" TextMode="Password" Width="200px"></asp:TextBox></td>
        </tr>
        <tr>
            <td>新密码确认</td>
            <td><asp:TextBox ID="tbconfirm" runat="server" TextMode="Password" Width="200px"></asp:TextBox></td>
        </tr>
    </table>
    <br />
    <br />
    <div style="margin-left:240px">
        <asp:Button ID="savebtn" runat="server" Text="确认更改" OnClick="Save" Width="80px" />
        <asp:Button ID="Button1" runat="server" Text="返回首页"  OnClick="Button1_Click" Width="80px" />
    </div>

</asp:Content>
