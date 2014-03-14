<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PermissionManagement.aspx.cs" Inherits="RoleManage" MasterPageFile="~/Master/AdminConsole.master" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="Head">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="ContentPlaceHolder">
    <h3><a href="<%=ResolveUrl("~/admin/Index.aspx") %>">首页</a><small>></small><a href="RoleManage.aspx">油站角色管理</a><small>></small>权限管理</h3>
    <div>
        <asp:Label ID="ErrorMessage" runat="server" Visible="False" Width="771px"></asp:Label>
    </div>
    <div>
        <br />
        <h4><asp:Label ID="RoleName" runat="server" Visible="True" Width="771px" BackColor="white" ForeColor="black"></asp:Label></h4>
         <table style="text-align:center">
             <tr style="color:white;background-color:#366b6b">
                 <th>权限类型</th>
                 <th>状态</th>
             </tr>
             <tr style="color:black;background-color:#eee">                 
                 <td style="width:200px">
                     文件权限
                 </td>
                 <td style="width:200px">
                     <asp:CheckBoxList ID="permCheck" runat="server" RepeatDirection="Vertical" style="margin-left:60px">
                     </asp:CheckBoxList> 
                 </td>
             </tr>
             <tr style="color:black;background-color:#dcdcdc">
                 <td>
                     信息权限
                 </td>
                 <td>
                     <asp:CheckBoxList ID="permCheck1" runat="server" RepeatDirection="Vertical" style="margin-left:60px">
                     </asp:CheckBoxList> 
                 </td>
             </tr>
         </table>
         <br />         
        <div style="margin-left:243px">
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="确认更改" Width="80px" />
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="返回上一页" Width="80px" />
            <br />
        </div>
        <div>
            <br />

        </div>
        &nbsp;
    </div>
</asp:Content>
