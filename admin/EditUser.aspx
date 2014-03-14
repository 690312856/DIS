<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditUser.aspx.cs" Inherits="admin_UserProject" MasterPageFile="~/Master/AdminConsole.master" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="Head">
    <style type="text/css">
        .style2 {
            width: 300px;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="ContentPlaceHolder">
    <h3><a href="<%=ResolveUrl("~/admin/Index.aspx") %>">首页</a><small>></small><a href="<%=ResolveUrl("~/admin/UserManage.aspx") %>">油站用户管理</a><small>></small>委任项目-<asp:Label ID="name" runat="server"></asp:Label></h3>
    <div>
        <div>
            <p>
                <asp:Label ID="ErrorMessage" runat="server" Visible="false" Width="772px"></asp:Label>
            </p>
        </div>
        <br />
        <div>
            <h4>委任项目角色</h4>
            <table>
                <tr>
                    <td class="style2">项目名称&nbsp;&nbsp;<asp:DropDownList ID="ddlProject" runat="server"
                        Width="184px">
                    </asp:DropDownList>
                    </td>
                    <td width="300">项目角色&nbsp;&nbsp;<asp:DropDownList ID="ddlRole" runat="server"
                        Width="184px">
                    </asp:DropDownList>
                        <asp:AccessDataSource ID="AccessDataSource3" runat="server"
                            DataFile="~/App_Data/DIS.mdb"
                            SelectCommand="SELECT [RoleName] FROM [RolePermission]"></asp:AccessDataSource>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td width="200">
                        <asp:Button ID="addProject" runat="server" Text="新增" Width="63px" OnClick="addProject_Click" style="float:right;margin-right:50px" />
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <h4>目前担任项目角色</h4>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px"
            CellPadding="4" DataKeyNames="ID" DataSourceID="AccessDataSource1"
            ForeColor="Black" GridLines="Vertical" Width="550px" OnRowDataBound="DataBound_click" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AllowSorting="true">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField Visible="false">
                    <ItemTemplate>
                        <asp:CheckBox Visible="false" ID="CheckBox1" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="项目名" SortExpression="ProjectName">
                    <ItemTemplate>
                        <asp:Label runat="Server" ID="lbProject" Text='<%#Bind("ProjectName") %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>

                        <asp:DropDownList ID="ddlProject1" runat="server" Width="200px"
                            DataSourceID="AccessDataSource2" DataTextField="OilProjectTitle"
                            DataValueField="OilProjectTitle">
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="角色">
                    <ItemTemplate>
                        <asp:Label runat="Server" ID="lbRole" Text='<%#Bind("RoleName") %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlRole1" runat="server"
                            Width="200px" DataSourceID="AccessDataSource3" DataTextField="RoleName"
                            DataValueField="RoleName">
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="操作" ShowHeader="False">
                    <ItemStyle Width="13%" />
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" CssClass="delete" Text="删除" runat="server" OnClick="Dele_Click"
                            OnClientClick="return confirm('确定删除吗？');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#CCCC99" />
            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
            <RowStyle BackColor="#F7F7DE" />
            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FBFBF2" />
            <SortedAscendingHeaderStyle BackColor="#848384" />
            <SortedDescendingCellStyle BackColor="#EAEAD3" />
            <SortedDescendingHeaderStyle BackColor="#575357" />
        </asp:GridView>

        <asp:AccessDataSource ID="AccessDataSource1" runat="server"
            ConflictDetection="CompareAllValues" DataFile="~/App_Data/DIS.mdb"
            DeleteCommand="DELETE FROM [UPR] WHERE [ID] = ? AND (([ProjectName] = ?) OR ([ProjectName] IS NULL AND ? IS NULL)) AND (([UserName] = ?) OR ([UserName] IS NULL AND ? IS NULL)) AND (([RoleName] = ?) OR ([RoleName] IS NULL AND ? IS NULL))"
            InsertCommand="INSERT INTO [UPR] ([ID], [ProjectName], [UserName], [RoleName]) VALUES (?, ?, ?, ?)"
            OldValuesParameterFormatString="original_{0}"
            SelectCommand="SELECT * FROM [UPR] WHERE ([UserName] = ?)"
            UpdateCommand="UPDATE [UPR] SET [ProjectName] = ?, [UserName] = ?, [RoleName] = ? WHERE [ID] = ? AND (([ProjectName] = ?) OR ([ProjectName] IS NULL AND ? IS NULL)) AND (([UserName] = ?) OR ([UserName] IS NULL AND ? IS NULL)) AND (([RoleName] = ?) OR ([RoleName] IS NULL AND ? IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_ProjectName" Type="String" />
                <asp:Parameter Name="original_ProjectName" Type="String" />
                <asp:Parameter Name="original_UserName" Type="String" />
                <asp:Parameter Name="original_UserName" Type="String" />
                <asp:Parameter Name="original_RoleName" Type="String" />
                <asp:Parameter Name="original_RoleName" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ID" Type="Int32" />
                <asp:Parameter Name="ProjectName" Type="String" />
                <asp:Parameter Name="UserName" Type="String" />
                <asp:Parameter Name="RoleName" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="li" Name="LoginName"
                    QueryStringField="LoginName" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="ProjectName" Type="String" />
                <asp:Parameter Name="UserName" Type="String" />
                <asp:Parameter Name="RoleName" Type="String" />

                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_ProjectName" Type="String" />
                <asp:Parameter Name="original_ProjectName" Type="String" />
                <asp:Parameter Name="original_UserName" Type="String" />
                <asp:Parameter Name="original_UserName" Type="String" />
                <asp:Parameter Name="original_RoleName" Type="String" />
                <asp:Parameter Name="original_RoleName" Type="String" />

            </UpdateParameters>
        </asp:AccessDataSource>
    </div>

    <br />
    <asp:AccessDataSource ID="AccessDataSource2" runat="server"
        DataFile="~/App_Data/DIS.mdb"
        SelectCommand="SELECT [OilProjectTitle] FROM [OilProject] WHERE ([IsDelete] = ?)">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="IsDelete" Type="Int32" />
        </SelectParameters>
    </asp:AccessDataSource>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        

</asp:Content>
