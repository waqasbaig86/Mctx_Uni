using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HMS_ShiftManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Common ObjCommon = new Common();

        DataTable dtEmployeeName = ObjCommon.GetEmpl();

        DataTable dtdepartment = ObjCommon.GetDepartments();

        ddlDepartment.DataSource = dtdepartment;
        ddlDepartment.DataValueField = "department_id";
        ddlDepartment.DataTextField = "department_name";
        ddlDepartment.DataBind();        

        DataTable dtShift = ObjCommon.GetShift();

        ddlShifts.DataSource = dtShift;
        ddlShifts.DataValueField = "shift_id";
        ddlShifts.DataTextField = "shift_name";
        ddlShifts.DataBind();
        

        ddlChangeShift.DataSource = dtShift;
        ddlChangeShift.DataValueField = "shift_id";
        ddlChangeShift.DataTextField = "shift_name";
        ddlChangeShift.DataBind();
        
    }
}