using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SettingForms_AddAssignCharge : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Common ObjCommon = new Common();

        DataTable dtEmployeeName = ObjCommon.GetEmpl();

        ddlemployeename.DataSource = dtEmployeeName;
        ddlemployeename.DataValueField = "employee_id";
        ddlemployeename.DataTextField = "employee_name";
        ddlemployeename.DataBind();
        ddlemployeename.Items.Insert(0, new ListItem("-- Select --", ""));
    }
}