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
   
    [WebMethod]
    public static Dictionary<string, object> getHeirarchy(string EmployeeId,string Type)
    {
       
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("@EmpId", EmployeeId);
        ObjDBManager.AddParameter("@Type", Type);
        DataSet ds = ObjDBManager.ExecuteDataSet("GetEmployeeForReportingPerson", "UnileverConnectionString", "Heirarchy");
        DataTable dt = new DataTable();
        dt = ds.Tables["Heirarchy"];
        return ToJson(dt);
    }

    [WebMethod]
    public static void UpdateHierarchy(string EmployeeId, string ReportingId, string DateFrom, string DateTo, string MainReporting)
    {
        //getUserAndDate();        
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("@EmpId", EmployeeId);
        ObjDBManager.AddParameter("@ReportingId", ReportingId);
        ObjDBManager.AddParameter("@DateFrom", DateFrom);
        ObjDBManager.AddParameter("@DateTo", DateTo);
        ObjDBManager.AddParameter("@MainReporting", bool.Parse(MainReporting));
        ObjDBManager.AddParameter("@Modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
        ObjDBManager.AddParameter("@Modified_date", DateTime.Now);
        ObjDBManager.InsertUpdateProc("ChangeReportingPerson", "UnileverConnectionString");
    }
    #endregion
}