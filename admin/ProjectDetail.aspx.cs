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
/// <summary>
/// 输入后清空为解决，提示语没有，缺乏删除按钮，布局问题，错误提示
/// </summary>
public partial class User_ProjectDetail : System.Web.UI.Page
{
    public int pid=0;
    DBClass dbObj = new DBClass();
    CommonClass ccObj = new CommonClass();

    protected void Page_Load(object sender, EventArgs e)
    {
        pid = Convert.ToInt32(Request["OilProjectID"]);
        this.ErrorMessage.Visible = false;
        if (!IsPostBack)
        {
            string s = "select OilProjectTitle from [OilProject] where OilProjectID = "+pid+"";
            var r = DBHelper.INST.ExecuteSqlDR(s);
            if (r.Read())
            {
                this.projectname.Text = Convert.ToString(r[0]);
                this.Title = Convert.ToString(r[0]);
            }
            r.Dispose();
            
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
        string str = "select top 6 UserName +' '+ '(' + LoginName +')' as clUser from Users ";//////////////////////////////////////////////
        //DataTable d2 = dbObj.GetDataSet(dbObj.GetCommandStr(str), "Users");
        DataSet d2 = DBHelper.INST.ExecuteSqlDS(str);
            this.clistUser.DataSource = d2;
            this.clistUser.DataTextField = "clUser";
            this.clistUser.DataBind();
        ds.Dispose();
        d2.Dispose();
        
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bindData();
    }
    protected void tbUserSearch_TextChanged(object sender, EventArgs e)
    {
        string key = this.tbUserSearch.Text.Trim();
        string str = "select UserName +' '+ '(' + LoginName +')' as clUser from Users where (LoginName like '%" + key + "%' or UserName like '%" + key + "%' ) ";
        DataTable ds = dbObj.GetDataSet(dbObj.GetCommandStr(str), "Users");
        if (ds.Rows.Count > 0)
        {
            this.clistUser.DataSource = ds;
            clistUser.DataBind();
        }
        else
        {
            this.ErrorMessage.Text = "不存在该用户";
            this.ErrorMessage.CssClass = "failureNotification";
            this.ErrorMessage.Visible = true;
        }
        ds.Dispose();
    }
    protected void addMember_Click(object sender, EventArgs e)
    {
        Boolean bit = false;
        this.ErrorMessage.Visible = false;
        for (int i = 0; i < clistUser.Items.Count; i++)
            for (int j = 0; j < cblistRole.Items.Count; j++)
            {
                if (clistUser.Items[i].Selected && cblistRole.Items[j].Selected)
                {
                    string s = "select UserName from Users where UserName = '" + clistUser.Items[i].Text.Substring(0,clistUser.Items[i].Text.IndexOf("(")) + "'";
                    var r = DBHelper.INST.ExecuteSqlDR(s);
                    if (r.Read())
                    {
                        s= Convert.ToString(r[0]);
                    }
                    string str = "insert into UPR(ProjectName, UserName, RoleName)values('" + this.projectname.Text
                        + "','" + s + "','" + cblistRole.Items[j].Text + "')";
                    dbObj.ExecNonQuery(dbObj.GetCommandStr(str));
                    r.Dispose();
                    this.ErrorMessage.CssClass = "detailNotification";
                    ErrorMessage.Text = "成功添加项目角色信息！";
                    this.ErrorMessage.Visible = true;
                    bit = true;
                 
                }
            }
        if (!bit)
        {
            this.ErrorMessage.CssClass = "failureNotification";
            ErrorMessage.Text = "未选择角色或人员！";
            this.ErrorMessage.Visible = true;
        }
        else
        {
            cblistRole.ClearSelection();
        }
        bindData();
    }
    protected void RowDelete_Click(object sender, GridViewDeleteEventArgs e)
    {
        this.ErrorMessage.Visible = false;
        string str = "Delete from UPR where ID = " + GridView1.DataKeys[e.RowIndex].Value.ToString();
        dbObj.ExecNonQuery(dbObj.GetCommandStr(str));
        bindData();
        this.ErrorMessage.CssClass = "detailNotification";
        ErrorMessage.Text = "删除成功！";
        this.ErrorMessage.Visible = true;
    }
}