using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Collections;
using System.Configuration;
using System.Web.Security;

public partial class User_Information : System.Web.UI.Page
{
private DataSet myDS = new DataSet();
    UserClass usObj = new UserClass();
    DBClass dbObj = new DBClass();
    CommonClass ccObj = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        this.ErrorMessage.Visible = false;

        if (!Page.IsPostBack)
        {
            Data_Load();
        }
    }

    private void Data_Load()
    {
        Users u = Users.GetUserSession(HttpContext.Current.Session);
        if (u != null)
        {
            this.Name.Text = u.UserName.ToString();
            this.tbemail.Text = u.Email.ToString();
            this.tbtime.Text = u.CreateTime;
        }
        else
        {
            HttpContext context = HttpContext.Current;
            u = Users.load(context.User.Identity.Name);
            this.Name.Text = u.UserName.ToString();
            this.tbemail.Text = u.Email.ToString();
            this.tbtime.Text = u.CreateTime;
        }        
    }

    private bool EmailDetecton(string str)
    {
        string pattern = @"^[0-9a-zA-Z\.\-_]+@([a-zA-Z\.\-_]+\.)+[a-zA-Z]{2,4}$";
        RegexStringValidator rsv = new RegexStringValidator(pattern);
        try
        {
            rsv.Validate(str);
            return true;
        }
        catch
        {
            return false;
        }
    }
 
    protected void Save(object sender, EventArgs e)
    {
        HttpContext context = HttpContext.Current;
        Users u = Users.load(context.User.Identity.Name);
        this.ErrorMessage.Visible = false;
        this.ErrorMessage.CssClass = "failureNotification";
        if (this.tbemail.Text.Trim() == "" || this.tbpass.Text.Trim() == ""
            || this.tbconfirm.Text.Trim() == "")
        {
            
            ErrorMessage.Text = "请输入必要信息！";
            this.ErrorMessage.Visible = true;

            
        }
        else if(this.pass.Text!=u.Password)
        {
            ErrorMessage.Text = "原密码错误，请重新输入";
            this.ErrorMessage.Visible = true;
        }
        else if (this.tbpass.Text.Trim() != this.tbconfirm.Text.Trim())
        {
            
            ErrorMessage.Text = "密码前后不一致！";
            this.ErrorMessage.Visible = true;

           
        }

        else if (this.tbpass.Text.Trim().Length < 6 || this.tbpass.Text.Trim().Length > 16)
        {
            
            ErrorMessage.Text = "密码长度不符合要求，请输入6-16位的字符串！";
            this.ErrorMessage.Visible = true;

            
        }
        else if (!EmailDetecton(this.tbemail.Text.Trim()))
        {
            
            ErrorMessage.Text = "邮箱格式不正确！";
            this.ErrorMessage.Visible = true;

            
        }
        else
        {
            Users.changePassword(this.tbemail.Text, this.tbpass.Text);
            this.ErrorMessage.CssClass = "detailNotification";
            ErrorMessage.Text = "更改成功";
            this.ErrorMessage.Visible = true;            
        }
       
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/admin/Index.aspx");
    }
}