using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class GetImageDatafromDB : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string IDValue = Request.QueryString["PrimaryKeyIDValue"];
            string TableName = Request.QueryString["tableName"];
            string IDName = Request.QueryString["PrimaryKeyColumnName"];
            string ImageColumnName = Request.QueryString["ImagecolumnName"];

            string constr = ConfigurationManager.ConnectionStrings["UnileverConnectionString"].ConnectionString;
            string sQuery = "SELECT " + ImageColumnName + " FROM " + TableName + " WHERE " + IDName + " =" + IDValue + " and " + ImageColumnName + " IS NOT NULL";

            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand(sQuery, con);

            //cmd.Parameters.Add("@ProductID", SqlDbType.Int).Value = Int32.Parse(sProductID);

            using (con)
            {
                con.Open();
                SqlDataReader DR = cmd.ExecuteReader();

                if (DR.Read())
                {
                    //byte[] test = (byte[])(DR["NewPhoto"]);
                    //(byte[])ds.Tables[0].Rows[0]["Image3"]
                    if ((DR[ImageColumnName]) != System.DBNull.Value)
                    {
                        byte[] imgData = (byte[])DR[ImageColumnName];
                        Response.BinaryWrite(imgData);
                    }
                   
                }
            }
        }
    }
}