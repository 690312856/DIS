<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminConsole.master" AutoEventWireup="true" CodeFile="ProjectDoc.aspx.cs" Inherits="User_UserProjectDoc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style>
        .panel {
            overflow: scroll;
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
    <a href='ProjectDetail.aspx?OilProjectID=<%Response.Write(pid.ToString());%>'>
        <div style="border: 1px solid rgb(187, 187, 187); border-right: none; color: white; position: absolute; top: 64px; left: 221px; width: 100px; height: 23px; border-bottom: none; background-color: #366B6B; text-align: center;">人员管理</div>
    </a>
    <div style="color: black; position: absolute; top: 64px; left: 320px; width: 100px; height: 24px; border: 1px solid rgb(187, 187, 187); border-bottom: none; background-color: #FFFFFF; text-align: center;">文件管理</div>
    <div id="container" style="margin-top: 37px; margin-left: 5px; width: 800px; height: 437px; border-width: 1px; border-style: solid;">
        <div>
            <asp:Label ID="ErrorMessage" runat="server" Visible="False" Width="750px"></asp:Label>
        </div>
        <div id="projectBrief" style="margin-top:30px;">


            <div style="float: left; margin-top: 25px; margin-left: 20px; width: auto; height: 350px;">
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
                        <asp:BoundField DataField="FileName" SortExpression="FileName" HeaderText="文件名" />
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
                    </Columns>
                </asp:GridView>
            </div>
            <div style="float: right; margin-top: 55px; margin-right: 40px;">
                <div>
                    <asp:FileUpload ID="FileUpload1" runat="server" Height="30px" Width="200px" />
                </div>
                <div>
                    <asp:Button ID="uploadClk" runat="server" Text="上传" OnClick="uploadClk_Click1"
                        Height="22px" Width="40px" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
