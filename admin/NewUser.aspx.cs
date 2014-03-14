using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class Account_NewUser : System.Web.UI.Page
{
    private string Code;
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void CreateUserButton_Click(object sender, EventArgs e)
    {
        string Username;
        string Loginname;
        string UserEmail;
        string UserPassword;
        Loginname = LoginName.Text;
        UserEmail = Email.Text;
        UserPassword = Password.Text;
        Username = UserName.Text;
        int isSuccess;
        if (Admini.Checked)
        {
            isSuccess=Users.Register(Username, UserPassword, Loginname, UserEmail, 0);
        }
        else
            isSuccess=Users.Register(Username, UserPassword, Loginname, UserEmail,2);
            switch (isSuccess)
            {
                case 1:
                    {
                        //Response.Redirect(ResolveUrl("~/admin/ADUser.aspx"));
                        this.ErrorMessage.Text = "添加成功";
                        this.ErrorMessage.CssClass = "detailNotification";
                        this.ErrorMessage.Visible = true;
                        break;
                    }
                case 0:
                    {
                        this.ErrorMessage.CssClass = "failureNotification";
                        ErrorMessage.Text = "您输入的用户名和邮箱已存在";
                        this.ErrorMessage.Visible = true;
                        break;
                    }
                case -1:
                    {
                        this.ErrorMessage.CssClass = "failureNotification";
                        ErrorMessage.Text = "您输入的用户名已存在";
                        this.ErrorMessage.Visible = true;
                        break;
                    }
                case -2:
                    {
                        this.ErrorMessage.CssClass = "failureNotification";
                        ErrorMessage.Text = "您输入的邮箱已存在";
                        this.ErrorMessage.Visible = true;
                        break;
                    }
            }
        

    }

}


