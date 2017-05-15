using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reports_TestReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string Querry = @"SELECT TOP 300 [LogId]
      ,[RegNo]
      ,[EmpId]
      ,[EmpName]
      ,[LogTime]
      ,[TerminalId]
      ,[Date]
      ,[CheckType]
      ,[Updated]
      ,[EntryImage]
      ,[ModifiedBy]
      ,[modificationDate]
  FROM [WPGPayroll].[dbo].[LogEmp]";


        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Querry, "EmployeeEducation", "UnileverConnectionString");
        DataTable dt = new DataTable();
        dt = ds.Tables["EmployeeEducation"];

        ReportViewer1.Reset();
        ReportDataSource rptDataSource = new ReportDataSource("DataSet1",dt);
        ReportViewer1.LocalReport.DataSources.Add(rptDataSource);
        ReportViewer1.LocalReport.ReportPath = "Reports/TestReport.rdlc";
        ReportViewer1.LocalReport.Refresh();
    }
}