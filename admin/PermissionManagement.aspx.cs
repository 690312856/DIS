using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections;

public partial class RoleManage : System.Web.UI.Page
{
    DBClass dbObj = new DBClass();
    CommonClass ccObj = new CommonClass();
   // int xx = Convert.ToInt32(Request.QueryString["RoleID"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        this.ErrorMessage.Visible = false;
        this.ErrorMessage.Visible = false;
        if (!Page.IsPostBack)
        {

            string str = "select [RoleName] from RolePermission where ID = " + Request.QueryString["RoleID"].ToString();
            DataTable Rolename = dbObj.GetDataSet(dbObj.GetCommandStr(str), "RolePermission");
            this.RoleName.Text = Rolename.Rows[0][0] + "的权限";
            ArrayList myArrayList = new ArrayList();
            myArrayList.Add("查看文件");
            myArrayList.Add("删除文件");
            myArrayList.Add("上传文件");
            myArrayList.Add("下载文件");

            permCheck.DataSource = myArrayList;
            permCheck.DataBind();
            string str1 = "select[ReadFile],[DeleteFile],[Upload],[DownLoad] from  RolePermission where ID= " + Request.QueryString["RoleID"].ToString();
            DataTable fuck = dbObj.GetDataSet(dbObj.GetCommandStr(str1), "RolePermission");

            for (int i = 0; i < 4; i++)
            {
                if (Convert.ToBoolean(fuck.Rows[0][i].ToString().Trim()) == true)
                {
                    permCheck.Items[i].Selected = true;
                }
            }
            myArrayList.Clear();
            myArrayList.Add("个人信息");
            permCheck1.DataSource = myArrayList;
            permCheck1.DataBind();
            str1 = "select[ReadSelf] from  RolePermission where ID= " + Request.QueryString["RoleID"].ToString();
            DataTable fucks = dbObj.GetDataSet(dbObj.GetCommandStr(str1), "RolePermission");

            for (int i = 0; i < 1; i++)
            {
                if (Convert.ToBoolean(fucks.Rows[0][i].ToString().Trim()) == true)
                {
                    permCheck1.Items[i].Selected = true;
                }
            }
        }
       
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       

        string str1 = "update RolePermission set [ReadFile]="  + permCheck.Items[0].Selected
            +",[DeleteFile]=" + permCheck.Items[1].Selected
            +",[Upload]=" + permCheck.Items[2].Selected
            +",[DownLoad]=" + permCheck.Items[3].Selected
            +",[ReadSelf]="+ permCheck1.Items[0].Selected
            + " where ID=" + Request.QueryString["RoleID"].ToString();

        dbObj.ExecScalar(dbObj.GetCommandStr(str1));
        Response.Redirect("~/admin/PermissionManagement.aspx?RoleID=" + Request.QueryString["RoleID"].ToString());
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/admin/RoleManage.aspx");
    }
}