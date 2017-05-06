using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SettingForms_Trainer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Common ObjCommon = new Common();

        DataTable dtemployee = ObjCommon.GetEmployee();

        ddlemployeeid.DataSource = dtemployee;
        ddlemployeeid.DataValueField = "employee_id";
        ddlemployeeid.DataTextField = "employee_name";
        ddlemployeeid.DataBind();
        ddlemployeeid.Items.Insert(0, new ListItem("-- Select --", ""));
    }
}