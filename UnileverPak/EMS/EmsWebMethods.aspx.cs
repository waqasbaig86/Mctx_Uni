using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.IO;


public partial class EMS_EmsWebMethods : System.Web.UI.Page
{
    static string UserID = "";
    static string CurrentDate = "";
    protected void Page_Load(object sender, EventArgs e)
    {

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

        [WebMethod]
    public static int SaveEmployee(string employeeId, string EmployeeName, string EmployeeNo, string FatherName, string EmployeeCNIC, string EmployeeAddress, string EmployeePhoneNo, string EmployeeMobile,
        string EmployeeEmail, string Gender, string EmployeeCity, string Religion, string Sectt, string Caste, string BloddGroup, 
        string EmployeeReporting, string Department, string Designation, string Shift, string Photo, string Employee_Dob, string Employee_Status)
    {
        int EmpId = int.Parse(employeeId);
        DBManager objbmanger = new DBManager();
        
        objbmanger.AddParameter("@EmployeeName", EmployeeName);
        objbmanger.AddParameter("@FatherName", FatherName);
        objbmanger.AddParameter("@EmployeeCNIC", EmployeeCNIC);
        objbmanger.AddParameter("@EmployeeAddress", EmployeeAddress);
        objbmanger.AddParameter("@EmpolyeePhone", EmployeePhoneNo);
        objbmanger.AddParameter("@EmployeeMobile", EmployeeMobile);
        objbmanger.AddParameter("@EmployeeEmail", EmployeeEmail);
        objbmanger.AddParameter("@Gender", Gender);
        objbmanger.AddParameter("@EmployeeCity", EmployeeCity);
        objbmanger.AddParameter("@Status", Employee_Status);
        objbmanger.AddParameter("@EmployeeDob", Employee_Dob);
        objbmanger.AddParameter("@EmployeeReligion", Religion);
        objbmanger.AddParameter("@EmployeeSectt", Sectt);
        objbmanger.AddParameter("@EmployeeCaste", Caste);
        objbmanger.AddParameter("@EmployeeBloodGroup", BloddGroup);
        //objbmanger.AddParameter("@EmployeeEducation", Education);
        objbmanger.AddParameter("@EmployeeReporting", EmployeeReporting);
        objbmanger.AddParameter("@EmployeeDepartment", Department);
        objbmanger.AddParameter("@EmployeeDesignation", Designation);
        objbmanger.AddParameter("@EmployeeShift", Shift);
      //  objbmanger.AddParameter("@NewPhoto", Photo);
        //objbmanger.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
        //objbmanger.AddParameter("@created_date", DateTime.Now);
        int i = 0;
        if (Photo != "")
        {
            string varFilePath = "~/EMS/EmployeePictures/";
            var imagePath = HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg");
            if (File.Exists(imagePath))
            {
                byte[] file;
                using (var stream = new FileStream(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"), FileMode.Open, FileAccess.Read))
                {
                    using (var reader = new BinaryReader(stream))
                    {
                        file = reader.ReadBytes((int)stream.Length);
                    }
                }

                objbmanger.AddParameter("@NewPhoto", file);

                // string path = "~/Pics/Image1.jpg";
                System.IO.File.Delete(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"));
                i = 1;
            }
        }
        if (EmpId == 0)
        {

            objbmanger.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            objbmanger.AddParameter("@created_date", DateTime.Now);
            objbmanger.AddParameter("@EmployeeID", EmpId, SqlDbType.Int, 4, ParameterDirection.Output);
            objbmanger.AddParameter("@EmployeeNo", EmployeeNo);
            objbmanger.InsertUpdateProcedure("AddEmployee", "UnileverConnectionString");
           // EmpId = int.Parse(objbmanger.Parameters[19 + i].Value.ToString());
        }
        else
        {
            objbmanger.AddParameter("@EmployeeID", EmpId);
            objbmanger.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            objbmanger.AddParameter("@modified_date", DateTime.Now);
            objbmanger.InsertUpdateProcedure("UpdateEmployee", "UnileverConnectionString");
        }
        return EmpId;
        //objbmanger.InsertUpdateProcedure("AddEmployee", "UnileverConnectionString");
    }
    [WebMethod]
        public static void saveAcedmic(string employeeid, string Quailification, string YearOfCompletion, string Grade, string Percentage, string School)
        {
            DBManager objacademic = new DBManager();
            objacademic.AddParameter("@EmployeeId", employeeid);
            objacademic.AddParameter("@Qualification", Quailification);
            objacademic.AddParameter("@Yearofcompletion", YearOfCompletion);
            objacademic.AddParameter("@Grade", Grade);
            objacademic.AddParameter("@percentage", Percentage);
            objacademic.AddParameter("@School_Uni", School);
            objacademic.InsertUpdateProcedure("AddEmployeeAcademic", "UnileverConnectionString");
        }
    [WebMethod]
    public static void saveFinance(string employeeid, string AccountNo, string NtnNo, string EobiNo, string Bank)
    {
        DBManager objfinance = new DBManager();
        objfinance.AddParameter("@EmployeeId", employeeid);
        objfinance.AddParameter("@AccountNo", AccountNo);
        objfinance.AddParameter("@NtnNo", NtnNo);
        objfinance.AddParameter("@EobiNo", EobiNo);
        objfinance.AddParameter("@selectbank", Bank);
        objfinance.InsertUpdateProcedure("AddEmployeeFinance", "UnileverConnectionString");
        


    }
    [WebMethod]
    public static Dictionary<string, object> getEmployeeId()
    {
        string querry = "select top 1 employee_id from tbl_employee ORDER BY employee_id DESC";
        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(querry, "RetrieveEmployeeId", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["RetrieveEmployeeId"];
        return ToJson(dt);
    }
    [WebMethod]
    #region
    public static Dictionary<string, object> getEmployeeEducation(string Employee_Edu_Id)
    {
        string Querry = @"select EE.Employee_Edu_Id,isnull(edu.education_name,'')as EducationName,isnull(edu.education_id,'')as EducationId,EE.Employee_Id,isnull(EE.Year_of_completion,'')as yearofcompletion ,EE.Grade_Cgpa
                       ,EE.Percentage,EE.School_Uni from tbl_employee_education EE
                       left join tbl_employee E on E.employee_id=EE.Employee_Id
                       left join tbl_education edu on edu.education_id=EE.Employee_Qualification where EE.Employee_Id='" + Employee_Edu_Id + "' and EE.is_deleted=0";
                       

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Querry, "EmployeeEducation", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["EmployeeEducation"];
        return ToJson(dt);
    }
    
    [WebMethod]
    public static void DeleteEmployeeEducation(string Employee_Education_ID)
    {
        string query = "update tbl_employee_education set is_deleted=1 where Employee_Edu_Id='" + int.Parse(Employee_Education_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }

    [WebMethod]
    public static void UpdateEmployeeEducation(string Employee_Education_Id,string Employee_Qualification,string Employee_CompletionYear,string Employee_Cgpa_Grade,string Employee_Percentage,string Employee_School_Uni)
    {
        string query = "UPDATE [tbl_employee_education]" +
         " SET [Employee_Qualification] = '" + Employee_Qualification + "',[Year_of_completion] = '" + Employee_CompletionYear + "'" +
        " ,[Grade_Cgpa] = '" + Employee_Cgpa_Grade + "',[Percentage] = '" + Employee_Percentage + "',[School_Uni] = '" + Employee_School_Uni + "' WHERE [Employee_Edu_Id]='" + Employee_Education_Id + "'";
        
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion
}