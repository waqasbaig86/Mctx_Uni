using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EMS_Employee : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Common ObjCommon = new Common();

        DataTable dtbloodgroup = ObjCommon.GetBloodGroup();

        ddlBloodGroup.DataSource = dtbloodgroup;
        ddlBloodGroup.DataValueField = "blood_group_id";
        ddlBloodGroup.DataTextField = "blood_group_name";
        ddlBloodGroup.DataBind();
        ddlBloodGroup.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtcast = ObjCommon.GetCastee();

        ddlCaste.DataSource = dtcast;
        ddlCaste.DataValueField = "cast_id";
        ddlCaste.DataTextField = "cast_name";
        ddlCaste.DataBind();
        ddlCaste.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtsectt = ObjCommon.Getsect();

        ddlSectt.DataSource = dtsectt;
        ddlSectt.DataValueField = "sectt_id";
        ddlSectt.DataTextField = "sectt_name";
        ddlSectt.DataBind();
        ddlSectt.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtdepartment = ObjCommon.GetDepartments();

        ddlDepartment.DataSource = dtdepartment;
        ddlDepartment.DataValueField = "department_id";
        ddlDepartment.DataTextField = "department_name";
        ddlDepartment.DataBind();
        ddlDepartment.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtdesignation = ObjCommon.GetDesignationn();

        ddlDesignation.DataSource = dtdesignation;
        ddlDesignation.DataValueField = "designation_id";
        ddlDesignation.DataTextField = "designation_name";
        ddlDesignation.DataBind();
        ddlDesignation.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dteducation = ObjCommon.GetEducationn();

        ddlQualification.DataSource = dteducation;
        ddlQualification.DataValueField = "education_id";
        ddlQualification.DataTextField = "education_name";
        ddlQualification.DataBind();
        ddlQualification.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtreligion = ObjCommon.GetReligionn();

        ddlReligionid.DataSource = dtreligion;
        ddlReligionid.DataValueField = "religion_id";
        ddlReligionid.DataTextField = "religion_name";
        ddlReligionid.DataBind();
        ddlReligionid.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtemployee = ObjCommon.GetEmpl();

        ddlEmployeeReporting.DataSource = dtemployee;
        ddlEmployeeReporting.DataValueField = "employee_id";
        ddlEmployeeReporting.DataTextField = "employee_name";
        ddlEmployeeReporting.DataBind();
        ddlEmployeeReporting.Items.Insert(0, new ListItem("-- Select --", "0"));
        
        DataTable dtShift = ObjCommon.GetShift();

        ddlShift.DataSource = dtShift;
        ddlShift.DataValueField = "shift_id";
        ddlShift.DataTextField = "shift_name";
        ddlShift.DataBind();
        ddlShift.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtcity = ObjCommon.GetCity();

        ddlcity.DataSource = dtcity;
        ddlcity.DataValueField = "city_id";
        ddlcity.DataTextField = "city_name";
        ddlcity.DataBind();
        ddlcity.Items.Insert(0, new ListItem("-- Select --", ""));
        
        DataTable dtGender = ObjCommon.GetGender();

        ddlGender.DataSource = dtGender;
        ddlGender.DataValueField = "Gender_Id";
        ddlGender.DataTextField = "Gender_Name";
        ddlGender.DataBind();
        ddlGender.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtBank = ObjCommon.GetBank();

        ddlBank.DataSource = dtBank;
        ddlBank.DataValueField = "Bank_id";
        ddlBank.DataTextField = "Bank_Name";
        ddlBank.DataBind();
        ddlBank.Items.Insert(0, new ListItem("-- Select --", ""));


        DataTable dtEmployer = ObjCommon.GetEmployer();

        ddlEmployer.DataSource = dtEmployer;
        ddlEmployer.DataValueField = "company_id";
        ddlEmployer.DataTextField = "company_name";
        ddlEmployer.DataBind();
        ddlEmployer.Items.Insert(0, new ListItem("-- Select --", ""));

    }

    protected string UploadFolderPath = "~/EMS/EmployeePictures/";
    protected void FileUploadComplete(object sender, EventArgs e)
    {

        long i = 1;
        foreach (byte b in Guid.NewGuid().ToByteArray())
        {
            i *= ((int)b + 1);
        }
        string newFileName = string.Format("{0:x}", i - DateTime.Now.Ticks);


        //string filename = System.IO.Path.GetFileName(AsyncFileUpload1.FileName);

        //AsyncFileUpload1.SaveAs(Server.MapPath(this.UploadFolderPath) + newFileName + ".jpg");

        HttpCookie ActiveTabs = new HttpCookie("tabs");
        ActiveTabs.Values["url"] = newFileName;
        Response.Cookies.Add(ActiveTabs);

    }
}