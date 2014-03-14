<%@ Page Title="" Language="C#" ValidateRequest="false" MasterPageFile="~/Master/AdminConsole.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="AdminIndex" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <h3>首页-通知中心</h3>
    <br />
    <div style="width: 45%; float: left">
        <h4>通知提醒：</h4>
        <a href="<%=ResolveUrl("~/admin/UserManage.aspx") %>">
            <div id="b1" runat="server" style="width: 400px; height: 60px; margin-left: 30px; margin-top: 20px; text-align: center; background-color: #f6f7a0; border-color: #fffc83; color: #754400; font-size: 1.1em; border: 2px solid;">
                <br />
                现在还有&nbsp;<big><strong><asp:Label ID="linkButton" runat="server"></asp:Label></strong></big>&nbsp;
                位用户需要激活
            </div>
        </a>
        <a href="<%=ResolveUrl("~/admin/UserManage.aspx") %>">
            <%--<div style="width: 400px; height: 60px; background-color: #89f142; margin-left: 30px; margin-top: 20px; text-align: center">--%>
            <div style="width: 400px; height: 60px; margin-left: 30px; margin-top: 20px; text-align: center; background-color: #dfffdf; border-color: #9fcf9f; color: #005f00; font-size: 1.1em; border: 2px solid;">
                <br />
                现在总共有&nbsp;<big><strong><asp:Label ID="num" runat="server"></asp:Label></strong></big>&nbsp;
                位用户
            </div>
        </a>
        <a href="<%=ResolveUrl("~/admin/ProjectManage.aspx") %>">
            <%--<div style="width: 400px; height: 60px; background-color: #89f142; margin-left: 30px; margin-top: 20px; text-align: center">--%>
            <div style="width: 400px; height: 60px; margin-left: 30px; margin-top: 20px; text-align: center; background-color: #dfffdf; border-color: #9fcf9f; color: #005f00; font-size: 1.1em; border: 2px solid;">
                <br />
                现在总共有&nbsp;<big><strong><asp:Label ID="num2" runat="server"></asp:Label></strong></big>&nbsp;
                个项目
            </div>
        </a>
    </div>
    <div style="width: 40%; float: right">
        <div style="width: 300px">
            <h4>上次登录时间：<asp:Label ID="time" runat="server"></asp:Label></h4>
        </div>
    </div>
</asp:Content>
