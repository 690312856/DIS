using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_ChangePassword : System.Web.UI.Page
{
    private string Code = "admin123";//加密所使用的八位的key
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["state"] == "successed")
        {
            this.ErrorMessage.CssClass = "detailNotification";
            ErrorMessage.Text = "一封验证邮件已经发送到你的邮箱，请登陆你的邮箱查看更改密码";
            this.ErrorMessage.Visible = true;
            this.LoginName.Enabled = false;
            this.Email.Enabled = false;
        }
    }
    protected void ChangePasswordButton_Click(object sender, EventArgs e)
    {

        if (this.VerificationCode.Text.ToUpper() == Session["CheckCode"].ToString().ToUpper())
        {
            if (Users.isMatch(this.LoginName.Text, this.Email.Text))
            {
                Users u = Users.load(this.LoginName.Text);
                string url = HttpContext.Current.Request.Url.Host + "/Account/NewPassword.aspx?e=" + (DES.Encrypt(u.Email, Code));
                string msg = "<p>请点击<a href=\"" + url + "\">此处</a>更改你的密码，或者点击以下网址:</p><br>" + url;
                Mail.SendMail(this.Email.Text, "DIS网站:修改密码", msg);
                Response.Redirect(ResolveUrl("~/Account/ChangePassword.aspx?state=successed"));
            }
            else
            {
                this.ErrorMessage.CssClass = "failureNotification";
                ErrorMessage.Text = "用户名不存在或邮箱跟用户名不一致";
                this.ErrorMessage.Visible = true;
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
