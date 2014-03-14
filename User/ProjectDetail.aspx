<%@ Page Title="" Language="C#" MasterPageFile="~/Master/UserConsole.master" AutoEventWireup="true" CodeFile="ProjectDetail.aspx.cs" Inherits="User_ProjectDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style>
        .panel { overflow:auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <h3><a href="<%=ResolveUrl("~/User/UserProjectManagement.aspx") %>">我的项目</a><small>></small><asp:Label ID="projectname" runat="server"></asp:Label></h3>
    <div style="color:black; position:absolute;top:64px; left:221px; width:100px;height:24px;border:1px solid rgb(187, 187, 187);border-right:none; border-bottom:none;background-color:#FFFFFF;text-align:center;">项目概述</div>
    <a href='UserProjectDoc.aspx?OilProjectID=<%Response.Write(pid.ToString());%>'><div style="color:white; position:absolute;top:64px; left:320px; width:100px;height:23px;border:1px solid rgb(187, 187, 187);border-bottom:none;background-color:#366B6B;text-align:center;">文件管理</div></a>
    <div id="container" style=" margin-top:38px; margin-left: 5px; width: 800px; height: 437px; border-color: rgb(187, 187, 187); border-width: 1px; border-style: solid;">
        <div id="projectBrief">
            <div style="float: left; width: 470px; height: 400px; margin-left: 10px; margin-top: 25px; border-style:solid;border-width:1px;border-color:#bbbbbb">
                <p style="background-color:#366B6B;color:white; font-size:medium;font-weight:bold;">&nbsp项目简介</p>
                <div style="margin-left:10px;margin-top:2px">
              <asp:Panel ID="panelPC" Width="460px" Height="375" runat="server" CssClass="panel" BorderColor="#bbbbbb">
                  <asp:Label ID="lb" runat="server"></asp:Label>
              </asp:Panel>
                </div>
           </div>
            <div style="float:right;margin-top:25px;margin-right:20px;width:270px;">
                <asp:GridView ID="GridView1" runat="server" DataKeyNames="OilProjectID" CellPadding="3"
                    ForeColor="Black" GridLines="None" Width="100%"
                    OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="True" PageSize="10"
                    AutoGenerateColumns="False" Style="text-align: center">
                    <Columns>
<%--                        <asp:BoundField HeaderText="项目名称" DataField="OilProjectTitle" ItemStyle-HorizontalAlign="Center" />--%>
                        <asp:BoundField HeaderText="项目成员" DataField="UserName" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="担任角色" DataField="RoleName" ItemStyle-HorizontalAlign="Center" />
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
        </div>

        <div id="documentManage">
        </div>
    </div>
</asp:Content>

