using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SettingForms_Training : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Common ObjCommon = new Common();

        DataTable dtTrainingCategory = ObjCommon.GetTrainingCategory();

        ddlTrainingCategoryid.DataSource = dtTrainingCategory;
        ddlTrainingCategoryid.DataValueField = "training_category_id";
        ddlTrainingCategoryid.DataTextField = "training_category_name";
        ddlTrainingCategoryid.DataBind();
        ddlTrainingCategoryid.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dttrainingprerequiste = ObjCommon.GetTrainingPrerequisite();

        ddlprerequisteid.DataSource = dttrainingprerequiste;
        ddlprerequisteid.DataValueField = "training_id";
        ddlprerequisteid.DataTextField = "training_name";
        ddlprerequisteid.DataBind();
        ddlprerequisteid.Items.Insert(0, new ListItem("-- Select --", ""));
    }
}