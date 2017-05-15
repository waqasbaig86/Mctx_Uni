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


public partial class EMS_health_care_history : System.Web.UI.Page
{
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

    #region
    [WebMethod]
    public static Dictionary<string, object> getEmployeeInfo(string Empno)
    {
        string Query = "select * from tbl_employee where employee_id='" + Empno + "'";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "tbl_employeeResult", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["tbl_employeeResult"];
        return ToJson(dt);

    }
    #endregion
}