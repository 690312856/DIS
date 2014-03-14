using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml; 

public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected string[] titleName = new string[7];  // 记录目录标题名
    protected string[] titleUrl = new string[7];  // 记录目录标题的路径
    protected string[] buttonImage = new string[13];// 图标的路径
    protected string[] buttonImageUrl = new string[13];// 图标的路径
    protected void Page_Load(object sender, EventArgs e)
    {
        /*
         *  载入 Footer.xml 文件
         *  加载轮转图片与页脚
         */
        if (!IsPostBack)
        {
            this.LoginText.Text = "<a href=\"" + ResolveUrl("~/Account/Login.aspx") + "\"><strong>登录</strong></a>";
            this.RegisterText.Text = "<a href=\"" + ResolveUrl("~/Account/Register.aspx") + "\"><strong>注册</strong></a>";
            HttpContext context = HttpContext.Current;
            if (context.User.Identity.Name != "")
            {
                if (context.User.IsInRole("0"))
                    this.LoginText.Text = "<a href=\"" + ResolveUrl("~/admin/Index.aspx") + "\"><strong>" + context.User.Identity.Name + "</strong></a>";
                else
                    this.LoginText.Text = "<a href=\"" + ResolveUrl("~/User/UserProjectManagement.aspx") + "\"><strong>" + context.User.Identity.Name + "</strong></a>";
                this.RegisterText.Text = "<a href=\"" + ResolveUrl("~/Account/Logout.aspx") + "\"><strong>退出</strong></a>";
            }
        }
        XmlDocument document = new XmlDocument();           
        document.Load(Server.MapPath("~/Footer.xml"));
        Footer.DataSource = document.DocumentElement.SelectSingleNode("footer").ChildNodes;
        Footer.DataBind();

        /*
         * 利用 Footer.xml 文件 更新 titleName 与 titleUrl 
         */
        XmlNode titleNode = document.DocumentElement.SelectSingleNode("footer").SelectSingleNode("catalogue");
        titleName[0] = titleNode.Attributes["value"].Value;
        titleUrl[0] = ResolveUrl(titleNode.Attributes["url"].Value);
        for (int i = 1; i <= 5; i++)
        {
            titleNode = titleNode.NextSibling;
            titleName[i] = titleNode.Attributes["value"].Value;
            titleUrl[i] = ResolveUrl(titleNode.Attributes["url"].Value);
        }

        XmlNode titleNode3 = document.DocumentElement.SelectSingleNode("buttons").SelectSingleNode("//buttonImage[@id='1']").SelectSingleNode("item");
        buttonImage[0] = ResolveUrl(titleNode3.InnerText);
        buttonImageUrl[0] = ResolveUrl(titleNode3.Attributes["url"].Value);
        for (int i = 1; i <= 12; i++)
        {
            titleNode3 = titleNode3.NextSibling;
            buttonImage[i] = ResolveUrl(titleNode3.InnerText);
            buttonImageUrl[i] = ResolveUrl(titleNode3.Attributes["url"].Value);
        }


        // 绑定数据，公司名与链接
        titleNode = titleNode.ParentNode.ParentNode.SelectSingleNode("Company");
        titleName[6] = titleNode.Attributes["value"].Value;
        titleUrl[6] = ResolveUrl(titleNode.Attributes["url"].Value);

        // 绑定公司名页脚下的Repeater控件
        Company.DataSource = document.DocumentElement.SelectSingleNode("Company").ChildNodes;
        Company.DataBind();
    }
}
