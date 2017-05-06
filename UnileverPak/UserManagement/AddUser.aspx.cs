using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
public partial class UserManagement_AddUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string Department = "";
        if (Request.QueryString["UserId"] != null)
        {
            DBManager ObjDBManager = new DBManager();
            ObjDBManager.AddParameter("@UserId", Request.QueryString["UserId"]);
            DataTable dt = ObjDBManager.ExecuteDataTable("GetUserById", "UnileverConnectionString");
            if (dt.Rows.Count > 0)
            {
                hdnUserId.Value = Request.QueryString["UserId"];
                txtFName.Value = dt.Rows[0]["firstname"].ToString();
                Department = dt.Rows[0]["address"].ToString();
                txtLName.Value = dt.Rows[0]["lastname"].ToString();
                txtPno.Value = dt.Rows[0]["city"].ToString();
                ddlRole.SelectedValue = dt.Rows[0]["RoleId"].ToString();
                txtMobileNo.Value = dt.Rows[0]["mobile"].ToString();
                txtUserName.Value = dt.Rows[0]["username"].ToString();
                txtEmail.Value = dt.Rows[0]["email"].ToString();
               // txtPassword.Attributes["type"] = "password";
                txtPassword.Value ="!#!#!#!#!#!#!#!#!#" ;//dt.Rows[0]["password"].ToString();

              //  txtPassword.Text = dt.Rows[0]["password"].ToString();
                 
            }
        }

        Common ObjCommon = new Common();

        DataTable dtDepartments = ObjCommon.GetDepartments();

        ddlDepartmentSearch.DataSource = dtDepartments;
        ddlDepartmentSearch.DataValueField = "Department_Id";
        ddlDepartmentSearch.DataTextField = "Department_Name";
        ddlDepartmentSearch.DataBind();
        ddlDepartmentSearch.Items.Insert(0, new ListItem("-- Select --", "-- Select --"));
        if (Department !="")
        ddlDepartmentSearch.SelectedItem.Text = Department;
    }

    public static Dictionary<string, object> ToJson(DataTable table)
    {
        Dictionary<string, object> j = new Dictionary<string, object>();
        j.Add(table.TableName, RowsToDictionary(table));
        return j;
    }

    private static List<Dictionary<string, object>> RowsToDictionary(DataTable table)
    {
        List<Dictionary<string, object>> objs =
            new List<Dictionary<string, object>>();
        foreach (DataRow dr in table.Rows)
        {
            Dictionary<string, object> drow = new Dictionary<string, object>();
            for (int i = 0; i < table.Columns.Count; i++)
            {
                drow.Add(table.Columns[i].ColumnName, dr[i]);
            }
            objs.Add(drow);
        }

        return objs;
    }

    #region Delete Relation
    [WebMethod]
    public static void DeleteUser(string UserID)
    {
        string query = "update dbo.users set IsActive=0 where userid='" + int.Parse(UserID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion
}