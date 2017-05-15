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
    public static int SaveEmployee(
        string employeeId, string EmployeeName, string EmployeeNo, 
        string FatherName, string EmployeeCNIC,string EmployeeAddress, 
        string EmployeePhoneNo, string EmployeeMobile,string EmployeeEmail, 
        string Gender, string EmployeeCity, string Employee_Dob, 
        string Employee_Status, string Religion, string Sectt, 
        string Caste, string BloddGroup, string EmployeeReporting, 
        string Department, string Designation,string Shift, 
        string Photo, string Quailification,string Employer,     
        string AccountNo, string NtnNo, string EobiNo, string Bank
            )
    {
        int EmpId = int.Parse(employeeId);
        DBManager objbmanger = new DBManager();
        if (EmpId == 0)
        {
            objbmanger.AddParameter("@EmployeeID", EmpId, SqlDbType.Int, 4, ParameterDirection.Output);
            objbmanger.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            objbmanger.AddParameter("@created_date", DateTime.Now);
        
        }
        else
        {
            objbmanger.AddParameter("@EmployeeID", EmpId);
            objbmanger.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            objbmanger.AddParameter("@modified_date", DateTime.Now);
        }
        
        objbmanger.AddParameter("@EmployeeNo", EmployeeNo);
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
        objbmanger.AddParameter("@EmployeeEducation", Quailification);
        objbmanger.AddParameter("@EmployeeReporting", EmployeeReporting);
        objbmanger.AddParameter("@EmployeeDepartment", Department);
        objbmanger.AddParameter("@EmployeeDesignation", Designation);
        objbmanger.AddParameter("@EmployeeShift", Shift);
        objbmanger.AddParameter("@Employer_Id", Employer);
        //  objbmanger.AddParameter("@NewPhoto", Photo);
        //objbmanger.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
        //objbmanger.AddParameter("@created_date", DateTime.Now);        
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
            }
        }
        if (EmpId == 0)
        {
            
            objbmanger.InsertUpdateProcedure("AddEmployee", "UnileverConnectionString");
            EmpId = int.Parse(objbmanger.Parameters[0].Value.ToString());
        }
        else
        {
         
            objbmanger.InsertUpdateProcedure("UpdateEmployee", "UnileverConnectionString");
        }
        saveFinance(EmpId,  AccountNo,  NtnNo,  EobiNo,  Bank);
        return EmpId;
        //objbmanger.InsertUpdateProcedure("AddEmployee", "UnileverConnectionString");
    }
    [WebMethod]
        public static void saveAcedmic(int employeeid, string Quailification, string YearOfCompletion, string Grade, string Percentage, string School)
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
    public static void saveFinance(int employeeid, string AccountNo, string NtnNo, string EobiNo, string Bank)
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

    #region Shift Management
    [WebMethod]
    public static Dictionary<string, object> getEmployees(string EmpNo,string Department,string Shift)
    {
        DBManager ObjDBManager = new DBManager();        
        ObjDBManager.AddParameter("@EmpNumber", EmpNo);
        ObjDBManager.AddParameter("@DeptId", Department);
        ObjDBManager.AddParameter("@ShiftId", Shift);

        DataSet ds = ObjDBManager.ExecuteDataSet("GetEmployeesForShift", "UnileverConnectionString","Employee");
        DataTable dt = new DataTable();
        dt = ds.Tables["Employee"];
        return ToJson(dt);
    }
    [WebMethod]
    public static void ChangeShift(string EmpId, string ShiftId)
    {    
            DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("@EmpId", EmpId);
        ObjDBManager.AddParameter("@ShiftId", ShiftId);
        ObjDBManager.AddParameter("@Modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
        ObjDBManager.AddParameter("@Modified_date", DateTime.Now);
        ObjDBManager.InsertUpdateProc("ChangeShiftForEmployee", "UnileverConnectionString");        
    }
    #endregion
    #region Health Info
    //[WebMethod]
    //public static void SaveHealthInfo(
    //    string EmpId, string FHHTN, string FHIHD, string FHDM)
    //{

    //}

    [WebMethod]
    public static void SaveHealthInfo(string HealthId,
        string EmpId,string FHHTN, string FHIHD, string FHDM,
        string FHAsthma, string FHOther, string Surgicalhistory,
        string CDHTN, string CDIHD, string CDDM,
        string CDAsthma, string CDOther, string Smoking,
        string SubstanceAbuse, string Exercise, string Stress,
        string Build, string Weight, string Height,
        string BMI, string Waist, string BP,
        string Pulse, string OralCavity, string Thyroid,
        string Skin, string Vision, string SpecificDeformity,
        string GIT, string CVS, string Respiratory,
        string CNS, string Hb, string ERS,
        string TLC, string Platelets, string FBS,
        string UricAcid, string UrineDR, string BloodGroup,
        string HBsAg, string AntiHCV, string SUrea,
        string SCreatinine, string SBilirubin, string SGPT,
        string SCholesterol, string TGD, string ECG, 
        string CXR,string Adiometry, string MOthers, 
        string VHistory,string VTetanus, string VTyphoid, 
        string VOthers,string CurrentMedication, string Remarks
        )
    {
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("@HealthId", HealthId);
        ObjDBManager.AddParameter("@EmpId", EmpId);
        ObjDBManager.AddParameter("@FHHTN", FHHTN);
        ObjDBManager.AddParameter("@FHIHD", FHIHD);
        ObjDBManager.AddParameter("@FHDM", FHDM);
        ObjDBManager.AddParameter("@FHAsthma", FHAsthma);
        ObjDBManager.AddParameter("@FHOther", FHOther);

        ObjDBManager.AddParameter("@Surgicalhistory", Surgicalhistory);
        ObjDBManager.AddParameter("@CDHTN", CDHTN);
        ObjDBManager.AddParameter("@CDIHD", CDIHD);
        ObjDBManager.AddParameter("@CDDM", CDDM);
        ObjDBManager.AddParameter("@CDAsthma", CDAsthma);
        ObjDBManager.AddParameter("@CDOther", CDOther);
        ObjDBManager.AddParameter("@Smoking", Smoking);
        ObjDBManager.AddParameter("@SubstanceAbuse", SubstanceAbuse);
        ObjDBManager.AddParameter("@Exercise", Exercise);
        ObjDBManager.AddParameter("@Stress", Stress);
        ObjDBManager.AddParameter("@Build", Build);
        ObjDBManager.AddParameter("@Weight", Weight==""?"0": Weight);
        ObjDBManager.AddParameter("@Height", Height == "" ? "0" : Height);
        ObjDBManager.AddParameter("@BMI", BMI == "" ? "0" : BMI);
        ObjDBManager.AddParameter("@Waist", Waist == "" ? "0" : Waist);
        ObjDBManager.AddParameter("@BP", BP == "" ? "0" : BP);
        ObjDBManager.AddParameter("@Pulse", Pulse == "" ? "0" : Pulse);
        ObjDBManager.AddParameter("@OralCavity", OralCavity);
        ObjDBManager.AddParameter("@Thyroid", Thyroid);
        ObjDBManager.AddParameter("@Skin", Skin);
        ObjDBManager.AddParameter("@Vision", Vision);
        ObjDBManager.AddParameter("@SpecificDeformity", SpecificDeformity);
        ObjDBManager.AddParameter("@GIT", GIT);
        ObjDBManager.AddParameter("@CVS", CVS);
        ObjDBManager.AddParameter("@Respiratory", Respiratory);
        ObjDBManager.AddParameter("@CNS", CNS);
        ObjDBManager.AddParameter("@Hb", Hb);
        ObjDBManager.AddParameter("@ERS", ERS);
        ObjDBManager.AddParameter("@TLC", TLC);
        ObjDBManager.AddParameter("@Platelets", Platelets);
        ObjDBManager.AddParameter("@FBS", FBS);
        ObjDBManager.AddParameter("@UricAcid", UricAcid);
        ObjDBManager.AddParameter("@UrineDR", UrineDR);
        ObjDBManager.AddParameter("@BloodGroup", BloodGroup);
        ObjDBManager.AddParameter("@HBsAg", HBsAg);
        ObjDBManager.AddParameter("@AntiHCV", AntiHCV);
        ObjDBManager.AddParameter("@SUrea", SUrea);
        ObjDBManager.AddParameter("@SCreatinine", SCreatinine);
        ObjDBManager.AddParameter("@SBilirubin", SBilirubin);
        ObjDBManager.AddParameter("@SGPT", SGPT);
        ObjDBManager.AddParameter("@SCholesterol", SCholesterol);
        ObjDBManager.AddParameter("@TGD", TGD);
        ObjDBManager.AddParameter("@ECG", ECG);
        ObjDBManager.AddParameter("@CXR", CXR);
        ObjDBManager.AddParameter("@Adiometry", Adiometry);
        ObjDBManager.AddParameter("@MOthers", MOthers);
        ObjDBManager.AddParameter("@VHistory", VHistory);
        ObjDBManager.AddParameter("@VTetanus", VTetanus);
        ObjDBManager.AddParameter("@VTyphoid", VTyphoid);
        ObjDBManager.AddParameter("@VOthers", VOthers);
        ObjDBManager.AddParameter("@CurrentMedication", CurrentMedication);
        ObjDBManager.AddParameter("@Remarks", Remarks);

        ObjDBManager.AddParameter("@Modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
        ObjDBManager.AddParameter("@Modified_date", DateTime.Now);

        ObjDBManager.InsertUpdateProc("SaveHealthInfo", "UnileverConnectionString");
    }
    #endregion
}