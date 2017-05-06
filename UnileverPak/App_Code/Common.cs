using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
/// <summary>
/// Summary description for Common
/// </summary>
public class Common
{
	public Common()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public DataTable GetGates()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetGate", "UnileverConnectionString");
    }
    public DataTable GetCity()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetCity", "UnileverConnectionString");
    }
    public DataTable GetGender()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetGender", "UnileverConnectionString");
    }
    public DataTable GetEmpl()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("Getemployee", "UnileverConnectionString");
    }
    public DataTable GetShift()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetShift", "UnileverConnectionString");
    }
    public DataTable GetBank()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetBank", "UnileverConnectionString");
    }
    public DataTable GetBloodGroup()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetBloodGroup", "UnileverConnectionString");
    }
    public DataTable GetCastee()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetCast", "UnileverConnectionString");
    }
    public DataTable Getsect()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetSectt", "UnileverConnectionString");
    }
    public DataTable GetClientid()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetClientID", "UnileverConnectionString");
    }
    public DataTable GetTerminalType()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetTerminalType", "UnileverConnectionString");
    }
    public DataTable GetTraining()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetTrainingschedule", "UnileverConnectionString");
    }
    public DataTable GetDamoclesSensorTypeInfo()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDamoclesSensorTypeInfos", "UnileverConnectionString");
    }

    public DataTable GetDamoclesSensorTypeInfo1()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDamoclesSensorTypeInfos1", "UnileverConnectionString");
    }



    public DataTable GetDepartments()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDepartment", "UnileverConnectionString");
    }
    public DataTable GetEducationn()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetEducation", "UnileverConnectionString");
    }
    public DataTable GetReligionn()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetReligion", "UnileverConnectionString");
    }
    public DataTable GetDesignationn()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDesignation", "UnileverConnectionString");
    }
    public DataTable GetEmployee()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("Getemployee", "UnileverConnectionString");
    }
    public DataTable GetTrainingCategory()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetTrainingCategory", "UnileverConnectionString");
    }
    public DataTable GetTrainingPrerequisite()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetTrainingNameForPreRer", "UnileverConnectionString");
    }




    public DataTable GetDepartmentsForResidentSearch()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDepartmentForResidentSearch", "UnileverConnectionString");
    }


    public DataTable GetDepartmentsForNonResidentSearch()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDepartmentForNonResidentSearch", "UnileverConnectionString");
    }
    public DataTable GetReligion()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetReligion", "UnileverConnectionString");
    }

    public DataTable GetRelation()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetRelation", "UnileverConnectionString");
    }

    public DataTable GetCategory()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetCategory", "UnileverConnectionString");
    }

    public DataTable GetCardCategory()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetCardCategory", "UnileverConnectionString");
    }

    public DataTable GetRanks()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetRanks", "UnileverConnectionString");
    }
    public DataTable GetDesignation()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDesignation", "UnileverConnectionString");
    }

    public DataTable GetDesignationForResidentSearch()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDesignationForResidentSearch", "UnileverConnectionString");
    }


    public DataTable GetDesignationForNonResidentSearch()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDesignationForNonResidentSearch", "UnileverConnectionString");
    }



    public DataTable GetLocations()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetLocations", "UnileverConnectionString");
    }

    public DataTable GetCaste()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetCaste", "UnileverConnectionString");
    }

    public DataTable GetSectt()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetSectt", "UnileverConnectionString");
    }


    public DataTable GetEduducation()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetEducation", "UnileverConnectionString");
    }
}