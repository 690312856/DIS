using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class admin_UserProject : System.Web.UI.Page
{
    DBClass dbObj = new DBClass();

    protected void Page_Load(object sender, EventArgs e)
    {
        this.ErrorMessage.Visible = false;
        if (string.IsNullOrEmpty(Request.QueryString["LoginName"]))
        {
            Response.Redirect("~/admin/UserManage.aspx");
        }
        else
        {
            this.name.Text = Request.QueryString["LoginName"].ToString();
            if (!IsPostBack)
            {
                Data_Load();

                ListItem li = new ListItem("--请选择--", "");
                this.ddlProject.Items.Insert(0, li);
                this.ddlRole.Items.Insert(0, li);

            }
        }
    }

    protected void Data_Load()
    {
        string str = "select OilProjectTitle from OilProject";
        DataTable ds = dbObj.GetDataSet(dbObj.GetCommandStr(str), "OilProject");
        ddlProject.DataSource = ds;
        ddlProject.DataTextField = "OilProjectTitle";

        ddlProject.DataBind();

        string str1 = "select RoleName from RolePermission";
        DataTable ds1 = dbObj.GetDataSet(dbObj.GetCommandStr(str1), "RolePermission");
        ddlRole.DataSource = ds1;
        ddlRole.DataTextField = "RoleName";
        ddlRole.DataBind();

    }

    protected void addProject_Click(object sender, EventArgs e)
    {
        if (this.ddlProject.SelectedValue == "" || this.ddlRole.SelectedValue == "")
        {
            this.ErrorMessage.CssClass = "failureNotification";
            ErrorMessage.Text = "请填写\"项目名称\"及\"项目角色\"";
            this.ErrorMessage.Visible = true;
        }
        else
        {
            string sql = "select * from UPR where ProjectName = '" + this.ddlProject.SelectedValue + "' AND UserName = '" +
                    Request.QueryString["LoginName"] + "' AND RoleName= '" + this.ddlRole.SelectedValue + "'";
             var r = DBHelper.INST.ExecuteSqlDR(sql);
             if (!r.Read())
             {
                 string str = "insert into UPR (ProjectName, UserName, RoleName) values ('" + this.ddlProject.SelectedValue + "','" +
                    Request.QueryString["LoginName"] + "','" + this.ddlRole.SelectedValue + "')";
                 dbObj.ExecNonQuery(dbObj.GetCommandStr(str));
                 GridView1.DataBind();
                 this.ErrorMessage.CssClass = "detailNotification";
                 ErrorMessage.Text = "添加成功";
                 this.ErrorMessage.Visible = true;
             }
             else
             {
                 this.ErrorMessage.CssClass = "failureNotification";
                 ErrorMessage.Text = "该用户已在选择项目中担任了所选的角色";
                 this.ErrorMessage.Visible = true;
             }
        }
    }

    protected void DataBound_click(object sender, GridViewRowEventArgs e)
    {

    }
    protected void Dele_Click(object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        GridViewRow row = btn.Parent.Parent as GridViewRow;
        CheckBox cbox = (CheckBox)row.FindControl("CheckBox1");
        cbox.Checked = true;
        for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
        {
            CheckBox cbox1 = (CheckBox)GridView1.Rows[i].FindControl("checkBox1");
            if (cbox1.Checked == true)
            {
                string sqlstr = "delete from [UPR] where ID=" + Convert.ToInt32(GridView1.DataKeys[i].Value);
                dbObj.ExecNonQuery(dbObj.GetCommandStr(sqlstr));
                GridView1.DataBind();
            }
        }
        this.ErrorMessage.CssClass = "detailNotification";
        ErrorMessage.Text = "删除成功";
        this.ErrorMessage.Visible = true;
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
   
}