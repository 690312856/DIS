using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_NewPassword : System.Web.UI.Page
{
    private string em, state;
    private string Code = "admin123";//解密所使用的八位的key，必须跟加密的一样
    protected void Page_Load(object sender, EventArgs e)
    {
        em = Request.QueryString["e"];
        state = (string)Request.QueryString["state"];
        if (state == "successed")
        {
            this.ErrorMessage.CssClass = "detailNotification";
            ErrorMessage.Text = "您的密码已更改,请返回登录页登录";
            this.ErrorMessage.Visible = true;
            this.LoginName.Enabled = false;
            this.Email.Enabled = false;
        }
        else if (em == null)
        {
            this.ErrorMessage.CssClass = "failureNotification";
            ErrorMessage.Text = "页面失效，请重新从邮箱打开相应的链接";
            this.ErrorMessage.Visible = true;
            this.LoginName.Enabled = false;
            this.Email.Enabled = false;
        }
        else
        {
            string email = DES.Decrypt(em, Code);
            this.Email.Text = email;
            this.Email.Enabled = false;
        }
    }
    protected void ChangePasswordButton_Click(object sender, EventArgs e)
    {
        if (this.VerificationCode.Text.ToUpper() == Session["CheckCode"].ToString().ToUpper())
        {
            if (Users.isMatch(this.LoginName.Text, this.Email.Text))
            {
                Users.changePassword(this.Email.Text, this.Password.Text);
                Response.Redirect(ResolveUrl("~/Account/NewPassword.aspx?state=successed"));
            }
            else
            {
                this.ErrorMessage.CssClass = "failureNotification";
                ErrorMessage.Text = "用户名与注册邮箱不一致";
                this.ErrorMessage.Visible = true;
            }
            // 
        }
        else
        {
            this.ErrorMessage.CssClass = "failureNotification";
            ErrorMessage.Text = "验证码错误，请重新输入";
            this.ErrorMessage.Visible = true;
        }
    }
}