using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SettingForms_TrainingSchedule : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Common ObjCommon = new Common();

        DataTable dtTraining = ObjCommon.GetTraining();

        ddlTrainingid.DataSource = dtTraining;
        ddlTrainingid.DataValueField = "training_id";
        ddlTrainingid.DataTextField = "training_name";
        ddlTrainingid.DataBind();
        ddlTrainingid.Items.Insert(0, new ListItem("-- Select --", ""));
    }
}