<%@ Page Language="C#" ValidateRequest="false" MasterPageFile="~/Master/AdminConsole.master"
    AutoEventWireup="true" CodeFile="UserManage.aspx.cs" Inherits="ADUser"
    Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>


<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">

    <div>
        <h3><a href="<%=ResolveUrl("~/admin/Index.aspx") %>">首页</a><small>></small>油站用户管理</h3>
        <p>
            <asp:DropDownList ID="ChooseUser" runat="server" OnSelectedIndexChanged="ChooseUser_SelectedIndexChanged"
                AutoPostBack="True">
            </asp:DropDownList>
            <asp:TextBox CssClass="searchTextBox" ID="Search_key" runat="server" Text="请输入需要查找的用户名"/>
            <asp:Button CssClass="searchButton" ID="Search" OnClick="Search_Click" runat="server" Text="搜索"/>
            <asp:LinkButton class="add" ID="NewUser" OnClick="NewUser_Click" runat="server" Text="新建用户" />
        </p>
        <div>
            <p>
                <asp:Label ID="ErrorMessage" runat="server" Visible="false" Width="772px"></asp:Label>
            </p>
        </div>
        <asp:GridView AllowPaging="true" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="19" Style="text-align: center" ID="GridView1" runat="server" DataKeyNames="UserID" AutoGenerateColumns="False" ForeColor="#333333" GridLines="None" Width="100%">
            <Columns>
                <asp:TemplateField Visible="false">
                    <ItemTemplate>
                        <asp:CheckBox Visible="false" ID="CheckBox1" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                                        
                         <asp:HyperLinkField DataNavigateUrlFields="LoginName" 
                                 DataNavigateUrlFormatString="EditUser.aspx?LoginName={0}" 
                                 DataTextField="LoginName" DataTextFormatString="{0}" HeaderText="登录名" />
                      
               <%-- <asp:BoundField ItemStyle-Width="10%" DataField="LoginName" HeaderText="登录名" />--%>
                <asp:BoundField ItemStyle-Width="20%" DataField="Email" HeaderText="邮箱" />
                <asp:BoundField ItemStyle-Width="15%" DataField="UserName" HeaderText="用户名" />
                <asp:TemplateField ItemStyle-Width="5%" HeaderText="管理员" ShowHeader="False">
                    <ItemStyle Width="7%" />
                    <ItemTemplate>
                        <asp:Image ID="isAdmin" runat="server" ImageUrl="~/images/icon/empty.png" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField ItemStyle-Width="17%" DataField="CreateTime" HeaderText="创建时间" DataFormatString="{0:d}"/>
                <asp:BoundField ItemStyle-Width="17%" DataField="LastLoginTime" HeaderText="上次登录" DataFormatString="{0:d}"/>
                <asp:TemplateField HeaderText="状态" ShowHeader="False">
                    <ItemStyle Width="7%" />
                    <ItemTemplate>
                        <asp:LinkButton ID="Active" runat="server" OnClick="Active_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="删除" ShowHeader="False">
                    <ItemStyle Width="7%" />
                    <ItemTemplate>
                        <asp:LinkButton CssClass="delete" ID="Dele" Text="删除" runat="server" OnClick="GridView1_RowDeleting"
                            OnClientClick="return confirm('确定删除吗？');" />
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
    </div>

</asp:Content>
