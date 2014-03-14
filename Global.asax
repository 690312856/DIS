<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // 在应用程序启动时运行的代码

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  在应用程序关闭时运行的代码

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // 在出现未处理的错误时运行的代码

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // 在新会话启动时运行的代码

    }

    void Session_End(object sender, EventArgs e) 
    {
        // 在会话结束时运行的代码。 
        // 注意: 只有在 Web.config 文件中的 sessionstate 模式设置为 InProc 时，才会引发 Session_End 事件。
        // 如果会话模式设置为 StateServer 
        // 或 SQLServer，则不会引发该事件。

    }
    protected void Application_AuthenticateRequest(object sender, EventArgs e)
    {
        HttpApplication app = (HttpApplication)sender;
        HttpContext context = app.Context; //获取本次Http请求的HttpContext对象 
        if (context.Request.IsAuthenticated) //验证过的一般用户才能进行角色验证 
        {
            FormsIdentity Id = (FormsIdentity)context.User.Identity; //当前用户标识
            FormsAuthenticationTicket Ticket = Id.Ticket; //取得身份证票 
            string[] Roles = Ticket.UserData.Split(','); //将角色数据转成字符串数组,得到相关的角色信息 
            context.User = new System.Security.Principal.GenericPrincipal(Id, Roles); //重新生成带有角色信息的用户
        }
    }          
</script>
