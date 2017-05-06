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

public partial class SettingForms_SettingWebMethods : System.Web.UI.Page
{
    static string UserID = "";
    static string CurrentDate = "";
    static string factoryid = "1";
    static string religionid = "1";
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public static void getUserAndDate()
    {

        CurrentDate = DateTime.Now.ToShortDateString();
        UserID = HttpContext.Current.Profile.GetPropertyValue("FirstName").ToString() + " " + HttpContext.Current.Profile.GetPropertyValue("LastName").ToString();//"mctxAdmin";
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
    #region department
    #region Save Department
    [WebMethod]
    public static void SaveDepartment(string Department_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_department]" +
       "([department_name],[factory_id],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Department_Name + "','" + factoryid + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion
    #region Get Department
    [WebMethod]
    public static Dictionary<string, object> getDepartmentDetail()
    
    {

        string Query = "SELECT [department_id],[department_name],[factory_id],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [tbl_department] where is_deleted=0 order by department_name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetDepartmentDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetDepartmentDetail"];
        return ToJson(dt);

    }
    #endregion
    #region Delete Department
    [WebMethod]
    public static void DeleteDepartment(string Department_ID)
    {
        string query = "update tbl_department set is_deleted=1 where department_id='" + int.Parse(Department_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion
    #region Update Department
    [WebMethod]
    public static void UpdateDepartment(string Department_ID, string Department_Name)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_department]" +
" SET [department_name] = '" + Department_Name + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [department_id]='" + Department_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
#endregion

    #region Designations

    #region Save Designation
    [WebMethod]
    public static void SavePersonDesignation(string designation)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_designation]" +
       "([designation_name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + designation + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update Designation
    [WebMethod]
    public static void UpdatePersonDesignation(string Person_DesignationID, string designation)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_designation]" +
  " SET [designation_name] = '" + designation + "',[modified_date] = '" + CurrentDate + "'" +
  " ,[modified_by] = '" + UserID + "' WHERE [designation_id]='" + Person_DesignationID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Designation
    [WebMethod]
    public static Dictionary<string, object> getPersonDesignationDetail()
    {

        string Query = "SELECT hrdsg.[designation_id],hrdsg.[designation_name],isnull(CONVERT(varchar(20), hrdsg.[created_date],101),'') as created_date " +
        " ,hrdsg.[created_by],isnull(CONVERT(varchar(20), hrdsg.[modified_date],101),'') as modified_date " +
       "  ,hrdsg.[modified_by],hrdsg.[is_deleted] "+
      "  FROM [tbl_designation] hrdsg   " +

      "   where is_deleted=0 and designation_name is not null and designation_name !=''  order by designation_name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "PersonDesignationDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["PersonDesignationDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Designation
    [WebMethod]
    public static void DeletePersonDesignation(string Designation_ID)
    {
        string query = "update tbl_designation set is_deleted=1 where designation_id='" + int.Parse(Designation_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion

    #region Education

    #region Save Education
    [WebMethod]
    public static void SaveEducation(string Education_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_education]" +
       "([education_name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Education_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update Education
    [WebMethod]
    public static void UpdateEducation(string Education_ID, string Education_Name)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_education]" +
" SET [education_name] = '" + Education_Name + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [education_id]='" + Education_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Education
    [WebMethod]
    public static Dictionary<string, object> getEducationDetail()
    {

        string Query = "SELECT [education_id],[education_name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [tbl_education] where is_deleted=0 order by education_name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "EducationDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["EducationDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Education
    [WebMethod]
    public static void DeleteEducation(string Education_ID)
    {
        string query = "update tbl_education set is_deleted=1 where education_id='" + int.Parse(Education_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion
    #region Religion

    #region Save Religion
    [WebMethod]
    public static void SaveReligions(string Religion_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_religion]" +
       "([religion_name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Religion_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update Religion
    [WebMethod]
    public static void UpdateReligions(string Religion_ID, string Religion_Name)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_religion]" +
" SET [religion_name] = '" + Religion_Name + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [religion_id]='" + Religion_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Religion
    [WebMethod]
    public static Dictionary<string, object> getReligionDetail()
    {

        string Query = "SELECT [religion_id],[religion_name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [tbl_religion] where is_deleted=0 order by religion_name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "ReligionDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["ReligionDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Religion
    [WebMethod]
    public static void DeleteReligion(string Religion_ID)
    {
        string query = "update tbl_religion set is_deleted=1 where religion_id='" + int.Parse(Religion_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion
    #region Caste

    #region Save Caste
    [WebMethod]
    public static void SaveCaste(string Caste_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_cast]" +
       "([cast_name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Caste_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update Caste
    [WebMethod]
    public static void UpdateCaste(string Caste_ID, string Caste_Name)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_cast]" +
" SET [cast_name] = '" + Caste_Name + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [cast_id]='" + Caste_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Caste
    [WebMethod]
    public static Dictionary<string, object> getCasteDetail()
    {

        string Query = "SELECT [cast_id],[cast_name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [tbl_cast] where is_deleted=0 order by cast_name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "CasteDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["CasteDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Caste
    [WebMethod]
    public static void DeleteCaste(string Caste_ID)
    {
        string query = "update tbl_cast set is_deleted=1 where cast_id='" + int.Parse(Caste_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion
    #region Sectt

    #region Save Sectt
    [WebMethod]
    public static void SaveSectt(string Sectt_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_sectt]" +
       "([sectt_name],[religion_id],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Sectt_Name + "','" + religionid + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update Sectt
    [WebMethod]
    public static void UpdateSectt(string Sectt_ID, string Sectt_Name)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_sectt]" +
" SET [sectt_name] = '" + Sectt_Name + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [sectt_id]='" + Sectt_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Sectt
    [WebMethod]
    public static Dictionary<string, object> getSecttDetail()
    {

        string Query = "SELECT [sectt_id],[sectt_name],[religion_id],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [tbl_sectt] where is_deleted=0 order by sectt_name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "SecttDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["SecttDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Sectt
    [WebMethod]
    public static void DeleteSectt(string Sectt_ID)
    {
        string query = "update tbl_sectt set is_deleted=1 where sectt_id='" + int.Parse(Sectt_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion
    #region Relation

    #region Save Relation
    [WebMethod]
    public static void SaveRelation(string Relation_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_relation]" +
       "([relation_name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Relation_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update Relation
    [WebMethod]
    public static void UpdateRelation(string Relation_ID, string Relation_Name)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_relation]" +
" SET [relation_name] = '" + Relation_Name + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [relation_id]='" + Relation_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Relation
    [WebMethod]
    public static Dictionary<string, object> getRelations()
    {

        string Query = "SELECT [relation_id],[relation_name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [tbl_relation] where is_deleted=0 order by relation_name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "RelationDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["RelationDetail"];
        return ToJson(dt);


    }
    #endregion

    #region Delete Relation
    [WebMethod]
    public static void DeleteRelation(string Relation_ID)
    {
        string query = "update tbl_relation set is_deleted=1 where relation_id='" + int.Parse(Relation_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion
    #region Trainer

    #region Save Trainer
    [WebMethod]
    public static void SaveTrainer(string Trainer_Name, string Trainer_Company, string Trainer_Phoneno, string Trainer_Designation, string employee)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_trainer]" +
       "([trainer_name],[trainer_company],[trainer_phone_no],[trainer_designation],[employee_id],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Trainer_Name + "','" + Trainer_Company + "','" + Trainer_Phoneno + "','" + Trainer_Designation + "','" + employee + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update Trainer
    [WebMethod]
    public static void updateTrainer(string Trainer_ID, string Trainer_Name, string Trainer_company, string Trainer_phoneno, string Trainer_Designation, string Employee)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_trainer]" +
 " SET [trainer_name] = '" + Trainer_Name + "',[trainer_company] = '" + Trainer_company + "',[trainer_phone_no] = '" + Trainer_phoneno + "',[trainer_designation] = '" + Trainer_Designation + "',[employee_id] = '" + Employee + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [trainer_id]='" + Trainer_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Trainer
    [WebMethod]
    public static Dictionary<string, object> getTrainer()
    {

        string Query = "select t.trainer_id as trainerid,t.trainer_name as trainername,t.trainer_company as trainercompany,t.trainer_designation as trainerdesignation,t.trainer_phone_no as trainerphoneno,emp.employee_id as employeeid,emp.employee_name as employeename  from tbl_trainer t "+
                  " inner join tbl_employee emp on emp.employee_id=t.employee_id "+
        "  where t.is_deleted=0 order by trainername ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "TrainerDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["TrainerDetail"];
        return ToJson(dt);


    }
    #endregion

    #region Delete Trainer
    [WebMethod]
    public static void DeleteTrainer(string Trainer_ID)
    {
        string query = "update tbl_trainer set is_deleted=1 where trainer_id='" + int.Parse(Trainer_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion

    #region Training Category

    #region Save Training Category
    [WebMethod]
    public static void SaveTrainingcategory(string Training_category)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_training_category]" +
       "([training_category_name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Training_category + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update Training Category
    [WebMethod]
    public static void UpdateTrainingCategory(string ID, string Training_category)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_training_category]" +
" SET [training_category_name] = '" + Training_category + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [training_category_id]='" + ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Training Category
    [WebMethod]
    public static Dictionary<string, object> getTrainingCategory()
    {

        string Query = "SELECT [training_category_id],[training_category_name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [tbl_training_category] where is_deleted=0 order by training_category_name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "TrainingCategory", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["TrainingCategory"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Training Category
    [WebMethod]
    public static void DeleteTrainingCategory(string Training_Category)
    {
        string query = "update tbl_training_category set is_deleted=1 where training_category_id='" + int.Parse(Training_Category) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion

    #region Training 

    #region Save Training 
    [WebMethod]
    public static void SaveTraining(string Training_Name, string Training_Category, string Training_Prerequisite, string Training_PrerequisiteName)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_training]" +
       "([training_name],[training_category_id],[training_prerequisite_id],[created_date],[created_by],[modified_date],[modified_by],[is_deleted],training_prereqiuisite_name)" +
       "VALUES('" + Training_Name + "','" + Training_Category + "','" + Training_Prerequisite + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "', '" + Training_PrerequisiteName + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update Training 
    [WebMethod]
    public static void UpdateTraining(string Training_ID, string Training_Name, string Training_category, string Trainer_prereq, string Training_PrerequisiteName)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_training]" +
   " SET [training_name] = '" + Training_Name + "',[training_category_id] = '" + Training_category + "',[training_prerequisite_id] = '" + Trainer_prereq + "',[training_prereqiuisite_name] = '" + Training_PrerequisiteName + "',[modified_date] = '" + CurrentDate + "'" +
   " ,[modified_by] = '" + UserID + "' WHERE [training_id]='" + Training_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Training
    [WebMethod]
    public static Dictionary<string, object> getTraining()
    {
        string Query = " select t.training_id as trainingid,t.training_name as trainingname,t.training_prerequisite_id as prereqid,tc.training_category_id as trainingcategoryid,t.training_prereqiuisite_name " +
              ", tc.training_category_name as  categoryname   from tbl_training t " +
              " join tbl_training_category tc on tc.training_category_id=t.training_category_id "+
                 " where t.is_deleted=0 order by trainingname ASC ";
        

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "Training", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["Training"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Training
    [WebMethod]
    public static void DeleteTraining(string Training_ID)
    {
        string query = "update tbl_training set is_deleted=1 where training_id='" + int.Parse(Training_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion

    #region Training Schedule

    #region Save Training Schedule
    [WebMethod]
    public static void SaveTrainingSchedule(string Start_Date, string End_Date, string Start_Time, string End_Time, string Training_ID)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_training_schedule]" +
       "([training_schedule_strat_date],[training_schedule_end_date],[training_schedule_start_time],[training_schedule_end_time],[training_id],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Start_Date + "','" + End_Date + "','" + Start_Time + "','" + End_Time + "','" + Training_ID + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update Training
    [WebMethod]
    public static void UpdateTrainingschedule(string TrainingSchedule_ID, string StartDate, string EndDate, string StartTime, string EndTime, string TrainingName)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_training_schedule]" +
      " SET [training_schedule_strat_date] = '" + StartDate + "',[training_schedule_end_date] = '" + EndDate + "',[training_schedule_start_time] = '" + StartTime + "',[training_schedule_end_time] = '" + EndTime + "',[training_id] = '" + TrainingName + "',[modified_date] = '" + CurrentDate + "'" +
      " ,[modified_by] = '" + UserID + "' WHERE [training_schedule_id]='" + TrainingSchedule_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Training schedule
    [WebMethod]
    public static Dictionary<string, object>gettrainingschedule()
    {
        string Query = " select ts.training_schedule_id as Trainingscheduleid,convert(varchar(10), ts.training_schedule_end_date,101) as enddate,LEFT(ts.training_schedule_end_time,5) as endtime,LEFT(ts.training_schedule_start_time,5) as strattime,convert(varchar(10),ts.training_schedule_strat_date) as stratdate, t.training_id,t.training_name as trainingname " + 
             " from tbl_training_schedule ts "+
             " join tbl_training t on t.training_id=ts.training_id "+
               " where ts.is_deleted=0 ";
        //string Query = "SELECT [training_category_id],[training_category_name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        //" ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        //"  ,[modified_by],[is_deleted]" +
        //" FROM [tbl_training_category] where is_deleted=0 order by training_category_name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "TrainingSchedule", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["TrainingSchedule"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Training
    [WebMethod]
    public static void DeleteTrainingSchedule(string TrainingSchedule_ID)
    {
        string query = "update tbl_training_schedule set is_deleted=1 where training_schedule_id='" + int.Parse(TrainingSchedule_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion

    #region City

    #region Save City
    [WebMethod]
    public static void SaveCity(string City_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_city]" +
       "([city_name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + City_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update City
    [WebMethod]
    public static void UpdateCity(string City_ID, string City_Name)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_city]" +
    " SET [city_name] = '" + City_Name + "',[modified_date] = '" + CurrentDate + "'" +
    " ,[modified_by] = '" + UserID + "' WHERE [city_id]='" + City_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get City
    [WebMethod]
    public static Dictionary<string, object> getCityDetail()
    {

        string Query = "SELECT [city_id],[city_name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [tbl_city] where is_deleted=0 order by city_name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "CityDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["CityDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete City
    [WebMethod]
    public static void DeleteCity(string City_ID)
    {
        string query = "update tbl_city set is_deleted=1 where city_id='" + int.Parse(City_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion

    #region Company

    #region Save Company
    [WebMethod]
    public static void Savecompany(string Company_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_Add_Company]" +
       "([Company_Name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Company_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update Company
    [WebMethod]
    public static void UpdateCompany(string Company_ID, string Company_Name)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_Add_Company]" +
    " SET [Company_Name] = '" + Company_Name + "',[modified_date] = '" + CurrentDate + "'" +
    " ,[modified_by] = '" + UserID + "' WHERE [Company_id]='" + Company_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Company
    [WebMethod]
    public static Dictionary<string, object> getCompanyDetail()
    {

        string Query = "SELECT [Company_id],[Company_Name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [tbl_Add_Company] where is_deleted=0 order by Company_Name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "CompanyDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["CompanyDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Company
    [WebMethod]
    public static void DeleteCompany(string Company_ID)
    {
        string query = "update tbl_Add_Company set is_deleted=1 where Company_id='" + int.Parse(Company_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion

    #region Leave

    #region Save Leave
    [WebMethod]
    public static void SaveLeave(string Leave_Type)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_Add_LeaveType]" +
       "([Leave_Type],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Leave_Type + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update LeaveType
    [WebMethod]
    public static void UpdateLeave(string Leave_ID, string Leave_Type)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_Add_LeaveType]" +
    " SET [Leave_Type] = '" + Leave_Type + "',[modified_date] = '" + CurrentDate + "'" +
    " ,[modified_by] = '" + UserID + "' WHERE [Leave_Id]='" + Leave_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Leave Type
    [WebMethod]
    public static Dictionary<string, object> getLeaveDetail()
    {

        string Query = "SELECT [Leave_Id],[Leave_Type],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [tbl_Add_LeaveType] where is_deleted=0 order by Leave_Type ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "LeaveDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["LeaveDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Leave
    [WebMethod]
    public static void DeleteLeave(string Leave_ID)
    {
        string query = "update tbl_Add_LeaveType set is_deleted=1 where Leave_Id='" + int.Parse(Leave_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion

    #region Job Status

    #region Save JobStatus
    [WebMethod]
    public static void SaveJobStatus(string Job_Status)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_addEmployee_Job_Status]" +
       "([Employee_Job_status],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Job_Status + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update JobStatus
    [WebMethod]
    public static void UpdateJobStatus(string JobStatus_ID, string JobStatus)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_addEmployee_Job_Status]" +
    " SET [Employee_Job_status] = '" + JobStatus + "',[modified_date] = '" + CurrentDate + "'" +
    " ,[modified_by] = '" + UserID + "' WHERE [EmployeeStatus_Id]='" + JobStatus_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Job Status
    [WebMethod]
    public static Dictionary<string, object> getJobStatusDetail()
    {

        string Query = "SELECT [EmployeeStatus_Id],[Employee_Job_status],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [tbl_addEmployee_Job_Status] where is_deleted=0 order by Employee_Job_status ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "JobStatusDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["JobStatusDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Leave
    [WebMethod]
    public static void DeleteJobstatus(string JobStatus_ID)
    {
        string query = "update tbl_addEmployee_Job_Status set is_deleted=1 where EmployeeStatus_Id='" + int.Parse(JobStatus_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion

    #region Reasoning

    #region Save Reasoning
    [WebMethod]
    public static void SaveReasoning(string Reasoning)
    {
        getUserAndDate();


        string query = "INSERT INTO [AddReasoning]" +
       "([Reasoning],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Reasoning + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update Reasoning
    [WebMethod]
    public static void UpdateReasoning(string Reasoning_ID, string Reasoning)
    {
        getUserAndDate();

        string query = "UPDATE [AddReasoning]" +
    " SET [Reasoning] = '" + Reasoning + "',[modified_date] = '" + CurrentDate + "'" +
    " ,[modified_by] = '" + UserID + "' WHERE [Reasoning_Id]='" + Reasoning_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Reasoning
    [WebMethod]
    public static Dictionary<string, object> getReasoningDetail()
    {

        string Query = "SELECT [Reasoning_Id],[Reasoning],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [AddReasoning] where is_deleted=0 order by Reasoning ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "ReasoningDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["ReasoningDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Reasoning
    [WebMethod]
    public static void DeleteReasoning(string Reasoning_ID)
    {
        string query = "update AddReasoning set is_deleted=1 where Reasoning_Id='" + int.Parse(Reasoning_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #endregion

    #region Assign Charge

    #region save Assign Charge
    [WebMethod]
    public static void SaveAssignCharge(string Employee_Id, string Designation_Name, string Department_Name, string AssignCharge_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [tbl_Add_AssignCharge]" +
       "([Assign_Charge],[Employee_Id],[Department_Id],[Designation_Id],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + AssignCharge_Name + "','" + Employee_Id + "','" + Department_Name + "','" + Designation_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion

    #region Update Reasoning
    [WebMethod]
    public static void UpdateAssignCharge(string AssignCharge_ID, string AssignCharge, string Department, string Desigantion, string Employee)
    {
        getUserAndDate();

        string query = "UPDATE [tbl_Add_AssignCharge]" +
    " SET [Assign_Charge] = '" + AssignCharge + "',[Employee_Id] = '" + Employee + "',[Department_Id] = '" + Department + "',[Designation_Id] = '" + Desigantion + "',[modified_date] = '" + CurrentDate + "'" +
    " ,[modified_by] = '" + UserID + "' WHERE [AssignCharge_Id]='" + AssignCharge_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
    }
    #endregion
    #region Get Assign Charge
    [WebMethod]
    public static Dictionary<string, object> getAssignCharge()
    
    {

        string Query = " SELECT ac.AssignCharge_Id,ac.Assign_Charge,emp.employee_id,emp.employee_name,dep.department_id,dep.department_name,desig.designation_id,desig.designation_name, "+
                       " isnull(CONVERT(varchar(20), ac.[created_date],101),'') as created_date "+
                       " ,ac.[created_by],isnull(CONVERT(varchar(20), ac.[modified_date],101),'') as modified_date "+
                       ",ac.[modified_by],ac.[is_deleted] FROM tbl_Add_AssignCharge ac " +
                       " inner join tbl_department dep on dep.department_id=ac.Department_Id "+
                       " inner join tbl_designation desig on desig.designation_id=ac.Designation_Id "+
                       " inner join tbl_employee emp on emp.employee_id=ac.Employee_Id "+
                       " where ac.is_deleted=0 order by ac.Assign_Charge ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "AssignChargeDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["AssignChargeDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Reasoning
    [WebMethod]
    public static void DeleteAssignCharge(string AssignCharge_ID)
    {
        string query = "update tbl_Add_AssignCharge set is_deleted=1 where AssignCharge_Id='" + int.Parse(AssignCharge_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

    }
    #endregion
    #region retrieve desig depart
[WebMethod]
    public static Dictionary<string, object> retrievedesigdepart(string Employee_ID)
    {
        string querry = "select emp.employee_id,emp.employee_name,dep.department_id,dep.department_name " +
            " ,desig.designation_id,desig.designation_name from tbl_employee emp " +
            " inner join tbl_department dep on dep.department_id=emp.department_id " +
             " inner join tbl_designation desig on desig.designation_id=emp.designation_id " +
             " where emp.employee_id='" + Employee_ID + "'";
        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(querry, "RetrieveDesigAndDepartDetail", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["RetrieveDesigAndDepartDetail"];
        return ToJson(dt);
    }
    #endregion

    #endregion

#region Bank

#region Save Bank
[WebMethod]
public static void SaveBank(string Bank_Name)
{
    getUserAndDate();


    string query = "INSERT INTO [tbl_AddBank]" +
   "([Bank_Name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
   "VALUES('" + Bank_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

    DBManager ObjDBManager = new DBManager();
    ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

}
#endregion

#region Update Bank
[WebMethod]
public static void UpdateBank(string Bank_ID, string Bank_Name)
{
    getUserAndDate();

    string query = "UPDATE [tbl_AddBank]" +
" SET [Bank_Name] = '" + Bank_Name + "',[modified_date] = '" + CurrentDate + "'" +
" ,[modified_by] = '" + UserID + "' WHERE [Bank_id]='" + Bank_ID + "'";
    DBManager ObjDBManager = new DBManager();
    ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
}
#endregion
#region Get Bank
[WebMethod]
public static Dictionary<string, object> getBankDetail()
{

    string Query = "SELECT [Bank_id],[Bank_Name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
    " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
    "  ,[modified_by],[is_deleted]" +
    " FROM [tbl_AddBank] where is_deleted=0 order by Bank_Name ASC";

    DBManager ObjDBManager = new DBManager();
    DataSet ds = ObjDBManager.SelectQuery(Query, "BankDetail", "UnileverConnectionString");
    DataTable dt = new DataTable();
    dt = ds.Tables["BankDetail"];
    return ToJson(dt);

}
#endregion

#region Delete Bank
[WebMethod]
public static void DeleteBank(string Bank_ID)
{
    string query = "update tbl_AddBank set is_deleted=1 where Bank_id='" + int.Parse(Bank_ID) + "'";
    DBManager ObjDBManager = new DBManager();
    ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

}
#endregion

#endregion


#region Holiday

#region Save Holiday
[WebMethod]
public static void SaveHoliday(string Holiday_Name, string FromDate, string ToDate, string TotalDays)
{
    getUserAndDate();


    string query = "INSERT INTO [tbl_AddHolidays]" +
   "([holiday_name],[holiday_date_from],[holiday_date_to],[total_holidays],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
   "VALUES('" + Holiday_Name + "','" + FromDate + "','" + ToDate + "','" + TotalDays + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

    DBManager ObjDBManager = new DBManager();
    ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

}
#endregion

#region Update Holiday
[WebMethod]
public static void UpdateHoliday(string Holiday_ID, string Holiday_Name, string FromDate, string ToDate, string TotalDays)
{
    getUserAndDate();

    string query = "UPDATE [tbl_AddHolidays]" +
" SET [holiday_name] = '" + Holiday_Name + "',[holiday_date_from] = '" + FromDate + "',[holiday_date_to] = '" + ToDate + "',[total_holidays] = '" + TotalDays + "',[modified_date] = '" + CurrentDate + "'" +
" ,[modified_by] = '" + UserID + "' WHERE [holiday_id]='" + Holiday_ID + "'";
    DBManager ObjDBManager = new DBManager();
    ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
}
#endregion
#region Get Holiday
[WebMethod]
public static Dictionary<string, object> getHolidayDetail()
{

    string Query = "SELECT [holiday_id],[holiday_name],isnull(CONVERT(varchar(20), [holiday_date_from],101),'') as from_date,isnull(CONVERT(varchar(20), [holiday_date_to],101),'') as to_date,total_holidays,isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
    " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
    "  ,[modified_by],[is_deleted]" +
    " FROM [tbl_AddHolidays] where is_deleted=0 order by holiday_name ASC";

    DBManager ObjDBManager = new DBManager();
    DataSet ds = ObjDBManager.SelectQuery(Query, "dtHolidayDetail", "UnileverConnectionString");
    DataTable dt = new DataTable();
    dt = ds.Tables["dtHolidayDetail"];
    return ToJson(dt);

}
#endregion

#region Delete Holiday
[WebMethod]
public static void DeleteHolidayDetail(string Holiday_ID)
{
    string query = "update tbl_AddHolidays set is_deleted=1 where holiday_id='" + int.Parse(Holiday_ID) + "'";
    DBManager ObjDBManager = new DBManager();
    ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");

}
#endregion

#endregion
}