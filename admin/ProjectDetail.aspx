<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminConsole.master" AutoEventWireup="true" CodeFile="ProjectDetail.aspx.cs" Inherits="User_ProjectDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style type="text/css">
        .panel {
            overflow:auto;
            /*overflow: scroll;*/
        }
                .detailNotification {
            margin-left: 6px;
            position: absolute;
        }

        .failureNotification {
            margin-left: 6px;
            position: absolute;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <h3><a href="<%=ResolveUrl("~/admin/Index.aspx") %>">首页</a><small>></small><a href="<%=ResolveUrl("~/admin/ProjectManage.aspx") %>">油站项目管理</a><small>></small><asp:Label ID="projectname" runat="server"></asp:Label></h3>
    <div style="color: black; position: absolute; top: 64px; left: 221px; width: 100px; height: 24px; border: 1px solid rgb(187, 187, 187); border-right: none; border-bottom: none; background-color: #FFFFFF; text-align: center;">人员管理</div>
    <a href='ProjectDoc.aspx?OilProjectID=<%Response.Write(pid.ToString());%>'>
        <div style="color: white; position: absolute; top: 64px; left: 320px; width: 100px; height: 23px; border: 1px solid rgb(187, 187, 187); border-bottom: none; background-color: #366B6B; text-align: center;">文件管理</div>
    </a>
    <div id="container" style="margin-top: 37px; margin-left: 5px; width: 800px; height: 437px; border-width: 1px; border-style: solid;">
                <div>
            <asp:Label ID="ErrorMessage" runat="server" Visible="False" Width="750px"></asp:Label>
        </div>
        <div style="float: left; margin-top: 50px; margin-left: 20px; width: 350px;">
            <h4>成员名单：</h4>
            <asp:GridView ID="GridView1" runat="server" DataKeyNames="ID" CellPadding="3"
                ForeColor="Black" GridLines="None" Width="100%"
                OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="True" PageSize="10" 
                AutoGenerateColumns="False" Style="text-align: center" OnRowDeleting="RowDelete_Click">
                <Columns>
                    <asp:BoundField HeaderText="项目成员" DataField="UserName" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField HeaderText="担任角色" DataField="RoleName" ItemStyle-HorizontalAlign="Center" />
                     <asp:TemplateField HeaderText="操作">
            <ItemTemplate>
                 <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Delete"    Text="删除" OnClientClick="javascript:return confirm('真的要删除吗？');"></asp:LinkButton>
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
        <div>
            <div style="float: right; width: 380px;margin-top:50px;height:400px;">
                <div style="float:left; height:400px">
                <h4>用户名：</h4>

                <asp:TextBox ID="tbUserSearch" runat="server" AutoPostBack="True"
                    OnTextChanged="tbUserSearch_TextChanged"></asp:TextBox><asp:Button
                        ID="Button1" runat="server" Text="搜索" />
                <asp:Panel runat="server" CssClass="panel" Height="300">
                <asp:CheckBoxList ID="clistUser" runat="server" CssClass="CheckListCss">
                </asp:CheckBoxList>
                </asp:Panel>
                </div>
                <div style="float:left;margin-left:20px;">
                <h4>角色：</h4>
                <br />
                <asp:CheckBoxList ID="cblistRole" runat="server"
                    DataSourceID="AccessDataSource3" DataTextField="RoleName"
                    DataValueField="RoleName">
                </asp:CheckBoxList>
                <br />
                    <br />
                <asp:Button ID="addMember" runat="server" Text="新增成员"
                    OnClick="addMember_Click" />
                <asp:AccessDataSource ID="AccessDataSource3" runat="server"
                    DataFile="~/App_Data/DIS.mdb"
                    SelectCommand="SELECT [RoleName] FROM [RolePermission]"></asp:AccessDataSource>

                </div>
            </div>
        </div>

        <div id="documentManage">
        </div>
    </div>
</asp:Content>

