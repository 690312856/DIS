<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RoleManage.aspx.cs" Inherits="RoleManage" MasterPageFile="~/Master/AdminConsole.master" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="Head">
    <style type="text/css">
        .style1 {
            width: 770px;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="ContentPlaceHolder">
    <h3><a href="<%=ResolveUrl("~/admin/Index.aspx") %>">首页</a><small>></small>油站角色管理</h3>
    <div>
        <p>
            <asp:Label ID="ErrorMessage" runat="server" Visible="False" Width="773px"></asp:Label>
        </p>
    </div>
    <div>
        <br />
        <h4>创建角色</h4>
        <div id="createField" runat="Server" style="margin-left:30px">
            <table style="width: 770px;">
                <tr>
                    <td class="style1">角色名称:&nbsp;&nbsp;&nbsp;<asp:TextBox ID="roleName" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="style1">用户权限:<asp:CheckBoxList ID="permCheck" runat="server" RepeatDirection="Horizontal" style="margin-left:70px;margin-top:-20px" ></asp:CheckBoxList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="create" CssClass="submitButton" runat="server" Text="创建" OnClick="create_Click" style="margin-left:430px" />
                    </td>

                </tr>
            </table>

        </div>
        <br />
        <h4>已有角色</h4>
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                BorderWidth="1px"
                CellPadding="2"
                ForeColor="Black" GridLines="None" Width="100%" PageSize="10">
                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                <Columns>

                    <asp:HyperLinkField HeaderText="角色名称" DataNavigateUrlFields="ID"
                        DataNavigateUrlFormatString="~/admin/PermissionManagement.aspx?RoleId={0}" DataTextField="RoleName" ItemStyle-HorizontalAlign="Center" />
                    <asp:TemplateField HeaderText="查看文件" ItemStyle-HorizontalAlign="Center">

                        <ItemTemplate>
                            <asp:Image ID="ReadFilePic" runat="server" ImageUrl="~/images/icon/empty.png" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="删除文件" ItemStyle-HorizontalAlign="Center">

                        <ItemTemplate>
                            <asp:Image ID="DeleteFilePic" runat="server" ImageUrl="~/images/icon/empty.png" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="上传文件" ItemStyle-HorizontalAlign="Center">

                        <ItemTemplate>
                            <asp:Image ID="UpLoadPic" runat="server" ImageUrl="~/images/icon/empty.png" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="下载文件" ItemStyle-HorizontalAlign="Center">

                        <ItemTemplate>
                            <asp:Image ID="DownLoadPic" runat="server" ImageUrl="~/images/icon/empty.png" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="个人信息" ItemStyle-HorizontalAlign="Center">

                        <ItemTemplate>
                            <asp:Image ID="ReadSelfPic" runat="server" ImageUrl="~/images/icon/empty.png" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="状态">
                        <ItemStyle Width="60px" />
                        <ItemTemplate>
                            <a class="delete"></a>
                            <asp:LinkButton ID="DeleteButton" runat="server" OnClick="DeleteButton_Click" OnClientClick="return confirm('确定要删除吗?')">删除</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <AlternatingRowStyle BackColor="White" />
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#366B6B" ForeColor="White" Font-Bold="True" />
                <HeaderStyle BackColor="#366B6B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#366B6B" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Font-Size="Small" Height="10" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#366B6B" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#366B6B" />
            </asp:GridView>
            <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="~/App_Data/DIS.mdb"
                DeleteCommand="DELETE FROM [RolePermission] WHERE [ID] = ?"
                InsertCommand="INSERT INTO [RolePermission] ([ID], [RoleName], [ReadFile], [DeleteFile], [Upload], [DownLoad], [ReadSelf]) VALUES (?, ?, ?, ?, ?, ?, ?)"
                OldValuesParameterFormatString="original_{0}"
                UpdateCommand="UPDATE [RolePermission] SET [RoleName] = ?, [ReadFile] = ?, [DeleteFile] = ?, [Upload] = ?, [DownLoad] = ?, [ReadSelf] = ? WHERE [ID] = ?">
                <DeleteParameters>
                    <asp:Parameter Name="original_ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                    <asp:Parameter Name="RoleName" Type="String" />
                    <asp:Parameter Name="ReadFile" Type="Boolean" />
                    <asp:Parameter Name="DeleteFile" Type="Boolean" />
                    <asp:Parameter Name="Upload" Type="Boolean" />
                    <asp:Parameter Name="DownLoad" Type="Boolean" />
                    <asp:Parameter Name="ReadSelf" Type="Boolean" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="RoleName" Type="String" />
                    <asp:Parameter Name="ReadFile" Type="Boolean" />
                    <asp:Parameter Name="DeleteFile" Type="Boolean" />
                    <asp:Parameter Name="Upload" Type="Boolean" />
                    <asp:Parameter Name="DownLoad" Type="Boolean" />
                    <asp:Parameter Name="ReadSelf" Type="Boolean" />
                    <asp:Parameter Name="original_ID" Type="Int32" />
                </UpdateParameters>
            </asp:AccessDataSource>
        </div>
    </div>
</asp:Content>
