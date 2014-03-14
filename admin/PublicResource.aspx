<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PublicResource.aspx.cs" Inherits="User_PublicResource" MasterPageFile="~/Master/AdminConsole.master" Title="公共资源" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <h3><a href="<%=ResolveUrl("~/admin/Index.aspx") %>">首页</a><small>></small><a href="<%=ResolveUrl("~/admin/PublicResource.aspx") %>">公共资源</a></h3>
    <div>
        <asp:Label ID="ErrorMessage" runat="server" Visible="False" Width="771px"></asp:Label>
    </div>
    <div style="float: left; margin-top: 10px; margin-left: 10px;">
        <h4 style="width:300px">资源文件:</h4>
    <div>
        <asp:TextBox ID="searchBox" runat="server" style="float:left; margin-left: 325px;margin-top:1px;height:22px;"></asp:TextBox><asp:Button ID="searchBtn" runat="server" Text="搜索" OnClick="searchBtn_Click" Width="47" Height="25" />
    </div>
    <asp:GridView ID="GridView2"
        runat="server" CellPadding="3"
        AutoGenerateColumns="False" OnRowDeleting="myFileDelete"
        OnRowCommand="downLoad"
        OnPageIndexChanging="GridView2_PageIndexChanging"
        DataKeyNames="ID" BackColor="#DEBA84" AllowPaging="True" PageSize="10"
        BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellSpacing="2"
        Width="508px">
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
        <Columns>
            <asp:BoundField DataField="FileName" HeaderText="文件名" />
            <asp:BoundField DataField="UserName" HeaderText="创建者"
                SortExpression="UserName"></asp:BoundField>

            <asp:BoundField DataField="CreateTime" HeaderText="创建时间"
                SortExpression="CreateTime"></asp:BoundField>
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <asp:LinkButton ID="TestLinkBtn" runat="server"
                        CommandName="dlCommand"
                        CommandArgument='<%# Eval("FileURL")%>'
                        Text="下载"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="操作">
            <ItemTemplate>
                 <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Delete"    Text="删除" OnClientClick="javascript:return confirm('真的要删除吗？');"></asp:LinkButton>
           </ItemTemplate>
            </asp:TemplateField>
            <%--<asp:CommandField ShowDeleteButton="True" HeaderText="操作" DeleteText="删除"/>--%>
        </Columns>
    </asp:GridView>
    </div>
    <div style="float: right; margin-top: 10px; margin-right: 50px;">
        <h4>上传资料:</h4>
        <div  style="margin-top:20px">
            <asp:FileUpload ID="FileUpload1" runat="server" Height="30px" Width="200px" />
        </div>
        <div>
            <asp:Button ID="uploadClk" runat="server" Text="上传" OnClick="uploadClk_Click1"
                Height="22px" Width="40px" />
        </div>
    </div>
</asp:Content>
