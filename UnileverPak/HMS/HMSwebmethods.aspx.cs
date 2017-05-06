using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HMS_Settingwebmethods : System.Web.UI.Page
{
    static string UserID = "";
    static string CurrentDate = "";
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
    #region Hierarchy Mangement
    #region get hierarchy
    [WebMethod]
    public static Dictionary<string, object> getHeirarchy(string Employee_ID)
    {
        string Query = " select emp.employee_id,emp.employee_name,desig.designation_id as designationid,isnull(desig.designation_name,'') as designationName,"+
                       " dep.department_id as departmentid,isnull(dep.department_name,'') as departmentname, "+
                       " isnull((select  emp2.employee_name from tbl_employee emp2 where emp2.employee_id=emp.employee_reporting_id),'') as reportingPersonName "+
                       " From tbl_employee emp "+
                       " left join tbl_designation desig on desig.designation_id=emp.designation_id "+
                       " left join tbl_department dep on dep.department_id=emp.department_id "+

                       " where emp.employee_reporting_id='" + Employee_ID + "'";


        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "Heirarchy", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["Heirarchy"];
        return ToJson(dt);
    }
    #endregion

    

    #region Update Hierarchy
    [WebMethod]
    public static void UpdateHierarchy(string Reporting_Id, string Employee_ID)
    {
        getUserAndDate();
        string[] empID = Employee_ID.Split('`');
        for (int i = 0; i <= empID.Length-1; i++) { 

        string query = "UPDATE [tbl_employee]" +
    " SET [employee_reporting_id] = '" + Reporting_Id + "'" +
    "  WHERE [employee_id]='" + empID[i] + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "UnileverConnectionString");
        }
    }
    #endregion
   
    #endregion
}