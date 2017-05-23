using System;
using System.Data;


public partial class EMS_health_care_history : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("@EmpId", Request.QueryString["EmpId"].ToString());
        
        DataTable dt = ObjDBManager.ExecuteDataTable("GetHealthInfo", "UnileverConnectionString");

        if(dt.Rows.Count>0)
        {
            hdnHealthId.Value = dt.Rows[0]["HealthId"].ToString();            
            TxtDoa.Text= dt.Rows[0]["DOA"].ToString();
            TxtEmpno.Value = dt.Rows[0]["employee_number"].ToString();
            TxtName.Value = dt.Rows[0]["employee_name"].ToString();
            TxtDept.Value = dt.Rows[0]["department_name"].ToString();
            TxtDob.Value = dt.Rows[0]["dob"].ToString();
            //TxtDoa.Value = dt.Rows[0]["Employee_Id"].ToString();

            TxtHtn.Value = dt.Rows[0]["FHHTN"].ToString();
            TxtIhd.Value = dt.Rows[0]["FHIHD"].ToString();
            TxtDm.Value = dt.Rows[0]["FHDM"].ToString();
            TxtAsthma.Value = dt.Rows[0]["FHAsthma"].ToString();
            TxtOther.Value = dt.Rows[0]["FHOther"].ToString();

            TxtHistory.Value = dt.Rows[0]["Surgicalhistory"].ToString();

            TxtHtn1.Value = dt.Rows[0]["CDHTN"].ToString();
            TxtIhn1.Value = dt.Rows[0]["CDIHD"].ToString();
            TxtDm1.Value = dt.Rows[0]["CDDM"].ToString();
            TxtAsthma1.Value = dt.Rows[0]["CDAsthma"].ToString();
            TxtOther1.Value = dt.Rows[0]["CDOther"].ToString();

            TxtSmoking.Value = dt.Rows[0]["Smoking"].ToString();
            TxtAbuse.Value = dt.Rows[0]["SubstanceAbuse"].ToString();
            TxtExercise.Value = dt.Rows[0]["Exercise"].ToString();
            TxtStress.Value = dt.Rows[0]["Stress"].ToString();

            TxtBuild.Value = dt.Rows[0]["Build"].ToString();
            TxtWeight.Value = dt.Rows[0]["Weight"].ToString();
            TxtHeight.Value = dt.Rows[0]["Height"].ToString();
            TxtBmi.Value = dt.Rows[0]["BMI"].ToString();
            TxtWasit.Value = dt.Rows[0]["Waist"].ToString();
            TxtBpDiastolic.Value = dt.Rows[0]["BPDiastolic"].ToString();
            TxtBpSystolic.Value = dt.Rows[0]["BPSystolic"].ToString();
            TxtPulse.Value = dt.Rows[0]["Pulse"].ToString();

            TxtOral.Value = dt.Rows[0]["OralCavity"].ToString();
            TxtThyroid.Value = dt.Rows[0]["Thyroid"].ToString();
            TxtSkin.Value = dt.Rows[0]["Skin"].ToString();
            TxtVision.Value = dt.Rows[0]["Vision"].ToString();

            TxtDefomity.Value = dt.Rows[0]["SpecificDeformity"].ToString();

            TxtGIT.Value = dt.Rows[0]["GIT"].ToString();
            TxtCVS.Value = dt.Rows[0]["CVS"].ToString();
            txtRespiratory.Value = dt.Rows[0]["Respiratory"].ToString();
            txtCNS.Value = dt.Rows[0]["CNS"].ToString();

            txtHb.Value = dt.Rows[0]["Hb"].ToString();
            txtERS.Value = dt.Rows[0]["ERS"].ToString();
            txtTLC.Value = dt.Rows[0]["TLC"].ToString();
            txtPlatelets.Value = dt.Rows[0]["Platelets"].ToString();
            txtFBS.Value = dt.Rows[0]["FBS"].ToString();
            txtUricAcid.Value = dt.Rows[0]["UricAcid"].ToString();

            txtUrineDR.Value = dt.Rows[0]["UrineDR"].ToString();
            txtBloodGroup.Value = dt.Rows[0]["BloodGroup"].ToString();
            txtHBs.Value = dt.Rows[0]["HBsAg"].ToString();
            txtAntiHCV.Value = dt.Rows[0]["AntiHCV"].ToString();
            txtUrea.Value = dt.Rows[0]["SUrea"].ToString();

            txtCreatinine.Value = dt.Rows[0]["SCreatinine"].ToString();
            txtBilirubin.Value = dt.Rows[0]["SBilirubin"].ToString();
            txtSGPT.Value = dt.Rows[0]["SGPT"].ToString();
            txtCholesterol.Value = dt.Rows[0]["SCholesterol"].ToString();
            txtTGD.Value = dt.Rows[0]["TGD"].ToString();

            txtECG.Value = dt.Rows[0]["ECG"].ToString();
            txtCXR.Value = dt.Rows[0]["CXR"].ToString();

            txtAdiometry.Value = dt.Rows[0]["Adiometry"].ToString();
            txtMOthers.Value = dt.Rows[0]["MOthers"].ToString();

            txtVHistory.Value = dt.Rows[0]["VHistory"].ToString();
            txtVTetanus.Value = dt.Rows[0]["VTetanus"].ToString();
            txtVTyphoid.Value = dt.Rows[0]["VTyphoid"].ToString();
            txtVOthers.Value = dt.Rows[0]["VOthers"].ToString();
            txtCurrentMedication.Value = dt.Rows[0]["CurrentMedication"].ToString();
            txtRemarks.Value = dt.Rows[0]["Remarks"].ToString();
        }
    }
    
}