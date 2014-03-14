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
using System.IO;


public partial class User_UserProjectDoc : System.Web.UI.Page
{ 
    public static int pid = 0;
    DBClass dbObj = new DBClass();
    CommonClass ccObj = new CommonClass();
    string userName;
    static string ProjectTitle;
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext context = HttpContext.Current;
        Users u= Users.load(context.User.Identity.Name);
        userName = u.UserName;
        this.ErrorMessage.Visible = false;
        //this.ErrorMessage.Visible = false;
        if (!IsPostBack)
        {
            pid = Convert.ToInt32(Request["OilProjectID"]);
            string s = "select OilProjectTitle from [OilProject] where OilProjectID = " + pid + "";
            var r = DBHelper.INST.ExecuteSqlDR(s);
            if (r.Read())
            {
                this.projectname.Text = Convert.ToString(r[0]);
                ProjectTitle = Convert.ToString(r[0]);
                this.Title = Convert.ToString(r[0]);
            }
            func();
            bindData();
        }
    }
    void bindData()
    {
        string str = "select * from File where ProjectName = '" + ProjectTitle + "'";
        DataSet ds = DBHelper.INST.ExecuteSqlDS(str);
        this.GridView2.DataSource = ds;
        GridView2.DataBind();
        ds.Dispose();
    }
    protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView2.PageIndex = e.NewPageIndex;
        bindData();
    }
    protected void myFile_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void myFileDelete(object sender, GridViewDeleteEventArgs e)
    {
        this.ErrorMessage.Visible = false;

        string str1 = "select RoleName from UPR where UserName = '" + userName + "' and ProjectName = '" + ProjectTitle + "'";
        DataTable role = dbObj.GetDataSet(dbObj.GetCommandStr(str1), "UPR");
        int j;
        for (j = 0; j < role.Rows.Count; j++)
        {
            string str3 = "select DeleteFile from RolePermission where RoleName = '" + role.Rows[0][j] + "'";
            if (dbObj.ExecScalar(dbObj.GetCommandStr(str3)) == "True")
            {
                break;
            }
        }

        if (j == role.Rows.Count)
        {
            this.ErrorMessage.CssClass = "failureNotification";
            ErrorMessage.Text = "你没有删除文件的权限！";
            this.ErrorMessage.Visible = true;

            return;
        }
        string s = "select * from File where ID=" + Convert.ToInt32(GridView2.DataKeys[e.RowIndex].Value.ToString());
        var r = DBHelper.INST.ExecuteSqlDR(s);
        if (r.Read())
        {
            System.IO.File.Delete(Server.MapPath(r["FileURL"].ToString()));//删除
        }

        string str = "delete from File where ID = " + Convert.ToInt32(GridView2.DataKeys[e.RowIndex].Value.ToString());
        dbObj.ExecNonQuery(dbObj.GetCommandStr(str));
        this.bindData();
        this.ErrorMessage.CssClass = "detailNotification";
        ErrorMessage.Text = "删除成功！";
        this.ErrorMessage.Visible = true;
    }

    protected void downLoad(object sender, GridViewCommandEventArgs e)
    {
        this.ErrorMessage.Visible = false;

        string str1 = "select RoleName from UPR where UserName = '" + userName + "' and ProjectName = '" + ProjectTitle
           + "'";
        DataTable role = DBHelper.INST.ExecuteSqlDS(str1).Tables[0];
        int j;
        for (j = 0; j < role.Rows.Count; j++)
        {
            string str3 = "select DownLoad from RolePermission where RoleName = '" + role.Rows[0][j] + "'";
            if (dbObj.ExecScalar(dbObj.GetCommandStr(str3)) == "True")
            {
                break;
            }
        }

        if (j == role.Rows.Count)
        {
            this.ErrorMessage.CssClass = "failureNotification";
            ErrorMessage.Text = "你没有下载文件的权限！";
            this.ErrorMessage.Visible = true;
            return;
        }

        if (e.CommandName == "dlCommand")
        {
            string FullFileName = e.CommandArgument.ToString();
            FileInfo info = new FileInfo(FullFileName);
            Response.Clear();
            Response.ClearHeaders();
            Response.Buffer = false;
            Response.ContentType = "application/octet-stream";
            Response.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(info.Name, System.Text.Encoding.UTF8).Replace("+", "%20"));
            //Response.AppendHeader("Content-Length", info.Length.ToString());
            Response.WriteFile(FullFileName);
            Response.Flush();
            Response.End();
            //Response.Redirect("Default.aspx");
        }
    }

    private void func()
    {
        this.ErrorMessage.Visible = false;
        
        string str = "select ProjectName from UPR where UserName = '" + userName + "'";
        DataTable proName = dbObj.GetDataSet(dbObj.GetCommandStr(str), "UPR");
        int i;
        for (i = 0; i < proName.Rows.Count; i++)
        {
            if (proName.Rows[i][0].ToString() == ProjectTitle)
                break;
        }


        if (i == proName.Rows.Count)
        {

            ErrorMessage.Text = "不是你所属的项目，因此无法打开！";
            this.ErrorMessage.CssClass = "failureNotification";
            this.ErrorMessage.Visible = true;

            return;
        }

        string str1 = "select RoleName from UPR where UserName = '" + userName + "' and ProjectName = '" + ProjectTitle
            + "'";
        DataTable role = dbObj.GetDataSet(dbObj.GetCommandStr(str1), "UPR");
        for (int j = 0; j < role.Rows.Count; j++)
        {
            string str3 = "select ReadFile from RolePermission where RoleName = '" + role.Rows[0][j] + "'";
            if (dbObj.ExecScalar(dbObj.GetCommandStr(str3)) == "True")
            {
                return;
            }
        }
        this.ErrorMessage.CssClass = "failureNotification";
        ErrorMessage.Text = "你没有查看文件的权限！";
        this.ErrorMessage.Visible = true;


    }
    protected void uploadClk_Click1(object sender, EventArgs e)
    {
        this.ErrorMessage.Visible = false;

        string str1 = "select RoleName from UPR where UserName = '" + userName + "' and ProjectName = '" + ProjectTitle
           + "'";
        DataTable role = dbObj.GetDataSet(dbObj.GetCommandStr(str1), "UPR");
        int j;
        for (j = 0; j < role.Rows.Count; j++)
        {
            string str3 = "select UpLoad from RolePermission where RoleName = '" + role.Rows[0][j] + "'";
            if (dbObj.ExecScalar(dbObj.GetCommandStr(str3)) == "True")
            {
                break;
            }
        }

        if (j == role.Rows.Count)
        {

            ErrorMessage.Text = "你没有上传文件的权限！";
            this.ErrorMessage.CssClass = "failureNotification";
            this.ErrorMessage.Visible = true;

            return;
        }
        string save = "~/File/" + ProjectTitle + "/";
        string savePath = Server.MapPath(save);
        

        if (!Directory.Exists(savePath)) //如果文件夹不存在则创建
        {
            Directory.CreateDirectory(savePath);

        }

        if (FileUpload1.HasFile)
        {
            int i = 0;
            string filename = FileUpload1.FileName;
            savePath += filename;
            string save1 = savePath;
                     
            while (File.Exists(save1))
            {
                i++;
                save1 = Path.GetDirectoryName(savePath) + "/" + Path.GetFileNameWithoutExtension(savePath) + "(" + i + ")" + Path.GetExtension(savePath);
            }
            FileUpload1.SaveAs(save1);
            this.ErrorMessage.CssClass = "detailNotification";
            ErrorMessage.Text = "上传成功！";//文件类型:" + FileUpload1.PostedFile.ContentType + FileUpload1.PostedFile.ContentLength;
            this.ErrorMessage.Visible = true;
            // Response.Write(FileUpload1.PostedFile.ContentType + FileUpload1.PostedFile.ContentLength + "<br>");

            string str = "insert into File(FileName, FileURL, ProjectName, UserName, Description, CreateTime) values ( '" + Path.GetFileName(save1) + "','" + save + Path.GetFileName(save1) + "','"
                + ProjectTitle + "','" + userName + "','a new file', date())";
            dbObj.ExecNonQuery(dbObj.GetCommandStr(str));
            bindData();//Response.Redirect("UserProjectDoc.aspx?OilProjectID=" + pid);
            
        }
        else
        {
            this.ErrorMessage.CssClass = "failureNotification";
            ErrorMessage.Text = "请选择文件！";
            this.ErrorMessage.Visible = true;
        }
    }
    protected void searchBtn_Click(object sender, EventArgs e)
    {
        string key = this.searchBox.Text.Trim();
        string str = "select * from File where ProjectName = '" + ProjectTitle + "' and (FileName like '%" + key + "%' or UserName like '%"+key+"%')";
        DataSet ds = DBHelper.INST.ExecuteSqlDS(str);
        GridView2.DataSource = ds;
        GridView2.DataBind();
        ds.Dispose();
    }
}