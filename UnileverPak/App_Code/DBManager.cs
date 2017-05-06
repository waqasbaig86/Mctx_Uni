using System;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
/// <summary>
/// Summary description for DBManager
/// </summary>
public class DBManager
{
    SqlDataAdapter _SqlAdapter = new SqlDataAdapter();
    SqlConnection _SqlCon;
    SqlCommand _SqlCommand = new SqlCommand();
    public List<SqlParameter> Parameters = new List<SqlParameter>();
    public DBManager()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public void Openconn(string connStr)
    {
        try
        {
            string constr = ConfigurationManager.ConnectionStrings[connStr].ConnectionString;
            _SqlCon = new SqlConnection(constr);
            _SqlCon.Open();
        }
        catch (Exception exp)
        {
            throw exp;
        }
    }
    public  void CloseConnection()
    {
        _SqlCon.Close();
        _SqlCon.Dispose();
    }
    public void AddParameter(string parameterName, object value)
    {
        SqlParameter parameter = new SqlParameter(parameterName, value);
        Parameters.Add(parameter);
    }

    public void AddParameter(string parameterName, object value, SqlDbType sqlDbType, int size, ParameterDirection parameterDirection)
    {
        SqlParameter parameter = new SqlParameter(parameterName, sqlDbType, size);
        parameter.Value = value;
        parameter.Direction = parameterDirection;
        Parameters.Add(parameter);
    }

    public int InsertUpdateProcedure(string procedureName,string strConn)
    {
        int result = 0;

        try
        {
            Openconn(strConn);
            _SqlCommand = new SqlCommand(procedureName, _SqlCon);
            if (Parameters.Count != 0)
            {
                for (int i = 0; i < Parameters.Count; i++)
                {
                    _SqlCommand.Parameters.Add(Parameters[i]);
                }

            }
            _SqlCommand.CommandType = CommandType.StoredProcedure;
            result = _SqlCommand.ExecuteNonQuery();

            CloseConnection();
        }
        catch (Exception)
        {
            CloseConnection();
            throw;
        }

        return result;
    }
    public DataSet ExecuteDataSet(string procedureName, string strConn)
    {


        DataSet dataSet = new DataSet();

        try
        {
            Openconn(strConn);
            _SqlCommand = new SqlCommand(procedureName, _SqlCon);
            if (Parameters.Count != 0)
            {
                for (int i = 0; i < Parameters.Count; i++)
                {
                    _SqlCommand.Parameters.Add(Parameters[i]);
                }

            }
            _SqlCommand.CommandType = CommandType.StoredProcedure;
            _SqlAdapter = new SqlDataAdapter(_SqlCommand);
            _SqlAdapter.Fill(dataSet);

            CloseConnection();
        }
        catch (Exception)
        {
            CloseConnection();
            throw;
        }
        return dataSet;
    }
    public DataTable ExecuteDataTable(string procedureName, string strConn)
    {


        DataTable dataTable = new DataTable();

        try
        {
            Openconn(strConn);
            _SqlCommand = new SqlCommand(procedureName, _SqlCon);
            if (Parameters.Count != 0)
            {
                for (int i = 0; i < Parameters.Count; i++)
                {
                    _SqlCommand.Parameters.Add(Parameters[i]);
                }

            }
            _SqlCommand.CommandType = CommandType.StoredProcedure;
            _SqlAdapter = new SqlDataAdapter(_SqlCommand);
            _SqlAdapter.Fill(dataTable);

            CloseConnection();
        }
        catch (Exception)
        {
            CloseConnection();
            throw;
        }

        return dataTable;
    }
    public DataSet SelectQuery(string query, string dtName, string strConn)
    {


        DataSet dset = new DataSet();

        try
        {
            Openconn(strConn);
            _SqlCommand = new SqlCommand(query, _SqlCon);            
            _SqlCommand.CommandType = CommandType.Text;
            _SqlAdapter = new SqlDataAdapter(_SqlCommand);
            _SqlAdapter.Fill(dset, dtName);
            
            CloseConnection();            
        }
        catch (Exception)
        {
            CloseConnection();            
            
            throw;
        }

        return dset;
    }
    public int InsertUpdateQuery(string query, string strConn)
    {
        int result = 0;

        try
        {
            Openconn(strConn);
            _SqlCommand = new SqlCommand(query, _SqlCon);            
            _SqlCommand.CommandType = CommandType.Text;
            result = _SqlCommand.ExecuteNonQuery();

            CloseConnection();
        }
        catch (Exception)
        {
            CloseConnection();
            throw;
        }

        return result;
    }
    //public DataSet ExecuteDataSet(string spName, Hashtable param, string connStr)
    //{
    //    DataSet ds = new DataSet();
    //    try
    //    {
    //        if (_SqlCon.State == 0)
    //        {
    //            Openconn(connStr);
    //        }
    //        _SqlCommand.Connection = _SqlCon;
    //        _SqlCommand.CommandText = spName;
    //        _SqlCommand.CommandType = CommandType.StoredProcedure;
    //        foreach (string para in param.Keys)
    //        {
    //            _SqlCommand.Parameters.AddWithValue(para, param[para]);
    //        }
    //        _SqlAdapter.SelectCommand = (_SqlCommand);
    //        _SqlAdapter.Fill(ds);
    //    }
    //    catch (Exception exp)
    //    {
    //        throw exp;
    //    }
    //    finally
    //    {
    //        _SqlAdapter.Dispose();
    //        _SqlCon.Close();
    //    }
    //    return ds;
    //}
    //public DataTable ExecuteDataTable(string spName, Hashtable param, string connStr)
    //{
    //    DataTable dt = new DataTable();
    //    try
    //    {
    //        if (_SqlCon.State == 0)
    //        {
    //            Openconn(connStr);
    //        }
    //        _SqlCommand.Connection = _SqlCon;
    //        _SqlCommand.CommandText = spName;
    //        _SqlCommand.CommandType = CommandType.StoredProcedure;
    //        foreach (string para in param.Keys)
    //        {
    //            _SqlCommand.Parameters.AddWithValue(para, param[para]);
    //        }
    //        _SqlAdapter.SelectCommand = (_SqlCommand);
    //        _SqlAdapter.Fill(dt);
    //    }
    //    catch (Exception exp)
    //    {
    //        throw exp;
    //    }
    //    finally
    //    {
    //        _SqlAdapter.Dispose();
    //        _SqlCon.Close();
    //    }
    //    return dt;
    //}
    //public void ExecuteNonQuery(string spName, Hashtable param, string connStr)
    //{        
    //    try
    //    {
    //        if (_SqlCon.State == 0)
    //        {
    //            Openconn(connStr);
    //        }
    //        _SqlCommand.Connection = _SqlCon;
    //        _SqlCommand.CommandText = spName;
    //        _SqlCommand.CommandType = CommandType.StoredProcedure;
    //        foreach (string para in param.Keys)
    //        {
    //            _SqlCommand.Parameters.AddWithValue(para, param[para]);
    //        }

    //        _SqlCommand.ExecuteNonQuery();
    //    }
    //    catch (Exception exp)
    //    {
    //        throw exp;
    //    }
    //    finally
    //    {         
    //        _SqlCon.Close();
    //    }
    //}

}
