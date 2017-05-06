using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EMS_CallBack_EmployeeHandler : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DBManager ObjDBManager = new DBManager();

       
        if (Request.Form["Name"] != "")
            ObjDBManager.AddParameter("Name", Request.Form["Name"]);

        DataTable dt = ObjDBManager.ExecuteDataTable("GetEmployees", "UnileverConnectionString");

        rptEmployee.DataSource = dt;
        rptEmployee.DataBind();
    }
}