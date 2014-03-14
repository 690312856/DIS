using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class AdminIndex : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string s = "select count(*) from [Users] where UserType = 1" ;
        var r = DBHelper.INST.ExecuteSqlDR(s);
        int count=0;
        if(r.Read())
        {
            count = Convert.ToInt32(r[0]);
        }
        if (count == 0)
        {
            this.b1.Visible = false;
        }
        else
        this.linkButton.Text = count.ToString();
        s = "select count(*) from [Users]";
        r = DBHelper.INST.ExecuteSqlDR(s);
        if (r.Read())
        {
            count = Convert.ToInt32(r[0]);
        }
        this.num.Text = count.ToString();
        s = "select count(*) from [OilProject]";
        r = DBHelper.INST.ExecuteSqlDR(s);
        if (r.Read())
        {
            count = Convert.ToInt32(r[0]);
        }
        this.num2.Text = count.ToString();
         Users u = Users.GetUserSession(HttpContext.Current.Session);
        if (u != null)
        {
            this.time.Text = u.LastLoginTime;
        }
        else
        {
            HttpContext context = HttpContext.Current;
            u = Users.load(context.User.Identity.Name);
            this.time.Text = u.LastLoginTime;
        }
        r.Close();
    }
}
