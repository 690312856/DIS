using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.Xml;
using System.Web.Caching;

public partial class ADUser : System.Web.UI.Page
{
    static String key;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            bindData("select * from [Users]");
            bindDroplist();
        }

        //点击清空搜索框默认值
        Search_key.Attributes.Add("OnFocus", "this.value='',this.style.color='black'");
    }
    void bindDroplist()
    {
        ChooseUser.Items.Add(new ListItem("--选择用户--", "4"));
        ChooseUser.Items.Add(new ListItem("全部用户", "0"));
        ChooseUser.Items.Add(new ListItem("未激活", "1"));
        ChooseUser.Items.Add(new ListItem("已激活", "2"));
        ChooseUser.Items.Add(new ListItem("已锁定", "3"));
    }
    void bindData(string dsStr)//数据绑定
    {
        DataSet ds = DBHelper.INST.ExecuteSqlDS(dsStr);
        GridView1.DataSource = ds;
        GridView1.DataKeyNames = new string[] { "UserID" };
        GridView1.DataBind();
        isAdministrator(dsStr);
        ds.Dispose();
    }


    protected void isAdministrator(string dsStr)//判断为管理员/普通用户/
    {
         
        LinkButton act;
        var r = DBHelper.INST.ExecuteSqlDR(dsStr);
        DataSet d = DBHelper.INST.ExecuteSqlDS(dsStr);
        HttpContext context = HttpContext.Current;
        for (int i = 0;i < GridView1.Rows.Count; i++)
        //for (int i = 0; r.Read(); i++)
        {
           // d.Tables[0].Rows[i+GridView1.PageIndex*GridView1.PageSize] 
            //int j = Convert.ToInt32(r["UserType"]);
            int j = Convert.ToInt32( d.Tables[0].Rows[i+GridView1.PageIndex*GridView1.PageSize] ["UserType"]);
            switch (j)
            {
                case 0:
                    {
                        Image cimage = (Image)GridView1.Rows[i].FindControl("isAdmin");
                        cimage.ImageUrl = ResolveUrl("~/images/admin/true.png");
                        if (context.User.Identity.Name == d.Tables[0].Rows[i + GridView1.PageIndex * GridView1.PageSize]["LoginName"].ToString())
                        {
                            LinkButton dele = (LinkButton)GridView1.Rows[i].FindControl("Dele");
                            dele.Visible = false;
                            act = (LinkButton)GridView1.Rows[i].FindControl("Active");
                            act.Visible = false;
                        }
                        else
                        {
                            LinkButton dele1 = (LinkButton)GridView1.Rows[i].FindControl("Dele");
                            dele1.Visible = true;
                            act = (LinkButton)GridView1.Rows[i].FindControl("Active");
                            act.Text = "锁定";
                            act.CssClass = "lock";
                            act.Visible = true;
                        }
                        break;

                    }
                case 1: 
                    {
                        act = (LinkButton)GridView1.Rows[i].FindControl("Active");
                        act.Text = "激活";
                        act.CssClass = "unlock";
                        break;

                    }
                case 2:
                    {
                        act = (LinkButton)GridView1.Rows[i].FindControl("Active");
                        act.Text = "锁定";
                        act.CssClass = "lock";
                        break;
                    }
                case 3:
                    {
                        act = (LinkButton)GridView1.Rows[i].FindControl("Active");
                        act.Text = "解锁";
                        act.CssClass = "unlock";
                        break;
                    }
            }

        }
        r.Close();
    }
    
    
    
    protected void GridView1_RowDeleting(object sender, EventArgs e)//删除
    {
        LinkButton btn = sender as LinkButton;
        GridViewRow row = btn.Parent.Parent as GridViewRow;
        CheckBox cbox = (CheckBox)row.FindControl("CheckBox1");
        cbox.Checked = true;
        for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
        {
            CheckBox cbox1 = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
            if (cbox1.Checked == true)
            {
                 int deleteitem=Convert.ToInt32(GridView1.DataKeys[i].Value);
              
                 bool delete = Users.removeFromUser(deleteitem);//调用ExceSQL执行删除操作
                   if (delete)
                   {
                      this.ErrorMessage.CssClass = "detailNotification";
                      ErrorMessage.Text = "删除成功";
                      this.ErrorMessage.Visible = true;
                      ChooseUser.Items.Clear();
                      bindDroplist();
                      bindData("select * from [Users]");//调用自定义方法重新绑定控件中数据
                   }
                   else
                   {
                       this.ErrorMessage.CssClass = "failureNotification";
                       ErrorMessage.Text = "删除失败";
                       this.ErrorMessage.Visible = true;
                   }
            }
        }
       

    }


    protected void Active_Click(object sender, EventArgs e)
    {
        LinkButton act = sender as LinkButton;
        int changeKind = -1;
        GridViewRow row = act.Parent.Parent as GridViewRow;
        CheckBox cbox = (CheckBox)row.FindControl("CheckBox1");
        cbox.Checked = true;
        for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
        {
            CheckBox cbox1 = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
            if (cbox1.Checked == true)
            {
                 changeKind = Convert.ToInt32(GridView1.DataKeys[i].Value);
            }
        }
        if (act.Text.Equals("激活")) 
        {
            Users.udUserkind(2, changeKind);
            this.ErrorMessage.CssClass = "detailNotification";
            ErrorMessage.Text = "激活成功";
            this.ErrorMessage.Visible = true;
        }
        if (act.Text.Equals("锁定"))
        {
            Users.udUserkind(3, changeKind);
            this.ErrorMessage.CssClass = "detailNotification";
            ErrorMessage.Text = "锁定成功";
            this.ErrorMessage.Visible = true;
        }
        if (act.Text.Equals("解锁"))
        {
            Users.udUserkind(2, changeKind);
            this.ErrorMessage.CssClass = "detailNotification";
            ErrorMessage.Text = "解锁成功";
            this.ErrorMessage.Visible = true;
        }
        if (ChooseUser.SelectedIndex != 1 && ChooseUser.SelectedIndex != 0)
        {
            String sd = "select * from [Users] where UserType = " + ChooseUser.SelectedValue;
            DataSet ds1 = DBHelper.INST.ExecuteSqlDS(sd);
            GridView1.DataSource = ds1;
            GridView1.DataBind();
            ds1.Dispose();
            bindData(sd);
        }
         else if(key!=null)
        {
            bindData("select * from [Users] where [LoginName] like '" + key + "' or [UserName] like '" + key + "'");
        }
        else
        {
            bindData("select * from [Users]");
        }
    }
    protected void Search_Click(object sender, EventArgs e)
    {
            ChooseUser.SelectedIndex = 0;
            key = Search_key.Text;
            String sd = "select * from [Users] where [LoginName] like '%" + key + "%' or [UserName] like '%" + key + "%'";
            DataSet ds1 = DBHelper.INST.ExecuteSqlDS(sd);
            if (ds1.Tables.Count > 0 && ds1.Tables[0].Rows.Count > 0)
            {
                this.ErrorMessage.Visible = false;
            }
            else
            {
                this.ErrorMessage.Visible = true;
                this.ErrorMessage.CssClass = "failureNotification";
                this.ErrorMessage.Text = "不存在该用户";
            }
            bindData(sd);
            ds1.Dispose();
            this.Search_key.Text = "";
        
    }
    protected void ChooseUser_SelectedIndexChanged(object sender, EventArgs e)
    {

            key = "";
            if (ChooseUser.SelectedIndex != 1 && ChooseUser.SelectedIndex != 0)
            {
                String sd = "select * from [Users] where UserType= " + ChooseUser.SelectedValue;
                DataSet ds1 = DBHelper.INST.ExecuteSqlDS(sd);
                GridView1.DataSource = ds1;
                GridView1.DataBind();
                this.ErrorMessage.Visible = false;
                bindData(sd);
                ds1.Dispose();
            }
            else
            {
                this.ErrorMessage.Visible = false;
                bindData("select * from [Users]");
            }
        
    }
    protected void NewUser_Click(object sender, EventArgs e)
    {
        Response.Redirect("NewUser.aspx");
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        ChooseUser_SelectedIndexChanged(sender, e);
    }

    protected void EditUse_Command(object sender, CommandEventArgs e)
    {
        Response.Redirect("EditUser.aspx?name=" + e.CommandName);
    }
}