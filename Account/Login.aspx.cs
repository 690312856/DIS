using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;


public partial class Account_Login : System.Web.UI.Page
{
    string ReturnUrl;
    protected void Page_Load(object sender, EventArgs e)
    {
        ReturnUrl = Request.QueryString["ReturnUrl"];
        if (ReturnUrl != null)
        {
            if (ReturnUrl == "process")
            {
                this.ErrorMessage.CssClass = "detailNotification";
                ErrorMessage.Text = "您的账户正在等待审核，请耐心等候";
                this.ErrorMessage.Visible = true;
            }
            else
            {
                this.ErrorMessage.CssClass = "failureNotification";
                ErrorMessage.Text = "您未登录或者你没有该地址的访问权限";
                this.ErrorMessage.Visible = true;
            }
        }
        
        HttpContext context = HttpContext.Current;
        if (context.User.Identity.Name != "")
        {
            this.ErrorMessage.CssClass = "detailNotification";
            if (string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
            {
                ErrorMessage.Text = "您已经以<strong>" + context.User.Identity.Name + "<strong>登录";
            }
            else
            {
                this.ErrorMessage.CssClass = "failureNotification";
                ErrorMessage.Text = "您未登录或者你没有该地址的访问权限";
            }
            this.ErrorMessage.Visible = true;
            this.LoginName.Enabled = false;
            this.Password.Enabled = false;
            this.LoginButton.Enabled = false;
        }
        
    }
    protected void LoginButton_Click(object sender, EventArgs e)
    {
        Users u = Users.Login(this.LoginName.Text, this.Password.Text);
        if (u != null)
        {
            switch (u.UserType)
            {
                case 0:
                    {

                        Users.SetUserSession(u, HttpContext.Current.Session);
                        Users.UpdateLastLoginDate(this.LoginName.Text);
                        FormsAuthenticationTicket authTicket;
                        authTicket = new FormsAuthenticationTicket(1, u.LoginName, DateTime.Now, DateTime.Now.AddMinutes(30), true, "0", "/");
                        string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                        HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                        if (this.RememberMe.Checked == true)
                            authCookie.Expires.AddYears(1);
                        Response.Cookies.Add(authCookie);
                        if (string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                        {
                            Response.Redirect("~/admin/Index.aspx");
                        }
                        else
                        {
                            Response.Redirect(Request.QueryString["ReturnUrl"].ToString());
                        }                        
                        break;
                    }
                case 1:
                    {
                        this.ErrorMessage.CssClass = "detailNotification";
                        ErrorMessage.Text = "用户名未被激活，请耐心等候...";
                        this.ErrorMessage.Visible = true;
                        break;
                    }
                case 2:
                    {
                        Users.SetUserSession(u, HttpContext.Current.Session);
                        Users.UpdateLastLoginDate(this.LoginName.Text);
                        FormsAuthenticationTicket authTicket;
                        authTicket = new FormsAuthenticationTicket(1, u.LoginName, DateTime.Now, DateTime.Now.AddMinutes(30), true, "2", "/");
                        string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                        HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                        if (this.RememberMe.Checked == true)
                            authCookie.Expires.AddYears(1);
                        Response.Cookies.Add(authCookie);
                        if (string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                        {
                            Response.Redirect("~/User/UserProjectManagement.aspx");
                        }
                        else
                        {
                            Response.Redirect(Request.QueryString["ReturnUrl"].ToString());
                        }  
                        break;
                    }
                case 3:
                    {
                        this.ErrorMessage.CssClass = "lockNotification";
                        ErrorMessage.Text = "该用户已被锁定，请联系管理员";
                        this.ErrorMessage.Visible = true;
                        break;
                    }
            }

        }
        else
        {
            this.ErrorMessage.CssClass = "failureNotification";
            ErrorMessage.Text = "用户名不存在或用户名与密码不一致";
            this.ErrorMessage.Visible = true;
        }
    }
}
