using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.IO;
//using OfficeOpenXml;
//using OfficeOpenXml.Style;
using System.Drawing;
using System.Web.Security;
using System.Web;
using System.Security.Cryptography;
using System.Collections;

/// <summary>
/// Summary description for DBCommonMethods
/// </summary>
public class DBCommonMethods
{
    DBManager dbManager = new DBManager();
    //static Excel.Worksheet xlWorkSheetToExport = null;
  //  static ExcelWorksheet xlWorkSheetToExport = null;
    static int iRowCnt = 1, picHeight = 40, picWidth = 60;
    static List<string> serventIds = new List<string>();
    static List<int> headingRows = new List<int>();
    static string path;
	public DBCommonMethods()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static Dictionary<string, object> getCNICAndName(string CNIC)
    {

        string Query = "SELECT EID,ServiceNo,CardNumber,HR_Designation.designation as Rank,isnull(convert(varchar(10), AllotmentDate,101),'') as AllotmentDate, " +
" FirstName,LastName,CurrAddr,PerAddr,Nic,convert(varchar(10), Dob,101) as Dob, PhoneOffice,PhoneHome,Mobile, " +
" isnull(convert(varchar(10), ReleaseDate,101),'') as ReleaseDate," +
"  host.[HOST_NAME] as Location,Department_Name as Department,HR_Designation.designation as Designation,BarCode,Photo," +
" _Status as [status] from Employee" +
" inner join host on Employee.Location=host.id" +
" inner join mctx_Department on Employee.Department=mctx_Department.Department_ID" +
" left join HR_Designation on Employee.Rank=HR_Designation.Designation_ID where Status = 'Active'";
        if (CNIC != null && CNIC != "")
        {
            Query += " and Nic ='" + CNIC + "' ";
        }

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "EmployeeDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["EmployeeDetail"];
        return ToJson(dt);

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

    public static string[] GetCNICNos(string CNIC, string Type = "1", string Name = "", string Rank = "", string Status = "1")
    {
        string recordTable = "Employee";
        if (Type == "2")
        {
            recordTable = "NonResident";
        }
        else if (Type == "3")
        {
            recordTable = "Visitor";
        }
        List<string> customers = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["vmsconnectionstring"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select Nic, FirstName from " + recordTable + " where " +
                " Nic like'%" + CNIC + "%' ";
                //cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}", sdr["Nic"]));
                      
                    }
                }
                conn.Close();
            }
            return customers.ToArray();
        }
    }
    public static string[] GetVisitorReferenceName(string Name)
    {

        List<string> customers = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["vmsconnectionstring"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select emp.EID, emp.FirstName +' '+ emp.LastName as ReferenceName,emp.ServiceNo,emp.Rank_ID,emp.Designation,emp.CurrAddr from Employee emp  where " +

                " emp.FirstName+' '+ emp.LastName like '%" + Name + "%' ";
                //cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}  & Service # {1}**  EID &&{2} Rank &Rnk{3} Desig &Dsg{4} EmpAdddress &EmpAdd{5}*", sdr["ReferenceName"], sdr["ServiceNo"], sdr["EID"], sdr["Rank_ID"], sdr["Designation"], sdr["CurrAddr"]));
                        //customers.Add(string.Format("{0}", sdr["EID"]));
                    }
                }
                conn.Close();
            }
            return customers.ToArray();
        }
    }
    public static string[] GetNames(string Name, string Type = "1", string CNIC = "", string Rank = "", string Status = "1")
    {
        string recordTable = "Employee";
        if (Type == "2")
        {
            recordTable = "NonResident";
        }
        else if (Type == "3")
        {
            recordTable = "Visitor";
        }

        Name = Name.ToLower();

        List<string> customers = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["vmsconnectionstring"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select  FirstName,LastName from " + recordTable + " where " +
                " LOWER(FirstName) like'%" + Name + "%' OR LOWER(LastName) like'%" + Name + "%' and Status = 'Active'";
                //cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}", sdr["FirstName"] + " " + sdr["LastName"]));
                    }
                }
                conn.Close();
            }
            return customers.ToArray();
        }
    }

    public static Dictionary<string, object> GetAllDesignations()
    {
        string Query = "select Designation_ID, designation from HR_Designation"; 
        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "Designations", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["Designations"];
        return ToJson(dt);
    }
   

    #region Reports
    #region Get  Employee by CNIC No
    public static Dictionary<string, object> getCNICWiseReport(string CNIC, string Type = "1")
    {
        string Query = "";
        if (Type == "1")
        {
            Query = "SELECT top 100 EID,ServiceNo,CardNumber, Employee.Status,isnull(HR_Designation.designation,'') as Rank,isnull(convert(varchar(10), AllotmentDate,101),'') as AllotmentDate, " +  
     "FirstName,LastName,CurrAddr,PerAddr,Nic,convert(varchar(10), Dob,101) as Dob, PhoneOffice,PhoneHome,Mobile,  "+
     "isnull(convert(varchar(10), ReleaseDate,101),'') as ReleaseDate, "+
      "host.[HOST_NAME] as Location,isnull(Department_Name,'') as Department,HR_Designation.designation as Designation,BarCode,NewPhoto as Photo, " +
     "_Status as [status] from Employee "+
    "  left join mctx_Department on Employee.Department=mctx_Department.Department_ID" +
    " left join host on Employee.Location=host.ID " +
    " left join mctx_Ranks Rnk on Employee.Rank_ID=Rnk.Rank_ID   " +
    "     left join HR_Designation on Employee.Designation=HR_Designation.Designation_ID where 1=1";
            if (CNIC != null && CNIC != "")
            {
                Query += " and Nic ='" + CNIC + "' ";
            }
        }
        else if (Type == "2")
        {
            //Query = "SELECT em.NRID as EID,'' as ServiceNo,em.CardNumber,des.designation as Rank,'' as AllotmentDate," +
            //        "em.FirstName,em.LastName,em.CurrAddr,em.PerAddr,em.Nic,'' as Dob, em.PhoneOffice,em.PhoneHome,em.Mobile," +
            //        "'' as ReleaseDate,'' as Location,dep.Department_Name as Department,des.designation as Designation,em.BarCode,em.Photo," +
            //        "em._Status as [status] from NonResident em inner join mctx_Department dep on em.Department= dep.Department_ID " +
            //        "left join HR_Designation des on em.Designation= des.Designation_ID where Status = 'Active' ";
            //if (CNIC != null && CNIC != "")
            //{
            //    Query += " and Nic like'%" + CNIC + "%' ";
            //}
            Query = "SELECT nr.NRID,nr.CardNumber,nr.FirstName, nr.LastName,nr.RelName,nr.CurrAddr,nr.PerAddr,nr.NIC,nr.PhoneHome, "+
                    "nr.PhoneOffice,nr.Mobile,relg.Religion_Name as Religion,nr.Sectt,cst.Caste_Name as Caste,nr.Education,nr.Witness1Name,nr.Witness1Addr,nr.Witness2Name,nr.Witness2Addr, "+
                    "nr.Authority,convert(varchar(10), nr.DateofEntry,101) as DateofEntry,nr.Firm,nr.FirmAddr,nr.Product,nr.ShopKeeper,nr.Status ,isnull(dep.Department_Name,'') as Department, " +
                    "nr.Market,nr.Status,nr.photo as Photo, des.designation as Designation,isnull(rel.Relation_Name, '') as Rel "+
                    "FROM NonResident nr "+
                    "left join mctx_Religion relg on nr.Religion = relg.Religion_ID "+
                    "left join mctx_Caste cst on nr.Caste = cst.Caste_ID " +
                    "left join mctx_Department dep on nr.Department = dep.Department_ID " +
                    "left join HR_Designation des on nr.Designation = des.Designation_ID " +
                    "left join mctx_Relation rel on nr.Rel = rel.Relation_ID where 1=1 ";

            if (CNIC != null && CNIC != "")
            {
                Query += " and nr.Nic ='" + CNIC + "' ";
            }

        }
        else if (Type == "3")
        {

            Query = " select v.FirstName, v.LastName, v.VID, isnull(v.CardNo,'') as CardNo, des.designation as Rank, v.NIC, v.Phone, v.Mobile, v.Addr, v.Profession, v.VisitPurpose, " +
                    " v.VisitDays, v.IssueDt, v.ValidUpto, v.ReferenceName, isnull(rel.Relation_Name,'') as Relation, v.Status, v.BarCode, v.ReferenceAdd as Reference, v.Photo " +
                    " from Visitor v "+
                    " left join HR_Designation des on v.Rank = des.Designation_ID left join mctx_Relation rel on v.Relation = rel.Relation_ID where 1=1 ";
            if (CNIC != null && CNIC != "")
            {
                Query += " and v.NIC ='" + CNIC + "' ";
            }
        }

        else if (Type == "4")
        {

            Query = "SELECT  [ID] ,[CNIC] as NIC,[VISITOR_NAME],[FATHER_NAME],[DOB],[ADDRESS],[DATE],[TIME_IN],[TIME_OUT] " +
             " ,[HOST],[VEHICLE_NUMBER],[TOKEN_NUMBER],[DEPARTMENT],[GATE_NUMBER],[NAME] as FirstName, '' as LastName,[PHONE_NUMBER] " +
             " ,[RESTRICTED],[PICTURE_ID],[mctx_visitor].[IsHandled],[Is_deleted],[Client_IP],[Relations],[Status] " +
             " ,[Visit_Purpose] as VisitPurpose,[NewPhoto],RFID AS CardNo " +
             " FROM [mctx_visitor] INNER JOIN dbo.mctx_VirdiUsers ON dbo.mctx_visitor.ID=dbo.mctx_VirdiUsers.User_ID " +
             " WHERE dbo.mctx_VirdiUsers.User_Type='mctx_visitor' ";
            if (CNIC != null && CNIC != "")
            {
                Query += " and CNIC ='" + CNIC + "' ";
            }
        }


        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "EmployeeDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["EmployeeDetail"];
        return ToJson(dt);

    }


    public static Dictionary<string, object> getIDWiseReport(string ID, string Type = "1")
    {
        string Query = "";
        if (Type == "1")
        {
           Query = "SELECT EID,ServiceNo,CardNumber, Employee.Status,isnull(HR_Designation.designation,'') as Rank,isnull(convert(varchar(10), AllotmentDate,101),'') as AllotmentDate, " +  
     "FirstName,LastName,CurrAddr,PerAddr,Nic,convert(varchar(10), Dob,101) as Dob, PhoneOffice,PhoneHome,Mobile,  "+
     "isnull(convert(varchar(10), ReleaseDate,101),'') as ReleaseDate, "+
      "host.[HOST_NAME] as Location,Department_Name as Department,HR_Designation.designation as Designation,BarCode,NewPhoto as Photo, " +
     "_Status as [status] from Employee " +
    "  left join mctx_Department on Employee.Department=mctx_Department.Department_ID" +
    " left join host on Employee.Location=host.ID " +
    " left join mctx_Ranks Rnk on Employee.Rank_ID=Rnk.Rank_ID   " +
    "     left join HR_Designation on Employee.Designation=HR_Designation.Designation_ID where 1=1";
            if (ID != null && ID != "")
            {
                Query += " and EID ='" + ID + "' ";
            }
        }
        else if (Type == "2")
        {
            //Query = "SELECT em.NRID as EID,'' as ServiceNo,em.CardNumber,des.designation as Rank,'' as AllotmentDate," +
            //        "em.FirstName,em.LastName,em.CurrAddr,em.PerAddr,em.Nic,'' as Dob, em.PhoneOffice,em.PhoneHome,em.Mobile," +
            //        "'' as ReleaseDate,'' as Location,dep.Department_Name as Department,des.designation as Designation,em.BarCode,em.Photo," +
            //        "em._Status as [status] from NonResident em inner join mctx_Department dep on em.Department= dep.Department_ID " +
            //        "left join HR_Designation des on em.Designation= des.Designation_ID where Status = 'Active'";
            Query = "SELECT nr.NRID,nr.CardNumber,nr.FirstName, nr.LastName,nr.RelName,nr.CurrAddr,nr.PerAddr,nr.NIC,nr.PhoneHome, "+
                    "nr.PhoneOffice,nr.Mobile,relg.Religion_Name as Religion,nr.Sectt,cst.Caste_Name as Caste,nr.Education,nr.Witness1Name,nr.Witness1Addr,nr.Witness2Name,nr.Witness2Addr, "+
                    "nr.Authority,convert(varchar(10), nr.DateofEntry,101) as DateofEntry,nr.Firm,nr.FirmAddr,nr.Product,nr.ShopKeeper, dep.Department_Name as Department, "+
                    "nr.Market,nr.Status,nr.NewPhoto as Photo, des.designation as Designation, rel.Relation_Name as Rel " +
                    "FROM NonResident nr "+
                    "inner join mctx_Religion relg on nr.Religion = relg.Religion_ID "+
                    "inner join mctx_Caste cst on nr.Caste = cst.Caste_ID "+
                    "inner join mctx_Department dep on nr.Department = dep.Department_ID "+
                    "inner join HR_Designation des on nr.Designation = des.Designation_ID "+
                    "inner join mctx_Relation rel on nr.Rel = rel.Relation_ID where 1 = 1 ";
            if (ID != null && ID != "")
            {
                Query += " and nr.NRID ='" + ID + "' ";
            }

        }
        else if (Type == "3")
        {
            //Query = "SELECT em.VID as EID,'' as ServiceNo,em.CardNo as CardNumber,des.designation as Rank,'' as AllotmentDate," +
            //        "em.FirstName,em.LastName,em.Addr as CurrAddr,em.Addr as PerAddr,em.Nic,'' as Dob, em.Phone as PhoneOffice,'' as PhoneHome,em.Mobile," +
            //        "'' as ReleaseDate,'' as Location,'' as Department,des.designation as Designation,em.BarCode,em.Photo," +
            //        "em.Status as [status] from Visitor em left join HR_Designation des on em.Rank= des.Designation_ID where Status = 'Active'";
            Query = " select v.FirstName, v.LastName, v.VID, v.CardNo, des.designation as Rank, v.NIC, v.Phone, v.Mobile, v.Addr, v.Profession, v.VisitPurpose, " +
                   " v.VisitDays, v.IssueDt, v.ValidUpto, v.ReferenceName, rel.Relation_Name as Relation, v.Status, v.BarCode, v.ReferenceAdd as Reference, v.NewPhoto Photo " +
                   " from Visitor v " +
                   " left join HR_Designation des on v.Rank = des.Designation_ID left join mctx_Relation rel on v.Relation = rel.Relation_ID where 1=1 ";
            if (ID != null && ID != "")
            {
                Query += " and v.VID ='" + ID + "' ";
            }
        }

        else if(Type =="4")
        {

            Query = "SELECT  [ID] ,[CNIC] as NIC,[VISITOR_NAME],[FATHER_NAME],[DOB],[ADDRESS],[DATE],[TIME_IN],[TIME_OUT] " +
           " ,[HOST],[VEHICLE_NUMBER],[TOKEN_NUMBER],[DEPARTMENT],[GATE_NUMBER],[NAME] as FirstName, '' as LastName,[PHONE_NUMBER] " +
           " ,[RESTRICTED],[PICTURE_ID],[mctx_visitor].[IsHandled],[Is_deleted],[Client_IP],[Relations],[Status] " +
           " ,[Visit_Purpose] as VisitPurpose,[NewPhoto] as Photo,RFID AS CardNo " +
           " FROM [mctx_visitor] INNER JOIN dbo.mctx_VirdiUsers ON dbo.mctx_visitor.ID=dbo.mctx_VirdiUsers.User_ID " +
           " WHERE dbo.mctx_VirdiUsers.User_Type='mctx_visitor' ";
            if (ID != null && ID != "")
            {
                Query += " and ID ='" + ID + "' ";
            }

        }

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "EmployeeDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["EmployeeDetail"];
        return ToJson(dt);

    }


    public static Dictionary<string, object> getEmployeeFamily(string EID)
    {

        string Query = " SELECT ef.EID,ef.EFID,ef.CardNumber,ef.FirstName,ef.LastName, " +
                        "[mctx_Relation].Relation_Name as Relation,ef.NIC,ef.Mobile,ef.BarCode,ef.Status,ef.NewPhoto Photo,ef.vaddr,ef.vpurpose,ef._status as [status], " + 
                        "(em.FirstName + ' ' + em.LastName) as empName "+ 
                        "FROM EmployeeFamily ef inner join Employee em on ef.EID = em.EID "+
                        "inner join mctx_Relation on ef.Relation=mctx_Relation.Relation_ID "+
                        "where ef.EID= " + EID;


        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "EmployeeFamilyDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["EmployeeFamilyDetail"];
        return ToJson(dt);

    }

    public static Dictionary<string, object> getEmployeeSerant(string EID)
    {

        string Query = "SELECT sr.SID,sr.EID,sr.CardNumber,sr.FirstName,sr.LastName,sr.FH,sr.CurrAddr,sr.PerAddr,sr.Caste,convert(varchar,sr.DOB,101) as DOB,sr.PlaceofWork, "+
                        " sr.NIC, mctx_Religion.Religion_Name as Religion,sr.MarkofIdentification,convert(varchar,sr.DOB,101) as ResidenceDate,convert(varchar,sr.DOB,101) as ReleaseDate,sr.Status,sr.NewPhoto Photo,sr.text1,sr.text2,sr.text3, " +
                        " sr.text4,sr.phoneoffice,sr.phonehome,sr.mobile, (em.FirstName + ' ' + em.LastName) as empName "+
                        " FROM Servant sr "+
                        " inner join Employee em on sr.EID = em.EID "+
                        " inner join mctx_Religion on sr.Religion=mctx_Religion.Religion_ID "+
                        " WHERE  sr.EID= " + EID;


        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "EmployeeServantDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["EmployeeServantDetail"];
        return ToJson(dt);

    }

    public static Dictionary<string, object> getEmployeeServantFamily(string SID)
    {

        string Query = "SELECT sf.SFID,sf.SID,sf.EID,sf.CardNumber,sf.FirstName,sf.LastName,sf.Profession,rel.Relation_Name as Relation,sf.NIC," +
                        "sf.PlaceofWork,sf.Status,sf.NewPhoto Photo,sf.Mobile, (ser.FirstName + ' ' + ser.LastName) as ServantName " +
                        "FROM ServantFamily sf inner join mctx_Relation rel on sf.Relation= rel.Relation_ID " +
                        "inner join Servant ser on sf.SID = ser.SID " +
                        "WHERE sf.SID= " + SID ;

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "EmployeeServantFamilyDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["EmployeeServantFamilyDetail"];
        return ToJson(dt);

    }

    //public static Dictionary<string, object> getEmployeeSerantFamily(string EID)
    //{

    //    string Query = " SELECT SFID,SID,EID,CardNumber,FirstName,LastName,Profession,mctx_Relation.Relation_Name as Relation,NIC,PlaceofWork,Status,Photo,Mobile " +
    //    "FROM ServantFamily inner join mctx_Relation on ServantFamily.Relation=mctx_Relation.Relation_ID " +
    //    "WHERE EID=" + EID ;


    //    DBManager ObjDBManager = new DBManager();
    //    DataSet ds = ObjDBManager.SelectQuery(Query, "EmployeeServantFamilyDetail", "vmsconnectionstring");
    //    DataTable dt = new DataTable();
    //    dt = ds.Tables["EmployeeServantFamilyDetail"];
    //    return ToJson(dt);

    //}
    #endregion

    #region Get  Employee by Name
    public static Dictionary<string, object> getEmployeeNameWiseReport(string Name, string Type = "1", string CNIC = "", string Rank = "", string Status = "",string From="", string To="")
    {
        string Query = "";
        if (Type == "1")
        {
            Query = "SELECT EID,ServiceNo,CardNumber, Employee.Status,isnull(HR_Designation.designation,'') as Rank,isnull(convert(varchar(10), AllotmentDate,101),'') as AllotmentDate, " +
    " FirstName,LastName,CurrAddr,PerAddr,Nic,convert(varchar(10), Dob,101) as Dob, PhoneOffice,PhoneHome,Mobile,  " +
    " isnull(convert(varchar(10), ReleaseDate,101),'') as ReleaseDate, " +
    " host.[HOST_NAME] as Location,isnull(Department_Name,'') as Department,HR_Designation.designation as Designation,BarCode,NewPhoto as Photo, " +
    " _Status as [status] from Employee " +
    " left join mctx_Department on Employee.Department=mctx_Department.Department_ID" +
    " left join host on Employee.Location=host.ID " +
    " left join mctx_Ranks Rnk on Employee.Rank_ID=Rnk.Rank_ID   " +
    " left join HR_Designation on Employee.Designation=HR_Designation.Designation_ID" +
    " where 1=1";

            if (!string.IsNullOrEmpty(Name))
            {
                 Query += "and (FirstName + ' ' + LastName) like'%" + Name + "%' ";
            }
            if (!string.IsNullOrEmpty(CNIC))
            {
                Query += " and ( Nic ='" + CNIC + "' OR CardNumber = '"+CNIC+"' )";
            }
            if (!string.IsNullOrEmpty(Rank))
            {
                Query += " and HR_Designation.Designation_ID ='" + Rank + "'";
            }
            if (!string.IsNullOrEmpty(Status))
            {
               // Status = Status.ToUpper();
                Query += " and Status = '" + Status + "'";
            }
        }
        else if (Type == "2")
        {
            //Query = "SELECT em.NRID as EID,'' as ServiceNo,em.CardNumber,des.designation as Rank,'' as AllotmentDate," +
            //        "em.FirstName,em.LastName,em.CurrAddr,em.PerAddr,em.Nic,'' as Dob, em.PhoneOffice,em.PhoneHome,em.Mobile," +
            //        "'' as ReleaseDate,'' as Location,dep.Department_Name as Department,des.designation as Designation,em.BarCode,em.Photo," +
            //        "em._Status as [status] from NonResident em inner join mctx_Department dep on em.Department= dep.Department_ID " +
            //        "left join HR_Designation des on em.Designation= des.Designation_ID " +
            //        "where (em.FirstName + ' ' + em.LastName) like '%" + Name + "%'";
            Query = " SELECT nr.NRID,nr.CardNumber,nr.FirstName, nr.LastName,nr.RelName ,nr.CurrAddr,nr.PerAddr,nr.NIC,nr.PhoneHome, " +
                    " nr.PhoneOffice,nr.Mobile,relg.Religion_Name as Religion,nr.Sectt,cst.Caste_Name as Caste,nr.Education,nr.Witness1Name,nr.Witness1Addr,nr.Witness2Name,nr.Witness2Addr, " +
                    " nr.Authority,convert(varchar(10), nr.DateofEntry,101) as DateofEntry,nr.Firm,nr.FirmAddr,nr.Product,nr.ShopKeeper,isnull( dep.Department_Name,'') as Department, " +
                    " nr.Market,nr.Status,nr.photo as Photo, isnull(des.designation,'') as Designation, rel.Relation_Name as Rel " +
                    " FROM NonResident nr " +
                    " left join mctx_Religion relg on nr.Religion = relg.Religion_ID " +
                    " left join mctx_Caste cst on nr.Caste = cst.Caste_ID " +
                    " left join mctx_Department dep on nr.Department = dep.Department_ID " +
                    " left join HR_Designation des on nr.Designation = des.Designation_ID " +
                    " left join mctx_Relation rel on nr.Rel = rel.Relation_ID " +
                    " where 1=1 ";

            if (!string.IsNullOrEmpty(Name))
            {
                Query += "and (nr.FirstName + ' ' + nr.LastName) like'%" + Name + "%' ";
            }
            if (!string.IsNullOrEmpty(CNIC))
            {
                Query += " and ( nr.Nic ='" + CNIC + "' OR nr.CardNumber = '" + CNIC + "' )";
            }
            if (!string.IsNullOrEmpty(Rank))
            {
                Query += " and des.Designation_ID ='" + Rank + "'";
            }
          
            if (!string.IsNullOrEmpty(Status))
            {
               
                Query += " and  nr.Status ='" + Status + "'";
            }

        }
        else if (Type == "3")
        {
            //Query = "SELECT em.VID as EID,'' as ServiceNo,em.CardNo as CardNumber,des.designation as Rank,'' as AllotmentDate," +
            //        "em.FirstName,em.LastName,em.Addr asCurrAddr,em.Addr as PerAddr,em.Nic,'' as Dob, em.Phone as PhoneOffice,'' as PhoneHome,em.Mobile," +
            //        "'' as ReleaseDate,'' as Location,'' as Department,des.designation as Designation,em.BarCode,em.Photo," +
            //        "em.Status as [status] from Visitor em left join HR_Designation des on em.Rank= des.Designation_ID " +
            //        "where (em.FirstName + ' ' + em.LastName) like '%" + Name + "%'";
            Query = " select v.FirstName, v.LastName, v.VID, isnull(v.CardNo,'') as CardNo, des.designation as Rank, v.NIC, v.Phone, v.Mobile, v.Addr, v.Profession, isnull(v.VisitPurpose,'') as VisitPurpose, " +
                   "  v.VisitDays, v.IssueDt, v.ValidUpto, v.ReferenceName, isnull(rel.Relation_Name,'') as Relation, v.Status, v.BarCode, v.ReferenceAdd as Reference, v.Photo " +
                   "  from Visitor v " +
                   "  left join HR_Designation des on v.Rank = des.Designation_ID left join mctx_Relation rel on v.Relation = rel.Relation_ID "+
           
                   "  where 1=1 ";

            if (!string.IsNullOrEmpty(Name))
            {
                Query += "and (v.FirstName + ' ' + v.LastName) like'%" + Name + "%' ";
            }
            if (!string.IsNullOrEmpty(CNIC))
            {
                Query += " and ( v.Nic ='" + CNIC + "' OR v.CardNo = '" + CNIC + "' )";
            }
            if (!string.IsNullOrEmpty(Rank))
            {
                Query += " and des.Designation_ID ='" + Rank + "'";
            }

            if (!string.IsNullOrEmpty(Status))
            {
               
                Query += " and v.Status ='" + Status + "'";
            }
                    
        }
        else if (Type == "4")
        {


            Query = " SELECT  [ID] ,[CNIC] as NIC,[VISITOR_NAME],[FATHER_NAME],[DOB],[ADDRESS],[DATE],[TIME_IN],[TIME_OUT] " +
           " ,[HOST],[VEHICLE_NUMBER],[TOKEN_NUMBER],[DEPARTMENT],[GATE_NUMBER],[NAME] as FirstName, '' as LastName,[PHONE_NUMBER] " +
           " ,[RESTRICTED],[PICTURE_ID],[mctx_visitor].[IsHandled],[Is_deleted],[Client_IP],[Relations],[Status] " +
           " ,[Visit_Purpose] as VisitPurpose,[NewPhoto] as Photo,RFID AS CardNo " +
           "  FROM [mctx_visitor] INNER JOIN dbo.mctx_VirdiUsers ON dbo.mctx_visitor.ID=dbo.mctx_VirdiUsers.User_ID " +
                // " WHERE dbo.mctx_VirdiUsers.User_Type='mctx_visitor' and "+
           "  where  1=1 ";
           //"AND [Date] between '" + From + "' and '" + To + "'";

            if (!string.IsNullOrEmpty(Name))
            {
                Query += " and NAME like'%" + Name + "%'";
            }
          
           
        if (!string.IsNullOrEmpty(CNIC))
            {
                Query += " and CNIC ='" + CNIC + "'";
            }
           
            if (!string.IsNullOrEmpty(Status))
            {
               
                Query += " and  Status ='" + Status + "'";
            }
            if (!string.IsNullOrEmpty(From) && !string.IsNullOrEmpty(To))
            {

                DateTime dtFrom = DateTime.Parse(From);
                DateTime dtTo = DateTime.Parse(To);
                string NewDateFrom = dtFrom.ToString("M/d/yyyy");
                string NewDateTo = dtTo.ToString("M/d/yyyy");
                Query += "AND [Date] between '" + NewDateFrom + "' and '" + NewDateTo + "'";
            }
        


        }
        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "EmployeeDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["EmployeeDetail"];
        return ToJson(dt);


    }
    #endregion


    #region Get  Visitor by Date
    public static Dictionary<string, object> getVisitorDateWiseReport(string FromDate, string ToDate)
    {

        string Query = "SELECT  [ID],[CNIC],[VISITOR_NAME],[FATHER_NAME],[DOB],[ADDRESS],[DATE],[TIME_IN],[TIME_OUT],[HOST],[VEHICLE_NUMBER]" +
         " ,[TOKEN_NUMBER],[DEPARTMENT],[GATE_NUMBER],[NAME],[PHONE_NUMBER],[RESTRICTED],[PICTURE_ID]  FROM [visitor] where Status = 'Active'";
        if (FromDate != null && FromDate != "")
        {
            DateTime dtFrom = Convert.ToDateTime(FromDate);
            string dtFromOnlyDate = string.Format("{0:M/d/yyyy}", dtFrom);
            DateTime dtTo = Convert.ToDateTime(ToDate);
            string dtToOnlyDate = string.Format("{0:M/d/yyyy}", dtTo);
            Query += " and [Date] between '" + dtFromOnlyDate + "' and '" + dtToOnlyDate + "'";
        }
        Query += " order by [ID] desc";
        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "VisitorDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["VisitorDetail"];
        return ToJson(dt);

    }
    #endregion
    #endregion

    //#region Export Excel

    //public static string ExportToExcel(string pathParam, string[] empIds, string recordType = "1", string fileName = "EmployeeDetails", string employeeFamilyId = "")
    //{
    //    string returnValue = "";
    //    // SET THE CONNECTION STRING.
    //    try
    //    {
    //        string dirPath = pathParam + "\\exportedfiles\\";
    //        path = pathParam;

    //        if (!Directory.Exists(dirPath))   // CHECK IF THE FOLDER EXISTS. IF NOT, CREATE A NEW FOLDER.
    //        {
    //            Directory.CreateDirectory(dirPath);
    //        }
    //        FileInfo newFile = new FileInfo(dirPath + fileName + ".xlsx");
    //        if (newFile.Exists)
    //        {
    //            newFile.Delete();  // ensures we create a new workbook
    //            newFile = new FileInfo(dirPath + fileName + ".xlsx");
    //        }

    //        // ADD A WORKBOOK USING THE EXCEL APPLICATION.
    //        ExcelPackage xlAppToExport = new ExcelPackage(newFile);
    //        // ADD A WORKSHEET.
    //        xlWorkSheetToExport = xlAppToExport.Workbook.Worksheets.Add("workbook1");

    //        // ROW ID FROM WHERE THE DATA STARTS SHOWING.
    //        iRowCnt = 1;

    //        if (recordType == "1") {
    //            EmployeeDetails(empIds, recordType);
    //            if (!String.IsNullOrEmpty(employeeFamilyId))    // Family and Servant details of which employee is shown on browser (or not shown)
    //            {
    //                string[] familyIds = { employeeFamilyId };
    //                EmployeeFamilyDetails(familyIds, recordType);
    //                EmployeeServantDetails(familyIds, recordType);
    //                EmployeeServantFamilyDetails();
    //            }
    //        } else if (recordType == "2") {
    //            NonResidentDetails(empIds, recordType);
    //        } else if (recordType == "3") {
    //            VisitorDetails(empIds, recordType);
    //        }
    //        else if (recordType == "4")
    //        {
    //            VMSVisitorDetails(empIds, recordType);
    //        }
            
    //        if (recordType == "1" && !String.IsNullOrEmpty(employeeFamilyId))
    //        {
                
    //        }

    //        for (int j = 1; j <= 15; j++)
    //        {
    //            xlWorkSheetToExport.Column(j).AutoFit(10,20);
    //        }

    //        // SAVE THE FILE IN A FOLDER.
    //        xlWorkSheetToExport.Calculate();
    //        xlAppToExport.Save();

            
    //    }
    //    catch (Exception ex)
    //    {
    //        returnValue = ex.Message.ToString();
    //    }
    //    finally
    //    {

    //    }
    //    return returnValue;
    //}
    ///* Export to Excel Using InterOP
    //public static string ExportToExcelOrignal(string pathParam, string[] empIds, string recordType, string fileName)
    //{
    //    string returnValue = "";
    //    // SET THE CONNECTION STRING.
    //    try
    //    {
    //        string dirPath = pathParam + "\\exportedfiles\\";
    //        path = pathParam;
    //        if (!Directory.Exists(dirPath))   // CHECK IF THE FOLDER EXISTS. IF NOT, CREATE A NEW FOLDER.
    //        {

    //            Directory.CreateDirectory(dirPath);
    //        }

    //        File.Delete(dirPath + fileName + ".xlsx"); // DELETE THE FILE BEFORE CREATING A NEW ONE.

    //        // Set "Everyone" Permission to Folder 
    //        string redirectionFolder = Convert.ToString(dirPath);
    //        FileSystemAccessRule everyOne = new FileSystemAccessRule("Everyone", FileSystemRights.FullControl, AccessControlType.Allow);
    //        DirectorySecurity dirSecurity = new DirectorySecurity(redirectionFolder, AccessControlSections.Group);
    //        dirSecurity.AddAccessRule(everyOne);
    //        Directory.SetAccessControl(redirectionFolder, dirSecurity);

    //        // ADD A WORKBOOK USING THE EXCEL APPLICATION.
    //        Excel.Application xlAppToExport = new Excel.Application();
    //        xlAppToExport.Workbooks.Add("");

    //        // ADD A WORKSHEET.
    //        xlWorkSheetToExport = default(Excel.Worksheet);
    //        xlWorkSheetToExport = (Excel.Worksheet)xlAppToExport.Sheets["Sheet1"];

    //        // ROW ID FROM WHERE THE DATA STARTS SHOWING.
    //        iRowCnt = 1;

    //        // SHOW THE HEADER.
    //        //xlWorkSheetToExport.Cells[1, 1] = "Employee Details";

    //        //Excel.Range range = xlWorkSheetToExport.Cells[1, 1] as Excel.Range;
    //        //range.EntireRow.Font.Name = "Calibri";
    //        //range.EntireRow.Font.Bold = true;
    //        //range.EntireRow.Font.Size = 20;

    //        //xlWorkSheetToExport.Range["A1:D1"].MergeCells = true;       // MERGE CELLS OF THE HEADER.

    //        EmployeeDetails(empIds, recordType);
    //        if (recordType == "1")
    //        {
    //            EmployeeFamilyDetails(empIds, recordType);
    //            EmployeeServantDetails(empIds, recordType);
    //            EmployeeServantFamilyDetails();
    //        }
    //        // FINALLY, FORMAT THE EXCEL SHEET USING EXCEL'S AUTOFORMAT FUNCTION.
    //        for (int j = 1; j < iRowCnt; j++)
    //        {
    //            Excel.Range range1 = xlAppToExport.ActiveCell.Worksheet.Cells[j, 1] as Excel.Range;
    //            if (headingRows.Contains(j))
    //                range1.AutoFormat(ExcelAutoFormat.xlRangeAutoFormatList3);
    //            range1.RowHeight = 30;
    //            range1.ColumnWidth = 15;
    //        }

    //        // SAVE THE FILE IN A FOLDER.
    //        xlWorkSheetToExport.SaveAs(dirPath + fileName + ".xlsx");


    //        // CLEAR.
    //        xlAppToExport.Workbooks.Close();
    //        xlAppToExport.Quit();
    //        xlAppToExport = null;
    //        xlWorkSheetToExport = null;

    //        //lblConfirm.Text = "Data Exported Successfully";
    //        //lblConfirm.Attributes.Add("style", "color:green; font: normal 14px Verdana;");
    //        //btView.Attributes.Add("style", "display:block");
    //        //btDownLoadFile.Attributes.Add("style", "display:block");

    //    }
    //    catch (Exception ex)
    //    {
    //        returnValue = ex.Message.ToString();
    //        //lblConfirm.Text = ex.Message.ToString();
    //        //lblConfirm.Attributes.Add("style", "color:red; font: bold 14px/16px Sans-Serif,Arial");
    //    }
    //    finally
    //    {

    //    }
    //    return returnValue;
    //}
    //*/
    //private static void EmployeeDetails(string[] empIds, string recordType)
    //{
    //    string pictureDir = path + "\\EmpPictures\\";
    //    string headerName = "Resident";
        
    //    // SHOW THE HEADER.
    //    xlWorkSheetToExport.Cells[iRowCnt, 1].Value = headerName + " Search Details";
    //    ExcelRange range = xlWorkSheetToExport.Cells[iRowCnt,1,iRowCnt,7];
    //    range.Style.Font.Bold = true;
    //    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
    //    range.Style.Fill.BackgroundColor.SetColor(Color.DarkBlue);
    //    range.Style.Font.Color.SetColor(Color.White);
    //    xlWorkSheetToExport.Row(iRowCnt).Height = 30;
    //    //range.RowHeight = 25;
    //    //range.ColumnWidth = 15;
    //    range.Merge = true;       // MERGE CELLS OF THE HEADER.
    //    range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

    //    iRowCnt++;

    //    int j = 0;
    //    // SHOW COLUMNS ON THE TOP.
    //    xlWorkSheetToExport.Cells[iRowCnt, 1].Value = "Service No";
    //    xlWorkSheetToExport.Cells[iRowCnt, 2].Value = "Name";
    //    xlWorkSheetToExport.Cells[iRowCnt, 3].Value = "Rank";
    //    xlWorkSheetToExport.Cells[iRowCnt, 4].Value = "NIC";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 5].Value = "Date of Birth";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Location";
    //    xlWorkSheetToExport.Cells[iRowCnt, 5].Value = "Department";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Allotment Date";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 7].Value = "Release Date";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 10].Value = "Cell No";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 11].Value = "Phone Office";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 12].Value = "Phone Home";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 13].Value = "Current Address";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 14].Value = "Permanent Address";
    //  xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Status";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 7].Value = "Release Date";
    //    xlWorkSheetToExport.Cells[iRowCnt, 7].Value = "Photo";

    //    range = xlWorkSheetToExport.Cells[iRowCnt, 1, iRowCnt, 7];
    //    range.Style.Font.Bold = true;
    //    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
    //    range.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
    //    range.Style.Font.Color.SetColor(Color.White);
    //    xlWorkSheetToExport.Row(iRowCnt).Height = 30;

    //    for (j = 0; j < empIds.Count(); j++)
    //    {
    //        if (String.IsNullOrEmpty(empIds[j]))
    //            continue;

    //        Dictionary<string, object> report = DBCommonMethods.getIDWiseReport(empIds[j], recordType);
    //        List<Dictionary<string, object>> employeeFamily = (List<Dictionary<string, object>>)report["EmployeeDetail"];

    //        for (int i = 0; i < employeeFamily.Count; i++)
    //        {
    //            iRowCnt++;
    //            xlWorkSheetToExport.Cells[iRowCnt, 1].Value = employeeFamily[i]["ServiceNo"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 2].Value = employeeFamily[i]["FirstName"].ToString() + " " + employeeFamily[i]["LastName"].ToString();
    //            xlWorkSheetToExport.Cells[iRowCnt, 3].Value = employeeFamily[i]["Rank"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 4].Value = employeeFamily[i]["Nic"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 5].Value = employeeFamily[i]["Dob"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["Location"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 5].Value = employeeFamily[i]["Department"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["AllotmentDate"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 7].Value = employeeFamily[i]["ReleaseDate"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 10].Value = employeeFamily[i]["Mobile"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 11].Value = employeeFamily[i]["PhoneOffice"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 12].Value = employeeFamily[i]["PhoneHome"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 13].Value = employeeFamily[i]["CurrAddr"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 14].Value = employeeFamily[i]["PerAddr"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 15] = employeeFamily[i]["Photo"];   

    //            xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["Status"];

    //            if (!Convert.IsDBNull(employeeFamily[i]["Photo"]))
    //            {
    //                byte[] imgData = (byte[])employeeFamily[i]["Photo"];
    //                if (imgData != null && imgData.Length > 0)
    //                {
    //                    MemoryStream ms = new MemoryStream(imgData);
    //                    Image img = Image.FromStream(ms);
    //                    var picture = xlWorkSheetToExport.Drawings.AddPicture(iRowCnt.ToString(), img);
    //                    picture.From.Column = 7 - 1;
    //                    picture.From.Row = iRowCnt - 1;
    //                    picture.SetSize(picWidth, picHeight);
    //                }
    //            }
               
             

    //            //if (File.Exists(pictureDir + employeeFamily[i]["Photo"] + ".JPG"))
    //            //{
    //            //    Image img =Image.FromFile(pictureDir + employeeFamily[i]["Photo"] + ".JPG");
    //            //    var picture = xlWorkSheetToExport.Drawings.AddPicture(iRowCnt.ToString(), img);
    //            //    picture.From.Column =7 - 1;
    //            //    picture.From.Row = iRowCnt - 1;
    //            //    picture.SetSize(picWidth, picHeight);
                    
    //            //    //Excel.Range pictureCell = xlWorkSheetToExport.Cells[iRowCnt, 15] as Excel.Range;
    //            //    //Excel.Shape pic = xlWorkSheetToExport.Shapes.AddPicture(pictureDir + employeeFamily[i]["Photo"] + ".JPG", MsoTriState.msoFalse, MsoTriState.msoCTrue, float.Parse(pictureCell.Left.ToString()), float.Parse(pictureCell.Top.ToString()), 46, 15);
    //            //    //pic.Placement = Excel.XlPlacement.xlMoveAndSize;
    //            //}

    //            xlWorkSheetToExport.Row(iRowCnt).Height = 30;
    //        }
    //    }
    //}

    //private static void NonResidentDetails(string[] empIds, string recordType)
    //{
    //    string pictureDir = path + "\\NoneResidentsPictures\\";
    //    string headerName = "Non-Resident";

    //    // SHOW THE HEADER.
    //    xlWorkSheetToExport.Cells[iRowCnt, 1].Value = headerName + " Search Details";
    //    ExcelRange range = xlWorkSheetToExport.Cells[iRowCnt, 1, iRowCnt, 7];
    //    range.Style.Font.Bold = true;
    //    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
    //    range.Style.Fill.BackgroundColor.SetColor(Color.DarkBlue);
    //    range.Style.Font.Color.SetColor(Color.White);
    //    xlWorkSheetToExport.Row(iRowCnt).Height = 30;
    //    //range.RowHeight = 25;
    //    //range.ColumnWidth = 15;
    //    range.Merge = true;       // MERGE CELLS OF THE HEADER.
    //    range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

    //    iRowCnt++;

    //    int j = 0;
    //    // SHOW COLUMNS ON THE TOP.
    //    xlWorkSheetToExport.Cells[iRowCnt, 1].Value = "Card No";
    //    xlWorkSheetToExport.Cells[iRowCnt, 2].Value = "Name";
    //    xlWorkSheetToExport.Cells[iRowCnt, 3].Value = "CNIC NO.";
    //   // xlWorkSheetToExport.Cells[iRowCnt, 4].Value = "Relation";
    //   // xlWorkSheetToExport.Cells[iRowCnt, 5].Value = "Relation Name";
    //   // xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Current Address";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 7].Value = "Permenant Address";
    //    xlWorkSheetToExport.Cells[iRowCnt, 4].Value = "Department";
    //    xlWorkSheetToExport.Cells[iRowCnt, 5].Value = "Designation";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 10].Value = "Phone Home";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 11].Value = "Phone Office";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 12].Value = "Mobile";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 13].Value = "Religion";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 14].Value = "Sectt";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 15].Value = "Caste";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 16].Value = "Education";
    //    xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Status";
    //    xlWorkSheetToExport.Cells[iRowCnt, 7].Value = "Photo";

    //    range = xlWorkSheetToExport.Cells[iRowCnt, 1, iRowCnt, 7];
    //    range.Style.Font.Bold = true;
    //    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
    //    range.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
    //    range.Style.Font.Color.SetColor(Color.White);
    //    xlWorkSheetToExport.Row(iRowCnt).Height = 30;

    //    for (j = 0; j < empIds.Count(); j++)
    //    {
    //        if (String.IsNullOrEmpty(empIds[j]))
    //            continue;

    //        Dictionary<string, object> report = DBCommonMethods.getIDWiseReport(empIds[j], recordType);
    //        List<Dictionary<string, object>> employeeFamily = (List<Dictionary<string, object>>)report["EmployeeDetail"];

    //        for (int i = 0; i < employeeFamily.Count; i++)
    //        {
    //            iRowCnt++;
    //            xlWorkSheetToExport.Cells[iRowCnt, 1].Value = employeeFamily[i]["CardNumber"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 2].Value = employeeFamily[i]["FirstName"].ToString() + " " + employeeFamily[i]["LastName"].ToString();
    //            xlWorkSheetToExport.Cells[iRowCnt, 3].Value = employeeFamily[i]["NIC"];
    //            // xlWorkSheetToExport.Cells[iRowCnt, 4].Value = employeeFamily[i]["RelName"];
    //            // xlWorkSheetToExport.Cells[iRowCnt, 5].Value = employeeFamily[i]["Rel"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["CurrAddr"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 7].Value = employeeFamily[i]["PerAddr"];
    //          xlWorkSheetToExport.Cells[iRowCnt, 4].Value = employeeFamily[i]["Department"];
    //          xlWorkSheetToExport.Cells[iRowCnt, 5].Value = employeeFamily[i]["Designation"];

    //            //xlWorkSheetToExport.Cells[iRowCnt, 10].Value = employeeFamily[i]["PhoneHome"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 11].Value = employeeFamily[i]["PhoneOffice"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 12].Value = employeeFamily[i]["Mobile"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 13].Value = employeeFamily[i]["Religion"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 14].Value = employeeFamily[i]["Sectt"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 15].Value = employeeFamily[i]["Caste"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 16].Value = employeeFamily[i]["Education"];
    //          xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["Status"];

    //                                    //xlWorkSheetToExport.Cells[iRowCnt, 15] = employeeFamily[i]["Photo"];                
    //            //if (File.Exists(pictureDir + employeeFamily[i]["Photo"] + ".JPG"))
    //            //{
    //            //    Image img = Image.FromFile(pictureDir + employeeFamily[i]["Photo"] + ".JPG");
    //            //    var picture = xlWorkSheetToExport.Drawings.AddPicture(iRowCnt.ToString(), img);
    //            //    picture.From.Column = 7- 1;
    //            //    picture.From.Row = iRowCnt - 1;
    //            //    picture.SetSize(picWidth, picHeight);
    //            //}


    //          if (!Convert.IsDBNull(employeeFamily[i]["Photo"]))
    //          {
    //              byte[] imgData = (byte[])employeeFamily[i]["Photo"];
    //              if (imgData != null && imgData.Length > 0)
    //              {
    //                  MemoryStream ms = new MemoryStream(imgData);
    //                  Image img = Image.FromStream(ms);
    //                  var picture = xlWorkSheetToExport.Drawings.AddPicture(iRowCnt.ToString(), img);
    //                  picture.From.Column = 7 - 1;
    //                  picture.From.Row = iRowCnt - 1;
    //                  picture.SetSize(picWidth, picHeight);
    //              }
    //          }
               
             


    //            xlWorkSheetToExport.Row(iRowCnt).Height = 30;
    //        }
    //    }
    //}

    //private static void VisitorDetails(string[] empIds, string recordType)
    //{
    //    string pictureDir = path + "\\VisitorPictures\\";
    //    string headerName = "Visitor";

    //    // SHOW THE HEADER.
    //    xlWorkSheetToExport.Cells[iRowCnt, 1].Value = headerName + " Search Details";
    //    ExcelRange range = xlWorkSheetToExport.Cells[iRowCnt, 1, iRowCnt, 7];
    //    range.Style.Font.Bold = true;
    //    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
    //    range.Style.Fill.BackgroundColor.SetColor(Color.DarkBlue);
    //    range.Style.Font.Color.SetColor(Color.White);
    //    xlWorkSheetToExport.Row(iRowCnt).Height = 30;
    //    //range.RowHeight = 25;
    //    //range.ColumnWidth = 15;
    //    range.Merge = true;       // MERGE CELLS OF THE HEADER.
    //    range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

    //    iRowCnt++;

    //    int j = 0;
    //    // SHOW COLUMNS ON THE TOP.
    //    xlWorkSheetToExport.Cells[iRowCnt, 1].Value = "Card No";
    //    xlWorkSheetToExport.Cells[iRowCnt, 2].Value = "Name";
    //    xlWorkSheetToExport.Cells[iRowCnt, 3].Value = "NIC";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 4].Value = "Phone";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 5].Value = "Mobile";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Address";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 7].Value = "Job/Study";
    //    xlWorkSheetToExport.Cells[iRowCnt, 4].Value = "Visit Purpose";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 9].Value = "Visit Days";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 10].Value = "Issue Date";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 11].Value = "Valid Upto";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 12].Value = "Reference Name";
    //    xlWorkSheetToExport.Cells[iRowCnt, 5].Value = "Relation";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 14].Value = "Rank";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 15].Value = "Reference";
    //    xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Status";
    //    xlWorkSheetToExport.Cells[iRowCnt, 7].Value = "Photo";

    //    range = xlWorkSheetToExport.Cells[iRowCnt, 1, iRowCnt, 7];
    //    range.Style.Font.Bold = true;
    //    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
    //    range.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
    //    range.Style.Font.Color.SetColor(Color.White);
    //    xlWorkSheetToExport.Row(iRowCnt).Height = 30;

    //    for (j = 0; j < empIds.Count(); j++)
    //    {
    //        if (String.IsNullOrEmpty(empIds[j]))
    //            continue;

    //        Dictionary<string, object> report = DBCommonMethods.getIDWiseReport(empIds[j], recordType);
    //        List<Dictionary<string, object>> employeeFamily = (List<Dictionary<string, object>>)report["EmployeeDetail"];

    //        for (int i = 0; i < employeeFamily.Count; i++)
    //        {
    //            iRowCnt++;
    //            xlWorkSheetToExport.Cells[iRowCnt, 1].Value = employeeFamily[i]["CardNo"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 2].Value = employeeFamily[i]["FirstName"].ToString() + " " + employeeFamily[i]["LastName"].ToString();
    //            xlWorkSheetToExport.Cells[iRowCnt, 3].Value = employeeFamily[i]["NIC"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 4].Value = employeeFamily[i]["Phone"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 5].Value = employeeFamily[i]["Mobile"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["Addr"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 7].Value = employeeFamily[i]["Profession"];
    //              xlWorkSheetToExport.Cells[iRowCnt, 4].Value = employeeFamily[i]["VisitPurpose"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 9].Value = employeeFamily[i]["VisitDays"];

    //            //xlWorkSheetToExport.Cells[iRowCnt, 10].Value = employeeFamily[i]["IssueDt"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 11].Value = employeeFamily[i]["ValidUpto"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 12].Value = employeeFamily[i]["ReferenceName"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 5].Value = employeeFamily[i]["Relation"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 14].Value = employeeFamily[i]["Rank"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 15].Value = employeeFamily[i]["Reference"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 15] = employeeFamily[i]["Photo"]; 
    //            xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["Status"];
    //            //if (File.Exists(pictureDir + employeeFamily[i]["Photo"] + ".JPG"))
    //            //{
    //            //    Image img = Image.FromFile(pictureDir + employeeFamily[i]["Photo"] + ".JPG");
    //            //    var picture = xlWorkSheetToExport.Drawings.AddPicture(iRowCnt.ToString(), img);
    //            //    picture.From.Column = 7 - 1;
    //            //    picture.From.Row = iRowCnt - 1;
    //            //    picture.SetSize(picWidth, picHeight);
    //            //}


    //            if (!Convert.IsDBNull(employeeFamily[i]["Photo"]))
    //            {
    //                byte[] imgData = (byte[])employeeFamily[i]["Photo"];
    //                if (imgData != null && imgData.Length > 0)
    //                {
    //                    MemoryStream ms = new MemoryStream(imgData);
    //                    Image img = Image.FromStream(ms);
    //                    var picture = xlWorkSheetToExport.Drawings.AddPicture(iRowCnt.ToString(), img);
    //                    picture.From.Column = 7 - 1;
    //                    picture.From.Row = iRowCnt - 1;
    //                    picture.SetSize(picWidth, picHeight);
    //                }
    //            }
               
             
    //            xlWorkSheetToExport.Row(iRowCnt).Height = 30;
    //        }
    //    }
    //}



    //private static void VMSVisitorDetails(string[] empIds, string recordType)
    //{
      
    //    string headerName = "VMS Visitor";

    //    // SHOW THE HEADER.
    //    xlWorkSheetToExport.Cells[iRowCnt, 1].Value = headerName + " Search Details";
    //    ExcelRange range = xlWorkSheetToExport.Cells[iRowCnt, 1, iRowCnt, 7];
    //    range.Style.Font.Bold = true;
    //    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
    //    range.Style.Fill.BackgroundColor.SetColor(Color.DarkBlue);
    //    range.Style.Font.Color.SetColor(Color.White);
    //    xlWorkSheetToExport.Row(iRowCnt).Height = 30;
    //    //range.RowHeight = 25;
    //    //range.ColumnWidth = 15;
    //    range.Merge = true;       // MERGE CELLS OF THE HEADER.
    //    range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

    //    iRowCnt++;

    //    int j = 0;
    //    // SHOW COLUMNS ON THE TOP.
    //    xlWorkSheetToExport.Cells[iRowCnt, 1].Value = "Card No";
    //    xlWorkSheetToExport.Cells[iRowCnt, 2].Value = "Name";
    //    xlWorkSheetToExport.Cells[iRowCnt, 3].Value = "Father/Husband Name";
    //    xlWorkSheetToExport.Cells[iRowCnt, 4].Value = "NIC";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 4].Value = "Phone";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 5].Value = "Mobile";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Address";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 7].Value = "Job/Study";
    //    xlWorkSheetToExport.Cells[iRowCnt, 5].Value = "Visit Purpose";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 9].Value = "Visit Days";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 10].Value = "Issue Date";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 11].Value = "Valid Upto";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 12].Value = "Reference Name";
    //    xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Address";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 14].Value = "Rank";
    //    //xlWorkSheetToExport.Cells[iRowCnt, 15].Value = "Reference";
    //    xlWorkSheetToExport.Cells[iRowCnt, 7].Value = "Status";
    //    xlWorkSheetToExport.Cells[iRowCnt, 8].Value = "Photo";

    //    range = xlWorkSheetToExport.Cells[iRowCnt, 1, iRowCnt, 8];
    //    range.Style.Font.Bold = true;
    //    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
    //    range.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
    //    range.Style.Font.Color.SetColor(Color.White);
    //    xlWorkSheetToExport.Row(iRowCnt).Height = 30;

    //    for (j = 0; j < empIds.Count(); j++)
    //    {
    //        if (String.IsNullOrEmpty(empIds[j]))
    //            continue;

    //        Dictionary<string, object> report = DBCommonMethods.getIDWiseReport(empIds[j], recordType);
    //        List<Dictionary<string, object>> employeeFamily = (List<Dictionary<string, object>>)report["EmployeeDetail"];

    //        for (int i = 0; i < employeeFamily.Count; i++)
    //        {
    //            iRowCnt++;
    //            xlWorkSheetToExport.Cells[iRowCnt, 1].Value = employeeFamily[i]["CardNo"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 2].Value = employeeFamily[i]["VISITOR_NAME"].ToString();
    //            xlWorkSheetToExport.Cells[iRowCnt, 3].Value = employeeFamily[i]["FATHER_NAME"].ToString();
    //            xlWorkSheetToExport.Cells[iRowCnt, 4].Value = employeeFamily[i]["NIC"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 4].Value = employeeFamily[i]["Phone"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 5].Value = employeeFamily[i]["Mobile"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["Addr"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 7].Value = employeeFamily[i]["Profession"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 5].Value = employeeFamily[i]["VisitPurpose"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 9].Value = employeeFamily[i]["VisitDays"];

    //            //xlWorkSheetToExport.Cells[iRowCnt, 10].Value = employeeFamily[i]["IssueDt"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 11].Value = employeeFamily[i]["ValidUpto"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 12].Value = employeeFamily[i]["ReferenceName"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["ADDRESS"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 14].Value = employeeFamily[i]["Rank"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 15].Value = employeeFamily[i]["Reference"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 15] = employeeFamily[i]["Photo"]; 
    //            xlWorkSheetToExport.Cells[iRowCnt, 7].Value = employeeFamily[i]["Status"];
    //            //if (File.Exists(pictureDir + employeeFamily[i]["Photo"] + ".JPG"))
    //            //{
    //            //    Image img = Image.FromFile(pictureDir + employeeFamily[i]["Photo"] + ".JPG");
    //            //    var picture = xlWorkSheetToExport.Drawings.AddPicture(iRowCnt.ToString(), img);
    //            //    picture.From.Column = 7 - 1;
    //            //    picture.From.Row = iRowCnt - 1;
    //            //    picture.SetSize(picWidth, picHeight);
    //            //}


    //            if (!Convert.IsDBNull(employeeFamily[i]["Photo"]))
    //            {
    //                byte[] imgData = (byte[])employeeFamily[i]["Photo"];
    //                if (imgData != null && imgData.Length > 0)
    //                {
    //                    MemoryStream ms = new MemoryStream(imgData);
    //                    Image img = Image.FromStream(ms);
    //                    var picture = xlWorkSheetToExport.Drawings.AddPicture(iRowCnt.ToString(), img);
    //                    picture.From.Column = 8 - 1;
    //                    picture.From.Row = iRowCnt - 1;
    //                    picture.SetSize(picWidth, picHeight);
    //                }
    //            }

    //            xlWorkSheetToExport.Row(iRowCnt).Height = 30;
    //        }
    //    }
    //}
    //private static void EmployeeFamilyDetails(string[] empIds, string recordType)
    //{
    //    int j = 0;
        
    //    for (j = 0; j < empIds.Count(); j++)
    //    {
    //        if (String.IsNullOrEmpty(empIds[j]))
    //            continue;

    //        Dictionary<string, object> report = DBCommonMethods.getEmployeeFamily(empIds[j]);
    //        List<Dictionary<string, object>> employeeFamily = (List<Dictionary<string, object>>)report["EmployeeFamilyDetail"];

    //        if (employeeFamily.Count < 1)
    //            continue;

    //        iRowCnt = iRowCnt + 2;
    //        string employeeName = employeeFamily[0]["empName"].ToString();
    //        // SHOW THE HEADER.
    //        xlWorkSheetToExport.Cells[iRowCnt, 1].Value = employeeName + " Family Details";
    //        ExcelRange range = xlWorkSheetToExport.Cells[iRowCnt, 1,iRowCnt, 7];
    //        range.Style.Font.Bold = true;
    //        range.Style.Fill.PatternType = ExcelFillStyle.Solid;
    //        range.Style.Fill.BackgroundColor.SetColor(Color.DarkBlue);
    //        range.Style.Font.Color.SetColor(Color.White);
    //        xlWorkSheetToExport.Row(iRowCnt).Height = 30;
    //        //range.RowHeight = 25;
    //        //range.ColumnWidth = 15;
    //        range.Merge = true;       // MERGE CELLS OF THE HEADER.
    //        range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

    //        iRowCnt++;
    //        // SHOW COLUMNS ON THE TOP.
    //        xlWorkSheetToExport.Cells[iRowCnt, 1].Value = "Card No";
    //        xlWorkSheetToExport.Cells[iRowCnt, 2].Value = "Name";
    //        xlWorkSheetToExport.Cells[iRowCnt, 3].Value = "Relation";
    //        xlWorkSheetToExport.Cells[iRowCnt, 4].Value = "NIC";
    //        xlWorkSheetToExport.Cells[iRowCnt, 5].Value = "Cell No";
    //        xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Status";
    //        //xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Address";
    //        //xlWorkSheetToExport.Cells[iRowCnt, 7].Value = "Visit Purpose";
    //        xlWorkSheetToExport.Cells[iRowCnt, 7].Value = "Photo";

    //        range = xlWorkSheetToExport.Cells[iRowCnt, 1, iRowCnt, 7];
    //        range.Style.Font.Bold = true;
    //        range.Style.Fill.PatternType = ExcelFillStyle.Solid;
    //        range.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
    //        range.Style.Font.Color.SetColor(Color.White);
    //        xlWorkSheetToExport.Row(iRowCnt).Height = 30;

    //        for (int i = 0; i < employeeFamily.Count; i++)
    //        {
    //            iRowCnt++;
    //            xlWorkSheetToExport.Cells[iRowCnt, 1].Value = employeeFamily[i]["CardNumber"];//dt.Rows[i].Field("EmpName");
    //            xlWorkSheetToExport.Cells[iRowCnt, 2].Value = employeeFamily[i]["FirstName"].ToString() + " " + employeeFamily[i]["LastName"].ToString();
    //            xlWorkSheetToExport.Cells[iRowCnt, 3].Value = employeeFamily[i]["Relation"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 4].Value = employeeFamily[i]["NIC"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 5].Value = employeeFamily[i]["Mobile"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["Status"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["vaddr"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 7].Value = employeeFamily[i]["vpurpose"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 8] = employeeFamily[i]["Photo"];
    //            //if (File.Exists(path + "\\EmpPictures\\EmpFamilyPicture\\" + employeeFamily[i]["Photo"] + ".JPG"))
    //            //{
    //            //    Image img = Image.FromFile(path + "\\EmpPictures\\EmpFamilyPicture\\" + employeeFamily[i]["Photo"] + ".JPG");
    //            //    var picture = xlWorkSheetToExport.Drawings.AddPicture(iRowCnt.ToString(), img);
    //            //    picture.From.Column = 7 - 1;
    //            //    picture.From.Row = iRowCnt - 1;
    //            //    picture.SetSize(picWidth, picHeight);
    //            //}

    //            if (!Convert.IsDBNull(employeeFamily[i]["Photo"]))
    //            {
    //                byte[] imgData = (byte[])employeeFamily[i]["Photo"];
    //                if (imgData != null && imgData.Length > 0)
    //                {
    //                    MemoryStream ms = new MemoryStream(imgData);
    //                    Image img = Image.FromStream(ms);
    //                    var picture = xlWorkSheetToExport.Drawings.AddPicture(iRowCnt.ToString(), img);
    //                    picture.From.Column = 7 - 1;
    //                    picture.From.Row = iRowCnt - 1;
    //                    picture.SetSize(picWidth, picHeight);
    //                }
    //            }
    //            xlWorkSheetToExport.Row(iRowCnt).Height = 30;
    //        }
    //    }
    //}

    //private static void EmployeeServantDetails(string[] empIds, string recordType)
    //{
    //    int j = 0;
    //    serventIds.Clear();

    //    for (j = 0; j < empIds.Count(); j++)
    //    {
    //        if (String.IsNullOrEmpty(empIds[j]))
    //            continue;

    //        Dictionary<string, object> report = DBCommonMethods.getEmployeeSerant(empIds[j]);
    //        List<Dictionary<string, object>> employeeFamily = (List<Dictionary<string, object>>)report["EmployeeServantDetail"];

    //        if (employeeFamily.Count < 1)
    //            continue;

    //        iRowCnt = iRowCnt + 2;        
    //        string employeeName = employeeFamily[0]["empName"].ToString();
    //        // SHOW THE HEADER.
    //        xlWorkSheetToExport.Cells[iRowCnt, 1].Value = employeeName + " Servant Details";
    //        ExcelRange range = xlWorkSheetToExport.Cells[iRowCnt, 1, iRowCnt, 7];
    //        range.Style.Font.Bold = true;
    //        range.Style.Fill.PatternType = ExcelFillStyle.Solid;
    //        range.Style.Fill.BackgroundColor.SetColor(Color.DarkBlue);
    //        range.Style.Font.Color.SetColor(Color.White);
    //        xlWorkSheetToExport.Row(iRowCnt).Height = 30;
    //        //range.RowHeight = 25;
    //        //range.ColumnWidth = 15;
    //        range.Merge = true;       // MERGE CELLS OF THE HEADER.
    //        range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

    //        iRowCnt++;
    //        // SHOW COLUMNS ON THE TOP.
    //        xlWorkSheetToExport.Cells[iRowCnt, 1].Value = "Card No";
    //        xlWorkSheetToExport.Cells[iRowCnt, 2].Value = "Name";
    //        xlWorkSheetToExport.Cells[iRowCnt, 3].Value = "Religion";
    //        xlWorkSheetToExport.Cells[iRowCnt, 4].Value = "NIC";
    //        xlWorkSheetToExport.Cells[iRowCnt, 5].Value = "Cell No";
    //        xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Status";
    //        //xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Phone Home";
    //        xlWorkSheetToExport.Cells[iRowCnt, 7].Value = "Photo";

    //        range = xlWorkSheetToExport.Cells[iRowCnt, 1, iRowCnt, 7];
    //        range.Style.Font.Bold = true;
    //        range.Style.Fill.PatternType = ExcelFillStyle.Solid;
    //        range.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
    //        range.Style.Font.Color.SetColor(Color.White);
    //        xlWorkSheetToExport.Row(iRowCnt).Height = 30;

    //        for (int i = 0; i < employeeFamily.Count; i++)
    //        {
    //            iRowCnt++;
    //            xlWorkSheetToExport.Cells[iRowCnt, 1].Value = employeeFamily[i]["CardNumber"];//dt.Rows[i].Field("EmpName");
    //            xlWorkSheetToExport.Cells[iRowCnt, 2].Value = employeeFamily[i]["FirstName"].ToString() + " " + employeeFamily[i]["LastName"].ToString();
    //            xlWorkSheetToExport.Cells[iRowCnt, 3].Value = employeeFamily[i]["Religion"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 4].Value = employeeFamily[i]["NIC"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 5].Value = employeeFamily[i]["mobile"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["Status"];
    //           // xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["phonehome"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 7] = employeeFamily[i]["Photo"];
              
                
                
    //            //if (File.Exists(path + "\\EmpPictures\\EmpServantPicture\\" + employeeFamily[i]["Photo"] + ".JPG"))
    //            //{
    //            //    Image img = Image.FromFile(path + "\\EmpPictures\\EmpServantPicture\\" + employeeFamily[i]["Photo"] + ".JPG");
    //            //    var picture = xlWorkSheetToExport.Drawings.AddPicture(iRowCnt.ToString(), img);
    //            //    picture.From.Column = 7 - 1;
    //            //    picture.From.Row = iRowCnt - 1;
    //            //    picture.SetSize(picWidth, picHeight);
    //            //}


    //            if (!Convert.IsDBNull(employeeFamily[i]["Photo"]))
    //            {
    //                byte[] imgData = (byte[])employeeFamily[i]["Photo"];
    //                if (imgData != null && imgData.Length > 0)
    //                {
    //                    MemoryStream ms = new MemoryStream(imgData);
    //                    Image img = Image.FromStream(ms);
    //                    var picture = xlWorkSheetToExport.Drawings.AddPicture(iRowCnt.ToString(), img);
    //                    picture.From.Column = 7 - 1;
    //                    picture.From.Row = iRowCnt - 1;
    //                    picture.SetSize(picWidth, picHeight);
    //                }
    //            }
               
             


    //            xlWorkSheetToExport.Row(iRowCnt).Height = 30;
    //            serventIds.Add(employeeFamily[i]["SID"].ToString());
    //        }
    //    }
    //}

    //private static void EmployeeServantFamilyDetails()
    //{
    //    int j = 0;
        
    //    for (j = 0; j < serventIds.Count(); j++)
    //    {
    //        if (String.IsNullOrEmpty(serventIds[j]))
    //            continue;

    //        Dictionary<string, object> report = DBCommonMethods.getEmployeeServantFamily(serventIds[j]);
    //        List<Dictionary<string, object>> employeeFamily = (List<Dictionary<string, object>>)report["EmployeeServantFamilyDetail"];

    //        if (employeeFamily.Count < 1)
    //            continue;

    //        iRowCnt = iRowCnt + 2;
    //        string servantName = employeeFamily[0]["ServantName"].ToString();
    //        // SHOW THE HEADER.
    //        xlWorkSheetToExport.Cells[iRowCnt, 1].Value = servantName + " Servant Family Details";
    //        ExcelRange range = xlWorkSheetToExport.Cells[iRowCnt, 1, iRowCnt, 7];
    //        range.Style.Font.Bold = true;
    //        range.Style.Fill.PatternType = ExcelFillStyle.Solid;
    //        range.Style.Fill.BackgroundColor.SetColor(Color.DarkBlue);
    //        range.Style.Font.Color.SetColor(Color.White);
    //        range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
    //        range.Merge = true;
    //        xlWorkSheetToExport.Row(iRowCnt).Height = 30;

    //        iRowCnt++;
    //        // SHOW COLUMNS ON THE TOP.
    //        xlWorkSheetToExport.Cells[iRowCnt, 1].Value = "Card No";
    //        xlWorkSheetToExport.Cells[iRowCnt, 2].Value = "Name";
    //        xlWorkSheetToExport.Cells[iRowCnt, 3].Value = "Relation";
    //        xlWorkSheetToExport.Cells[iRowCnt, 4].Value = "NIC";
    //        xlWorkSheetToExport.Cells[iRowCnt, 5].Value = "Cell No";
    //        xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Status";
    //        //xlWorkSheetToExport.Cells[iRowCnt, 6].Value = "Profession";
    //        //xlWorkSheetToExport.Cells[iRowCnt, 7].Value = "Place of Work";
    //        xlWorkSheetToExport.Cells[iRowCnt, 7].Value = "Photo";

    //        range = xlWorkSheetToExport.Cells[iRowCnt, 1, iRowCnt, 7];
    //        range.Style.Font.Bold = true;
    //        range.Style.Fill.PatternType = ExcelFillStyle.Solid;
    //        range.Style.Fill.BackgroundColor.SetColor(Color.LightBlue);
    //        range.Style.Font.Color.SetColor(Color.White);
    //        xlWorkSheetToExport.Row(iRowCnt).Height = 30;

    //        for (int i = 0; i < employeeFamily.Count; i++)
    //        {
    //            iRowCnt++;
    //            xlWorkSheetToExport.Cells[iRowCnt, 1].Value = employeeFamily[i]["CardNumber"];//dt.Rows[i].Field("EmpName");
    //            xlWorkSheetToExport.Cells[iRowCnt, 2].Value = employeeFamily[i]["FirstName"].ToString() + " " + employeeFamily[i]["LastName"].ToString();
    //            xlWorkSheetToExport.Cells[iRowCnt, 3].Value = employeeFamily[i]["Relation"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 4].Value = employeeFamily[i]["NIC"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 5].Value = employeeFamily[i]["Mobile"];
    //            xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["Status"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 6].Value = employeeFamily[i]["Profession"];
    //            //xlWorkSheetToExport.Cells[iRowCnt, 7].Value = employeeFamily[i]["PlaceofWork"];

    //            //xlWorkSheetToExport.Cells[iRowCnt, 8] = employeeFamily[i]["Photo"];
               
                
                
    //            //if (File.Exists(path + "\\EmpPictures\\EmpServantPicture\\ServantFamilyPicture\\" + employeeFamily[i]["Photo"] + ".JPG"))
    //            //{
    //            //   Image img = Image.FromFile(path + "\\EmpPictures\\EmpServantPicture\\ServantFamilyPicture\\" + employeeFamily[i]["Photo"] + ".JPG");
    //            //    var picture = xlWorkSheetToExport.Drawings.AddPicture(iRowCnt.ToString(), img);
    //            //    picture.From.Column = 7 - 1;
    //            //    picture.From.Row = iRowCnt - 1;
    //            //    picture.SetSize(picWidth, picHeight);
    //            //}

    //            if (!Convert.IsDBNull(employeeFamily[i]["Photo"]))
    //            {
    //                byte[] imgData = (byte[])employeeFamily[i]["Photo"];
    //                if (imgData != null && imgData.Length > 0)
    //                {
    //                    MemoryStream ms = new MemoryStream(imgData);
    //                    Image img = Image.FromStream(ms);
    //                    var picture = xlWorkSheetToExport.Drawings.AddPicture(iRowCnt.ToString(), img);
    //                    picture.From.Column = 7 - 1;
    //                    picture.From.Row = iRowCnt - 1;
    //                    picture.SetSize(picWidth, picHeight);
    //                }
    //            }
               
             

    //            xlWorkSheetToExport.Row(iRowCnt).Height = 30;
    //        }
    //    }
    //}

    //#endregion

    #region Login and Master Pages

    public string UpdateUserPassword(string OldPwd, string NewPwd, string RepeatPwd)
    {
        OldPwd = HashPassword(OldPwd);
        string userId = HttpContext.Current.Profile.GetPropertyValue("UserId").ToString();
        string Query = "select password from users where userid = '" + userId + "' and password = '" + OldPwd + "'";
        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "userPassword", "vmsconnectionstring");
        if (ds.Tables["userPassword"].Rows.Count == 1)
        {
            NewPwd = HashPassword(NewPwd);
            Query = "update users set password = '" + NewPwd + "' where userid = '" + userId + "'";
            ObjDBManager.InsertUpdateQuery(Query, "vmsconnectionstring");
            return "Password changed successfully";
        }
        else {
            return "Old Password is incorrect";
        }        
    }

    public string HashPassword(string password)
    {
        string hashedPassword = "";
        string saltedPart = " Sada Haq Itthy Rakkh ";
        password = password + saltedPart;
        byte[] passwordArr = System.Text.Encoding.ASCII.GetBytes(password);
        SHA256 hash = SHA256.Create();
        byte[] hashedPwd = hash.ComputeHash(passwordArr);
        hashedPassword = Convert.ToBase64String(hashedPwd);
        return hashedPassword;
    }
    
    #endregion
}