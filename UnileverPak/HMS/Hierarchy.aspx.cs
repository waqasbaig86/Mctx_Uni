using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HMS_Hierarchy : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Common ObjCommon = new Common();

        DataTable dtEmployeeName = ObjCommon.GetEmpl();

        ddlReportingPerson.DataSource = dtEmployeeName;
        ddlReportingPerson.DataValueField = "employee_id";
        ddlReportingPerson.DataTextField = "employee_name";
        ddlReportingPerson.DataBind();
        ddlReportingPerson.Items.Insert(0, new ListItem("Select", "0"));
        
        ddlChangeReportingPerson.DataSource = dtEmployeeName;
        ddlChangeReportingPerson.DataValueField = "employee_id";
        ddlChangeReportingPerson.DataTextField = "employee_name";
        ddlChangeReportingPerson.DataBind();
        ddlChangeReportingPerson.Items.Insert(0, new ListItem("Select", "0"));

        
        DataTable dtdepartment = ObjCommon.GetDepartments();

        ddlDepartment.DataSource = dtdepartment;
        ddlDepartment.DataValueField = "department_id";
        ddlDepartment.DataTextField = "department_name";
        ddlDepartment.DataBind();
        ddlDepartment.Items.Insert(0, new ListItem("Select", "0"));

        DataTable dtShift = ObjCommon.GetShift();

        ddlShifts.DataSource = dtShift;
        ddlShifts.DataValueField = "shift_id";
        ddlShifts.DataTextField = "shift_name";
        ddlShifts.DataBind();
        ddlShifts.Items.Insert(0, new ListItem("Select", "0"));
    }
}