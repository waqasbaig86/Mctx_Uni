function saveHealthInfo() {
    var queryString = getQueryStringValue("EmpId")
    var empId = queryString["EmpId"];
    var healthInfo = "{"
    + "'HealthId':'" + empId + "',"
    + "'EmpId':'" + empId + "',"
    + "'FHHTN':'" + $.trim($("[id$='TxtHtn']").val()) + "',"
    + "'FHIHD':'" + $.trim($("[id$='TxtIhd']").val()) + "',"
    + "'FHDM':'" + $.trim($("[id$='TxtDm']").val()) + "',"
    + "'FHAsthma':'" + $.trim($("[id$='TxtAsthma']").val()) + "',"
    + "'FHOther':'" + $.trim($("[id$='TxtOther']").val()) + "',"
    + "'Surgicalhistory':'" + $.trim($("[id$='TxtHistory']").val()) + "',"

    + "'CDHTN':'" + $.trim($("[id$='TxtHtn1']").val()) + "',"
    + "'CDIHD':'" + $.trim($("[id$='TxtIhn1']").val()) + "',"
    + "'CDDM':'" + $.trim($("[id$='TxtDm1']").val()) + "',"
    + "'CDAsthma':'" + $.trim($("[id$='TxtAsthma1']").val()) + "',"
    + "'CDOther':'" + $.trim($("[id$='TxtOther1']").val()) + "',"

    + "'Smoking':'" + $.trim($("[id$='TxtSmoking']").val()) + "',"
    + "'SubstanceAbuse':'" + $.trim($("[id$='TxtAbuse']").val()) + "',"
    + "'Exercise':'" + $.trim($("[id$='TxtExercise']").val()) + "',"
    + "'Stress':'" + $.trim($("[id$='TxtStress']").val()) + "',"
    + "'Build':'" + $.trim($("[id$='TxtBuild']").val()) + "',"
    + "'Weight':'" + $.trim($("[id$='TxtWeight']").val()) + "',"
    + "'Height':'" + $.trim($("[id$='TxtHeight']").val()) + "',"
    + "'BMI':'" + $.trim($("[id$='TxtBmi']").val()) + "',"
    + "'Waist':'" + $.trim($("[id$='TxtWasit']").val()) + "',"
    + "'BP':'" + $.trim($("[id$='TxtBp']").val()) + "',"
    + "'Pulse':'" + $.trim($("[id$='TxtPulse']").val()) + "',"
    + "'OralCavity':'" + $.trim($("[id$='TxtOral']").val()) + "',"
    + "'Thyroid':'" + $.trim($("[id$='TxtThyroid']").val()) + "',"
    + "'Skin':'" + $.trim($("[id$='TxtSkin']").val()) + "',"
    + "'Vision':'" + $.trim($("[id$='TxtVision']").val()) + "',"
    + "'SpecificDeformity':'" + $.trim($("[id$='TxtDefomity']").val()) + "',"

    + "'GIT':'" + $.trim($("[id$='TxtGIT']").val()) + "',"
    + "'CVS':'" + $.trim($("[id$='TxtCVS']").val()) + "',"
    + "'Respiratory':'" + $.trim($("[id$='txtRespiratory']").val()) + "',"
    + "'CNS':'" + $.trim($("[id$='txtCNS']").val()) + "',"

    + "'Hb':'" + $.trim($("[id$='txtHb']").val()) + "',"
    + "'ERS':'" + $.trim($("[id$='txtERS']").val()) + "',"
    + "'TLC':'" + $.trim($("[id$='txtTLC']").val()) + "',"
    + "'Platelets':'" + $.trim($("[id$='txtPlatelets']").val()) + "',"
    + "'FBS':'" + $.trim($("[id$='txtFBS']").val()) + "',"
    + "'UricAcid':'" + $.trim($("[id$='txtUricAcid']").val()) + "',"
    + "'UrineDR':'" + $.trim($("[id$='txtUrineDR']").val()) + "',"
    + "'BloodGroup':'" + $.trim($("[id$='txtBloodGroup']").val()) + "',"
    + "'HBsAg':'" + $.trim($("[id$='txtHBs']").val()) + "',"
    + "'AntiHCV':'" + $.trim($("[id$='txtAntiHCV']").val()) + "',"
    + "'SUrea':'" + $.trim($("[id$='txtUrea']").val()) + "',"
    + "'SCreatinine':'" + $.trim($("[id$='txtCreatinine']").val()) + "',"
    + "'SBilirubin':'" + $.trim($("[id$='txtBilirubin']").val()) + "',"
    + "'SGPT':'" + $.trim($("[id$='txtSGPT']").val()) + "',"
    + "'SCholesterol':'" + $.trim($("[id$='txtCholesterol']").val()) + "',"
    + "'TGD':'" + $.trim($("[id$='txtTGD']").val()) + "',"

    + "'ECG':'" + $.trim($("[id$='txtECG']").val()) + "',"
    + "'CXR':'" + $.trim($("[id$='txtCXR']").val()) + "',"
    + "'Adiometry':'" + $.trim($("[id$='txtAdiometry']").val()) + "',"
    + "'MOthers':'" + $.trim($("[id$='txtMOthers']").val()) + "',"

    + "'VHistory':'" + $.trim($("[id$='txtVHistory']").val()) + "',"
    + "'VTetanus':'" + $.trim($("[id$='txtVTetanus']").val()) + "',"
    + "'VTyphoid':'" + $.trim($("[id$='txtVTyphoid']").val()) + "',"
    + "'VOthers':'" + $.trim($("[id$='txtVOthers']").val()) + "',"

    + "'CurrentMedication':'" + $.trim($("[id$='txtCurrentMedication']").val()) + "',"
    + "'Remarks':'" + $.trim($("[id$='txtRemarks']").val()) + "'"
                + "}";    
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json;",
        url: "EmsWebMethods.aspx/SaveHealthInfo",
        data: healthInfo
    }).done(function (error) {
        $("#divSuccessMsg").show();
        $("#divSuccessMsg").html("");
        $("#divSuccessMsg").html("Record Successfully Saved!");
        $("#divSuccessMsg").fadeOut(6000);
    }).fail(function() {
        alert(error.responseText);
    });
}