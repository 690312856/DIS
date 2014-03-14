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

public partial class User_ProjectDetail : System.Web.UI.Page
{
    public int pid=0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            pid = Convert.ToInt32(Request["OilProjectID"]);
            string s = "select OilProjectTitle from [OilProject] where OilProjectID = "+pid+"";
            var r = DBHelper.INST.ExecuteSqlDR(s);
            if (r.Read())
            {
                this.projectname.Text = Convert.ToString(r[0]);
                this.Title = Convert.ToString(r[0]);
            }
            
            bindData();
        }
    }
    void bindData()
    {
        //if (Request["p"] != null)
        //    pageIndex = Convert.ToInt32(Request["p"]);
        //else
        //    pageIndex = 1;

        DataPager p = new ExclusiveDataPager();
        //result = p.PageData(pageIndex, pageSize, "OilProject INNER JOIN UPR ON OilProject.OilProjectTitle = UPR.ProjectName", "*", "OilProjectID", ("UPR.UserName='"+username+"'"), "asc");
        string dsStr = "select top 10 * from OilProject INNER JOIN UPR ON OilProject.OilProjectTitle = UPR.ProjectName where (OilProject.OilProjectID="+pid+" and IsDelete=0) order by OilProjectID asc"; //"select * from OilProject where IsDelete=" + 0;
        DataSet ds = DBHelper.INST.ExecuteSqlDS(dsStr);

        GridView1.DataSource = ds;//result1.Result;
        GridView1.DataBind();
        ds.Dispose();
        string pcStr = "select OilProjectContent from OilProject INNER JOIN UPR ON OilProject.OilProjectTitle = UPR.ProjectName where (OilProject.OilProjectID=" + pid + ")";
        DataSet pcDS = DBHelper.INST.ExecuteSqlDS(pcStr);
        lb.Text= pcDS.Tables[0].Rows[0][0].ToString();
        pcDS.Dispose();
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bindData();
    }
}