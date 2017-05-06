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

public partial class PascWebMethod : System.Web.UI.Page
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
   
    #region Users
    [WebMethod]
    public static void SaveUser(string userId, string username, string password, string firstname, string lastname, string department, string Pno, string mobile, string email, string RoleId)
    {
      
        
        DBManager ObjDBManager = new DBManager();
        DBCommonMethods commonMethods = new DBCommonMethods();
        if (password == "!#!#!#!#!#!#!#!#Abcdefgh123")
            password = "";
        else
        password = commonMethods.HashPassword(password);
        ObjDBManager.AddParameter("@userId", userId);
        ObjDBManager.AddParameter("@username", username);
        ObjDBManager.AddParameter("@password", password);
        ObjDBManager.AddParameter("@firstname", firstname);
        ObjDBManager.AddParameter("@lastname", lastname);
        if (department == "-- Select --")
            department = "";
        ObjDBManager.AddParameter("@address", department);
        ObjDBManager.AddParameter("@city", Pno);
        ObjDBManager.AddParameter("@mobile", mobile);
        ObjDBManager.AddParameter("@email", email);
        ObjDBManager.AddParameter("@RoleId", RoleId);

        if (int.Parse(userId) == 0)
        {
            ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@created_date", DateTime.Now);

            ObjDBManager.InsertUpdateProcedure("AddUser", "UnileverConnectionString");
        }
        else
        {
            ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@modified_date", DateTime.Now);
            ObjDBManager.InsertUpdateProcedure("UpdateUser", "UnileverConnectionString");
        }
    }
    #endregion
}