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
using System.Xml.Linq;
using System.Xml;
using System.Web.Caching;

public partial class admin_UserProjectManagement : System.Web.UI.Page
{
    int pageSize = 10;
    int pageIndex = 1;
    string username = "liang";
    protected PageResult result;
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Session["UserID"] == null)
        //{
        //    ErrorMessage.Text = "请先登录！";
        //    this.ErrorMessage.Visible = true;
        //    this.AddProject.Enabled = false;
        //    this.Button1.Enabled = false;
        //    this.Button2.Enabled = false;
        //    this.Button5.Enabled = false;
        //    this.Button6.Enabled = false;
        //    return;
        //}
        //if (Session["UserName"].ToString() != "lin")
        //{
        //    ErrorMessage.Text = "非管理员用户只能浏览项目，无权进行修改！";
        //    this.ErrorMessage.Visible = true;
        //    this.AddProject.Enabled = false;
        //    this.Button1.Enabled = false;
        //    this.Button2.Enabled = false;
        //    this.Button5.Enabled = false;
        //    this.Button6.Enabled = false;

        //    //this.LinkButton1.Enabled = false;
        //}
        if (!IsPostBack)
        {
           // DataSet ds = DBHelper.INST.ExecuteSqlDS("select * from OilProjectDirection where IsDelete = 0 ");
            // 为控件绑定数据源，必须是表 
            bindData();
         //   ds.Dispose();
        }
    }

    void bindData()
    {
        InitPage();
        if (Request["p"] != null)
            pageIndex = Convert.ToInt32(Request["p"]);
        else
            pageIndex = 1;

        DataPager p = new ExclusiveDataPager();
        HttpContext context = HttpContext.Current;
        //result = p.PageData(pageIndex, pageSize, "OilProject INNER JOIN UPR ON OilProject.OilProjectTitle = UPR.ProjectName", "*", "OilProjectID", ("UPR.UserName='"+username+"'"), "asc");
        Users u = Users.load(context.User.Identity.Name);
        string dsStr = "select top 10 * from OilProject INNER JOIN UPR ON OilProject.OilProjectTitle = UPR.ProjectName where (UPR.UserName='" + u.UserName + "' and IsDelete=0) order by OilProjectID asc"; //"select * from OilProject where IsDelete=" + 0;
        DataSet ds = DBHelper.INST.ExecuteSqlDS(dsStr);

        GridView1.DataSource = ds;//result1.Result;
        GridView1.DataBind();
        ds.Dispose();

    }
    private void InitPage()
    {
        //CheckBox CheckBox2 = (CheckBox)GridView1.HeaderRow.FindControl("CheckBox2");
        //CheckBox2.Checked = false;
        for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
        {
            CheckBox cbox = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
            cbox.Checked = false;
        }

    }

    protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox CheckBox2 = (CheckBox)GridView1.HeaderRow.FindControl("CheckBox2");
        for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
        {
            CheckBox cbox = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
            if (CheckBox2.Checked == true)
            {
                cbox.Checked = true;
            }
            else
            {
                cbox.Checked = false;
            }
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bindData();
    }
    protected void ProjectNameEdit_Click(object sender, EventArgs e)
    {
        Response.Redirect("ProjectName.aspx");
    }
}