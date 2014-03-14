using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
public partial class Account_Register : System.Web.UI.Page
{
    private string Code;
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext context = HttpContext.Current;
        if (context.User.Identity.Name != "")
        {
            this.ErrorMessage.CssClass = "detailNotification";
            ErrorMessage.Text = "您已经以<strong>" + context.User.Identity.Name + "<strong>登录";
            this.ErrorMessage.Visible = true;
            this.LoginName.Enabled = false;
            this.Password.Enabled = false;
            this.UserName.Enabled = false;
            this.ConfirmPassword.Enabled = false;
            this.Email.Enabled = false;
            this.CreateUserButton.Enabled = false;
            this.VerificationCode.Enabled = false;
        }
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
        if (this.VerificationCode.Text.ToUpper() == Session["CheckCode"].ToString().ToUpper())
        {
            int isSuccess = Users.Register(Username, UserPassword, Loginname, UserEmail);
            switch (isSuccess)
            {
                case 1:
                    {
                        Response.Redirect(ResolveUrl("~/Account/Login.aspx?ReturnUrl=process"));
                        break;
                    }
                case 0:
                    {
                        this.ErrorMessage.CssClass = "failureNotification";
                        ErrorMessage.Text = "您输入的用户名和邮箱已存在，是否<a href=\"ChangePassword.aspx\" style=\"color:Red\">忘记密码</a>？";
                        this.ErrorMessage.Visible = true;
                        break;
                    }
                case -1:
                    {
                        this.ErrorMessage.CssClass = "failureNotification";
                        ErrorMessage.Text = "您输入的用户名已存在，是否<a href=\"ChangePassword.aspx\" style=\"color:Red\">忘记密码</a>？";
                        this.ErrorMessage.Visible = true;
                        break;
                    }
                case -2:
                    {
                        this.ErrorMessage.CssClass = "failureNotification";
                        ErrorMessage.Text = "您输入的邮箱已存在，是否<a href=\"ChangePassword.aspx\" style=\"color:Red\">忘记密码</a>？";
                        this.ErrorMessage.Visible = true;
                        break;
                    }
            }
        }
        else
        {
            this.ErrorMessage.CssClass = "failureNotification";
            ErrorMessage.Text = "验证码错误，请重新输入";
            this.ErrorMessage.Visible = true;
        }

    }
}
