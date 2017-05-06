using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class UserManagement_Users : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("Status", true); ;
        DataTable dt = ObjDBManager.ExecuteDataTable("GetUsers", "UnileverConnectionString");

        rptUsers.DataSource = dt;
        rptUsers.DataBind();

    }
}