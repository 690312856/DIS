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
    protected void Page_Load(object sender, EventArgs e)
    {
        this.bindData();
        

        this.ErrorMessage.Visible = false;
        if (!Page.IsPostBack)
        {
            ArrayList myArrayList = new ArrayList();
            myArrayList.Add("查看文件");
            myArrayList.Add("删除文件");
            myArrayList.Add("上传文件");
            myArrayList.Add("下载文件");
            myArrayList.Add("个人信息");
            
            permCheck.DataSource = myArrayList;
            this.createField.Visible = true;
            permCheck.DataBind();
        }
    }
    void bindData()//数据绑定
    {
        DataSet ds = DBHelper.INST.ExecuteSqlDS("SELECT * FROM [RolePermission]");
        GridView1.DataSource = ds;
        GridView1.DataKeyNames = new string[] { "ID","ReadFile","DeleteFile","UpLoad","DownLoad","ReadSelf" };
        GridView1.DataBind();
        ds.Dispose();
        if (this.GridView1.Rows.Count != 0)
        {
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                if (this.GridView1.DataKeys[i]["ReadFile"].ToString() == "True")
                {
                    ((Image)GridView1.Rows[i].FindControl("ReadFilePic")).ImageUrl = ResolveUrl("~/images/admin/true.png");
                }
                if (this.GridView1.DataKeys[i]["DeleteFile"].ToString() == "True")
                {
                    ((Image)GridView1.Rows[i].FindControl("DeleteFilePic")).ImageUrl = ResolveUrl("~/images/admin/true.png");
                }
                if (this.GridView1.DataKeys[i]["UpLoad"].ToString() == "True")
                {
                    ((Image)GridView1.Rows[i].FindControl("UpLoadPic")).ImageUrl = ResolveUrl("~/images/admin/true.png");
                }
                if (this.GridView1.DataKeys[i]["DownLoad"].ToString() == "True")
                {
                    ((Image)GridView1.Rows[i].FindControl("DownLoadPic")).ImageUrl = ResolveUrl("~/images/admin/true.png");
                }
                if (this.GridView1.DataKeys[i]["ReadSelf"].ToString() == "True")
                {
                    ((Image)GridView1.Rows[i].FindControl("ReadSelfPic")).ImageUrl = ResolveUrl("~/images/admin/true.png");
                }
            }
        }
    }
    
    protected void create_Click(object sender, EventArgs e)
    {
        if (this.roleName.Text == "")
        {
            this.ErrorMessage.CssClass = "failureNotification";
            ErrorMessage.Text = "请输入角色名！";
            this.ErrorMessage.Visible = true;
        }
        else
        {
            string str1 = "insert into RolePermission([RoleName], [ReadFile],[DeleteFile],[Upload],[DownLoad],[ReadSelf]) values ('" + this.roleName.Text
                              + "'," + permCheck.Items[0].Selected + "," + permCheck.Items[1].Selected + "," + permCheck.Items[2].Selected
                              + "," + permCheck.Items[3].Selected + "," + permCheck.Items[4].Selected + ")";

            dbObj.ExecScalar(dbObj.GetCommandStr(str1));
            Response.Redirect("~/admin/RoleManage.aspx");
        }
    }
    protected void DeleteButton_Click(object sender, EventArgs e)
    {
        int index = ((GridViewRow)(((LinkButton)sender).Parent.Parent)).RowIndex;
        string id = this.GridView1.DataKeys[index]["ID"].ToString();
        string str = "DELETE FROM [RolePermission] WHERE [ID] = " + id;
        dbObj.ExecScalar(dbObj.GetCommandStr(str));
        this.bindData();
        this.ErrorMessage.CssClass = "detailNotification";
        ErrorMessage.Text = "删除成功";
        this.ErrorMessage.Visible = true;
    }
}