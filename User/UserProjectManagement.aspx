<%@ Page Title="我的项目" Language="C#" MasterPageFile="~/Master/UserConsole.master" AutoEventWireup="true" CodeFile="UserProjectManagement.aspx.cs" Inherits="admin_UserProjectManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
<div>
                <asp:Label ID="ErrorMessage" runat="server" Visible="False" Width="912px" 
                    BackColor="Red" ForeColor="White"></asp:Label>
            </div>
<h3>我的项目</h3>
    <br />

    <asp:GridView ID="GridView1" runat="server" DataKeyNames="OilProjectID" CellPadding="4" 
        ForeColor="#333333" GridLines="None"  Width="100%" 
        OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="True" PageSize="10" 
        AutoGenerateColumns="False" style="text-align: center">
        <Columns>
             <asp:BoundField HeaderText="项目名称" DataField="OilProjectTitle" ItemStyle-HorizontalAlign="Center"  />
             <asp:BoundField HeaderText="角色名称" DataField="RoleName" ItemStyle-HorizontalAlign="Center"  />
            <asp:TemplateField HeaderText="查看">
                <ItemStyle Width="10%"/>
                <ItemTemplate>
                    <a class="edit" href='ProjectDetail.aspx?OilProjectID=<%# Eval("OilProjectID")%>'>查看 </a>
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
</asp:Content>
